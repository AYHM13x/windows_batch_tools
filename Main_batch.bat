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
echo 1. Activate Windows / Office (windows_maintenance_script.bat)
echo 2. Create Special Folders (Special_Folders.bat)
echo 3. Refresh Icons (refresh_icons.bat)
echo 4. Windows Maintenance (windows_maintenance_script.bat)
echo 5. Windows Utility and Get Apps (tweaks_get_apps.bat)
echo 6. System Repairs (SFC / DISM)
echo 7. Restart Audio Services
echo 8. Quick Scan Drive C (CHKDSK)
echo 0. Exit
echo ============================================
set /p choice="Select an option (0-8): "

if "%choice%"=="1" goto run_microsoft_activation_scripts
if "%choice%"=="2" goto run_create_special_folders
if "%choice%"=="3" goto run_refresh_icons
if "%choice%"=="4" goto run_windows_maintenance
if "%choice%"=="5" goto run_winutilis
if "%choice%"=="6" goto run_sys_repair
if "%choice%"=="7" goto run_restart_audio
if "%choice%"=="8" goto run_chkdsk
if "%choice%"=="0" goto exit_script

echo Invalid choice. Try again.
pause
goto menu

:run_microsoft_activation_scripts
if exist "MAS_AIO.cmd" (
    call "MAS_AIO.cmd"
) else (
    echo File God_Tools.bat not found.
)
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
if exist "tweaks&get_apps.bat" (
    call "tweaks&get_apps.bat"
) else (
    echo File tweaks&get_apps.bat not found.
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