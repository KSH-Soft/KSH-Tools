@echo off
cls
call:download "http://kashileo.magix.net/public/sims3.rar" "winrar.zip"
exit /b

:download
(echo src = "%~1"
echo Set v1 = CreateObject ("MSXML2.XMLHTTP"^)
echo Set v2  = CreateObject ("ADODB.Stream"^)
echo v1.open "GET", src, false
echo v1.send (^)
echo v2.open
echo v2.Type = 1
echo v2.Write v1.ResponseBody
echo v2.SaveToFile "%~2") >"%~dpn0.vbs"
cscript "%~dpn0.vbs"
del "%~dpn0.vbs" >nul
goto:eof