﻿#*******************************************************************************************#
#                                                                                           #
# Download Free Evaluation Version From: https://bytescout.com/download/web-installer       #
#                                                                                           #
# Also available as Web API! Get Your Free API Key: https://app.pdf.co/signup               #
#                                                                                           #
# Copyright © 2017-2020 ByteScout, Inc. All rights reserved.                                #
# https://www.bytescout.com                                                                 #
# https://pdf.co                                                                            #
#                                                                                           #
#*******************************************************************************************#

# Note: if you are looking for a more higher level API to extract data from invoices, reports, statements
# then please check Document Parser SDK and Web API at https://bytescout.com/products/developer/documentparsersdk/index.html
# and https://pdf.co for secure and scalable web api

Param (
    [Parameter(Mandatory = $true)]
    [string] $InputFileName = ""
)

#Add reference to Bytescout.PDFExtractor.dll assembly
Add-Type -Path "C:\Program Files\Bytescout PDF Extractor SDK\net4.00\Bytescout.PDFExtractor.dll"

# Check input file exists
if ((Test-Path $InputFileName) -eq $false) {

    Write-Host "Input file does not exist." -ForegroundColor Red
    Exit 0
}

# Create and activate Bytescout.PDFExtractor.TextExtractor instance
$Extractor = New-Object Bytescout.PDFExtractor.TextExtractor
$Extractor.RegistrationName = "demo"
$Extractor.RegistrationKey = "demo"

try {
    # Load sample PDF document
    $Extractor.LoadDocumentFromFile($InputFileName)

    # Get page count
    $PageCount = $Extractor.GetPageCount()
    Write-Host "Pages: $PageCount"

    # Enable the regular expressions
    $Extractor.RegexSearch = $true
    
    # Search dates in format 12/31/1999
    $RegexPattern = "[0-9]{2}/[0-9]{2}/[0-9]{4}"
    # See the complete regular expressions reference at https://msdn.microsoft.com/en-us/library/az24scfc(v=vs.110).aspx

    # Iterate through pages
    for ($i = 0; $i -lt $PageCount; $i++) {

        
        # Search each page for the pattern
        if ($Extractor.Find($i, $RegexPattern, $false) -eq $true) {

            do {
        
                $PageNo = $i + 1
                Write-Host "Found on page $PageNo"
                # Iterate through each element in the found text
                foreach ($Element in $Extractor.FoundText.Elements) {
                
                    Write-Host "Element " $Element.Index
                    Write-Host "Location: " $Element.Left ", " $Element.Top ", " $Element.Width ", " $Element.Height 
                    Write-Host "Text: " $Element.Text
                    Write-Host "Font is bold: " $Element.FontIsBold
                    Write-Host "Font is italic: " $Element.FontIsItalic
                    Write-Host "Font name: " $Element.FontName
                    Write-Host "Font size: " $Element.FontSize
                    Write-Host "Font color: " $Element.FontColor
                }
            } while ($Extractor.FindNext() -eq $true)
        } else {

            Write-Host "Nothing found"
        }
    }
} catch {

    Write-Host $_.Exception.Message
}

$Extractor.Dispose()