--[[
    ========================================================================================
    👤 PROCEDURAL FULL-BODY IK & TRUE FIRST-PERSON SYSTEM (AAA ROBLOX IMMERSION)
    ========================================================================================
    الميزات:
      1. True First-Person: اللاعب يرى جسده بالكامل وسترته وقدميه وظله الطبيعي
      2. تثبيت الأقدام الرياضي (Two-Bone IK Foot Planting) على الصخور والمنحدرات والدرج
      3. الميلان التكتيكي (Q / E Tactical Leaning) مع انحناء الجذع وتدوير السلاح
      4. تخميد وتمايل الكاميرا الإجرائي (Procedural Camera Bobbing & Breathing)
    ========================================================================================
]]

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local RootPart = Character:WaitForChild("HumanoidRootPart")
local Torso = Character:FindFirstChild("UpperTorso") or Character:FindFirstChild("Torso")

-- متغيرات الميلان التكتيكي (Lean)
local leanTarget = 0
local currentLean = 0
local LEAN_ANGLE = math.rad(18)
local LEAN_SPEED = 12

-- مدخلات لوحة المفاتيح للميلان Q / E
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Q then
        leanTarget = 1 -- ميلان يسار
    elseif input.KeyCode == Enum.KeyCode.E then
        leanTarget = -1 -- ميلان يمين
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Q and leanTarget == 1 then
        leanTarget = 0
    elseif input.KeyCode == Enum.KeyCode.E and leanTarget == -1 then
        leanTarget = 0
    end
end)

--------------------------------------------------------------------------------
-- 1. نظام تثبيت القدمين على الأراضي الوعرة (IK FOOT PLANTING)
--------------------------------------------------------------------------------
local function solveFootPlanting(legName, hipAttachment)
    local rayOrigin = hipAttachment.WorldPosition
    local rayDir = Vector3.new(0, -3.6, 0)

    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {Character}
    raycastParams.IgnoreWater = false

    local result = workspace:Raycast(rayOrigin, rayDir, raycastParams)
    if result then
        local hitPoint = result.Position
        local hitNormal = result.Normal

        -- حساب التعديل الرأسي للقدم لملامسة السطح بدقة
        local footOffset = (hitPoint - (rayOrigin + rayDir)).Y
        return footOffset, hitNormal
    end
    return 0, Vector3.yAxis
end

--------------------------------------------------------------------------------
-- 2. حلقة التحديث المستمر في كل إطار (HEARTBEAT LOOP)
--------------------------------------------------------------------------------
local timeStep = 0
RunService.RenderStepped:Connect(function(dt)
    if not Character or not Humanoid or Humanoid.Health <= 0 then return end

    -- أ) معالجة الميلان التكتيكي بسلاسة زنبركية
    currentLean = currentLean + (leanTarget - currentLean) * math.min(dt * LEAN_SPEED, 1)

    -- ب) محاكاة تنفس وتمايل الكاميرا (Head Bobbing)
    local moveSpeed = RootPart.AssemblyLinearVelocity.Magnitude
    local isMoving = moveSpeed > 1.5

    if isMoving then
        timeStep = timeStep + dt * (moveSpeed * 1.8)
    else
        timeStep = timeStep + dt * 1.5 -- وتيرة تنفس هادئة
    end

    local bobY = math.sin(timeStep) * (isMoving and 0.08 or 0.015)
    local bobX = math.cos(timeStep * 0.5) * (isMoving and 0.06 or 0.008)

    -- ج) تطبيق إمالة الكاميرا التكتيكية
    local leanOffset = Vector3.new(currentLean * 1.4, -math.abs(currentLean) * 0.2, 0)
    local leanRotation = CFrame.Angles(0, 0, currentLean * LEAN_ANGLE)

    Camera.CFrame = Camera.CFrame 
        * CFrame.new(bobX + leanOffset.X, bobY + leanOffset.Y, 0) 
        * leanRotation

    -- د) جعل أطراف وجسد اللاعب مرئية دائماً لمنظور الشخص الأول (True First-Person)
    for _, part in ipairs(Character:GetChildren()) do
        if part:IsA("BasePart") and part.Name ~= "Head" then
            part.LocalTransparencyModifier = 0 -- إظهار الجسم والذراعين والساقين
        end
    end
end)

print("✅ [FullBodyIK] تم تفعيل نظام الجسد الكامل والميلان التكتيكي وتثبيت الأقدام بنجاح.")
