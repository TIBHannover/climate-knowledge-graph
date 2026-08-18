<#
.SYNOPSIS
    Transforms a ResearchProject XML instance into an HTML5 webpage using XSLT.

.DESCRIPTION
    Uses .NET's built-in XslCompiledTransform — no extra software (Saxon, xsltproc)
    required. Handles the ResearchProject.dtd DOCTYPE declaration by enabling
    DtdProcessing.Parse on the XmlReader.

.PARAMETER Source
    Path to the XML source file. Defaults to project-info-en.xml in the same
    directory as this script.

.PARAMETER Output
    Path for the generated HTML file. Defaults to the source filename with .html
    extension in the same directory as this script.

.PARAMETER Stylesheet
    Path to the XSLT stylesheet. Defaults to ResearchProject.xslt in the same
    directory as this script.

.EXAMPLE
    # Default: transform project-info-en.xml → project-info-en.html
    .\Apply-XSLT.ps1

.EXAMPLE
    # Transform the German XML instance
    .\Apply-XSLT.ps1 -Source project-info-de.xml -Output project-info-de.html

.EXAMPLE
    # Explicit paths (run from any directory)
    .\Apply-XSLT.ps1 `
        -Source    "C:\gitlab\opp\project-info\project-info-en.xml" `
        -Output    "C:\gitlab\opp\project-info\project-info-en.html" `
        -Stylesheet "C:\gitlab\opp\project-info\ResearchProject.xslt"

.NOTES
    Part of the OPP project information pipeline.
    See pipeline.md for the full workflow description.
    Schema: https://schema.org/ResearchProject
#>

[CmdletBinding()]
param(
    [string] $Source,
    [string] $Output,
    [string] $Stylesheet
)

# Resolve defaults relative to the script's own directory
$scriptDir = $PSScriptRoot

if (-not $Source) {
    $Source = Join-Path $scriptDir "..\..\project-info-en.xml"
}
if (-not $Stylesheet) {
    $Stylesheet = Join-Path $scriptDir "..\ResearchProject.xslt"
}
if (-not $Output) {
    $baseName = [System.IO.Path]::GetFileNameWithoutExtension($Source)
    $Output   = Join-Path $scriptDir "..\..\$baseName.html"
}

# Resolve to absolute paths
$Source     = [System.IO.Path]::GetFullPath($Source)
$Stylesheet = [System.IO.Path]::GetFullPath($Stylesheet)
$Output     = [System.IO.Path]::GetFullPath($Output)

# Validate inputs
if (-not (Test-Path $Source)) {
    Write-Error "Source XML not found: $Source"
    exit 1
}
if (-not (Test-Path $Stylesheet)) {
    Write-Error "XSLT stylesheet not found: $Stylesheet"
    exit 1
}

Write-Host "Source     : $Source"
Write-Host "Stylesheet : $Stylesheet"
Write-Host "Output     : $Output"
Write-Host ""

try {
    # Load and compile the XSLT stylesheet
    # $true enables XSLT debug mode (useful for error messages)
    $xslt = [System.Xml.Xsl.XslCompiledTransform]::new($true)
    $xslt.Load($Stylesheet)

    # Load the XML source with DTD processing enabled
    # (ResearchProject XML uses <!DOCTYPE ResearchProject SYSTEM "ResearchProject.dtd">)
    $readerSettings = [System.Xml.XmlReaderSettings]::new()
    $readerSettings.DtdProcessing = [System.Xml.DtdProcessing]::Parse

    $reader = [System.Xml.XmlReader]::Create($Source, $readerSettings)
    $doc    = [System.Xml.XPath.XPathDocument]::new($reader)
    $reader.Close()

    # Write output as UTF-8
    $writer = [System.IO.StreamWriter]::new(
        $Output, $false, [System.Text.Encoding]::UTF8
    )
    $xslt.Transform($doc, $null, $writer)
    $writer.Close()

    $size = (Get-Item $Output).Length
    Write-Host "OK  Generated $Output  ($size bytes)" -ForegroundColor Green

} catch {
    Write-Error "Transform failed: $_"
    exit 1
}
