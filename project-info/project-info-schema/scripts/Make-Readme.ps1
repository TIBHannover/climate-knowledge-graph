<#
.SYNOPSIS
    Updates the repository root README.md with generated ResearchProject content
    from project-info-en.xml, leaving the hand-written part of the file intact.

.DESCRIPTION
    Convenience wrapper around Apply-XSLT.ps1 that sets the correct paths for
    the README generation pipeline:
        project-info-en.xml  +  ResearchProject-readme.xslt  →  README.md

    Unlike a plain XSLT transform, this script does NOT overwrite the whole
    file. It preserves everything in README.md up to and including the
    "## Project information as schema ResearchProject" marker heading, and
    replaces only the generated content that follows it. This lets the top of
    the README stay hand-written while the ResearchProject section is kept in
    sync with project-info-en.xml.

.PARAMETER Marker
    The heading line in README.md after which generated content is inserted.
    Everything before and including this line is left untouched; everything
    after it is replaced on each run.

.EXAMPLE
    cd C:\gitlab\opp
    .\project-info\scripts\Make-Readme.ps1

.NOTES
    Part of the OPP project information pipeline.
    See project-info\pipeline.md for the full workflow description.
#>

param(
    [string] $Marker = '## Project information as schema ResearchProject'
)

$schemaDir   = Join-Path $PSScriptRoot '..'
$projectInfo = Join-Path $PSScriptRoot '..\..'
$repoRoot    = Join-Path $PSScriptRoot '..\..\..'
$readmePath  = [System.IO.Path]::GetFullPath((Join-Path $repoRoot 'README.md'))

# Transform the XML into a temporary fragment file rather than writing
# straight to README.md.
$fragmentPath = Join-Path ([System.IO.Path]::GetTempPath()) 'researchproject-readme-fragment.md'

& (Join-Path $PSScriptRoot 'Apply-XSLT.ps1') `
    -Source      (Join-Path $projectInfo 'project-info-en.xml') `
    -Stylesheet  (Join-Path $schemaDir   'ResearchProject-readme.xslt') `
    -Output      $fragmentPath

if (-not (Test-Path $fragmentPath)) {
    Write-Error "Transform did not produce a fragment: $fragmentPath"
    exit 1
}
$fragment = (Get-Content -Raw -Encoding UTF8 $fragmentPath).TrimEnd()
Remove-Item $fragmentPath -Force

if (-not (Test-Path $readmePath)) {
    Write-Error "README.md not found: $readmePath"
    exit 1
}
$readmeLines = Get-Content -Encoding UTF8 $readmePath
$markerIndex = ($readmeLines | Select-String -Pattern ([regex]::Escape($Marker)) -SimpleMatch:$false).LineNumber

if (-not $markerIndex) {
    Write-Error "Marker heading not found in README.md: `"$Marker`""
    exit 1
}

# LineNumber is 1-based; keep everything through the marker line, then append
# the freshly generated fragment.
$kept    = $readmeLines[0..($markerIndex - 1)] -join "`n"
$newText = "$kept`n`n$fragment`n"

[System.IO.File]::WriteAllText($readmePath, $newText, [System.Text.Encoding]::UTF8)
Write-Host "OK  Updated $readmePath after marker `"$Marker`"" -ForegroundColor Green
