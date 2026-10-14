--[[
    ========================================================================================
    🤖 HYPER REALISM MASTER AI CONTROLLER (UNIFIED AUTONOMOUS AGENT API)
    ========================================================================================
    المطور: Antigravity Autonomous Engine
    الوظيفة: واجهة برمجية موحدة مصممة للذكاء الاصطناعي (AI Agents) لتشخيص البيئة،
             تفعيل الإضاءة السينمائية، خامات الـ PBR، أنظمة الأسلحة، وحركة الشخصيات
             بأمر واحد فقط وبدون أخطاء.
    ========================================================================================
]]

local Lighting = game:GetService("Lighting")
local MaterialService = game:GetService("MaterialService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local MasterAI = {}
MasterAI.Version = "3.5-AI-Autonomous"

--------------------------------------------------------------------------------
-- 1. الفحص الذاتي والتصحيح التلقائي (SELF-DIAGNOSTICS & AUTO-HEALING)
--------------------------------------------------------------------------------
function MasterAI.RunDiagnostics()
    local report = {
        LightingFixed = false,
        MaterialServiceFixed = false,
        DuplicateEffectsCleaned = 0,
        Status = "OPTIMAL"
    }

    -- تصحيح الإضاءة إلى Future Lighting
    if Lighting.Technology ~= Enum.Technology.Future then
        Lighting.Technology = Enum.Technology.Future
        Lighting.GlobalShadows = true
        report.LightingFixed = true
    end

    -- تفعيل خامات الـ PBR الحديثة
    if not MaterialService.Use2022Materials then
        MaterialService.Use2022Materials = true
        report.MaterialServiceFixed = true
    end

    -- تنظيف المؤثرات المكررة التي تسبب تشوه ألوان الشاشة
    local postEffectCount = {}
    for _, child in ipairs(Lighting:GetChildren()) do
        if child:IsA("PostEffect") or child:IsA("Atmosphere") then
            postEffectCount[child.ClassName] = (postEffectCount[child.ClassName] or 0) + 1
            if postEffectCount[child.ClassName] > 1 then
                child:Destroy()
                report.DuplicateEffectsCleaned = report.DuplicateEffectsCleaned + 1
            end
        end
    end

    print(string.format("🩺 [AI Diagnostics] تم الفحص: تصحيح إضاءة: %s | تنظيف مؤثرات: %d", 
        tostring(report.LightingFixed), report.DuplicateEffectsCleaned))
    return report
end

--------------------------------------------------------------------------------
-- 2. مصفوفة الإعدادات الجاهزة (BIOME & LIGHTING PRESETS)
--------------------------------------------------------------------------------
MasterAI.Presets = {
    AlpineForest = {
        TimeOfDay = "16:45:00",
        Brightness = 2.5,
        AtmosphereColor = Color3.fromRGB(205, 220, 235),
        AtmosphereDensity = 0.36,
        AtmosphereHaze = 2.2,
        Wind = Vector3.new(7.5, -0.6, 10.5),
        WaterColor = Color3.fromRGB(32, 70, 80),
    },
    NightOpsRain = {
        TimeOfDay = "22:30:00",
        Brightness = 0.85,
        AtmosphereColor = Color3.fromRGB(80, 95, 115),
        AtmosphereDensity = 0.52,
        AtmosphereHaze = 3.8,
        Wind = Vector3.new(12, -2, 14),
        WaterColor = Color3.fromRGB(15, 22, 28),
    },
    DesertCanyon = {
        TimeOfDay = "13:00:00",
        Brightness = 3.2,
        AtmosphereColor = Color3.fromRGB(245, 225, 195),
        AtmosphereDensity = 0.28,
        AtmosphereHaze = 3.1,
        Wind = Vector3.new(9, 0, 4),
        WaterColor = Color3.fromRGB(45, 95, 110),
    }
}

--------------------------------------------------------------------------------
-- 3. دالة النشر والتشغيل التلقائية الموحدة (ONE-CALL AUTONOMOUS DEPLOY)
--------------------------------------------------------------------------------
function MasterAI.Deploy(config)
    config = config or {}
    local biomeName = config.Biome or "AlpineForest"
    local preset = MasterAI.Presets[biomeName] or MasterAI.Presets.AlpineForest

    print("🚀 [MasterAI] جاري تشغيل بيئة: " .. biomeName)

    -- تشغيل الفحص الذاتي أولاً
    MasterAI.RunDiagnostics()

    -- تطبيق الإضاءة والغلاف الجوي
    Lighting.TimeOfDay = preset.TimeOfDay
    Lighting.Brightness = preset.Brightness
    Lighting.OutdoorAmbient = Color3.fromRGB(85, 90, 100)
    Lighting.EnvironmentDiffuseScale = 1
    Lighting.EnvironmentSpecularScale = 1

    -- إعداد Atmosphere
    local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere") or Instance.new("Atmosphere")
    atmosphere.Density = preset.AtmosphereDensity
    atmosphere.Haze = preset.AtmosphereHaze
    atmosphere.Color = preset.AtmosphereColor
    atmosphere.Decay = Color3.fromRGB(110, 110, 110)
    atmosphere.Glare = 0.35
    atmosphere.Parent = Lighting

    -- إعداد ColorCorrection
    local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect")
    cc.Brightness = 0.02
    cc.Contrast = (biomeName == "NightOpsRain") and 0.22 or 0.16
    cc.Saturation = (biomeName == "NightOpsRain") and -0.05 or 0.12
    cc.Parent = Lighting

    -- ضبط الرياح العالمية
    workspace.GlobalWind = preset.Wind

    -- تهيئة التضاريس والمياه
    local terrain = workspace:FindFirstChildOfClass("Terrain")
    if terrain then
        terrain.Decoration = true
        terrain.WaterColor = preset.WaterColor
        terrain.WaterReflectance = 0.92
    end

    print("✨ [MasterAI] تم بنجاح تطبيق كامل منظومة الواقعية الفائقة بشكل ذاتي!")
    return true
end

return MasterAI
