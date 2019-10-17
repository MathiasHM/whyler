@echo off
setlocal
cd /d "%~dp0"

set "problem=%~1"
set "source=problems\%problem%.asm"
if not exist "%source%" (
    echo Usage: build.cmd euler1
    exit /b 1
)

rem Load the installed Visual Studio build tools.
set "vs="
for /f "tokens=*" %%v in ('"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath') do set "vs=%%v"
if not defined vs exit /b 1
call "%vs%\VC\Auxiliary\Build\vcvars64.bat" >nul
if errorlevel 1 exit /b 1

rem Assemble the shared code and selected problem.
set "out=build\%problem%"
if not exist "%out%" mkdir "%out%"
for %%f in (shared\math.asm shared\io.asm shared\runner.asm "%source%") do (
    ml64 /nologo /Zi /Ishared /c /Fo"%out%\%%~nf.obj" "%%~f"
    if errorlevel 1 exit /b 1
)

rem Link and run.
link /nologo /DEBUG /INCREMENTAL:NO /SUBSYSTEM:CONSOLE /ENTRY:main /OUT:"%out%\%problem%.exe" "%out%\%problem%.obj" "%out%\math.obj" "%out%\io.obj" "%out%\runner.obj" kernel32.lib
if errorlevel 1 exit /b 1
"%out%\%problem%.exe"
exit /b %errorlevel%

