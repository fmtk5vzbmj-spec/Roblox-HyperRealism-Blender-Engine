import win32gui
import win32process

def cb(hwnd, extra):
    if win32gui.IsWindowVisible(hwnd):
        title = win32gui.GetWindowText(hwnd)
        if title:
            _, pid = win32process.GetWindowThreadProcessId(hwnd)
            print(f"PID {pid} (HWND {hwnd}): '{title}'")
    return True

win32gui.EnumWindows(cb, None)
