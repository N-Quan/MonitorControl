@echo off
setlocal

rem Hardcoded maximum luminance values for each monitor
set max_luminance_monitor0=100
set max_luminance_monitor1=30

rem Check if an argument is provided
if "%~1"=="" (
    echo Usage: %~nx0 ^<brightness_level^>
    echo brightness_level should be an integer from 0 to 100
    exit /b 1
)

rem Extract the brightness level from the argument
set brightness_level=%~1

rem Validate the brightness level
setlocal EnableDelayedExpansion
set /a "is_number=!brightness_level!" 2>nul
if not defined is_number (
    echo Error: Invalid brightness level. It should be an integer.
    exit /b 1
)
if %brightness_level% lss 0 (
    echo Error: Invalid brightness level. It should be between 0 and 100.
    exit /b 1
)
if %brightness_level% gtr 100 (
    echo Error: Invalid brightness level. It should be between 0 and 100.
    exit /b 1
)

rem Calculate the adjustment factors for each monitor
set /a "adjustment_factor_monitor0=100 / max_luminance_monitor0"
set /a "adjustment_factor_monitor1=100 / max_luminance_monitor1"

rem Apply the adjustment factors to the brightness level
set /a "adjusted_brightness_level_monitor0=brightness_level * adjustment_factor_monitor0"
set /a "adjusted_brightness_level_monitor1=brightness_level * adjustment_factor_monitor1"

rem Set the adjusted luminance of each monitor
monitorcontrol --monitor 0 --set-luminance %adjusted_brightness_level_monitor0%
monitorcontrol --monitor 1 --set-luminance %adjusted_brightness_level_monitor1%

endlocal
