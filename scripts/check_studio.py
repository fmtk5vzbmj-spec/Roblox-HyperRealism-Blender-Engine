import win32gui
import win32process

def cb(hwnd, extra):
    _, pid = win32process.GetWindowThreadProcessId(hwnd)
    text = win32gui.GetWindowText(hwnd)
    vis = win32gui.IsWindowVisible(hwnd)
    if pid == 12848 or 'Roblox' in text:
        print(f"HWND: {hwnd}, PID: {pid}, Visible: {vis}, Text: '{text}'")

win32gui.EnumWindows(cb, None)
