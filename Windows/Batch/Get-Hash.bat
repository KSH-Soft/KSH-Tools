rem Get-Hash
REM if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )
@echo off
REM certutil -hashfile %1 SHA256 | findstr /v "hash"
echo.
for /f "skip=1" %%G IN ('certutil -hashfile %1 SHA256 ^| findstr /v "hash"') DO echo %%G
echo.
pause
exit