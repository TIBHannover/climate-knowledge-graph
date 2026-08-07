<#
.SYNOPSIS
    Regenerates README.md at the repository root from project-info-en.xml.

.DESCRIPTION
    Convenience wrapper around Apply-XSLT.ps1 that sets the correct paths for
    the README generation pipeline:
        project-info-en.xml  +  ResearchProject-readme.xslt  →  README.md

.EXAMPLE
    cd C:\gitlab\opp
    .\project-info\scripts\Make-Readme.ps1

.NOTES
    Part of the OPP project information pipeline.
    See project-info\pipeline.md for the full workflow description.
#>

$projectInfo = Join-Path $PSScriptRoot '..'
$repoRoot    = Join-Path $PSScriptRoot '..\..'

& (Join-Path $PSScriptRoot 'Apply-XSLT.ps1') `
    -Source      (Join-Path $projectInfo 'project-info-en.xml') `
    -Stylesheet  (Join-Path $projectInfo 'ResearchProject-readme.xslt') `
    -Output      (Join-Path $repoRoot    'README.md')
