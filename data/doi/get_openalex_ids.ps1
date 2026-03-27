# Retrieve OpenAlex IDs for DOIs listed in data/doi/ar6-doi-validation.csv
# Writes results to data/doi/ar6-doi-with-openalex.csv

$input = 'data\doi\ar6-doi-validation.csv'
$output = 'data\doi\ar6-doi-with-openalex.csv'

if (-not (Test-Path $input)) { Write-Error "Input not found: $input"; exit 2 }
$rows = Import-Csv $input

$ua = 'ckg-openalex-retriever/1.0 (mailto:info@example.org)'

$results = @()
foreach ($r in $rows) {
    $doi = $r.doi
    if (-not $doi) { continue }
    $key = 'doi:' + $doi
    $enc = [uri]::EscapeDataString($key)
    $url = "https://api.openalex.org/works/$enc"
    Write-Host "Querying OpenAlex for: $doi"
    $openalex_id = ''
    try {
        $resp = Invoke-RestMethod -Uri $url -Headers @{ 'User-Agent' = $ua } -ErrorAction Stop -TimeoutSec 30
        if ($resp.id) { $openalex_id = $resp.id }
    } catch {
        # Try fallback search by filter
        try {
            $filter = [uri]::EscapeDataString("doi:$doi")
            $searchUrl = "https://api.openalex.org/works?filter=$filter"
            $sresp = Invoke-RestMethod -Uri $searchUrl -Headers @{ 'User-Agent' = $ua } -ErrorAction Stop -TimeoutSec 30
            if ($sresp.results -and $sresp.results.Count -gt 0) { $openalex_id = $sresp.results[0].id }
        } catch {
            $openalex_id = ''
        }
    }

    $obj = [PSCustomObject]@{
        input = $r.input
        doi = $r.doi
        status = $r.status
        type = $r.type
        title = $r.title
        publisher = $r.publisher
        published = $r.published
        crossref_url = $r.crossref_url
        openalex_id = $openalex_id
    }
    $results += $obj
}

$results | Export-Csv -Path $output -NoTypeInformation -Encoding UTF8
Write-Host "Wrote $output"
$found = ($results | Where-Object { $_.openalex_id -ne '' }).Count
$total = $results.Count
Write-Host "OpenAlex IDs found: $found / $total"