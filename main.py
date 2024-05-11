import keyboard
# TODO adjust display brightness and input with monitorcontrol functions and attach to hotkeys

def hotkey_callback_1():
    print("Hotkey 1 pressed!")

def hotkey_callback_2():
    print("Hotkey 2 pressed!")

def hotkey_callback_3():
    print("Hotkey 3 pressed!")

def hotkey_callback_4():
    print("Hotkey 4 pressed!")

def main():
    # Register multiple hotkeys
    keyboard.add_hotkey('alt+page up', hotkey_callback_1)
    keyboard.add_hotkey('alt+page down', hotkey_callback_2)
    keyboard.add_hotkey('alt+home', hotkey_callback_3)

    quit_hotkey = 'ctrl+alt+end'
    keyboard.add_hotkey(quit_hotkey, hotkey_callback_4)

    print("Hotkeys registered. Press the hotkeys to trigger the callbacks.")

    # Keep the script running
    keyboard.wait(quit_hotkey)  # Wait for key to exit

if __name__ == "__main__":
    main()
