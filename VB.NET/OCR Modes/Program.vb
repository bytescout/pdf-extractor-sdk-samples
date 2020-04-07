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


Imports Bytescout.PDFExtractor

' To make OCR work you should add the following references to your project:
' 'Bytescout.PDFExtractor.dll', 'Bytescout.PDFExtractor.OCRExtension.dll'.

Class Program

    Friend Shared Sub Main(args As String())

        ' Input document
        Dim inputDocument As String = ".\SampleWith_Vector_Image_Font.pdf"

        ' Extracting text with different OCRModes
        ' 1. TextFromImagesOnly (Plain Mode)
        Console.WriteLine("---------------------------------" + Environment.NewLine + "Extraction Mode: TextFromImagesOnly " + Environment.NewLine + "---------------------------------")
        Dim resultText As String = _ExtractTextWithSpecificOCRMode(inputDocument, OCRMode.TextFromImagesOnly)
        Console.WriteLine(resultText)

        ' 2. TextFromVectorOnly (Plain Mode)
        Console.WriteLine("---------------------------------" + Environment.NewLine + "Extraction Mode: TextFromVectorOnly " + Environment.NewLine + "---------------------------------")
        resultText = _ExtractTextWithSpecificOCRMode(inputDocument, OCRMode.TextFromVectorsOnly)
        Console.WriteLine(resultText)

        ' 3. TextFromImagesAndFonts (Combined Mode)
        Console.WriteLine("---------------------------------" + Environment.NewLine + "Extraction Mode: TextFromImagesAndFonts " + Environment.NewLine + "---------------------------------")
        resultText = _ExtractTextWithSpecificOCRMode(inputDocument, OCRMode.TextFromImagesAndFonts)
        Console.WriteLine(resultText)

        ' 4. TextFromImagesAndVectorsAndFonts (Combined Mode)
        Console.WriteLine("---------------------------------" + Environment.NewLine + "Extraction Mode: TextFromImagesAndVectorsAndFonts " + Environment.NewLine + "---------------------------------")
        resultText = _ExtractTextWithSpecificOCRMode(inputDocument, OCRMode.TextFromImagesAndVectorsAndFonts)
        Console.WriteLine(resultText)

        Console.ReadLine()

    End Sub

    ''' <summary>
    ''' Extract text from document with specific Ocr Mode
    ''' </summary>
    Friend Shared Function _ExtractTextWithSpecificOCRMode(inputDocument As String, ocrMode As OCRMode) As String

        ' Location of OCR language data files
        Dim ocrLanguageDataFolder As String = "c:\Program Files\Bytescout PDF Extractor SDK\ocrdata_best\"

        ' OCR language
        Dim ocrLanguage As String = "eng" ' "eng" for english, "deu" for German, "fra" for French, "spa" for Spanish etc - according to files in "ocrdata" folder
        ' Find more language files at https://github.com/bytescout/ocrdata/tree/master/ocrdata_best

        ' Create TextExtractor instance
        Using textExtractor As TextExtractor = New TextExtractor("demo", "demo")

            ' Load document to TextExtractor
            textExtractor.LoadDocumentFromFile(inputDocument)

            ' Specify Ocr Mode
            textExtractor.OCRMode = ocrMode

            ' Ocr language data folder path and language
            textExtractor.OCRLanguageDataFolder = ocrLanguageDataFolder
            textExtractor.OCRLanguage = ocrLanguage

            ' Return extracted text
            Return textExtractor.GetText()

        End Using

    End Function

End Class
