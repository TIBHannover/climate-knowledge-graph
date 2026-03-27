# Merge OpenAlex IDs from check CSV into validation CSV
$check = Import-Csv 'data\doi\ar6-doi-openalex-check.csv'
$val   = Import-Csv 'data\doi\ar6-doi-validation.csv'

$lookup = @{}
foreach ($c in $check) {
    if ($c.openalex_id) { $lookup[$c.doi] = $c.openalex_id }
}

$merged = @()
foreach ($v in $val) {
    $oa = ''
    if ($lookup.ContainsKey($v.doi)) { $oa = $lookup[$v.doi] }
    $obj = [PSCustomObject]@{
        input        = $v.input
        doi          = $v.doi
        status       = $v.status
        type         = $v.type
        title        = $v.title
        publisher    = $v.publisher
        published    = $v.published
        crossref_url = $v.crossref_url
        openalex_id  = $oa
    }
    $merged += $obj
}

$merged | Export-Csv 'data\doi\ar6-doi-validation.csv' -NoTypeInformation -Encoding UTF8
$f = ($merged | Where-Object { $_.openalex_id -ne '' }).Count
Write-Host ('Merged. OpenAlex IDs: ' + $f.ToString() + ' / ' + $merged.Count.ToString())