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
)

pause
cls

if exist iw3xo.exe (
	echo It seems you have IW3xo installed already...
	echo We found that this directroy has the iw3xo.exe
)

pause
cls

echo Current Cod4 directory: %~dp0
echo Is this OK? If not make sure the installer is in the COD4 Directory
pause

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

powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/kruumy/iw3xo-one-click-installer/main/START_IW3xo.bat -OutFile START_IW3xo.bat"

cls

REM for somereason latest version of iw3xo's auto iw3mvm loader does not work, using a different dll injector.
if exist "%APPDATA%"\codmvm_launcher\iw3mvm (
	echo Installing IW3MVM
	copy "%APPDATA%"\codmvm_launcher\iw3mvm\IW3MVM_CLIENT.dll iw3xo\bin\iw3mvm.dll.bak
	copy "%APPDATA%"\codmvm_launcher\iw3mvm\IW3MVM_CLIENT.dll iw3mvm.dll
	powershell -Command "Invoke-WebRequest https://github.com/kruumy/iw3xo-one-click-installer/raw/main/mvminjector.zip -OutFile mvminjector.zip"
	powershell -Command "Expand-Archive -LiteralPath mvminjector.zip"
	del mvminjector.zip
	move mvminjector\*
	RMDIR /S /Q mvminjector
)

cls

echo Install Complete...

pause