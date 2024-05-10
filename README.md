# MonitorControl

Use your keyboard shortcuts to control multiple External Displays simultaneously.
- Brightness
    - Key combo triggers prompt, allowing the user to set the brightness.
- Input Sources
    - Key combo toggles between preset input sources

This project uses the python `monitorcontrol` package to send DDC/CI commands to external displays.

# Setup
Install the following Python Packages:

`pip install monitorcontrol`

## Windows Instructions
`launcher.bat`
- Will launch and prompt user to set display brightness

`monitor_switcher.bat`
- will toggle between the two profiles. (Switch monitor inputs)

For each of the above bat files:

1. Create a shortcut (may need to copy the shortcut to e.g. the Desktop)
2. Right click the shortcut and go to `Properties`
3. Got to the `Shortcut` tab and assign a `Shortcut Key` e.g. `Ctrl+Alt+Z`

Whenever you press that key combination the corresponding bat file will launch.

## Linux Instructions
tba