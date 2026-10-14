"""
========================================================================================
🖱️ AUTONOMOUS PC & ROBLOX STUDIO DRIVER (AI HANDS & EYES CONTROLLER)
========================================================================================
هذا المحرك يمنح أي ذكاء اصطناعي (AI Agent) القدرة على تحريك الماوس والكيبورد أمام المستخدم،
وفتح التطبيقات، والتركيز على Roblox Studio، وإدخال الأكواد في الـ Command Bar،
والتحكم في الواجهات ثلاثية الأبعاد والأزرار مباشرة بدون الاعتماد على أوامر الترمنل فقط.
========================================================================================
"""

import sys
import os
import time
import subprocess
import pyautogui
import pyperclip
from PIL import Image

try:
    import win32gui
    import win32con
    import win32process
except ImportError:
    win32gui = None

# إعدادات الأمان وسلاسة حركة الماوس لتبدو طبيعية ومرئية للمستخدم
pyautogui.FAILSAFE = False
pyautogui.PAUSE = 0.15

def get_screen_resolution():
    w, h = pyautogui.size()
    print(f"🖥️ دقة الشاشة: {w}x{h}")
    return w, h

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
    """فتح أي تطبيق في الويندوز عبر الماوس والبحث التلقائي"""
    print(f"🚀 [AI Controller] جاري فتح التطبيق: {app_name}")
    # الضغط على زر الويندوز
    pyautogui.press("win")
    time.sleep(0.5)
    # كتابة اسم التطبيق
    pyautogui.write(app_name, interval=0.05)
    time.sleep(0.6)
    # الضغط على Enter للتشغيل
    pyautogui.press("enter")
    time.sleep(2.0)
    print(f"✅ تم إطلاق {app_name}")

def focus_roblox_studio():
    """التركيز على نافذة Roblox Studio وتقديمها للأمام"""
    match = find_window("Roblox Studio")
    if not match:
        print("⚠️ Roblox Studio غير مفتوح، جاري تشغيله تلقائياً...")
        open_application("Roblox Studio")
        time.sleep(4.0)
        match = find_window("Roblox Studio")

    if match:
        hwnd, title = match
        try:
            win32gui.ShowWindow(hwnd, win32con.SW_RESTORE)
            win32gui.SetForegroundWindow(hwnd)
            time.sleep(0.5)
            print(f"🎯 تم التركيز على نافذة: {title}")
            return hwnd
        except Exception as e:
            print(f"تنبيه التركيز: {e}")
            win32gui.BringWindowToTop(hwnd)
            return hwnd
    print("❌ تعذر العثور على Roblox Studio.")
    return None

def smooth_move_mouse(x, y, duration=0.6):
    """تحريك الماوس بسلاسة ملحوظة أمام المستخدم"""
    print(f"🖱️ [AI Vision] تحريك مؤشر الماوس إلى الإحداثيات: ({x}, {y})")
    pyautogui.moveTo(int(x), int(y), duration=duration, tween=pyautogui.easeInOutQuad)

def visible_click(x=None, y=None, button="left", clicks=1):
    """النقر بالماوس بشكل مرئي ومؤكد"""
    if x is not None and y is not None:
        smooth_move_mouse(x, y, duration=0.4)
    time.sleep(0.1)
    pyautogui.click(button=button, clicks=clicks)
    print(f"👆 [AI Click] نقرة {button} في الموقع الحالي.")

def inject_code_to_command_bar(code_or_file_path):
    """
    التحكم في Roblox Studio:
    التركيز، فتح الـ Command Bar، لصق الكود، والضغط على Enter أمام عين المستخدم!
    """
    code = code_or_file_path
    if os.path.exists(code_or_file_path):
        with open(code_or_file_path, "r", encoding="utf-8") as f:
            code = f.read()

    hwnd = focus_roblox_studio()
    if not hwnd:
        return False

    w, h = pyautogui.size()
    time.sleep(0.4)

    # 1. نسخ الكود للحافظة
    pyperclip.copy(code)
    print("📋 تم نسخ كود المحرك الواقعي للحافظة.")

    # 2. تحريك الماوس إلى أسفل الشاشة حيث يقع Command Bar عادة في Roblox Studio
    command_bar_x = int(w * 0.35)
    command_bar_y = int(h - 35)

    smooth_move_mouse(command_bar_x, command_bar_y, duration=0.6)
    time.sleep(0.2)
    pyautogui.click()
    time.sleep(0.2)

    # 3. تحديد الكل ولصق الكود
    pyautogui.hotkey("ctrl", "a")
    time.sleep(0.1)
    pyautogui.hotkey("ctrl", "v")
    time.sleep(0.3)

    # 4. الضغط على Enter لتشغيل الكود داخل استوديو
    pyautogui.press("enter")
    print("🔥 [AI Action] تم تنفيذ الكود في Command Bar بنجاح داخل Roblox Studio!")
    return True

def trigger_play_mode():
    """تشغيل وضع اللعب والتجربة F5 أمام المستخدم"""
    focus_roblox_studio()
    time.sleep(0.4)
    # تحريك الماوس إلى شريط الأدوات العلوي
    w, h = pyautogui.size()
    smooth_move_mouse(int(w * 0.5), int(h * 0.08), duration=0.5)
    time.sleep(0.2)
    pyautogui.press("f5")
    print("🎮 [AI Action] تم بدء وضع اللعب والتجربة (Play Mode F5)!")

def capture_screen(save_path):
    """التقاط الشاشة لفحص حالة الاستوديو والماب بصرياً"""
    screenshot = pyautogui.screenshot()
    screenshot.save(save_path)
    print(f"📸 [AI Vision] تم حفظ لقطة الشاشة في: {save_path}")
    return save_path

def main():
    if len(sys.argv) < 2:
        print("Usage: autonomous_pc_driver.py <action> [args...]")
        print("Actions: inject_command_bar, focus_studio, play, open_app, move_mouse, click, screenshot")
        return

    action = sys.argv[1].lower()

    if action == "inject_command_bar":
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
    elif action == "screenshot":
        path = sys.argv[2] if len(sys.argv) > 2 else "studio_view.png"
        capture_screen(path)
    else:
        print(f"Unknown action: {action}")

if __name__ == "__main__":
    main()
