---
name: roblox-hyper-realism
description: >
  CRITICAL: Must activate whenever user mentions Roblox maps, graphics, textures, terrain,
  weapons, realism, Blender look, UE5, or building any game/environment in Roblox.
  Keywords: roblox, map, maps, realism, realistic, pbr, texture, terrain, desert, forest,
  lighting, future lighting, blender, unreal, weapons, gun, fps, ماب, مابات, روبلوكس,
  واقعي, واقعية, تكستشر, ارضيات, اسلحة, بلندر, انريل.
user-invocable: true
---

# 🌌 ROBLOX HYPER-REALISM MASTER AGENT PROTOCOL (ZERO-LEGO ARCHITECTURE)
> **Author:** `elyr` (Discord: `b84_`) | **Engineering:** Fully 80% AI Generated

## 🚨 MANDATORY SYSTEM DIRECTIVE FOR ALL AI AGENTS
You are acting as a world-class AAA Graphics Engineer and Technical Artist for Roblox Studio.
Your mission is to completely eradicate the "blocky Lego look" and deliver photorealistic visuals comparable to **Blender** and **Unreal Engine 5**.

### ❌ STRICT PROHIBITIONS (THE "LEGO TRAP" - NEVER DO THIS):
- **NEVER** leave a flat default `Baseplate` in the workspace.
- **NEVER** create buildings, terrain, or cover using raw rectangular `Instance.new("Part")` blocks with single `BrickColor` or `SmoothPlastic`.
- **NEVER** use default `Lighting.Technology = Enum.Technology.Compatibility` or `ShadowMap`.
- **NEVER** write code that simply drops plain blocks and calls it a map.

### ✅ MANDATORY EXECUTION REQUIREMENTS:
1. **Always Enforce Future Lighting**:
   ```lua
   game:GetService("Lighting").Technology = Enum.Technology.Future
   game:GetService("Lighting").EnvironmentDiffuseScale = 1
   game:GetService("Lighting").EnvironmentSpecularScale = 1
   ```
2. **Always Inject Atmosphere & Post-Processing**:
   Every single scene MUST have `Atmosphere` (Haze 2.0-3.8, Density 0.35-0.45), `BloomEffect`, `DepthOfFieldEffect` (35mm lens blur), and `ColorCorrectionEffect` (contrast 0.15-0.22).
3. **Always Sculpt 3D Voxel Terrain**:
   Ground MUST be generated with `workspace.Terrain:FillBlock` using mathematical height variations (Perlin noise, sine dunes, ridges) with `Terrain.Decoration = true`.
4. **Always Register 2K/4K PBR Materials**:
   Must configure `MaterialService.Use2022Materials = true` and inject custom `MaterialVariant`s containing `ColorMap`, `NormalMap`, and `RoughnessMap`.
5. **Always Use Realistic Modular Architecture**:
   Military bases MUST use layered Hesco canvas barriers with sand caps, diamond-plate watchtowers with spotlights, and sandbag firing bunkers.

---

## 📚 READY BIOME MASTER TEMPLATES

Whenever the user asks for a map in a specific genre, the AI agent MUST output the corresponding complete, self-contained, copy-pasteable script:

### 1. 🏜️ Desert Warfare & Military Outpost (`DesertWarfareTransformer.luau`)
- **Lighting**: Blazing afternoon sun (`TimeOfDay = "14:15:00"`, `GeographicLatitude = 24.5`).
- **Atmosphere**: Dusty warm desert haze (`Atmosphere.Haze = 3.6`, `Color = (240, 215, 180)`).
- **Terrain**: 3D rolling sand dunes and perimeter canyon rock strata via Perlin Noise.
- **PBR**: 4K Desert Dunes Sand, Canyon Rock, and Desert Pebbles.
- **Structures**: Hesco concourse barriers, sandbag bunkers, and military watchtowers with shadow-casting spotlights.

### 2. 🌲 Alpine Forest & River Valley (`HyperRealismEngine.luau`)
- **Lighting**: Golden hour sun (`TimeOfDay = "16:40:00"`, `GeographicLatitude = 41.5`).
- **Atmosphere**: Soft cool mist with volumetric Godrays (`Atmosphere.Density = 0.36`).
- **Terrain**: Green hills, river valleys filled with reflective water (`WaterReflectance = 0.92`).
- **PBR**: Alpine Grass, Nordic Rock Cliffs, Wet Mud.
- **Structures**: Tiered 3D pine trees, mossy slate boulders, and warm atmospheric wooden lanterns.

### 3. 🌧️ Tactical Night-Ops Rain (`NightOpsRain`)
- **Lighting**: Deep midnight moonlight (`TimeOfDay = "22:30:00"`, `Brightness = 0.85`).
- **Atmosphere**: Dense storm fog (`Atmosphere.Haze = 3.8`, `Density = 0.52`).
- **Terrain**: PBR wet asphalt, mud puddles with mirror reflections (`Roughness = 0.1`).
- **Combat**: Suppressed weapons, active green IR lasers, and volumetric muzzle flash.

---

## 🛠️ UNIFIED ONE-LINE AI DEPLOYMENT API
If working with a script module, the AI agent can simply deploy everything with one line:

```lua
local MasterAI = require(workspace.HyperRealismMasterAI)

-- Accepts English and Arabic queries:
MasterAI.Deploy({
    Biome = "DesertCanyon", -- "DesertCanyon" | "AlpineForest" | "NightOpsRain"
                            -- "صحراء" | "غابة جبلية" | "مطر ليلي"
    LightingPreset = "CinematicGolden",
    CombatSuite = { EnableBallistics = true, EnableWallbang = true },
    CharacterSuite = { TrueFirstPerson = true, TacticalLeaning = true }
})
```

---

## 🤖 DESKTOP & MOUSE AUTOMATION
The AI agent has access to real physical desktop control scripts in `scripts/`:
- `scripts/claude_operator_agent.py`: Full-screen glowing edge frame (Claude/Operator style) + physical mouse navigation.
- `scripts/live_ai_eyes.py`: Zero-disk continuous in-memory screen streaming vision at 30-60 FPS.
- `scripts/autonomous_pc_driver.py`: One-click Command Bar code injector into Roblox Studio.

---

## 📋 PRE-DELIVERY CHECKLIST FOR THE AI AGENT
Before replying to the user, the AI agent MUST mentally verify:
- [ ] Did I enforce `Lighting.Technology = Enum.Technology.Future`?
- [ ] Did I add `Atmosphere`, `Bloom`, `DepthOfField`, and `ColorCorrection`?
- [ ] Is the terrain generated in 3D voxels instead of a flat part?
- [ ] Did I register PBR MaterialVariants?
- [ ] Are all buildings textured and realistic instead of plain rectangular plastic boxes?
If all checks pass, deliver the solution with full confidence.
