@echo off
setlocal

set personal_monitor_0="HDMI1"
set personal_monitor_1="DVI1"
set work_monitor_0="DP1"
set work_monitor_1="ANALOG1"

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
