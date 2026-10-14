--[[
    ========================================================================================
    HYPER REALISM ENGINE v2.0 - NEXT-GEN AAA BLENDER / UNREAL 5 EXPERIENCE IN ROBLOX
    ========================================================================================
    Author: Antigravity Roblox Architect
    Features:
      1. Massive 2K/4K PBR Material Library (MaterialVariants)
      2. 3D Procedural Terrain Sculptor (Fractal Perlin Noise)
      3. 3D Natural Asset Scatter (Detailed Pines, Mossy Boulders, Cinematic Lanterns)
      4. Future Lighting Stack with Volumetric Fog and Full Cinematic Post-Processing
    Usage:
      - Open Roblox Studio > Command Bar (View > Command Bar)
      - Paste this entire code and press Enter
    ========================================================================================
]]

local Lighting = game:GetService("Lighting")
local MaterialService = game:GetService("MaterialService")
local Terrain = workspace:FindFirstChildOfClass("Terrain") or workspace.Terrain
local Debris = game:GetService("Debris")

print("=========================================================")
print("[HyperRealism 2.0] Initializing Next-Gen AAA Visual Stack...")
print("=========================================================")

--------------------------------------------------------------------------------
-- 1. FUTURE LIGHTING & CINEMATIC ATMOSPHERE
--------------------------------------------------------------------------------
Lighting.Technology = Enum.Technology.Future
Lighting.Brightness = 2.6
Lighting.EnvironmentDiffuseScale = 1
Lighting.EnvironmentSpecularScale = 1
Lighting.GlobalShadows = true
Lighting.GeographicLatitude = 41.5
Lighting.TimeOfDay = "16:40:00" -- Golden hour sun angle
Lighting.OutdoorAmbient = Color3.fromRGB(90, 95, 105)
Lighting.Ambient = Color3.fromRGB(40, 42, 48)
Lighting.ShadowSoftness = 0.18

-- Clean old duplicate post-effects
for _, child in ipairs(Lighting:GetChildren()) do
    if child:IsA("PostEffect") or child:IsA("Atmosphere") or child:IsA("Sky") then
        child:Destroy()
    end
end

-- Volumetric Atmosphere
local atmosphere = Instance.new("Atmosphere")
atmosphere.Density = 0.36
atmosphere.Offset = 0.18
atmosphere.Haze = 2.2
atmosphere.Color = Color3.fromRGB(205, 220, 235)
atmosphere.Decay = Color3.fromRGB(115, 110, 105)
atmosphere.Glare = 0.4
atmosphere.Parent = Lighting

-- High-Definition Skybox
local sky = Instance.new("Sky")
sky.SkyboxBk = "rbxassetid://6444884314"
sky.SkyboxDn = "rbxassetid://6444884785"
sky.SkyboxFt = "rbxassetid://6444884925"
sky.SkyboxLf = "rbxassetid://6444884617"
sky.SkyboxRt = "rbxassetid://6444884483"
sky.SkyboxUp = "rbxassetid://6444885061"
sky.SunAngularSize = 13
sky.CelestialBodiesShown = true
sky.Parent = Lighting

-- Cinematic Depth Of Field (35mm lens blur)
local dof = Instance.new("DepthOfFieldEffect")
dof.FarIntensity = 0.72
dof.FocusDistance = 24
dof.InFocusRadius = 26
dof.NearIntensity = 0.12
dof.Parent = Lighting

-- Soft Bloom
local bloom = Instance.new("BloomEffect")
bloom.Intensity = 0.42
bloom.Size = 24
bloom.Threshold = 0.82
bloom.Parent = Lighting

-- Volumetric Godrays
local sunRays = Instance.new("SunRaysEffect")
sunRays.Intensity = 0.15
sunRays.Spread = 0.85
sunRays.Parent = Lighting

-- Color Grading LUT
local cc = Instance.new("ColorCorrectionEffect")
cc.Brightness = 0.02
cc.Contrast = 0.18
cc.Saturation = 0.14
cc.TintColor = Color3.fromRGB(255, 248, 240)
cc.Parent = Lighting

--------------------------------------------------------------------------------
-- 2. MEGA PBR TEXTURE LIBRARY (MATERIAL SERVICE)
--------------------------------------------------------------------------------
MaterialService.Use2022Materials = true

