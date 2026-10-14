# 🌌 Roblox Hyper-Realism Studio Framework (AAA Engine & AI Skill)
### Next-Generation Photorealistic Visuals, Ballistics & Autonomous In-Memory AI Vision

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Roblox Technology](https://img.shields.io/badge/Roblox-Future_Lighting-blue.svg)](https://create.roblox.com/)
[![Platform](https://img.shields.io/badge/Platform-Roblox_Studio-red.svg)](https://create.roblox.com/studio)
[![AI Autonomous](https://img.shields.io/badge/AI-Autonomous_Agent_Ready-brightgreen.svg)]()
[![Bilingual Support](https://img.shields.io/badge/Language_Support-English%20%7C%20Arabic-purple.svg)]()

> An all-in-one framework and autonomous AI skill designed to elevate Roblox games from the classic blocky look into photorealistic, AAA-tier fidelity comparable to Blender and Unreal Engine 5.
> Built with complete bilingual prompt comprehension (seamlessly understands both English and Arabic inputs).

---

## 📸 In-Studio Visual Showcases

### 1. Alpine Forest & Future Lighting
![Lush Alpine Forest Showcase](assets/roblox_future_lighting_showcase_1792006714159.jpg)

### 2. Macro 4K PBR Ground & Water Reflections
![Macro PBR Textures](assets/roblox_pbr_macro_showcase_1792007071371.jpg)

### 3. Tactical First-Person Combat View
![Tactical First Person](assets/roblox_fps_future_lighting_1792007162103.jpg)

### 4. Night-Ops Rain Scene with Quad-Tube NVGs
![Night Ops Tactical Rain](assets/roblox_tactical_rain_scene_1792007365297.jpg)

---

## ⚡ Core Systems

### 🎨 1. Photorealistic PBR Graphics & 3D Procedural Sculpting
- **Future Lighting & Global Illumination**: Multi-source soft shadows, realistic specular highlights, and global environment bouncing.
- **Volumetric Atmosphere**: Real Rayleigh scattering, depth haze, and volumetric Godrays penetrating forest canopies.
- **2K/4K PBR Material Library**: Seamless Color, Normal, and Roughness maps for Alpine Grass, Nordic Rock, Wet Mud, Desert Sand, Cobblestone, and River Pebbles.
- **Fractal Perlin Noise Sculptor**: Procedural terrain sculpting that dynamically generates ridges, valleys, and riverbeds.

### 🔫 2. Hyper-Realistic Combat & Ballistics
- **True Ballistics**: Trajectory physics featuring bullet drop ($g$), muzzle velocity ($v_0$), air drag, and wind deflection (`workspace.GlobalWind`).
- **Physical Spring Recoil**: Procedural camera pitch/yaw and weapon kickback using damped spring physics.
- **Material-Aware Wallbang**: Bullet penetration through glass, wood, sheet metal, and concrete with calibrated damage falloff.
- **Physical Spent Brass Casings**: Rotating ejected casings with realistic gravity, ground bouncing, and metallic acoustic feedback.
- **Supersonic Snap**: Audible Doppler snap whenever rounds pass within proximity of a player's head.

### 🚹 3. Full-Body IK & True First-Person
- **True First-Person**: Players see their complete 3D body, tactical gear, legs, feet, and cast accurate real-time shadows.
- **Tactical Leaning (Q / E)**: Torso rotation and camera tilting for peeking corners.
- **Procedural IK Foot Planting**: Two-bone IK adjusts foot height and surface alignment on slopes, rocks, and stairs.

### 👁️ 4. Live Streaming AI Eyes & Autonomous Desktop Hands
- **Live AI Eyes (`scripts/live_ai_eyes.py`)**: Zero-disk 30-60 FPS in-memory screen perception using `mss` and `numpy`. No static screenshots are saved to disk.
- **Floating Cyber HUD**: Sleek translucent corner overlay displaying live FPS, active window, and screen motion metrics.
- **Autonomous Desktop Driver (`scripts/autonomous_pc_driver.py`)**: Enables AI agents to smoothly move the mouse cursor, launch applications, focus Roblox Studio, and paste Luau scripts directly into the Command Bar.
- **Unified Master AI API (`HyperRealismMasterAI.luau`)**: Single-call deployment with automatic self-healing and diagnostics.

---

## 📂 Repository Structure

```
├── assets/                          # In-Studio showcase images
│   ├── roblox_fps_future_lighting_1792007162103.jpg
│   ├── roblox_future_lighting_showcase_1792006714159.jpg
│   ├── roblox_pbr_macro_showcase_1792007071371.jpg
│   └── roblox_tactical_rain_scene_1792007365297.jpg
│
├── skill/                           # AI Skill Definition
│   └── SKILL.md                     # Autonomous AI skill protocol (EN & AR support)
│
├── scripts/                         # Autonomous Drivers & Live Vision
│   ├── autonomous_pc_driver.py      # Mouse, keyboard & Studio Command Bar driver
│   └── live_ai_eyes.py              # Zero-disk in-memory streaming vision & HUD
│
├── HyperRealismMasterAI.luau         # Unified autonomous AI controller & diagnostics
├── HyperRealismEngine.luau          # Graphics, PBR library & 3D procedural terrain
├── HyperRealisticWeaponsEngine.luau  # Ballistics, spring recoil & surface reactions
├── ProceduralFullBodyIK.luau        # True First Person, Q/E lean & IK foot planting
└── AdvancedTacticalSuite.luau       # Wallbang penetration & brass ejection
```

---

## 🚀 Quick Start Guide

### Option 1: Roblox Studio Command Bar
1. Open your place in **Roblox Studio**.
2. Open the **Command Bar** (`View` > `Command Bar`).
3. Copy and paste the contents of [`HyperRealismEngine.luau`](HyperRealismEngine.luau) and press **Enter**.
4. Instantly experience AAA Future Lighting, PBR terrain, and volumetric atmosphere.

### Option 2: Autonomous AI Execution & Live Vision
Launch the live vision observer or let the AI inject the code automatically:
```bash
# Start continuous in-memory vision stream with floating HUD:
python scripts/autonomous_pc_driver.py live_eyes

# Inject and execute the engine directly into Roblox Studio:
python scripts/autonomous_pc_driver.py inject_command_bar HyperRealismEngine.luau
```

---

## 🌐 Bilingual Support (English & Arabic)

The engine and AI agent protocol natively process prompts and biome parameters in both languages:
```lua
local MasterAI = require(workspace.HyperRealismMasterAI)

-- English:
MasterAI.Deploy({ Biome = "AlpineForest" })

-- Arabic:
MasterAI.Deploy({ Biome = "غابة جبلية" })
```

---

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
