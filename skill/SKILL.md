---
name: roblox-hyper-realism
description: >
  Autonomous AI agent skill and framework to transform any Roblox project into AAA hyper-realism
  comparable to Blender and Unreal Engine 5. Provides autonomous PC and Roblox Studio mouse/keyboard control,
  continuous zero-disk RAM streaming vision (Live AI Eyes), Future Lighting automation, 4K PBR terrain,
  military ballistics, procedural spring recoil, and full-body IK.
  Supports full bilingual prompt comprehension (English & Arabic).
user-invocable: true
---

# 🤖 Roblox Hyper-Realism Studio: Autonomous AI Agent Protocol 4.0

This skill equips any AI Agent (Antigravity, Subagents, or LLM controllers) with the autonomous intelligence, procedural tools, and **physical desktop hands & live vision** needed to transform any Roblox game into next-generation AAA realism.

> **Bilingual Support**: The engine natively understands both **English** and **Arabic** user prompts, biome queries, and architectural instructions.

---

## 👁️ 1. Live AI Eyes & Continuous In-Memory Streaming Vision

Instead of taking slow, discrete screenshots and saving them to disk, the skill utilizes an ultra-fast in-memory streaming vision pipeline:
- **Zero-Disk Pipeline**: Captures screen frame buffers at **30–60 FPS** directly into RAM using `mss` and `numpy`. No image files are ever written to disk.
- **Real-Time Activity Perception**: Continuously tracks the active application window, cursor coordinates, and optical motion deltas.
- **Floating Cyber Eye HUD**: An optional transparent corner overlay window indicating real-time vision state.

📁 **Core Scripts**:
- [`scripts/live_ai_eyes.py`](file:///c:/Users/Yasin1/Documents/antigravity/eager-kepler/scripts/live_ai_eyes.py)
- [`scripts/autonomous_pc_driver.py`](file:///c:/Users/Yasin1/Documents/antigravity/eager-kepler/scripts/autonomous_pc_driver.py)

### Autonomous Action Commands:

| Action Command | Real-World Desktop Behavior |
| :--- | :--- |
| `python scripts/autonomous_pc_driver.py live_eyes` | Launches continuous in-memory vision stream with floating translucent HUD. |
| `python scripts/autonomous_pc_driver.py live_status` | Returns immediate in-RAM perception data (active window, mouse position, motion %). |
| `python scripts/autonomous_pc_driver.py open_app "Roblox Studio"` | Opens Roblox Studio via Windows search with natural keytyping. |
| `python scripts/autonomous_pc_driver.py focus_studio` | Finds and brings Roblox Studio to the foreground. |
| `python scripts/autonomous_pc_driver.py inject_command_bar "<path>"` | Navigates to Command Bar, pastes the Luau engine code, and presses Enter. |
| `python scripts/autonomous_pc_driver.py play` | Clicks and triggers Play Mode (F5) to test combat and physics. |

---

## 🎯 2. Autonomous AI Decision Matrix

When a user request arrives in English or Arabic, follow this logic flow:

```
                     [Receive User Request (EN/AR)]
                                   │
              ┌────────────────────┴────────────────────┐
              ▼                                         ▼
      [Map / Graphics / PBR]                    [Weapons / Physics / IK]
              │                                         │
              ├─ 1. Enforce Future Lighting             ├─ 1. Inject HyperRealisticWeaponsEngine
              ├─ 2. Inject Atmosphere & Post-FX         ├─ 2. Enable Spring Recoil & Ballistics
              ├─ 3. Register 2K/4K PBR Variants         ├─ 3. Bind ProceduralFullBodyIK (Q/E)
              └─ 4. Run Procedural 3D Terrain           └─ 4. Enable Wallbang & Supersonic Crack
                                   │
                                   ▼
          [Direct Execution via Autonomous PC Driver]
          - Execute: python autonomous_pc_driver.py inject_command_bar
          - Focus Roblox Studio & observe live in RAM
          - Trigger Playtest (F5)
```

---

## ⚡ 3. Unified Master AI API

Module: [`HyperRealismMasterAI.luau`](file:///c:/Users/Yasin1/Documents/antigravity/eager-kepler/HyperRealismMasterAI.luau)

The AI can configure and deploy the entire environment with a single call:

```lua
local MasterAI = require(workspace.HyperRealismMasterAI)

-- Accepts English and Arabic biome aliases:
MasterAI.Deploy({
    Biome = "AlpineForest",  -- English: "AlpineForest" | "NightOpsRain" | "DesertCanyon"
                             -- Arabic: "غابة جبلية" | "مطر ليلي" | "صحراء"
    LightingPreset = "CinematicGolden",
    CombatSuite = {
        EnableBallistics = true,
        EnableWallbang = true,
        MuzzleVelocity = 880,
    },
    CharacterSuite = {
        TrueFirstPerson = true,
        TacticalLeaning = true,
    }
})
```

---

## 🩺 4. Self-Diagnostics & Auto-Healing

The AI executes `MasterAI.RunDiagnostics()` to ensure:
1. **Lighting Technology**: Corrects any non-Future lighting to `Enum.Technology.Future`.
2. **MaterialService**: Ensures `Use2022Materials = true` is enabled.
3. **Duplicate Effects Cleanup**: Deletes conflicting `Atmosphere` or `BloomEffect` instances.
4. **Memory Hygiene**: Automatically applies `Debris:AddItem()` to brass casings and particle emitters for consistent 60 FPS.
