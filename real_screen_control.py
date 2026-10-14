"""
========================================================================================
⚡ REAL SCREEN PHYSICAL MOUSE CONTROLLER (ATTACHED TO USER'S DEFAULT DESKTOP)
========================================================================================
Author: elyr (Discord: b84_)
Engineering: Fully 80% AI Generated
========================================================================================
"""

import sys
import time
import math
import ctypes

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

u32 = ctypes.windll.user32

# 1. الاتصال المباشر بسطح المكتب الحقيقي للمستخدم (Default Desktop)
hDesk = u32.OpenDesktopW("Default", 0, False, 0x01FF)
if hDesk:
    u32.SetThreadDesktop(hDesk)
    print("✅ [Desktop Bridge] Connected directly to user's physical 'Default' Desktop!")
else:
    print("⚠️ Could not open Default Desktop, using current desktop.")

# الحصول على أبعاد الشاشة الحقيقية
w = u32.GetSystemMetrics(0) # SM_CXSCREEN
h = u32.GetSystemMetrics(1) # SM_CYSCREEN
cx, cy = w // 2, h // 2
print(f"🖥️ [Screen Resolution] {w}x{h} | Center: ({cx}, {cy})")

def smooth_move(start_x, start_y, end_x, end_y, steps=25, delay=0.015):
    for i in range(steps + 1):
        t = i / steps
        # Easing cubic
        t_ease = t * t * (3 - 2 * t)
        curr_x = int(start_x + (end_x - start_x) * t_ease)
        curr_y = int(start_y + (end_y - start_y) * t_ease)
        u32.SetCursorPos(curr_x, curr_y)
        time.sleep(delay)

print("🖱️ [Live AI Hands] Moving physical cursor right now across your monitor...")

# حركة 1: تحريك الماوس إلى منتصف الشاشة
smooth_move(100, 100, cx, cy, steps=30, delay=0.02)
time.sleep(0.3)

# حركة 2: رسم دائرة كبيرة وواضحة جداً في منتصف الشاشة
radius = 200
circle_steps = 45
print("🌀 [Live AI Hands] Drawing large circle in center of your screen...")
for i in range(circle_steps + 1):
    angle = (2 * math.pi / circle_steps) * i
    px = int(cx + radius * math.cos(angle))
    py = int(cy + radius * math.sin(angle))
    u32.SetCursorPos(px, py)
    time.sleep(0.025)

time.sleep(0.3)

# حركة 3: حركة أفقية ورأسية واضحة (يمين، يسار، أعلى، أسفل)
print("↔️ [Live AI Hands] Horizontal & vertical physical cursor glide...")
smooth_move(cx, cy, cx + 300, cy, steps=25, delay=0.015)
smooth_move(cx + 300, cy, cx - 300, cy, steps=35, delay=0.015)
smooth_move(cx - 300, cy, cx, cy, steps=25, delay=0.015)

smooth_move(cx, cy, cx, cy - 200, steps=25, delay=0.015)
smooth_move(cx, cy - 200, cx, cy + 200, steps=30, delay=0.015)
smooth_move(cx, cy + 200, cx, cy, steps=25, delay=0.015)

# محاكاة نقرة خفيفة
u32.mouse_event(0x0002, 0, 0, 0, 0) # MOUSEEVENTF_LEFTDOWN
time.sleep(0.05)
u32.mouse_event(0x0004, 0, 0, 0, 0) # MOUSEEVENTF_LEFTUP

print("🎯 [Live AI Hands] Direct physical mouse control executed on your monitor successfully!")
