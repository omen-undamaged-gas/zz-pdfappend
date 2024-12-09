@echo off
rem white-black
color f0
set sendto="%AppData%\Microsoft\Windows\SendTo"

echo Copy zz-pdfappend files to %sendto%
@pushd %~dp0
copy zz-pdfappend* %sendto% /-Y
@popd

echo Install PSWritePDF module...
powershell.exe -command "Install-Module PSWritePDF -Force -Scope CurrentUser"
echo.

echo Please edit 'zz-pdfappend.ps1' and change '^$pdf_append' to your own path.
pause
