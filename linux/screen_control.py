import screen_brightness_control as sbc

# List all connected displays
print(sbc.list_monitors())

# Get the current brightness
current_brightness = sbc.get_brightness()
print(f"Current Brightness: {current_brightness}")

# Set brightness to 50% for all monitors
# sbc.set_brightness(100)
sbc.set_brightness(0)

current_brightness = sbc.get_brightness()
print(f"Current Brightness: {current_brightness}")

# If you know the name or index of the specific monitor, you can specify:
# sbc.set_brightness(50, display='Monitor name or index')