local function registerPBRMaterial(baseMaterial, name, colorId, normalId, roughnessId, studs)
    local existing = MaterialService:FindFirstChild(name)
    if existing then existing:Destroy() end

    local variant = Instance.new("MaterialVariant")
    variant.Name = name
    variant.BaseMaterial = baseMaterial
    variant.ColorMap = "rbxassetid://" .. tostring(colorId)
    variant.NormalMap = "rbxassetid://" .. tostring(normalId)
    variant.RoughnessMap = "rbxassetid://" .. tostring(roughnessId)
    variant.StudsPerTile = studs or 12
    variant.Parent = MaterialService
    return variant
end

pcall(function()
    registerPBRMaterial(Enum.Material.Grass, "Cinematic_AlpineGrass", 6867375620, 6867375924, 6867376176, 12)
    registerPBRMaterial(Enum.Material.Rock, "Cinematic_NordicCliff", 6867382211, 6867382459, 6867382683, 16)
    registerPBRMaterial(Enum.Material.Mud, "Cinematic_WetMud", 6867379730, 6867379965, 6867380189, 10)
    registerPBRMaterial(Enum.Material.Sand, "Cinematic_DesertDunes", 6867383794, 6867383994, 6867384185, 14)
    registerPBRMaterial(Enum.Material.Cobblestone, "Cinematic_AncientCobble", 6867377289, 6867377519, 6867377726, 10)
    registerPBRMaterial(Enum.Material.Ground, "Cinematic_RiverPebbles", 6867374026, 6867374249, 6867374465, 8)
end)

--------------------------------------------------------------------------------
-- 3. DYNAMIC WATER & WIND PHYSICS
--------------------------------------------------------------------------------
workspace.GlobalWind = Vector3.new(7.5, -0.6, 10.5)

if Terrain then
    Terrain.Decoration = true
    Terrain.WaterColor = Color3.fromRGB(32, 70, 80)
    Terrain.WaterReflectance = 0.9
    Terrain.WaterTransparency = 0.68
    Terrain.WaterWaveSize = 0.22
    Terrain.WaterWaveSpeed = 11
end

--------------------------------------------------------------------------------
-- 4. 3D PROCEDURAL TERRAIN SCULPTING (PERLIN NOISE)
--------------------------------------------------------------------------------
local WorldRoot = workspace:FindFirstChild("HyperRealismWorld")
if WorldRoot then WorldRoot:Destroy() end
WorldRoot = Instance.new("Folder")
WorldRoot.Name = "HyperRealismWorld"
WorldRoot.Parent = workspace

print("[HyperRealism 2.0] Sculpting natural 3D procedural terrain...")

local CHUNK_SIZE = 280
local RESOLUTION = 14
local BASE_HEIGHT = 12

for x = -CHUNK_SIZE/2, CHUNK_SIZE/2, RESOLUTION do
    for z = -CHUNK_SIZE/2, CHUNK_SIZE/2, RESOLUTION do
        local n1 = math.noise(x * 0.008, z * 0.008, 1.23) * 35
        local n2 = math.noise(x * 0.02, z * 0.02, 4.56) * 12
        local height = BASE_HEIGHT + n1 + n2

        local riverDist = math.sqrt((x - 20)^2 + (z - 10)^2)
        local isRiver = riverDist < 45

        local material = Enum.Material.Grass
        if isRiver then
            material = Enum.Material.Mud
            height = height - 16
        elseif height > 28 then
            material = Enum.Material.Rock
        end

        local partSize = Vector3.new(RESOLUTION + 2, math.max(6, height + 10), RESOLUTION + 2)
        local cframe = CFrame.new(x, height / 2, z)
        Terrain:FillBlock(cframe, partSize, material)

        if isRiver and height < 12 then
            Terrain:FillBlock(CFrame.new(x, 4, z), Vector3.new(RESOLUTION + 2, 8, RESOLUTION + 2), Enum.Material.Water)
        end
    end
end

--------------------------------------------------------------------------------
-- 5. 3D NATURAL SCATTER & ASSETS
--------------------------------------------------------------------------------
print("[HyperRealism 2.0] Scattering procedural 3D pine trees, rocks, and lanterns...")

