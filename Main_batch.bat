@echo off
:: Direct administrator elevation check
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

color 0A

cd /d "%~dp0"

:menu
cls
echo ============================================
echo               Main Menu
echo ============================================
echo 1. Create Special Folders (Special_Folders.bat)
echo 2. Refresh Icons (refresh_icons.bat)
echo 3. Windows Maintenance (windows_maintenance_script.bat)
echo 4. Chris Titus Tech's Windows Utility (winutil.ps1)
echo 5. System Repairs (SFC / DISM)
echo 6. Restart Audio Services
echo 7. Quick Scan Drive C (CHKDSK)
echo 0. Exit
echo ============================================
set /p choice="Select an option (0-7): "

if "%choice%"=="1" goto run_create_special_folders
if "%choice%"=="2" goto run_refresh_icons
if "%choice%"=="3" goto run_windows_maintenance
if "%choice%"=="4" goto run_winutilis
if "%choice%"=="5" goto run_sys_repair
if "%choice%"=="6" goto run_restart_audio
if "%choice%"=="7" goto run_chkdsk
if "%choice%"=="0" goto exit_script

echo Invalid choice. Try again.
pause
goto menu

:run_create_special_folders
if exist "Special_Folders.bat" (
    call "Special_Folders.bat"
) else (
    echo File God_Tools.bat not found.
)
pause
goto menu

:run_refresh_icons
if exist "refresh_icons.bat" (
    call "refresh_icons.bat"
) else (
    echo File refresh_icons.bat not found.
)
pause
goto menu

:run_windows_maintenance
if exist "windows_maintenance_script.bat" (
    call "windows_maintenance_script.bat"
) else (
    echo File windows_maintenance_script.bat not found.
)
pause
goto menu

:run_winutilis
if exist "winutil.ps1" (
    powershell.exe -ExecutionPolicy Bypass -File "%~dp0winutil.ps1"
) else (
    echo File winutil.ps1 not found.
)
pause
goto menu

:run_sys_repair
echo Running SFC and DISM Repairs...
sfc /scannow
dism /online /cleanup-image /restorehealth
pause
goto menu

:run_restart_audio
echo Restarting Windows Audio Services...
net stop audiosrv
net stop AudioEndpointBuilder
net start AudioEndpointBuilder
net start audiosrv
pause
goto menu

:run_chkdsk
echo Checking Drive C: for Errors...
chkdsk C: /scan
pause
goto menu

:exit_script
exit /b