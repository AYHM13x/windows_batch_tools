@echo off
color 0A
 
:menu
cls
echo ============================================
echo               Main Menu
echo ============================================
echo 1. Chris Titus Tech's Windows Utility (winutil.ps1)
echo 2. Winhance - Windows Enhancement Utility (Winhance.ps1)
echo 0. Exit
echo ============================================
set /p choice="Select an option (0-2): "

if "%choice%"=="1" goto run_chris_titus
if "%choice%"=="2" goto run_winhance

echo Invalid choice. Try again.
pause
goto menu

:run_chris_titus
if exist "winutil.ps1" (
    powershell.exe -ExecutionPolicy Bypass -File "%~dp0winutil.ps1"
) else (
    echo File winutil.ps1 not found.
)
pause

:run_winhance
if exist "Winhance.ps1" (
    powershell.exe -ExecutionPolicy Bypass -Command "irm "https://get.winhance.net" | iex"
) else (
    echo File Winhance.ps1 not found.
)
pause

:exit_script
exit /b

:eof