@echo OFF
title unofficial iw3xo installer
color 0a


fltmc >nul 2>&1 || (
    echo Administrator privileges are required.
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo Right-click on the script and select "Run as administrator".
        pause & exit 1
    )
    exit 0
)

cd %~dp0
if exist "%LOCALAPPDATA%"\CallofDuty4MW (  
	echo Please Make sure you have COD4X deleted and uninstalled before installing
	pause
	cls
)
echo Current Cod4 directory: %~dp0
echo Is this OK? If not make sure the installer is in the COD4 Directory
pause
cls

powershell -Command "Invoke-WebRequest https://github.com/xoxor4d/iw3xo-dev/releases/download/3428/iw3xo_b3428.zip -OutFile iw3xo_b3428.zip"
powershell -Command "Expand-Archive -LiteralPath iw3xo_b3428.zip"
del iw3xo_b3428.zip
md iw3xo\bin\
move iw3xo_b3428\iw3xo\bin\* iw3xo\bin\
move iw3xo_b3428\main\* main\
move iw3xo_b3428\zone\english\* zone\english\
move iw3xo_b3428\*
del /F /S /Q iw3xo_b3428
RMDIR /S /Q iw3xo_b3428

echo Install Complete...

pause