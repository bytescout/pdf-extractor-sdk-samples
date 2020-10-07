'*******************************************************************************************'
'                                                                                           '
' Download Free Evaluation Version From:     https://bytescout.com/download/web-installer   '
'                                                                                           '
' Also available as Web API! Get free API Key https://app.pdf.co/signup                     '
'                                                                                           '
' Copyright © 2017-2020 ByteScout, Inc. All rights reserved.                                '
' https://www.bytescout.com                                                                 '
' https://www.pdf.co                                                                        '
'*******************************************************************************************'


' By default, "SearchablePDFMaker" uses one of the standard PDF fonts to apply 
' recognized text over the scanned document. Such fonts contain only basic characters 
' from ISO-8859-1 charset. 
' If you run OCR for one of the languages with characters that are not present in the default
' encoding, you should explicitly specify the font that contains the required characters
' using ".LabelingFont" property.
' If you run the application in Windows with a selected locale that matches OCR language, 
' it will be enough to specify the usual font "Arial". But if your app will run in an unknown
' environment (for example, in some virtual machine) you will need to install some full Unicode 
' font (e.g. "Arial Unicode MS") and then use it with SearchablePDFMaker:
' 
' searchablePDFMaker.LabelingFont = "Arial Unicode MS";

' Create Bytescout.PDFExtractor.SearchablePDFMaker object
Set searchablePDFMaker = CreateObject("Bytescout.PDFExtractor.SearchablePDFMaker")
searchablePDFMaker.RegistrationName = "demo"
searchablePDFMaker.RegistrationKey = "demo"

' Load sample PDF document
searchablePDFMaker.LoadDocumentFromFile("sample_ocr_with_rotatedPage.pdf")

' Set the location of OCR language data files
searchablePDFMaker.OCRLanguageDataFolder = "c:\Program Files\Bytescout PDF Extractor SDK\ocrdata_best"
			
' Set OCR language
' "eng" for english, "deu" for German, "fra" for French, "spa" for Spanish etc - according to files in "ocrdata" folder.
searchablePDFMaker.OCRLanguage = "eng"  
' Find more language files at https://github.com/bytescout/ocrdata

' Set PDF document rendering resolution
searchablePDFMaker.OCRResolution = 300

' Detect page rotation
searchablePDFMaker.OCRDetectPageRotation = true

' Process the document
searchablePDFMaker.MakePDFSearchable("result.pdf")

WScript.Echo "Searchable document saved as 'result.pdf'."
