"""
========================================================================================
LIVE AI EYES & CONTINUOUS DESKTOP OBSERVER (REAL-TIME IN-MEMORY STREAMING VISION)
========================================================================================
Author: Antigravity Autonomous Engine
Description:
  Continuous real-time vision engine for AI agents operating completely in RAM.
  - Zero-disk frame streaming at 30-60 FPS using mss and numpy.
  - Real-time user cursor, active window, and screen activity tracking.
  - Optical motion delta calculation without storing any screenshots.
  - Sleek floating translucent Cyber Eye HUD displaying live tracking status.
========================================================================================
"""

import time
import threading
import sys
import os
import mss
import numpy as np
import pyautogui

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

try:
    import win32gui
    import win32process
except ImportError:
    win32gui = None

try:
    import tkinter as tk
except ImportError:
    tk = None

class LiveAIEyes:
    def __init__(self, target_fps=30, enable_hud=True):
        self.target_fps = target_fps
        self.frame_delay = 1.0 / target_fps
        self.is_running = False
        self.sct = mss.mss()
        self.monitor = self.sct.monitors[1]
        self.last_frame = None
        self.active_window_title = ""
        self.cursor_pos = (0, 0)
        self.enable_hud = enable_hud
        self.hud_root = None
        self.hud_label = None

        self.current_state = {
            "fps": 0,
            "motion_detected": False,
            "motion_percentage": 0.0,
            "active_app": "Unknown",
            "mouse_pos": (0, 0),
            "roblox_active": False,
            "timestamp": time.time()
        }

    def start_vision_stream(self):
        """Starts the continuous in-memory vision stream."""
        self.is_running = True
        self.stream_thread = threading.Thread(target=self._vision_loop, daemon=True)
        self.stream_thread.start()
        print("[Live AI Eyes] Continuous in-memory vision stream active (Zero-disk RAM pipeline)!")

        if self.enable_hud and tk:
            self._start_floating_eye_hud()
        else:
            try:
                while self.is_running:
                    time.sleep(1.0)
            except KeyboardInterrupt:
                self.stop()

    def _vision_loop(self):
        """High-speed in-memory capture loop."""
        frame_count = 0
        fps_timer = time.time()

        while self.is_running:
            loop_start = time.time()

            raw_img = self.sct.grab(self.monitor)
            frame = np.array(raw_img, dtype=np.uint8)

            motion_percent = 0.0
            if self.last_frame is not None:
                diff = np.abs(frame[::8, ::8, :3].astype(int) - self.last_frame[::8, ::8, :3].astype(int))
                motion_pixels = np.sum(diff > 25)
                motion_percent = (motion_pixels / diff.size) * 100.0

            self.last_frame = frame

            current_mouse = pyautogui.position()
            current_window = self._get_active_window_title()
            is_roblox = "roblox" in current_window.lower()

            frame_count += 1
            if time.time() - fps_timer >= 1.0:
                self.current_state["fps"] = frame_count
                frame_count = 0
                fps_timer = time.time()

            self.current_state["motion_detected"] = motion_percent > 0.4
            self.current_state["motion_percentage"] = round(motion_percent, 2)
            self.current_state["active_app"] = current_window
            self.current_state["mouse_pos"] = (current_mouse.x, current_mouse.y)
            self.current_state["roblox_active"] = is_roblox
            self.current_state["timestamp"] = time.time()

            if self.hud_label:
                status_text = f"👁️ AI Eyes LIVE ({self.current_state['fps']} FPS)\nApp: {current_window[:28]}\nMouse: ({current_mouse.x}, {current_mouse.y})"
                self.hud_label.config(text=status_text)

            elapsed = time.time() - loop_start
            sleep_time = max(0, self.frame_delay - elapsed)
            time.sleep(sleep_time)

    def _get_active_window_title(self):
        if not win32gui:
            return "Active App"
        try:
            hwnd = win32gui.GetForegroundWindow()
            return win32gui.GetWindowText(hwnd) or "Desktop"
        except:
            return "Unknown"

    def _start_floating_eye_hud(self):
        """Displays a sleek floating HUD in the screen corner."""
        self.hud_root = tk.Tk()
        self.hud_root.title("AI Live Vision")
        self.hud_root.overrideredirect(True)
        self.hud_root.attributes("-topmost", True)
        self.hud_root.attributes("-alpha", 0.82)

        sw = self.hud_root.winfo_screenwidth()
        self.hud_root.geometry(f"220x65+{sw - 235}+20")
        self.hud_root.configure(bg="#0c1017")

        frame = tk.Frame(self.hud_root, bg="#0c1017", highlightbackground="#00ffcc", highlightthickness=1)
        frame.pack(fill=tk.BOTH, expand=True)

        self.hud_label = tk.Label(
            frame,
            text="👁️ AI Eyes: CONNECTING...",
            font=("Segoe UI", 9, "bold"),
            fg="#00ffcc",
            bg="#0c1017",
            justify=tk.LEFT,
            padx=8,
            pady=4
        )
        self.hud_label.pack(fill=tk.BOTH, expand=True)

        self.hud_root.bind("<Double-Button-1>", lambda e: self.stop())

        try:
            self.hud_root.mainloop()
        except:
            pass

    def stop(self):
        self.is_running = False
        if self.hud_root:
            try:
                self.hud_root.destroy()
            except:
                pass
        print("[Live AI Eyes] Vision stream stopped.")

    def get_live_perception(self):
        """Returns the real-time visual perception dictionary."""
        return self.current_state

if __name__ == "__main__":
    enable_hud = "--no-hud" not in sys.argv
    eyes = LiveAIEyes(target_fps=30, enable_hud=enable_hud)
    eyes.start_vision_stream()
