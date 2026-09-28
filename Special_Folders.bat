@echo off
setlocal EnableExtensions

color 0A

:: Prompt user for destination directory
echo.
echo Select destination directory for SpecialFolders:
echo Press [ENTER] to use default script directory (%~dp0)
echo.
set "USER_DIR="
set /p "USER_DIR=Enter path: "

:: If user pressed Enter, set to script directory, else use input
if defined USER_DIR (
    set "TARGET_DIR=%USER_DIR%"
) else (
    set "TARGET_DIR=%~dp0"
)

:: Strip surrounding quotes if present
set "TARGET_DIR=%TARGET_DIR:"=%"

:: Remove trailing backslash if present
if "%TARGET_DIR:~-1%"=="\" set "TARGET_DIR=%TARGET_DIR:~0,-1%"

:: Set final base directory path
set "BASE=%TARGET_DIR%\SpecialFolders"

echo.
echo [INFO] Target Path: "%BASE%"

:: Check base directory existence
if exist "%BASE%" (
    echo [INFO] Directory "%BASE%" already exists.
) else (
    echo [INFO] Creating directory "%BASE%"...
    mkdir "%BASE%" 2>nul || (
        echo [ERROR] Failed to create directory "%BASE%". Run as Administrator or check permissions.
        exit /b 1
    )
)

:: Apply custom folder icon (Control Panel style)
attrib -r -s -h "%BASE%\desktop.ini" >nul 2>&1
(
    echo [.ShellClassInfo]
    echo IconResource=%SystemRoot%\System32\imageres.dll,137
    echo IconFile=%SystemRoot%\System32\imageres.dll
    echo IconIndex=137
) > "%BASE%\desktop.ini"
attrib +h +s "%BASE%\desktop.ini" >nul
attrib +r "%BASE%" >nul

:: Create CLSID Special Folders
echo [INFO] Generating system shortcuts...

call :MakeCLSID "God Mode" "{ED7BA470-8E54-465E-825C-99712043E01C}"
call :MakeCLSID "Action Center" "{D555645E-D4F8-4c29-A827-D93C859C4F2A}"
call :MakeCLSID "Network Connections" "{7007ACC7-3202-11D1-AAD2-00805FC1270E}"
call :MakeCLSID "Devices and Printers" "{A8A91A66-3A7D-4424-8D24-04E180695C7A}"
call :MakeCLSID "Programs and Features" "{7b81be6a-ce2b-4676-a29e-eb907a5126c5}"
call :MakeCLSID "Windows Firewall" "{4026492F-2F69-46B8-B9BF-5654FC07E423}"
call :MakeCLSID "Troubleshooting" "{C58C4893-3BE0-4B45-ABB5-A63E4B8C8651}"
call :MakeCLSID "Credential Manager" "{1206F5F1-0569-412C-8FEC-3204630DFB70}"
call :MakeCLSID "AutoPlay" "{9C60DE1E-E5FC-40f4-A487-460851A8D915}"
call :MakeCLSID "Administrative Tools" "{D20EA4E1-3957-11d2-A40B-0C5020524153}"
call :MakeCLSID "System" "{BB06C0E4-D293-4f75-8A90-CB05B6477EEE}"
call :MakeCLSID "Personalization" "{ED834ED6-4B5A-4bfe-8F11-A626DCB6A921}"
call :MakeCLSID "Power Options" "{025A5937-A6BE-4686-A844-36FE4BEC8B6D}"
call :MakeCLSID "User Accounts" "{60632754-c523-4b62-b45c-4172da012619}"
call :MakeCLSID "RemoteApp and Desktop Connections" "{241D7C96-F8BF-4F85-B01F-E2B043341A4B}"

:: Generate Batch Launchers
echo [INFO] Generating script launchers...

call :MakeBatch "Date_and_Time.bat" "timedate.cpl"
call :MakeBatch "Display_Settings.bat" "start ms-settings:display"
call :MakeBatch "Folder_Options.bat" "control folders"
call :MakeBatch "Keyboard_Properties.bat" "control keyboard"
call :MakeBatch "Mouse_Properties.bat" "control mouse"
call :MakeBatch "Mobility_Center.bat" "mblctr"
call :MakeBatch "Performance_Monitor.bat" "perfmon.msc"
call :MakeBatch "Windows_Update.bat" "start ms-settings:windowsupdate"

:: Force Explorer refresh for icon/desktop.ini application
ie4uinit.exe -show >nul 2>&1

echo.
echo [SUCCESS] Operation completed in: %BASE%
goto :eof

:: Helper routine for CLSID folder creation
:MakeCLSID
if not exist "%BASE%\%~1.%~2" mkdir "%BASE%\%~1.%~2"
goto :eof

:: Helper routine for launcher file generation
:MakeBatch
(
    echo @echo off
    echo %~2
) > "%BASE%\%~1"
goto :eof