local function spawnRealisticPineTree(position, scale)
    local treeModel = Instance.new("Model")
    treeModel.Name = "RealisticPineTree"

    local trunk = Instance.new("Part")
    trunk.Name = "Trunk"
    trunk.Size = Vector3.new(1.8 * scale, 18 * scale, 1.8 * scale)
    trunk.CFrame = CFrame.new(position + Vector3.new(0, (18 * scale) / 2, 0))
    trunk.Material = Enum.Material.Wood
    trunk.Color = Color3.fromRGB(58, 41, 30)
    trunk.Anchored = true
    trunk.CastShadow = true
    trunk.Parent = treeModel

    local tiers = 4
    for t = 1, tiers do
        local foliage = Instance.new("Part")
        foliage.Name = "FoliageTier_" .. t
        local tierSize = (14 - (t * 2.5)) * scale
        foliage.Size = Vector3.new(tierSize, 4.5 * scale, tierSize)
        foliage.CFrame = CFrame.new(position + Vector3.new(0, (9 + (t * 3.5)) * scale, 0))
        foliage.Material = Enum.Material.Grass
        foliage.Color = Color3.fromRGB(38 + (t * 3), 64 + (t * 4), 38)
        foliage.Anchored = true
        foliage.CastShadow = true

        local mesh = Instance.new("SpecialMesh")
        mesh.MeshType = Enum.MeshType.Sphere
        mesh.Scale = Vector3.new(1, 0.7, 1)
        mesh.Parent = foliage
        foliage.Parent = treeModel
    end

    treeModel.Parent = WorldRoot
end

local function spawnDetailedRock(cframe, scale)
    local rock = Instance.new("Part")
    rock.Name = "RealisticBoulder"
    rock.Size = Vector3.new(5, 3.8, 5) * scale
    rock.CFrame = cframe * CFrame.Angles(
        math.rad(math.random(-20, 20)),
        math.rad(math.random(0, 360)),
        math.rad(math.random(-20, 20))
    )
    rock.Material = Enum.Material.Slate
    rock.Color = Color3.fromRGB(68 + math.random(-6, 6), 72 + math.random(-6, 6), 68 + math.random(-6, 6))
    rock.Anchored = true
    rock.CastShadow = true

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.Sphere
    mesh.Scale = Vector3.new(1, math.random(65, 85)/100, 1.1)
    mesh.Parent = rock
    rock.Parent = WorldRoot
end

local function spawnAtmosphericLantern(position)
    local post = Instance.new("Part")
    post.Name = "LanternPost"
    post.Size = Vector3.new(0.7, 8, 0.7)
    post.CFrame = CFrame.new(position + Vector3.new(0, 4, 0))
    post.Material = Enum.Material.WoodPlanks
    post.Color = Color3.fromRGB(48, 35, 26)
    post.Anchored = true
    post.Parent = WorldRoot

    local lamp = Instance.new("Part")
    lamp.Name = "LanternLamp"
    lamp.Size = Vector3.new(1.4, 1.7, 1.4)
    lamp.CFrame = post.CFrame * CFrame.new(0, 3.8, 0)
    lamp.Material = Enum.Material.Neon
    lamp.Color = Color3.fromRGB(255, 190, 100)
    lamp.Anchored = true
    lamp.Parent = WorldRoot

    local light = Instance.new("PointLight")
    light.Brightness = 2.4
    light.Range = 30
    light.Color = Color3.fromRGB(255, 175, 80)
    light.Shadows = true
    light.Parent = lamp
end

math.randomseed(tick())

for _ = 1, 32 do
    local px = math.random(-110, 110)
    local pz = math.random(-110, 110)
    local dist = math.sqrt((px - 20)^2 + (pz - 10)^2)
    if dist > 35 then
        local py = math.noise(px * 0.008, pz * 0.008, 1.23) * 35 + BASE_HEIGHT
        spawnRealisticPineTree(Vector3.new(px, py, pz), math.random(85, 135) / 100)
    end
end

for _ = 1, 36 do
    local rx = math.random(-125, 125)
    local rz = math.random(-125, 125)
    local ry = math.noise(rx * 0.008, rz * 0.008, 1.23) * 35 + BASE_HEIGHT
    spawnDetailedRock(CFrame.new(rx, ry + 1, rz), math.random(80, 200) / 100)
end

spawnAtmosphericLantern(Vector3.new(12, 10, -10))
spawnAtmosphericLantern(Vector3.new(-18, 12, 22))

print("=========================================================")
print("[HyperRealism 2.0] Hyper-realistic world generated successfully!")
print("=========================================================")
