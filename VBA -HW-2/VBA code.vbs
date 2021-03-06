Sub test():

'------------------------------------------
'Looping through all sheets in the workbook
'------------------------------------------
 For Each ws In Worksheets
'------------------
'Defining Variables
'-----------------


Dim stockvolume, increase, maxstock, counter, finalrow, hcounter As Double
Dim yend, ystart, difference, percentvalue, growth, fall As Variant
Dim pc1, pc2, pc3, currentticker, tickervalue, sheetname As String
Dim headings(1 To 4) As String

headings(1) = "Ticker"
headings(2) = "Yearly Change"
headings(3) = "Percent Change"
headings(4) = "Total Stock Volume"

'-------------------------------
'Adding Headings to the Solution
'-------------------------------


hcounter = 1

For i = 11 To 14

ws.Cells(1, i).Value = headings(hcounter)
hcounter = hcounter + 1

Next i



'-------------------------------------------------
'Since first row is for header, loop starts at i=2
'-------------------------------------------------
    lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row     ' finding the total number of rows in data
    counter = 2
For i = 2 To lastrow
    If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
        currentticker = ws.Cells(i, 1).Value
        yend = ws.Cells(i, 6).Value
        ystart = ws.Cells(i - increase, 3).Value
        difference = yend - ystart
        
        
    'Handling DIV/0 error in below code
        
        '__ __ __ __ __ __
        
        If ystart <> 0 Then
            percentvalue = difference / ystart
        Else
        End If
        '__ __ __ __ __ __
        
        
     
     
        pc1 = FormatPercent(percentvalue, 2)    'Converting pc1 to percent format
    
        ws.Range("L" & counter).Value = difference
        ws.Range("M" & counter).Value = pc1
        stockvolume = stockvolume + ws.Cells(i, 7).Value
        ws.Range("N" & counter).Value = stockvolume
        ws.Range("K" & counter).Value = currentticker
        counter = counter + 1               'Using counter cariable to add values to the nextline
        
        stockvolume = 0                     'Declaring initial stock-volume value as zero and looping over it to find the total sum
        increase = 0
    Else:
        stockvolume = stockvolume + ws.Cells(i, 7).Value
        
        increase = increase + 1     'Using variable to find the first open stock value in each ticker
    
    End If
Next i
    
    
    
    
    
    finalrow = ws.Cells(Rows.Count, 12).End(xlUp).Row     'finding the total number of rows in the summary table
    For i = 2 To finalrow
        If ws.Cells(i, 12).Value > 0 Then
            ws.Cells(i, 12).Interior.ColorIndex = 4     'Colorcoding postive as green and negative as red
        Else:
            ws.Cells(i, 12).Interior.ColorIndex = 3
        End If
    Next i
    
    
    
    
    
 '-----------------------------------------------------
 'Finding MaxStock and Maximum Percent Difference Below
 '-----------------------------------------------------
    
    maxstock = 0        'Inital Maxstock value is zero
    growth = 0          'Inital Max Positice percent change value = 0
    fall = 0            'inital Max Negative percent change value = 0
    
    
    
    For i = 2 To finalrow
        If ws.Cells(i, 14).Value > maxstock Then
            maxstock = ws.Cells(i, 14).Value        'Assigning the currentstock value to maxstock as long as the max value is found
            tickervalue = ws.Cells(i, 11).Value
            ws.Cells(4, 18).Value = tickervalue     'Assigning the corresponsing Tickervalue to the maxstock value
        Else:
            ws.Cells(4, 19).Value = maxstock        'if maxtcok > current stock then assign to a designated range
        End If
    Next i
    
    
 'Similar steps below for max postive percent differene as maxtock value
    
    For i = 2 To finalrow
        If ws.Cells(i, 13).Value > growth Then
            growth = ws.Cells(i, 13).Value
            tickervalue = ws.Cells(i, 11).Value
            ws.Cells(2, 18).Value = tickervalue
        Else:
            pc2 = FormatPercent(growth, 2)
            ws.Cells(2, 19).Value = pc2
        End If
    
    Next i
    
  'Similar steps below for min postive percent differene as maxtock value
  
    
    For i = 2 To finalrow
        If fall > ws.Cells(i, 13).Value Then
            fall = ws.Cells(i, 13).Value
            tickervalue = ws.Cells(i, 11).Value
            ws.Cells(3, 18).Value = tickervalue
    
        Else:
            pc3 = FormatPercent(fall, 2)
            ws.Cells(3, 19).Value = pc3
        End If
    Next i
 '_____________________________________________________________________
    
    
  'Adding Headers to Table in designated ranges
    
    ws.Cells(2, 17).Value = "Greatest % Increase"
    ws.Cells(3, 17).Value = "Greatest % Decrease"
    ws.Cells(4, 17).Value = "Greatest Total Volume"
    ws.Cells(1, 18).Value = "Ticker"
    ws.Cells(1, 19).Value = "Value"
    
    'Autofit, borders and bold text for better aesthetics
    sheetname = ws.Name
    ws.Cells(1, 17).Value = sheetname
    
    
    ws.Columns("A:S").AutoFit
    ws.Range("Q1:S4").Borders.LineStyle = xlContinuous
    ws.Range("k1:N" & finalrow).Borders.LineStyle = xlContinuous

    

    
    
    
Next ws
    
    
       
End Sub



