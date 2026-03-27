$csv = Import-Csv 'data\doi\ar6-doi-validation.csv'
$groups = $csv | Group-Object -Property type | Sort-Object Count -Descending
$out = @()
$out += '# DOI Types Summary'
$out += ''
$out += 'Source: data/doi/ar6-doi-validation.csv'
$out += ''
$out += 'Type | Count'
$out += '--- | ---'
foreach ($g in $groups) { $out += "$($g.Name) | $($g.Count)" }
$out += ''
$out += 'Top sample entries per type:'
foreach ($g in $groups) {
    $out += ''
    $out += "## $($g.Name) - $($g.Count)"
    $sample = $csv | Where-Object { $_.type -eq $g.Name } | Select-Object -First 5
    foreach ($s in $sample) { $out += "- $($s.doi) - $($s.title)" }
}
$out | Out-File 'data\doi\ar6-doi-types-summary.md' -Encoding UTF8
Write-Host 'Wrote data/doi/ar6-doi-types-summary.md'