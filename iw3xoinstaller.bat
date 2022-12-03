@echo OFF
title unofficial iw3xo installer
color 0a

set testdir=%~dp0
set myguid={A4E30755-FE04-4ab7-BD7F-E006E37B7BF7}.tmp
set waccess=0
echo.> "%testdir%\%myguid%"&&(set waccess=1&del "%testdir%\%myguid%")

if "%waccess%"=="1" (goto skip)

fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)

:skip

cd %~dp0
if exist "%LOCALAPPDATA%"\CallofDuty4MW (  
	echo Please Make sure you have COD4X deleted and uninstalled before installing
)

pause
cls

if exist iw3xo.exe (
	echo It seems you have IW3xo installed already...
	echo We found that this directroy has the iw3xo.exe
	pause
	cls
)

cd %~dp0

echo Current Cod4 directory: %~dp0
echo Is this OK? If not make sure the installer is in the COD4 Directory
pause

echo Installing iw3xo
powershell -Command "Invoke-WebRequest https://github.com/xoxor4d/iw3xo-dev/releases/download/3430/iw3xo_b3430.zip -OutFile iw3xo_b3430.zip"
powershell -Command "Expand-Archive -LiteralPath iw3xo_b3430.zip"
del iw3xo_b3430.zip
md iw3xo\bin\
move iw3xo_b3430\iw3xo\bin\* iw3xo\bin\
move iw3xo_b3430\main\* main\
move iw3xo_b3430\zone\english\* zone\english\
move iw3xo_b3430\*
del /F /S /Q iw3xo_b3430
RMDIR /S /Q iw3xo_b3430

echo Installing START_IW3xo.bat
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/kruumy/iw3xo-one-click-installer/main/START_IW3xo.bat -OutFile START_IW3xo.bat"

echo Installing IW3MVM
powershell -Command "Invoke-WebRequest https://github.com/kruumy/iw3xo-one-click-installer/raw/main/iw3mvm.dll -OutFile iw3xo\bin\iw3mvm.dll"


echo Install Complete...

pause