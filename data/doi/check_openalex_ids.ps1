# Improved OpenAlex ID retrieval for AR6 DOIs
# Tries multiple lookup strategies: direct, lowercase, filter, title search
# Writes results to data/doi/ar6-doi-openalex-check.csv

$input  = 'data\doi\ar6-doi-validation.csv'
$output = 'data\doi\ar6-doi-openalex-check.csv'

if (-not (Test-Path $input)) { Write-Error "Not found: $input"; exit 2 }
$rows = Import-Csv $input
$ua = 'ckg-openalex/1.0 (mailto:info@example.org)'

$results = @()
$foundCount = 0
$notFoundCount = 0

foreach ($r in $rows) {
    $doi = $r.doi
    if (-not $doi) { continue }

    $openalex_id = ''
    $openalex_type = ''
    $method = ''

    # Strategy 1: direct lookup with doi: prefix
    try {
        $url1 = 'https://api.openalex.org/works/doi:' + $doi
        $resp = Invoke-RestMethod -Uri $url1 -Headers @{ 'User-Agent' = $ua } -ErrorAction Stop -TimeoutSec 30
        if ($resp.id) {
            $openalex_id = $resp.id
            $openalex_type = $resp.type
            $method = 'direct'
        }
    } catch {}

    # Strategy 2: direct lookup with lowercase DOI
    if (-not $openalex_id) {
        try {
            $url2 = 'https://api.openalex.org/works/doi:' + $doi.ToLower()
            $resp = Invoke-RestMethod -Uri $url2 -Headers @{ 'User-Agent' = $ua } -ErrorAction Stop -TimeoutSec 30
            if ($resp.id) {
                $openalex_id = $resp.id
                $openalex_type = $resp.type
                $method = 'direct-lower'
            }
        } catch {}
    }

    # Strategy 3: direct lookup with full URL
    if (-not $openalex_id) {
        try {
            $enc = [uri]::EscapeDataString('https://doi.org/' + $doi)
            $url3 = 'https://api.openalex.org/works/' + $enc
            $resp = Invoke-RestMethod -Uri $url3 -Headers @{ 'User-Agent' = $ua } -ErrorAction Stop -TimeoutSec 30
            if ($resp.id) {
                $openalex_id = $resp.id
                $openalex_type = $resp.type
                $method = 'url-lookup'
            }
        } catch {}
    }

    # Strategy 4: filter search
    if (-not $openalex_id) {
        try {
            $url4 = 'https://api.openalex.org/works?filter=doi:' + [uri]::EscapeDataString($doi)
            $resp = Invoke-RestMethod -Uri $url4 -Headers @{ 'User-Agent' = $ua } -ErrorAction Stop -TimeoutSec 30
            if ($resp.results -and $resp.results.Count -gt 0) {
                $openalex_id = $resp.results[0].id
                $openalex_type = $resp.results[0].type
                $method = 'filter'
            }
        } catch {}
    }

    # Strategy 5: filter with full DOI URL
    if (-not $openalex_id) {
        try {
            $url5 = 'https://api.openalex.org/works?filter=doi:' + [uri]::EscapeDataString('https://doi.org/' + $doi)
            $resp = Invoke-RestMethod -Uri $url5 -Headers @{ 'User-Agent' = $ua } -ErrorAction Stop -TimeoutSec 30
            if ($resp.results -and $resp.results.Count -gt 0) {
                $openalex_id = $resp.results[0].id
                $openalex_type = $resp.results[0].type
                $method = 'filter-url'
            }
        } catch {}
    }

    if ($openalex_id) {
        $foundCount++
        Write-Host "FOUND  $doi -> $openalex_id ($method)"
    } else {
        $notFoundCount++
        Write-Host "MISS   $doi"
    }

    $obj = [PSCustomObject]@{
        doi            = $r.doi
        crossref_type  = $r.type
        title          = $r.title
        publisher      = $r.publisher
        crossref_url   = $r.crossref_url
        openalex_id    = $openalex_id
        openalex_type  = $openalex_type
        lookup_method  = $method
    }
    $results += $obj
}

$results | Export-Csv -Path $output -NoTypeInformation -Encoding UTF8
Write-Host ''
Write-Host ('Results: ' + $foundCount.ToString() + ' found, ' + $notFoundCount.ToString() + ' not found, ' + $results.Count.ToString() + ' total')
Write-Host ('Wrote ' + $output)