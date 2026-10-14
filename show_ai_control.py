"""
========================================================================================
⚡ LIVE AI HANDS DEMONSTRATION ON USER'S SCREEN
========================================================================================
Author: elyr (Discord: b84_)
Engineering: Fully 80% AI Generated
========================================================================================
"""

import sys
import time
import math
import threading
import pyautogui

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

try:
    import tkinter as tk
except ImportError:
    tk = None

pyautogui.FAILSAFE = False

print("🚀 [AI Live Control] Starting physical mouse takeover on your screen right now...")

# 1. إظهار نافذة الـ HUD العائمة بألوان السيطرة الحمراء القرمزية
hud_root = None
if tk:
    def run_hud():
        global hud_root
        hud_root = tk.Tk()
        hud_root.title("AI Takeover")
        hud_root.overrideredirect(True)
        hud_root.attributes("-topmost", True)
        hud_root.attributes("-alpha", 0.92)

        sw = hud_root.winfo_screenwidth()
        hud_root.geometry(f"280x95+{sw - 300}+30")
        hud_root.configure(bg="#0a0510")

        frame = tk.Frame(hud_root, bg="#0a0510", highlightbackground="#ff0055", highlightthickness=3)
        frame.pack(fill=tk.BOTH, expand=True)

        badge = tk.Label(
            frame,
            text="⚡ AI HANDS: ACTIVE MOUSE CONTROL",
            font=("Segoe UI", 10, "bold"),
            fg="#ff0055",
            bg="#0a0510",
            padx=8,
            pady=4
        )
        badge.pack(anchor="w")

        info = tk.Label(
            frame,
            text="Status: Controlling Hardware Mouse\n[by elyr (b84_) - 80% AI Engine]",
            font=("Consolas", 8),
            fg="#ffccdd",
            bg="#0a0510",
            justify=tk.LEFT,
            padx=8,
            pady=2
        )
        info.pack(fill=tk.BOTH, expand=True)

        hud_root.after(7000, hud_root.destroy)
        hud_root.mainloop()

    hud_thread = threading.Thread(target=run_hud, daemon=True)
    hud_thread.start()
    time.sleep(0.5)

# 2. إظهار دائرة النبض الضوئية عند النقر (Ripple Halo)
def show_ripple(x, y):
    if not tk: return
    def _ripple():
        try:
            r = tk.Toplevel()
            r.overrideredirect(True)
            r.attributes("-topmost", True)
            r.attributes("-transparentcolor", "black")
            size = 60
            r.geometry(f"{size}x{size}+{int(x - size/2)}+{int(y - size/2)}")
            c = tk.Canvas(r, width=size, height=size, bg="black", highlightthickness=0)
            c.pack()
            c.create_oval(4, 4, size-4, size-4, outline="#ff0055", width=3)
            c.create_oval(14, 14, size-14, size-14, outline="#00ffcc", width=2)
            c.create_oval(25, 25, size-25, size-25, fill="#ffffff", outline="")
            r.after(350, r.destroy)
        except:
            pass
    threading.Thread(target=_ripple, daemon=True).start()

# 3. تحريك الماوس بحركات واضحة جداً أمام عين المستخدم
w, h = pyautogui.size()
cx, cy = w // 2, h // 2

print(f"🖱️ [AI Hands] Moving mouse to center ({cx}, {cy})...")
pyautogui.moveTo(cx, cy, duration=0.8, tween=pyautogui.easeInOutQuad)
show_ripple(cx, cy)
time.sleep(0.3)

# رسم حركة دائرية انسيابية بالماوس في منتصف الشاشة ليراها المستخدم بوضوح تام
print("🌀 [AI Hands] Gliding mouse in circular motion across your screen...")
radius = 160
steps = 24
for i in range(steps + 1):
    angle = (2 * math.pi / steps) * i
    px = int(cx + radius * math.cos(angle))
    py = int(cy + radius * math.sin(angle))
    pyautogui.moveTo(px, py, duration=0.04)

show_ripple(cx + radius, cy)
time.sleep(0.3)

# حركة إضافية واضحة للأعلى والأسفل
pyautogui.moveTo(cx, cy - 150, duration=0.6, tween=pyautogui.easeInOutQuad)
show_ripple(cx, cy - 150)
time.sleep(0.2)

pyautogui.moveTo(cx, cy + 150, duration=0.6, tween=pyautogui.easeInOutQuad)
show_ripple(cx, cy + 150)
time.sleep(0.2)

pyautogui.moveTo(cx, cy, duration=0.5, tween=pyautogui.easeInOutQuad)
show_ripple(cx, cy)

print("✅ [AI Hands] Live mouse movement completed directly on your screen!")
