@echo off
:: Ensure administrator privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Administrative privileges required. Escalating...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Windows Maintenance Script
color 0A

:: Initialize Log File Path
set "LOGFILE=%SystemDrive%\maintenance_log.txt"
if exist "%LOGFILE%" del "%LOGFILE%"

echo =========================================== >> "%LOGFILE%"
echo Windows Maintenance Log - %date% %time% >> "%LOGFILE%"
echo =========================================== >> "%LOGFILE%"
echo. >> "%LOGFILE%"

echo Cleaning System Temp...
echo --- Cleaning System Temp --- >> "%LOGFILE%"
del /s /f /q "C:\Windows\Temp\*.*" >> "%LOGFILE%" 2>&1
for /d %%p in ("C:\Windows\Temp\*") do rmdir /s /q "%%p" >> "%LOGFILE%" 2>&1

echo =========================== >> "%LOGFILE%"

echo Cleaning User Temp...
echo --- Cleaning User Temp --- >> "%LOGFILE%"
del /s /f /q "%temp%\*.*" >> "%LOGFILE%" 2>&1
for /d %%p in ("%temp%\*") do rmdir /s /q "%%p" >> "%LOGFILE%" 2>&1

echo =========================== >> "%LOGFILE%"

echo Cleaning Windows Update Cache...
echo --- Cleaning Windows Update Cache --- >> "%LOGFILE%"
net stop wuauserv >> "%LOGFILE%" 2>&1
net stop bits >> "%LOGFILE%" 2>&1
del /s /f /q "C:\Windows\SoftwareDistribution\Download\*.*" >> "%LOGFILE%" 2>&1
net start wuauserv >> "%LOGFILE%" 2>&1
net start bits >> "%LOGFILE%" 2>&1

echo =========================== >> "%LOGFILE%"

echo Cleaning Recycle Bin...
echo --- Cleaning Recycle Bin --- >> "%LOGFILE%"
echo Cleaning Recycle Bin...
rd /s /q C:\$Recycle.Bin >> "%LOGFILE%" 2>&1
echo Cleaning Recycle Bin is Done >> "%LOGFILE%"

echo =========================== >> "%LOGFILE%"

echo Resetting Network and Flushing DNS...
echo --- Resetting Network and Flushing DNS --- >> "%LOGFILE%"
ipconfig /flushdns >> "%LOGFILE%" 2>&1
ipconfig /registerdns >> "%LOGFILE%" 2>&1
ipconfig /release >> "%LOGFILE%" 2>&1
ipconfig /renew >> "%LOGFILE%" 2>&1
netsh winsock reset >> "%LOGFILE%" 2>&1

echo =========================== >> "%LOGFILE%"

echo Cleaning Delivery Optimization Cache...
echo --- Cleaning Delivery Optimization Cache --- >> "%LOGFILE%"
net stop dosvc >> "%LOGFILE%" 2>&1
del /s /f /q "C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache\*.*" >> "%LOGFILE%" 2>&1
net start dosvc >> "%LOGFILE%" 2>&1

echo =========================== >> "%LOGFILE%"

echo Cleaning Windows Prefetch...
echo --- Cleaning Windows Prefetch --- >> "%LOGFILE%"
del /s /f /q "C:\Windows\Prefetch\*.*" >> "%LOGFILE%" 2>&1

echo =========================== >> "%LOGFILE%"

echo.
echo Maintenance completed successfully.
echo.

:ASK_LOG
set /p CHOICE="Do you want to view the detailed log file? (Y/N): "
if /i "%CHOICE%"=="Y" goto SHOW_LOG
if /i "%CHOICE%"=="N" goto CLOSE_SCRIPT
echo Invalid input. Please enter Y or N.
goto ASK_LOG

:SHOW_LOG
start notepad "%LOGFILE%"
goto CLOSE_SCRIPT

:CLOSE_SCRIPT
exit /b