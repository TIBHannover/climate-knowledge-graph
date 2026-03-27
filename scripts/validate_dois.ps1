# Validates DOIs listed in data/doi/ar6-doi.csv using CrossRef API
# Writes results to data/doi/ar6-doi-validation.csv

$repoRoot = 'C:\git\climate-knowledge-graph'
$input = Join-Path $repoRoot 'data\doi\ar6-doi.csv'
$output = Join-Path $repoRoot 'data\doi\ar6-doi-validation.csv'

if (-not (Test-Path $input)) {
    Write-Error "Input file not found: $input"
    exit 2
}

$lines = Get-Content -Path $input | ForEach-Object { $_.Trim() } | Where-Object { $_ -ne '' }
# skip header if present
if ($lines.Count -gt 0 -and ($lines[0] -match 'DOI' -or $lines[0].Trim('"') -eq 'DOI')) {
    $lines = $lines | Select-Object -Skip 1
}

$results = @()

$ua = 'ckg-doi-validator/1.0 (mailto:info@example.org)'

foreach ($raw in $lines) {
    $rawTrim = $raw.Trim('"')
    $doi = $rawTrim -replace '^https?://(dx\.)?doi\.org/','' -replace '^doi:',''
    $doi = $doi.Trim()
    if ($doi -eq '') { continue }
    $enc = [uri]::EscapeDataString($doi)
    $url = "https://api.crossref.org/works/$enc"
    Write-Host "Checking: $doi"
    try {
        $resp = Invoke-RestMethod -Uri $url -Headers @{ 'User-Agent' = $ua } -ErrorAction Stop -TimeoutSec 30
        $status = 'OK'
        $title = ''
        if ($resp.message.title) { $title = ($resp.message.title -join ' ') }
        $publisher = $resp.message.publisher -as [string]
        $published = ''
        if ($resp.message.'published-print') { $published = ($resp.message.'published-print'.'date-parts' -join '-') }
        $crossref_url = $resp.message.URL -as [string]
        $type = $resp.message.type -as [string]
    } catch {
        $status = 'NOTFOUND'
        $title = $_.Exception.Message -replace '\r|\n',' '
        $publisher = ''
        $published = ''
        $crossref_url = ''
        $type = ''
    }

    $obj = [PSCustomObject]@{
        input = $rawTrim
        doi = $doi
        status = $status
        type = $type
        title = $title
        publisher = $publisher
        published = $published
        crossref_url = $crossref_url
    }
    $results += $obj
}

# Ensure output dir exists
$dir = Split-Path -Path $output -Parent
if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }

$results | Export-Csv -Path $output -NoTypeInformation -Encoding UTF8
Write-Host "Wrote report to $output"

# Print summary
$ok = ($results | Where-Object { $_.status -eq 'OK' }).Count
$not = ($results | Where-Object { $_.status -ne 'OK' }).Count
Write-Host "Summary: $ok valid, $not invalid / not found"