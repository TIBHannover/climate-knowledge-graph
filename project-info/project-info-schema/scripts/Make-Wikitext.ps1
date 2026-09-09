<#
.SYNOPSIS
    Generates MediaWiki wikitext from the ResearchProject XML source.

.DESCRIPTION
    Convenience wrapper around Apply-XSLT.ps1 for wikitext output:
        project-info-<lang>.xml + ResearchProject-wikitext.xslt
        -> project-info-<lang>.wikitext

    The generated file is written to the project-info directory.

.PARAMETER Source
    XML source file. Defaults to project-info-en.xml.

.PARAMETER Output
    Output wikitext file path. Defaults to source basename + .wikitext.

.EXAMPLE
    .\Make-Wikitext.ps1

.EXAMPLE
    .\Make-Wikitext.ps1 -Source ..\..\project-info-de.xml
#>

[CmdletBinding()]
param(
    [string] $Source,
    [string] $Output
)

$schemaDir   = Join-Path $PSScriptRoot '..'
$projectInfo = Join-Path $PSScriptRoot '..\..'

if (-not $Source) {
    $Source = Join-Path $projectInfo 'project-info-en.xml'
}

$Source = [System.IO.Path]::GetFullPath($Source)

if (-not $Output) {
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($Source)
    $Output   = Join-Path $projectInfo "$baseName.wikitext"
}

$Output = [System.IO.Path]::GetFullPath($Output)

& (Join-Path $PSScriptRoot 'Apply-XSLT.ps1') `
    -Source     $Source `
    -Stylesheet (Join-Path $schemaDir 'ResearchProject-wikitext.xslt') `
    -Output     $Output

if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

Write-Host "OK  Generated wikitext: $Output" -ForegroundColor Green
