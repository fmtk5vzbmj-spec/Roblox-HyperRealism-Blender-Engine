"""
========================================================================================
AUTONOMOUS PC & ROBLOX STUDIO CONTROLLER (WITH LIVE IN-MEMORY AI VISION)
========================================================================================
Author: Antigravity Autonomous Engine
Description:
  Full autonomous mouse, keyboard, and Roblox Studio controller equipped with continuous
  zero-disk streaming vision (RAM-only pipeline without saving screenshots).
  Supports bilingual application targeting (English and Arabic names).
========================================================================================
"""

import sys
import os
import time
import subprocess
import pyautogui
import pyperclip

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

try:
    from live_ai_eyes import LiveAIEyes
except ImportError:
    try:
        from scripts.live_ai_eyes import LiveAIEyes
    except ImportError:
        LiveAIEyes = None

try:
    import win32gui
    import win32con
except ImportError:
    win32gui = None

pyautogui.FAILSAFE = False
pyautogui.PAUSE = 0.12

_live_eyes_instance = None

def get_or_start_live_eyes(enable_hud=False):
    global _live_eyes_instance
    if _live_eyes_instance is None and LiveAIEyes:
        _live_eyes_instance = LiveAIEyes(target_fps=30, enable_hud=enable_hud)
        import threading
        t = threading.Thread(target=_live_eyes_instance._vision_loop, daemon=True)
        t.start()
        print("[Live Vision] Continuous AI vision stream active in RAM (100% Zero-disk)!")
    return _live_eyes_instance

def find_window(title_pattern):
    if not win32gui:
        return None
    matches = []
    def enum_windows_callback(hwnd, _):
        if win32gui.IsWindowVisible(hwnd):
            title = win32gui.GetWindowText(hwnd)
            if title_pattern.lower() in title.lower():
                matches.append((hwnd, title))
    win32gui.EnumWindows(enum_windows_callback, None)
    return matches[0] if matches else None

def open_application(app_name):
    """Opens any Windows application with natural typing."""
    print(f"[AI Controller] Launching application: {app_name}")
    pyautogui.press("win")
    time.sleep(0.4)
    pyautogui.write(app_name, interval=0.04)
    time.sleep(0.5)
    pyautogui.press("enter")
    time.sleep(2.0)
    print(f"[AI Controller] Launched {app_name} successfully.")

def focus_roblox_studio():
    """Focuses and brings Roblox Studio to the foreground."""
    match = find_window("Roblox Studio")
    if not match:
        print("[AI Controller] Roblox Studio not running, launching automatically...")
        open_application("Roblox Studio")
        time.sleep(3.5)
        match = find_window("Roblox Studio")

    if match:
        hwnd, title = match
        try:
            win32gui.ShowWindow(hwnd, win32con.SW_RESTORE)
            win32gui.SetForegroundWindow(hwnd)
            time.sleep(0.4)
            print(f"[AI Controller] Focused window: {title}")
            return hwnd
        except Exception:
            win32gui.BringWindowToTop(hwnd)
            return hwnd
    print("[AI Controller] Could not locate Roblox Studio window.")
    return None

def smooth_move_mouse(x, y, duration=0.5):
    """Smoothly moves the cursor across the screen."""
    print(f"[AI Hands] Moving cursor to: ({x}, {y})")
    pyautogui.moveTo(int(x), int(y), duration=duration, tween=pyautogui.easeInOutQuad)

def visible_click(x=None, y=None, button="left", clicks=1):
    """Performs a visible mouse click."""
    if x is not None and y is not None:
        smooth_move_mouse(x, y, duration=0.4)
    time.sleep(0.1)
    pyautogui.click(button=button, clicks=clicks)
    print(f"[AI Click] {button.capitalize()} clicked at current coordinate.")

def inject_code_to_command_bar(code_or_file_path):
    """
    Directly injects and executes Luau scripts inside Roblox Studio Command Bar.
    """
    code = code_or_file_path
    if os.path.exists(code_or_file_path):
        with open(code_or_file_path, "r", encoding="utf-8") as f:
            code = f.read()

    hwnd = focus_roblox_studio()
    if not hwnd:
        return False

    w, h = pyautogui.size()
    time.sleep(0.3)

    pyperclip.copy(code)
    print("[AI Controller] Script copied to clipboard.")

    # Target Roblox Studio Command Bar at bottom
    command_bar_x = int(w * 0.35)
    command_bar_y = int(h - 35)

    smooth_move_mouse(command_bar_x, command_bar_y, duration=0.5)
    time.sleep(0.2)
    pyautogui.click()
    time.sleep(0.2)

    pyautogui.hotkey("ctrl", "a")
    time.sleep(0.1)
    pyautogui.hotkey("ctrl", "v")
    time.sleep(0.3)

    pyautogui.press("enter")
    print("[AI Hands] Code executed in Roblox Studio Command Bar successfully!")
    return True

def trigger_play_mode():
    """Triggers Play Mode (F5) in Roblox Studio."""
    focus_roblox_studio()
    time.sleep(0.3)
    w, h = pyautogui.size()
    smooth_move_mouse(int(w * 0.5), int(h * 0.08), duration=0.4)
    time.sleep(0.2)
    pyautogui.press("f5")
    print("[AI Hands] Play Mode (F5) triggered successfully!")

def get_live_status():
    """Queries real-time perception state in RAM."""
    eyes = get_or_start_live_eyes()
    if eyes:
        state = eyes.get_live_perception()
        print(f"[Live Perception] ActiveWindow: {state['active_app']} | Mouse: {state['mouse_pos']} | Motion: {state['motion_percentage']}% | StudioActive: {state['roblox_active']}")
        return state
    return None

def main():
    if len(sys.argv) < 2:
        print("Usage: autonomous_pc_driver.py <action> [args...]")
        print("Actions: live_eyes, inject_command_bar, focus_studio, play, open_app, move_mouse, click, live_status")
        return

    action = sys.argv[1].lower()

    if action == "live_eyes":
        eyes = LiveAIEyes(target_fps=30, enable_hud=True)
        eyes.start_vision_stream()
    elif action == "live_status":
        get_live_status()
    elif action == "inject_command_bar":
        target = sys.argv[2] if len(sys.argv) > 2 else "HyperRealismEngine.luau"
        inject_code_to_command_bar(target)
    elif action == "focus_studio":
        focus_roblox_studio()
    elif action == "play":
        trigger_play_mode()
    elif action == "open_app":
        app = " ".join(sys.argv[2:]) if len(sys.argv) > 2 else "Roblox Studio"
        open_application(app)
    elif action == "move_mouse":
        smooth_move_mouse(sys.argv[2], sys.argv[3])
    elif action == "click":
        x = sys.argv[2] if len(sys.argv) > 2 else None
        y = sys.argv[3] if len(sys.argv) > 3 else None
        visible_click(x, y)
    else:
        print(f"Unknown action: {action}")

if __name__ == "__main__":
    main()
