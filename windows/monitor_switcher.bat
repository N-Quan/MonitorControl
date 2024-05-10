@echo off
setlocal

REM Set the path to the configuration file
set "config_file=..\config.txt"

REM Check if the configuration file exists
if not exist "%config_file%" (
    echo Configuration file not found: %config_file%
    exit /b 1
)

REM Read configurations from the file
for /f "tokens=1,* delims==" %%a in (%config_file%) do (
    if "%%a"=="personal_monitor_0" set personal_monitor_0=%%b
    if "%%a"=="personal_monitor_1" set personal_monitor_1=%%b
    if "%%a"=="work_monitor_0" set work_monitor_0=%%b
    if "%%a"=="work_monitor_1" set work_monitor_1=%%b
)

REM Run monitorcontrol to get input source for monitor 0
for /f "tokens=*" %%a in ('monitorcontrol --monitor 0 --get-input-source') do set input_source=%%a

REM Check if input source is personal_setup
REM Check if the string contains a specific substring
echo "%input_source%" | findstr /c:"%personal_monitor_0%" >nul

if  %errorlevel% equ 0 (
    echo Input source is personal_setup
    REM Switch to work setup
    monitorcontrol --monitor 0 --set-input-source DP1
    monitorcontrol --monitor 1 --set-input-source ANALOG1
) else (
    echo Input source is not personal_setup
    REM Switch to personal_setup
    monitorcontrol --monitor 0 --set-input-source HDMI1
    monitorcontrol --monitor 1 --set-input-source DVI1
)

endlocal
