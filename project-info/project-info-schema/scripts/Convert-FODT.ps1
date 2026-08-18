<#
.SYNOPSIS
    Downloads an OPP project template FODT from Nextcloud and converts it to
    ResearchProject XML instances (English and German).

.DESCRIPTION
    Fetches the bilingual project template FODT from a Nextcloud public share URL
    (or uses a local copy), parses the Active Project Fields table, and writes
    project-info-en.xml and project-info-de.xml.

    All fields defined in project-template.fodt are supported, including structured
    fields (member/ORCID, memberOf/ROR, hasCredential, funding, image).
    German values fall back to English automatically when a cell contains "(= EN)".

.PARAMETER ShareUrl
    Nextcloud public share URL, e.g. https://tib.cloud/s/QFJHz4NZZLJKTe2
    The script appends /download to get the direct file automatically.

.PARAMETER LocalFodt
    Path to a locally saved FODT file. Use instead of ShareUrl when working offline
    or when you want to convert a specific versioned copy.

.PARAMETER EnOut
    Output path for the English XML. Defaults to project-info-en.xml next to this script.

.PARAMETER DeOut
    Output path for the German XML. Defaults to project-info-de.xml next to this script.

.PARAMETER SaveFodt
    Path to archive the downloaded FODT to. Defaults to
    project-info-schema\project-ckg.fodt (next to this script's parent folder),
    so the raw source stays committed alongside the generated XML and in sync
    with it. Pass -NoSaveFodt to skip archiving.

.PARAMETER NoSaveFodt
    If specified, skips archiving the downloaded FODT into the repo.

.EXAMPLE
    # Fetch from Nextcloud, update both XML files, and archive the FODT in-repo
    .\Convert-FODT.ps1 -ShareUrl https://tib.cloud/s/QFJHz4NZZLJKTe2

.EXAMPLE
    # Convert a locally saved copy
    .\Convert-FODT.ps1 -LocalFodt "C:\Downloads\project-template-2026.fodt"

.EXAMPLE
    # Fetch and convert without archiving a copy in the repo
    .\Convert-FODT.ps1 -ShareUrl https://tib.cloud/s/2j3A4Mjp7SdjDZa -NoSaveFodt

.NOTES
    Part of the OPP project information pipeline.
    See project-info\pipeline.md for the full workflow description.
    After running this script, regenerate outputs with:
        .\Apply-XSLT.ps1
        .\Make-Readme.ps1
#>

[CmdletBinding()]
param(
    [string] $ShareUrl  = "https://tib.cloud/s/2j3A4Mjp7SdjDZa",
    [string] $LocalFodt,
    [string] $EnOut,
    [string] $DeOut,
    [string] $SaveFodt,
    [switch] $NoSaveFodt
)

$scriptDir   = $PSScriptRoot
$schemaDir   = Join-Path $scriptDir '..'
$projectInfo = Join-Path $scriptDir '..\..'

if (-not $EnOut) { $EnOut = Join-Path $projectInfo 'project-info-en.xml' }
if (-not $DeOut) { $DeOut = Join-Path $projectInfo 'project-info-de.xml' }
$EnOut = [System.IO.Path]::GetFullPath($EnOut)
$DeOut = [System.IO.Path]::GetFullPath($DeOut)

# Archive the downloaded FODT in the repo by default so the raw source stays
# committed and in sync with the generated XML. -NoSaveFodt opts out.
if (-not $SaveFodt -and -not $NoSaveFodt) {
    $SaveFodt = Join-Path $schemaDir 'project-ckg.fodt'
}

# ============================================================
# 1. Obtain the FODT
# ============================================================
$fodtPath = $LocalFodt

if (-not $fodtPath) {
    $downloadUrl = $ShareUrl.TrimEnd('/') + '/download'
    $fodtPath    = Join-Path ([System.IO.Path]::GetTempPath()) 'project-ckg.fodt'
    Write-Host "Downloading FODT from $downloadUrl ..."
    try {
        Invoke-WebRequest -Uri $downloadUrl -OutFile $fodtPath -ErrorAction Stop
    } catch {
        Write-Error "Download failed: $_"
        exit 1
    }
    Write-Host "Downloaded: $fodtPath ($((Get-Item $fodtPath).Length) bytes)"
}

if ($SaveFodt -and -not $NoSaveFodt) {
    $SaveFodt = [System.IO.Path]::GetFullPath($SaveFodt)
    Copy-Item $fodtPath $SaveFodt -Force
    Write-Host "Saved FODT copy: $SaveFodt"
}

# ============================================================
# 2. Parse the FODT
# ============================================================
$doc = [System.Xml.XmlDocument]::new()
try {
    $doc.Load($fodtPath)
} catch {
    Write-Error "Failed to parse FODT XML: $_"
    exit 1
}

$ns = [System.Xml.XmlNamespaceManager]::new($doc.NameTable)
$ns.AddNamespace("table", "urn:oasis:names:tc:opendocument:xmlns:table:1.0")
$ns.AddNamespace("text",  "urn:oasis:names:tc:opendocument:xmlns:text:1.0")

$tables = $doc.SelectNodes("//table:table", $ns)
if ($tables.Count -lt 1) {
    Write-Error "No tables found in the FODT. Is this the correct file?"
    exit 1
}

$rows = $tables[0].SelectNodes("table:table-row", $ns)
Write-Host "Active fields table: $($rows.Count - 1) data rows"

# Helper: get all paragraph texts from a cell column (0=label, 1=EN, 2=DE)
function Get-Paras([System.Xml.XmlNode]$rowNode, [int]$col) {
    $cell = $rowNode.SelectNodes("table:table-cell", $ns)[$col]
    @($cell.SelectNodes("text:p", $ns) | ForEach-Object { $_.InnerText })
}

# XML-escape a string
function X([string]$s) {
    [System.Security.SecurityElement]::Escape($s)
}

# Check if a DE cell means "same as EN"
function Is-SameAsEN([string[]]$paras) {
    $paras.Count -eq 1 -and $paras[0] -eq '(= EN)'
}

# Load all rows into a hashtable keyed by the label cell's first paragraph
$fields = @{}
for ($i = 1; $i -lt $rows.Count; $i++) {
    $label = $rows[$i].SelectNodes("table:table-cell", $ns)[0].SelectNodes("text:p", $ns)[0].InnerText
    $fields[$label] = @{
        # Force array context: a single-paragraph cell would otherwise collapse
        # to a bare string, and later [0] indexing on a string returns a
        # character instead of the full value.
        EN = @(Get-Paras $rows[$i] 1)
        DE = @(Get-Paras $rows[$i] 2)
    }
}

Write-Host "Fields loaded: $($fields.Keys -join ', ')"

# ============================================================
# 3. Build XML for a language
# ============================================================
function Build-XML([string]$lang) {
    $isDE  = ($lang -eq 'de')
    $mlAttr = "xml:lang=""$lang"""

    # Resolve a field: return DE paras if available, else EN
    # The leading comma prevents PowerShell from unrolling a single-element
    # array back into a bare string as it passes through the return/pipeline
    # (which would make a later [0] index return one character, not the value).
    function Resolve([string]$key) {
        $f = $fields[$key]
        if ($isDE -and -not (Is-SameAsEN $f.DE)) { return ,$f.DE }
        return ,$f.EN
    }

    # ---- Simple text fields ----
    $nameVal    = (Resolve 'name')[0]
    $altName    = (Resolve 'alternateName')[0]
    $strapline  = (Resolve 'disambiguatingDescription')[0]
    $urlVal     = $fields['url'].EN[0]   # URL is always EN
    $kwVal      = (Resolve 'keywords')[0]

    # ---- Description (join paragraphs) ----
    $descParas  = Resolve 'description'
    $descVal    = ($descParas | Where-Object { $_ -ne $null }) -join "`n`n"

    # ---- sameAs (one per paragraph, always EN) ----
    $sameAsUrls = $fields['sameAs'].EN | Where-Object { $_ }

    # ---- identifier ----
    $idENParas  = $fields['identifier'].EN
    $idDisplay  = (Resolve 'identifier')[0]
    # Second EN paragraph holds the attribute spec: propertyID="..." value="..."
    $idAttrs    = if ($idENParas.Count -gt 1) { $idENParas[1] } else { '' }
    $pidMatch   = [regex]::Match($idAttrs, 'propertyID="([^"]+)"')
    $valMatch   = [regex]::Match($idAttrs, 'value="([^"]+)"')
    $propId     = if ($pidMatch.Success) { $pidMatch.Groups[1].Value } else { 'GrantID' }
    $idVal      = if ($valMatch.Success) { $valMatch.Groups[1].Value } else { '' }

    # ---- image (EN urls always; DE captions from row 3+ of DE column) ----
    $enImgParas = $fields['image → imageObject'].EN
    $deImgParas = $fields['image → imageObject'].DE
    $images     = @()
    for ($i = 0; $i -lt $enImgParas.Count; $i += 2) {
        $images += [pscustomobject]@{
            CaptionEN = $enImgParas[$i]
            Url       = if (($i + 1) -lt $enImgParas.Count) { $enImgParas[$i + 1] } else { '' }
        }
    }
    # DE captions appear after "DE captions:" marker at index 3 onward
    $deCaps = @()
    if ($isDE -and $deImgParas.Count -ge 4) {
        $deCaps = $deImgParas[3..($deImgParas.Count - 1)]
    }

    # ---- foundingDate / dissolutionDate ----
    # Only capture a leading ISO 8601 date (YYYY or YYYY-MM-DD) and ignore any
    # stray trailing text accidentally left in the source cell (e.g. ", keywords").
    $dateParas    = $fields['foundingDate / dissolutionDate'].EN
    $foundingDate = ($dateParas | Where-Object { $_ -match '^Start:\s*(\d{4}(?:-\d{2}-\d{2})?)' } |
                    ForEach-Object { $Matches[1] } | Select-Object -First 1)
    $dissolution  = ($dateParas | Where-Object { $_ -match '^End:\s*(\d{4}(?:-\d{2}-\d{2})?)' } |
                    ForEach-Object { $Matches[1] } | Select-Object -First 1)

    # ---- parentOrganization ----
    $poEN    = $fields['parentOrganization'].EN
    $poDE    = $fields['parentOrganization'].DE
    $poParas = if ($isDE -and -not (Is-SameAsEN $poDE)) { $poDE } else { $poEN }
    $poName  = $poParas[0]
    $poHref  = ''
    $poLine  = if ($poParas.Count -gt 1) { $poParas[1] } else { '' }
    if ($poLine -match 'ROR:\s*(.+)')   { $poHref = $Matches[1].Trim() }
    elseif ($poLine -match 'https?://') { $poHref = $poLine.Trim() }

    # ---- member (EN only; pairs: name, "ORCID: ID") ----
    $memberParas = $fields['member'].EN
    $members     = @()
    for ($i = 0; $i -lt $memberParas.Count; $i += 2) {
        $mName  = $memberParas[$i]
        $mOrcid = ''
        if (($i + 1) -lt $memberParas.Count -and $memberParas[$i + 1] -match 'ORCID:\s*(.+)') {
            $mOrcid = $Matches[1].Trim()
        }
        $members += [pscustomobject]@{ Name = $mName; Orcid = $mOrcid }
    }

    # ---- memberOf (EN: pairs name/href; DE: names only, hrefs from EN by position) ----
    $moEN    = $fields['memberOf'].EN
    $moDE    = $fields['memberOf'].DE
    $moItems = @()
    for ($i = 0; $i -lt $moEN.Count; $i += 2) {
        $moHref = ''
        $hLine  = if (($i + 1) -lt $moEN.Count) { $moEN[$i + 1] } else { '' }
        if ($hLine -match 'ROR:\s*(.+)')   { $moHref = $Matches[1].Trim() }
        elseif ($hLine -match 'https?://') { $moHref = $hLine.Trim() }
        $moItems += [pscustomobject]@{ NameEN = $moEN[$i]; Href = $moHref; NameDE = $moEN[$i] }
    }
    if ($isDE -and -not (Is-SameAsEN $moDE)) {
        for ($i = 0; $i -lt [Math]::Min($moItems.Count, $moDE.Count); $i++) {
            $moItems[$i].NameDE = $moDE[$i]
        }
    }

    # ---- funding (label:value pairs) ----
    $fundParas = Resolve 'funding'
    $fundMap   = @{}
    for ($i = 0; $i + 1 -lt $fundParas.Count; $i += 2) {
        $key = ($fundParas[$i] -replace ':$', '').Trim()
        $fundMap[$key] = $fundParas[$i + 1]
    }
    $fundName    = $fundMap['Name']
    $fundGrantId = if ($fundMap.ContainsKey('Grant ID'))         { $fundMap['Grant ID'] }
                   elseif ($fundMap.ContainsKey('Foerderkennzeichen')) { $fundMap['Foerderkennzeichen'] }
                   elseif ($fundMap.ContainsKey('Förderkennzeichen')) { $fundMap['Förderkennzeichen'] }
                   else { '' }
    $fundLabel   = if ($isDE -and $fundMap.ContainsKey('Förderkennzeichen')) { 'Förderkennzeichen' }
                   elseif ($isDE -and $fundMap.ContainsKey('Foerderkennzeichen')) { 'Förderkennzeichen' }
                   else { 'Grant ID' }
    $fundFunder  = if ($fundMap.ContainsKey('Funder'))   { $fundMap['Funder'] }
                   elseif ($fundMap.ContainsKey('Förderer')) { $fundMap['Förderer'] }
                   else { '' }
    $fundUrl     = $fundMap['URL']

    # ---- knowsAbout (one per paragraph) ----
    $kaParas = (Resolve 'knowsAbout') | Where-Object { $_ }

    # ---- knowsLanguage ("code (Name)" per paragraph) ----
    $klParas = Resolve 'knowsLanguage'
    $kLangs  = @()
    foreach ($kl in $klParas) {
        if ($kl -match '^([a-z]{2})\s+\((.+)\)$') {
            $kLangs += [pscustomobject]@{ Code = $Matches[1]; Name = $Matches[2] }
        }
    }

    # ---- hasCredential (blank-line-separated groups of 1-3 paragraphs) ----
    # Each item is a run of paragraphs bounded by blank paragraphs. A group can
    # be just a name (1 paragraph), name + url or name + description
    # (2 paragraphs), or name + description + url (3 paragraphs) — the source
    # document isn't consistent about how many lines each credential uses.
    function New-HcItem([string[]]$g) {
        if ($g.Count -eq 0) { return $null }
        $hcDesc = ''
        $hcUrl  = ''
        if ($g.Count -eq 2) {
            if ($g[1] -match '^https?://') { $hcUrl = $g[1] } else { $hcDesc = $g[1] }
        } elseif ($g.Count -ge 3) {
            $hcDesc = $g[1]
            $hcUrl  = $g[2]
        }
        [pscustomobject]@{ Name = $g[0]; Desc = $hcDesc; Url = $hcUrl }
    }

    $hcParas = Resolve 'hasCredential'
    $hcItems = @()
    $group   = @()
    foreach ($p in $hcParas) {
        if ([string]::IsNullOrEmpty($p)) {
            $hcItem = New-HcItem $group
            if ($hcItem) { $hcItems += $hcItem }
            $group = @()
        } else {
            $group += $p
        }
    }
    $hcItem = New-HcItem $group
    if ($hcItem) { $hcItems += $hcItem }

    # ============================================================
    # Emit XML
    # ============================================================
    $nl = "`n"
    $sb = [System.Text.StringBuilder]::new()

    $null = $sb.Append("<?xml version=""1.0"" encoding=""UTF-8""?>$nl")
    $null = $sb.Append("<?xml-stylesheet type=""text/xsl"" href=""project-info-schema/ResearchProject.xslt""?>$nl")
    $null = $sb.Append("<!DOCTYPE ResearchProject SYSTEM ""project-info-schema/ResearchProject.dtd"">$nl")
    $null = $sb.Append("<ResearchProject xml:lang=""$lang"" typeof=""schema:ResearchProject"" vocab=""https://schema.org/"">$nl$nl")

    $null = $sb.Append("    <name>$(X $nameVal)</name>$nl$nl")
    $null = $sb.Append("    <description>$(X $descVal)</description>$nl$nl")
    $null = $sb.Append("    <alternateName>$(X $altName)</alternateName>$nl$nl")
    $null = $sb.Append("    <url>$(X $urlVal)</url>$nl$nl")

    foreach ($sa in $sameAsUrls) {
        $null = $sb.Append("    <sameAs>$(X $sa)</sameAs>$nl")
    }
    $null = $sb.Append($nl)

    if ($propId -and $idVal) {
        $null = $sb.Append("    <identifier propertyID=""$(X $propId)"" value=""$(X $idVal)"">$(X $idDisplay)</identifier>$nl$nl")
    }

    for ($i = 0; $i -lt $images.Count; $i++) {
        $cap = if ($isDE -and $i -lt $deCaps.Count) { $deCaps[$i] } else { $images[$i].CaptionEN }
        $null = $sb.Append("    <image>$nl")
        $null = $sb.Append("        <imageObject>$nl")
        $null = $sb.Append("            <contentUrl>$(X $images[$i].Url)</contentUrl>$nl")
        $null = $sb.Append("            <caption $mlAttr>$(X $cap)</caption>$nl")
        $null = $sb.Append("        </imageObject>$nl")
        $null = $sb.Append("    </image>$nl")
    }
    $null = $sb.Append($nl)

    $null = $sb.Append("    <disambiguatingDescription $mlAttr>$(X $strapline)</disambiguatingDescription>$nl$nl")
    $null = $sb.Append("    <foundingDate>$(X $foundingDate)</foundingDate>$nl")
    $null = $sb.Append("    <dissolutionDate>$(X $dissolution)</dissolutionDate>$nl$nl")

    foreach ($m in $members) {
        $orcidHref = if ($m.Orcid) { " href=""https://orcid.org/$($m.Orcid)""" } else { '' }
        $null = $sb.Append("    <member typeof=""schema:Person""$orcidHref>$(X $m.Name)</member>$nl")
    }
    $null = $sb.Append($nl)

    foreach ($mo in $moItems) {
        $moName  = if ($isDE) { $mo.NameDE } else { $mo.NameEN }
        $moHref  = if ($mo.Href) { " href=""$(X $mo.Href)""" } else { '' }
        $null = $sb.Append("    <memberOf typeof=""schema:Organization""$moHref>$(X $moName)</memberOf>$nl")
    }
    $null = $sb.Append($nl)

    if ($poName) {
        $poHrefAttr = if ($poHref) { " href=""$(X $poHref)""" } else { '' }
        $null = $sb.Append("    <parentOrganization$poHrefAttr>$(X $poName)</parentOrganization>$nl$nl")
    }

    $null = $sb.Append("    <keywords $mlAttr>$(X $kwVal)</keywords>$nl$nl")

    $null = $sb.Append("    <funding>$nl")
    $null = $sb.Append("        <name>$(X $fundName)</name>$nl")
    if ($fundGrantId) {
        # Display text is just the label + grant ID — the funder name is emitted
        # separately below (and rendered by the XSLT), so don't repeat it here.
        $idDisp = "$fundLabel $(X $fundGrantId)"
        $null = $sb.Append("        <identifier propertyID=""GrantID"" value=""$(X $fundGrantId)"">$idDisp</identifier>$nl")
    }
    if ($fundFunder) {
        $null = $sb.Append("        <funder typeof=""schema:Organization"">$(X $fundFunder)</funder>$nl")
    }
    if ($fundUrl) {
        $null = $sb.Append("        <url>$(X $fundUrl)</url>$nl")
    }
    $null = $sb.Append("    </funding>$nl$nl")

    foreach ($ka in $kaParas) {
        $null = $sb.Append("    <knowsAbout $mlAttr>$(X $ka)</knowsAbout>$nl")
    }
    $null = $sb.Append($nl)

    foreach ($kl in $kLangs) {
        $null = $sb.Append("    <knowsLanguage languageCode=""$($kl.Code)"">$(X $kl.Name)</knowsLanguage>$nl")
    }
    $null = $sb.Append($nl)

    foreach ($hc in $hcItems) {
        $null = $sb.Append("    <hasCredential>$nl")
        $null = $sb.Append("        <name>$(X $hc.Name)</name>$nl")
        $null = $sb.Append("        <description>$(X $hc.Desc)</description>$nl")
        $null = $sb.Append("        <url>$(X $hc.Url)</url>$nl")
        $null = $sb.Append("    </hasCredential>$nl")
    }

    $null = $sb.Append("$nl</ResearchProject>$nl")
    return $sb.ToString()
}

# ============================================================
# 4. Write output files
# ============================================================
Write-Host ""
Write-Host "Building EN XML..."
$enXml = Build-XML 'en'
[System.IO.File]::WriteAllText($EnOut, $enXml, [System.Text.Encoding]::UTF8)
Write-Host "OK  $EnOut  ($($enXml.Length) chars)" -ForegroundColor Green

Write-Host "Building DE XML..."
$deXml = Build-XML 'de'
[System.IO.File]::WriteAllText($DeOut, $deXml, [System.Text.Encoding]::UTF8)
Write-Host "OK  $DeOut  ($($deXml.Length) chars)" -ForegroundColor Green

Write-Host ""
Write-Host "Next steps — regenerate outputs:" -ForegroundColor Cyan
Write-Host "  cd $(Split-Path $scriptDir -Parent | Split-Path -Parent)"
Write-Host "  .\project-info\scripts\Apply-XSLT.ps1"
Write-Host "  .\project-info\scripts\Make-Readme.ps1"
