# Generates an RDM-style markdown report from ar6-doi-validation.csv
$csvPath = 'data\doi\ar6-doi-validation.csv'
$outPath = 'data\doi\ar6-doi-rdm-plan.md'

if (-not (Test-Path $csvPath)) { Write-Error "CSV not found: $csvPath"; exit 2 }
$csv = Import-Csv $csvPath

$metaTotal = $csv.Count
$types = $csv | Group-Object type | Sort-Object Count -Descending
$publishers = ($csv | Group-Object publisher | Sort-Object Count -Descending) | Select-Object -First 10

$out = @()
$out += '# AR6 DOI Validation — RDM Plan'
$out += ""
$out += ('**Generated:** ' + (Get-Date -Format 'yyyy-MM-dd'))
$out += ''
$out += '## Overview'
$out += ''
$out += ('- Source CSV: data/doi/ar6-doi-validation.csv')
$out += ('- Total DOIs checked: ' + $metaTotal.ToString())
$out += ''
$out += '## Data summary'
$out += ''
$out += '### Types'
$out += ''
$out += 'Type | Count'
$out += '--- | ---'
foreach ($t in $types) { $out += ($t.Name + ' | ' + $t.Count.ToString()) }
$out += ''
$out += '### Top publishers'
$out += ''
$out += 'Publisher | Count'
$out += '--- | ---'
foreach ($p in $publishers) { $out += ($p.Name + ' | ' + $p.Count.ToString()) }
$out += ''
$out += '### OpenAlex coverage'
$out += ''
$oaFound = ($csv | Where-Object { $_.openalex_id -and $_.openalex_id -ne '' }).Count
$oaMiss  = $metaTotal - $oaFound
$out += ('- OpenAlex IDs found: ' + $oaFound.ToString() + ' / ' + $metaTotal.ToString())
$out += ('- Not in OpenAlex: ' + $oaMiss.ToString())
$out += '- Lookup strategies used: direct doi: prefix, lowercase, full URL, filter search (see data/doi/check_openalex_ids.ps1).'
$out += '- Most IPCC book-chapters and monographs are not yet indexed in OpenAlex.'
$out += ''
$out += '## Data management and reuse'
$out += ''
$out += '- DOI metadata retrieved from CrossRef via data/doi/validate_dois.ps1.'
$out += '- Publication dates fetched from CrossRef via data/doi/fetch_pub_dates.ps1.'
$out += '- OpenAlex IDs retrieved via data/doi/check_openalex_ids.ps1 and merged with data/doi/merge_openalex.ps1.'
$out += '- All scripts are included in data/doi/ for reproducibility.'
$out += ''
$out += '## Full list of DOIs and metadata'
$out += ''
$out += 'DOI | Type | Published | Title | Publisher | Status | CrossRef URL | OpenAlex ID'
$out += '--- | --- | --- | --- | --- | --- | --- | ---'
foreach ($r in $csv) {
    $doi = $r.doi
    $type = if ($r.type) { $r.type } else { '' }
    $title = ($r.title -replace '\r|\n',' ') -replace '"','' 
    $pub = ($r.publisher -replace '\r|\n',' ') -replace '"',''
    $status = $r.status
    $url = $r.crossref_url
    $openalex = ''
    if ($r.PSObject.Properties.Match('openalex_id')) { $openalex = $r.openalex_id }
    $published = ''
    if ($r.PSObject.Properties.Match('published')) { $published = $r.published }
    $out += ($doi + ' | ' + $type + ' | ' + $published + ' | ' + $title + ' | ' + $pub + ' | ' + $status + ' | ' + $url + ' | ' + $openalex)
}

$out += ''
$out += '## Provenance and reproducibility'
$out += ''
$out += ('- Validator script: data/doi/validate_dois.ps1')
$out += ('- Type summary script: data/doi/summarize_doi_types.ps1')
$out += ('- OpenAlex checker: data/doi/check_openalex_ids.ps1')
$out += ('- OpenAlex merger: data/doi/merge_openalex.ps1')
$out += ('- RDM plan generator: data/doi/generate_rdm_plan.ps1')
$out += ''
$out += '## Licensing and access'
$out += ''
$out += '- Metadata harvested from CrossRef (their terms apply).'
$out += '- This RDM plan and validation CSV are released with the repository under the repository license.'

$out | Out-File -FilePath $outPath -Encoding UTF8
Write-Host "Wrote $outPath"