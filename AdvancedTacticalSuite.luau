--[[
    ========================================================================================
    ADVANCED TACTICAL SUITE (WALLBANG PENETRATION, BRASS EJECTION & SUPERSONIC CRACK)
    ========================================================================================
    Author: Antigravity Roblox Architect
    Features:
      1. Material-Aware Wallbang Penetration (Glass, Wood, Thin Metal, Concrete)
      2. Physical Spent Brass Casings with Realistic Ejection & Ground Bouncing
      3. Supersonic Bullet Snap / Doppler Crack near Player Heads
    ========================================================================================
]]

local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local TacticalSuite = {}

-- Material density and maximum penetration thickness limits (Studs)
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
-- 1. MATERIAL-AWARE WALL PENETRATION (WALLBANG)
--------------------------------------------------------------------------------
function TacticalSuite.CheckPenetration(entryPos, bulletDir, hitMaterial, hitInstance)
    local maxDistance = PENETRATION_LIMITS[hitMaterial] or 0.2
    if maxDistance <= 0.1 then return nil, 0 end

    -- Raycast backwards from expected exit point
    local rayOrigin = entryPos + (bulletDir * maxDistance)
    local rayDir = -bulletDir * (maxDistance + 0.1)

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = RaycastFilterType.Include
    raycastParams.FilterDescendantsInstances = {hitInstance}

    local exitResult = workspace:Raycast(rayOrigin, rayDir, raycastParams)
    if exitResult then
        local wallThickness = (exitResult.Position - entryPos).Magnitude
        if wallThickness <= maxDistance then
            local damageFactor = 1 - (wallThickness / maxDistance) * 0.65
            return exitResult.Position, damageFactor
        end
    end
    return nil, 0
end

--------------------------------------------------------------------------------
-- 2. PHYSICAL SPENT BRASS CASINGS
--------------------------------------------------------------------------------
function TacticalSuite.EjectCasing(ejectionPortCFrame)
    local casing = Instance.new("Part")
    casing.Name = "SpentCasing"
    casing.Size = Vector3.new(0.12, 0.35, 0.12)
    casing.CFrame = ejectionPortCFrame
    casing.Material = Enum.Material.Metal
    casing.Color = Color3.fromRGB(212, 175, 55) -- Polished brass
    casing.CanCollide = true
    casing.Massless = false
    casing.Parent = workspace

    local rightForce = ejectionPortCFrame.RightVector * math.random(14, 22)
    local upForce = ejectionPortCFrame.UpVector * math.random(6, 12)
    local forwardForce = -ejectionPortCFrame.LookVector * math.random(2, 5)

    casing.AssemblyLinearVelocity = rightForce + upForce + forwardForce
    casing.AssemblyAngularVelocity = Vector3.new(
        math.random(-40, 40),
        math.random(-40, 40),
        math.random(-40, 40)
    )

    Debris:AddItem(casing, 4.0)
end

--------------------------------------------------------------------------------
-- 3. SUPERSONIC BULLET SNAP / WHIZ
--------------------------------------------------------------------------------
function TacticalSuite.CheckPlayerProximity(bulletPos, bulletVelocity)
    local localPlayer = Players.LocalPlayer
    if not localPlayer or not localPlayer.Character then return end

    local head = localPlayer.Character:FindFirstChild("Head")
    if not head then return end

    local distance = (head.Position - bulletPos).Magnitude
    if distance < 14 and distance > 1.5 then
        local snapSound = Instance.new("Sound")
        snapSound.SoundId = "rbxassetid://9114223173"
        snapSound.Volume = 0.8
        snapSound.PlayOnRemove = true
        snapSound.Parent = head
        snapSound:Destroy()
    end
end

return TacticalSuite
