'Command line: cscript setServerserviceOn.vbs //E:\vbscript


Dim objWMIService, objItem, objService
Dim colListOfServices, strComputer, strService

strComputer = "."

' NB strService is case sensitive.
strService = " 'lanmanserver' "

Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\" & strComputer & "\root\cimv2")

Set colListOfServices = objWMIService.ExecQuery ("Select * from Win32_Service Where Name ="& strService & " ")
For Each objService in colListOfServices

  objService.ChangeStartMode("Automatic")

  objService.StopService()

  WScript.Sleep 10000

  objService.StartService()

'WScript.Echo objService.Name
'Wscript.Echo objService.DisplayName
Next

WScript.Echo "Set to Automatic, then Stopped and Started " & strService 


'Function ConfigureService(sService, iType, sNode)

'Dim oComputer, oService
'Set oComputer = GetObject("WinNT://" & sNode & ",computer")

'On Error Resume Next
'Set oService = oComputer.GetObject("Service", sService)
'If Err.Number <> 0 Then
'ConfigureService = False
'Exit Function
'End If

'If oService.StartType <> iType Then
'oService.StartType = iType
'oService.SetInfo
'WScript.Sleep 1000
'End If

'ConfigureService = True
'End Function
