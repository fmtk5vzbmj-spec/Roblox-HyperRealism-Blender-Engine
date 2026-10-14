--[[
    ========================================================================================
    🔥 ADVANCED TACTICAL SUITE (WALLBANG PENETRATION, BRASS EJECTION & SUPERSONIC CRACK)
    ========================================================================================
    الميزات:
      1. اختراق الجدران والأسطح (Wallbang Penetration) بحسب كثافة المادة (خشب، معدن، زجاج)
      2. قذف فوارغ الرصاص فيزيائياً (Physical Brass Casings) مع ارتداد وصوت رنين على الأرض
      3. صوت اختراق حاجز الصوت (Supersonic Bullet Snap) عند مرور الرصاصة قرب رأس اللاعب
    ========================================================================================
]]

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local TacticalSuite = {}

-- جدول كثافة المواد وسماكة الاختراق المسموحة (Studs)
local PENETRATION_LIMITS = {
    [Enum.Material.Glass] = 12.0,
    [Enum.Material.Wood] = 2.8,
    [Enum.Material.WoodPlanks] = 2.4,
    [Enum.Material.Fabric] = 4.0,
    [Enum.Material.Plastic] = 1.8,
    [Enum.Material.Metal] = 0.8,
    [Enum.Material.CorrodedMetal] = 1.0,
    [Enum.Material.Concrete] = 0.4,
    [Enum.Material.Brick] = 0.5,
    [Enum.Material.Slate] = 0.3,
}

--------------------------------------------------------------------------------
-- 1. فحص اختراق الجدران (WALLBANG SYSTEM)
--------------------------------------------------------------------------------
function TacticalSuite.CheckPenetration(entryPos, bulletDir, hitMaterial, hitInstance)
    local maxDistance = PENETRATION_LIMITS[hitMaterial] or 0.2
    if maxDistance <= 0.1 then return nil, 0 end -- مادة غير قابلة للاختراق

    -- إطلاق شعاع عكسي من الجهة الأخرى للجدار للعثور على نقطة الخروج
    local rayOrigin = entryPos + (bulletDir * maxDistance)
    local rayDir = -bulletDir * (maxDistance + 0.1)

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = RaycastFilterType.Include
    raycastParams.FilterDescendantsInstances = {hitInstance}

    local exitResult = workspace:Raycast(rayOrigin, rayDir, raycastParams)
    if exitResult then
        local wallThickness = (exitResult.Position - entryPos).Magnitude
        if wallThickness <= maxDistance then
            -- تم الاختراق بنجاح! حساب نسبة فقدان الضرر بناءً على السماكة
            local damageFactor = 1 - (wallThickness / maxDistance) * 0.65
            return exitResult.Position, damageFactor
        end
    end
    return nil, 0
end

--------------------------------------------------------------------------------
-- 2. قذف فوارغ الرصاص الفيزيائية (PHYSICAL BRASS CASING EJECTION)
--------------------------------------------------------------------------------
function TacticalSuite.EjectCasing(ejectionPortCFrame)
    local casing = Instance.new("Part")
    casing.Name = "SpentCasing"
    casing.Size = Vector3.new(0.12, 0.35, 0.12)
    casing.CFrame = ejectionPortCFrame
    casing.Material = Enum.Material.Metal
    casing.Color = Color3.fromRGB(212, 175, 55) -- لون نحاسي لامع
    casing.CanCollide = true
    casing.Massless = false
    casing.Parent = workspace

    -- تطبيق سرعة وقوة اندفاع عشوائية جانبية واقعية
    local rightForce = ejectionPortCFrame.RightVector * math.random(14, 22)
    local upForce = ejectionPortCFrame.UpVector * math.random(6, 12)
    local forwardForce = -ejectionPortCFrame.LookVector * math.random(2, 5)

    casing.AssemblyLinearVelocity = rightForce + upForce + forwardForce
    casing.AssemblyAngularVelocity = Vector3.new(
        math.random(-40, 40),
        math.random(-40, 40),
        math.random(-40, 40)
    )

    -- إزالة الفارغ بعد 4 ثوانٍ للحفاظ على ثبات الأداء
    Debris:AddItem(casing, 4.0)
end

--------------------------------------------------------------------------------
-- 3. صوت أزيز واختراق الرصاص لرأس اللاعب (SUPERSONIC WHIZ / CRACK)
--------------------------------------------------------------------------------
function TacticalSuite.CheckPlayerProximity(bulletPos, bulletVelocity)
    local localPlayer = Players.LocalPlayer
    if not localPlayer or not localPlayer.Character then return end

    local head = localPlayer.Character:FindFirstChild("Head")
    if not head then return end

    local distance = (head.Position - bulletPos).Magnitude
    if distance < 14 and distance > 1.5 then -- مرت الرصاصة قريباً جداً من الرأس
        local snapSound = Instance.new("Sound")
        snapSound.SoundId = "rbxassetid://9114223173" -- صوت طلقة حاد يمر فوق الرأس
        snapSound.Volume = 0.8
        snapSound.PlayOnRemove = true
        snapSound.Parent = head
        snapSound:Destroy()
    end
end

return TacticalSuite
