@echo off
rem Build the MSI installers (x86, x64 and ARM64) from the binaries produced by build.cmd (signed by sign.cmd).
rem Usage: msi.cmd [Release|Debug]
setlocal
set CFG=%1
if "%CFG%"=="" set CFG=Release
for /f "usebackq delims=" %%i in (`"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -prerelease -requires Microsoft.Component.MSBuild -find MSBuild\**\Bin\MSBuild.exe`) do set MSBUILD=%%i
if not defined MSBUILD (echo MSBuild not found & exit /b 1)
for %%p in (x86 x64 ARM64) do (
  "%MSBUILD%" "%~dp0OpenPGPSetup\OpenPGPSetup.wixproj" /restore /p:Configuration=%CFG% /p:Platform=%%p /m /nologo /v:m || exit /b 1
)
