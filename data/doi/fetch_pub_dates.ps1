# Fetch publication dates from CrossRef as YYYY-MM-DD and merge into validation CSV
$csvPath = 'data\doi\ar6-doi-validation.csv'
$outPath = 'data\doi\ar6-doi-validation.csv'

if (-not (Test-Path $csvPath)) { Write-Error "Not found: $csvPath"; exit 2 }
$rows = Import-Csv $csvPath
$ua = 'ckg-doi-dates/1.0 (mailto:info@example.org)'

$results = @()
foreach ($r in $rows) {
    $doi = $r.doi
    $pubDate = ''
    if ($doi) {
        $enc = [uri]::EscapeDataString($doi)
        $url = 'https://api.crossref.org/works/' + $enc
        try {
            $resp = Invoke-RestMethod -Uri $url -Headers @{ 'User-Agent' = $ua } -ErrorAction Stop -TimeoutSec 30
            # Try published-print, then published-online, then issued
            $dp = $null
            if ($resp.message.'published-print'.'date-parts') {
                $dp = $resp.message.'published-print'.'date-parts'[0]
            } elseif ($resp.message.'published-online'.'date-parts') {
                $dp = $resp.message.'published-online'.'date-parts'[0]
            } elseif ($resp.message.'issued'.'date-parts') {
                $dp = $resp.message.'issued'.'date-parts'[0]
            }
            if ($dp) {
                $y = $dp[0].ToString()
                $m = if ($dp.Count -ge 2 -and $dp[1]) { $dp[1].ToString().PadLeft(2,'0') } else { '01' }
                $d = if ($dp.Count -ge 3 -and $dp[2]) { $dp[2].ToString().PadLeft(2,'0') } else { '01' }
                $pubDate = $y + '-' + $m + '-' + $d
            }
        } catch {
            $pubDate = ''
        }
    }
    Write-Host ($doi + ' -> ' + $pubDate)

    $obj = [PSCustomObject]@{
        input        = $r.input
        doi          = $r.doi
        status       = $r.status
        type         = $r.type
        title        = $r.title
        publisher    = $r.publisher
        published    = $pubDate
        crossref_url = $r.crossref_url
        openalex_id  = $r.openalex_id
    }
    $results += $obj
}

$results | Export-Csv -Path $outPath -NoTypeInformation -Encoding UTF8
Write-Host ''
Write-Host ('Wrote ' + $outPath + ' with ' + $results.Count.ToString() + ' rows')