@echo off
rem Sign the Release binaries (default) or the MSI installers.
rem Usage: sign.cmd <certificate thumbprint or subject name> [bin|msi] [timestamp url]
setlocal
if "%~1"=="" (echo Usage: sign.cmd ^<thumbprint^|subject^> [bin^|msi] [timestamp url] & exit /b 1)
set WHAT=%2
if "%WHAT%"=="" set WHAT=bin
set TS=%3
if "%TS%"=="" set TS=http://time.certum.pl
for /f "delims=" %%i in ('dir /b /s /o-n "%ProgramFiles(x86)%\Windows Kits\10\bin\signtool.exe" ^| findstr /i "\x64\\"') do set SIGNTOOL=%%i
if not defined SIGNTOOL (echo signtool not found & exit /b 1)
set SEL=/sha1 %1
echo %1| findstr /r /c:"^[0-9A-Fa-f]*$" >nul || set SEL=/n "%~1"
if /i "%WHAT%"=="msi" (set FILES=x86\Release\OpenPGPSetup_x86.msi x64\Release\OpenPGPSetup_x64.msi ARM64\Release\OpenPGPSetup_ARM64.msi) else (set FILES=x86\Release\openpgpmdrv32.dll x64\Release\openpgpmdrv64.dll ARM64\Release\openpgpmdrvARM64.dll)
for %%f in (%FILES%) do (
  "%SIGNTOOL%" sign %SEL% /d "OpenPGP minidriver" /tr %TS% /td sha256 /fd sha256 "%~dp0%%f" || exit /b 1
)
