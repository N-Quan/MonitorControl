@echo off
set /p input="Set Display Brightness: "
REM Replace "YourMainScript.bat" with the name of your main batch file
REM Replace "arg1 arg2" with any default arguments you want to pass
call brightness_control.bat %input%
