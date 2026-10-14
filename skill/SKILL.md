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

# 🤖 Roblox Hyper-Realism Studio: Autonomous AI Agent Protocol 5.0
> **Created by:** `elyr` (Discord: `b84_`)  
> **Engineering:** **Fully 80% AI Generated** by Autonomous Agentic AI

This skill equips any AI Agent (Antigravity, Subagents, or LLM controllers) with the autonomous intelligence, procedural tools, and **physical desktop hands & live vision** needed to transform any Roblox game into next-generation AAA realism.

> **Bilingual Support**: The engine natively understands both **English** and **Arabic** user prompts, biome queries, and architectural instructions.

---

## 🚫 CRITICAL DIRECTIVE: THE "LEGO BLOCK" TRAP & MANDATORY ENFORCEMENT

### Why Previous Agents Failed:
When asked to build a map (e.g. "Desert Warfare"), default AI models lazily create flat rectangular `Part` instances with `BrickColor.new("Brick yellow")` or `SmoothPlastic`, leaving the flat default Baseplate untouched. **THIS PRODUCES UGLY, CARTOONISH LEGO BLOCKS AND VIOLATES THIS SKILL.**

### ⚠️ THE 4 STRICT COMMANDMENTS (MANDATORY FOR ALL AGENTS):

1. **NO FLAT BASEPLATES ALLOWED**:
   - The agent MUST immediately delete `workspace.Baseplate`.
   - The ground MUST be generated using 3D procedural voxel terrain (`workspace.Terrain`) with Perlin noise height variations (rolling dunes, canyon ridges, mountain peaks).

2. **MANDATORY FUTURE LIGHTING & ATMOSPHERE**:
   - The agent MUST enforce `Lighting.Technology = Enum.Technology.Future`.
   - The agent MUST inject an `Atmosphere` object with custom `Haze` (2.0 to 3.8), `Density` (0.35 to 0.45), and a cinematic `ColorCorrectionEffect` LUT.

3. **MANDATORY 2K/4K PBR MATERIALS**:
   - The agent MUST register custom `MaterialVariant`s in `MaterialService` with Color, Normal, and Roughness maps (e.g. `Cinematic_DesertDunes`, `Cinematic_CanyonRock`, `Cinematic_AlpineGrass`).

4. **REALISTIC ARCHITECTURE ONLY**:
   - NEVER create plain, solid-colored rectangular boxes for buildings or cover.
   - For military bases: use layered Hesco concourse barriers with sand caps, diamond-plate steel watchtowers with shadow-casting spotlights, and sandbag bunkers with firing slits.
   - For nature: use tiered 3D pine trees, procedural boulders with slate meshes, and volumetric lanterns.

---

## 🏜️ READY-TO-RUN TEMPLATE: DESERT WARFARE AAA ENGINE
Every agent running this skill on a desert/military request MUST run the complete transformation script provided in:
📄 [`DesertWarfareTransformer.luau`](file:///c:/Users/Yasin1/Documents/antigravity/eager-kepler/DesertWarfareTransformer.luau)

---

## 👁️ 1. Live AI Eyes & Continuous In-Memory Streaming Vision

Instead of taking slow, discrete screenshots and saving them to disk, the skill utilizes an ultra-fast in-memory streaming vision pipeline:
- **Zero-Disk Pipeline**: Captures screen frame buffers at **30–60 FPS** directly into RAM using `mss` and `numpy`. No image files are ever written to disk.
- **Real-Time Activity Perception**: Continuously tracks the active application window, cursor coordinates, and optical motion deltas.
- **Claude / Operator Screen Edge Glow**: Draws a glowing 6px neon border around all 4 monitor edges while operating.

📁 **Core Scripts**:
- [`scripts/live_ai_eyes.py`](file:///c:/Users/Yasin1/Documents/antigravity/eager-kepler/scripts/live_ai_eyes.py)
- [`scripts/claude_operator_agent.py`](file:///c:/Users/Yasin1/Documents/antigravity/eager-kepler/scripts/claude_operator_agent.py)
- [`scripts/autonomous_pc_driver.py`](file:///c:/Users/Yasin1/Documents/antigravity/eager-kepler/scripts/autonomous_pc_driver.py)

---

## ⚡ 2. Unified Master AI API

Module: [`HyperRealismMasterAI.luau`](file:///c:/Users/Yasin1/Documents/antigravity/eager-kepler/HyperRealismMasterAI.luau)

The AI can configure and deploy the entire environment with a single call:

```lua
local MasterAI = require(workspace.HyperRealismMasterAI)

-- Accepts English and Arabic biome aliases:
MasterAI.Deploy({
    Biome = "DesertCanyon",  -- English: "DesertCanyon" | "AlpineForest" | "NightOpsRain"
                             -- Arabic: "صحراء" | "غابة جبلية" | "مطر ليلي"
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
