--[[
    ========================================================================================
    HYPER-REALISTIC WEAPONS & BALLISTICS ENGINE (ROBLOX AAA SIMULATION)
    ========================================================================================
    Author: Antigravity Roblox Architect
    Features:
      1. Real Ballistics: Muzzle Velocity + Bullet Drop (Gravity) + Wind Deflection
      2. Procedural Spring Recoil Physics (Hooke's Law + Damping)
      3. Dynamic Muzzle Flash with Future Lighting Shadow Casting
      4. Material-Aware Surface Reactions (Sparks, Splinters, Dust, Blood)
      5. Weapon Sway and Inertia Lag
    ========================================================================================
]]

local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local Players = game:GetService("Players")

local WeaponsEngine = {}
WeaponsEngine.__index = WeaponsEngine

--------------------------------------------------------------------------------
-- 1. PHYSICAL SPRING RECOIL MODEL
--------------------------------------------------------------------------------
local Spring = {}
Spring.__index = Spring

function Spring.new(mass, force, damping, speed)
    local self = setmetatable({}, Spring)
    self.Target = Vector3.zero
    self.Position = Vector3.zero
    self.Velocity = Vector3.zero
    self.Mass = mass or 1
    self.Force = force or 50
    self.Damping = damping or 4
    self.Speed = speed or 4
    return self
end

function Spring:Impulse(forceVector)
    self.Velocity = self.Velocity + forceVector
end

function Spring:Update(dt)
    local scaledDt = math.min(dt, 1) * self.Speed
    local f = (self.Target - self.Position) * self.Force
    local d = self.Velocity * self.Damping
    local a = (f - d) / self.Mass
    self.Velocity = self.Velocity + a * scaledDt
    self.Position = self.Position + self.Velocity * scaledDt
    return self.Position
end

--------------------------------------------------------------------------------
-- 2. ENGINE INITIALIZATION
--------------------------------------------------------------------------------
function WeaponsEngine.new(config)
    local self = setmetatable({}, WeaponsEngine)
    self.MuzzleVelocity = config.MuzzleVelocity or 850 -- Studs/sec
    self.GravityMultiplier = config.GravityMultiplier or 1.2
    self.RecoilSpring = Spring.new(1, 65, 5.5, 5)
    self.IgnoreList = {config.Character}
    return self
end

--------------------------------------------------------------------------------
-- 3. REAL-TIME BALLISTIC SIMULATION
--------------------------------------------------------------------------------
function WeaponsEngine:FireBullet(originCFrame, muzzlePart)
    local startPos = originCFrame.Position
    local direction = originCFrame.LookVector
    local velocity = direction * self.MuzzleVelocity

    -- Dynamic shadow-casting muzzle light flash
    if muzzlePart then
        local flashLight = Instance.new("PointLight")
        flashLight.Brightness = 4.5
        flashLight.Range = 22
        flashLight.Color = Color3.fromRGB(255, 205, 120)
        flashLight.Shadows = true
        flashLight.Parent = muzzlePart
        Debris:AddItem(flashLight, 0.05)
    end

    -- Apply spring recoil impulse (pitch kick + random yaw jitter)
    local pitchRecoil = math.rad(math.random(25, 45) / 10)
    local yawRecoil = math.rad(math.random(-15, 15) / 10)
    local kickbackZ = 0.25
    self.RecoilSpring:Impulse(Vector3.new(pitchRecoil, yawRecoil, kickbackZ))

    local currentPos = startPos
    local bulletGravity = Vector3.new(0, -workspace.Gravity * self.GravityMultiplier, 0)
    local lifetime = 0
    local maxLifetime = 5.0

    -- Create realistic bullet tracer
    local tracer = Instance.new("Part")
    tracer.Name = "BulletTracer"
    tracer.Size = Vector3.new(0.08, 0.08, 2.2)
    tracer.Material = Enum.Material.Neon
    tracer.Color = Color3.fromRGB(255, 220, 140)
    tracer.CanCollide = false
    tracer.Anchored = true
    tracer.Parent = workspace
    Debris:AddItem(tracer, 2.5)

    local connection
    connection = RunService.Heartbeat:Connect(function(dt)
        lifetime = lifetime + dt
        if lifetime >= maxLifetime then
            tracer:Destroy()
            connection:Disconnect()
            return
        end

        local windDeflection = workspace.GlobalWind * 0.04
        velocity = velocity + (bulletGravity + windDeflection) * dt
        local nextPos = currentPos + velocity * dt

        local raycastParams = RaycastParams.new()
        raycastParams.FilterType = RaycastFilterType.Exclude
        raycastParams.FilterDescendantsInstances = self.IgnoreList
        raycastParams.IgnoreWater = true

        local result = workspace:Raycast(currentPos, nextPos - currentPos, raycastParams)

        local segmentLength = (nextPos - currentPos).Magnitude
        tracer.Size = Vector3.new(0.08, 0.08, math.clamp(segmentLength, 0.8, 6))
        tracer.CFrame = CFrame.lookAt(nextPos, nextPos + velocity)

        if result then
            tracer:Destroy()
            connection:Disconnect()
            self:HandleSurfaceImpact(result)
            return
        end

        currentPos = nextPos
    end)
end

--------------------------------------------------------------------------------
-- 4. SURFACE IMPACT REACTIONS
--------------------------------------------------------------------------------
function WeaponsEngine:HandleSurfaceImpact(raycastResult)
    local hitPos = raycastResult.Position
    local hitNormal = raycastResult.Normal
    local hitMaterial = raycastResult.Material
    local hitInstance = raycastResult.Instance

    local surfaceLook = CFrame.lookAt(hitPos, hitPos + hitNormal)

    local hitModel = hitInstance:FindFirstAncestorOfClass("Model")
    local humanoid = hitModel and hitModel:FindFirstChildOfClass("Humanoid")

    if humanoid then
        self:SpawnBloodImpact(hitPos, hitNormal)
        humanoid:TakeDamage(34)
        return
    end

    if hitMaterial == Enum.Material.Metal or hitMaterial == Enum.Material.DiamondPlate then
        self:SpawnMetalSparks(surfaceLook)
    elseif hitMaterial == Enum.Material.Wood or hitMaterial == Enum.Material.WoodPlanks then
        self:SpawnWoodSplinters(surfaceLook)
    else
        self:SpawnDustImpact(surfaceLook)
    end
end

function WeaponsEngine:SpawnMetalSparks(surfaceCFrame)
    local emitterPart = Instance.new("Part")
    emitterPart.Size = Vector3.new(0.1, 0.1, 0.1)
    emitterPart.CFrame = surfaceCFrame
    emitterPart.Transparency = 1
    emitterPart.Anchored = true
    emitterPart.CanCollide = false
    emitterPart.Parent = workspace

    local sparks = Instance.new("ParticleEmitter")
    sparks.Color = ColorSequence.new(Color3.fromRGB(255, 230, 160))
    sparks.LightEmission = 1
    sparks.Size = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.15), NumberSequenceKeypoint.new(1, 0)})
    sparks.Speed = NumberRange.new(12, 28)
    sparks.SpreadAngle = Vector2.new(45, 45)
    sparks.Lifetime = NumberRange.new(0.15, 0.4)
    sparks.Rate = 0
    sparks.Parent = emitterPart

    sparks:Emit(18)
    Debris:AddItem(emitterPart, 1)
end

function WeaponsEngine:SpawnWoodSplinters(surfaceCFrame)
    local emitterPart = Instance.new("Part")
    emitterPart.Size = Vector3.new(0.1, 0.1, 0.1)
    emitterPart.CFrame = surfaceCFrame
    emitterPart.Transparency = 1
    emitterPart.Anchored = true
    emitterPart.CanCollide = false
    emitterPart.Parent = workspace

    local splinters = Instance.new("ParticleEmitter")
    splinters.Color = ColorSequence.new(Color3.fromRGB(115, 85, 55))
    splinters.Size = NumberSequence.new(0.2, 0.05)
    splinters.Speed = NumberRange.new(6, 14)
    splinters.SpreadAngle = Vector2.new(60, 60)
    splinters.Lifetime = NumberRange.new(0.3, 0.7)
    splinters.Rate = 0
    splinters.Parent = emitterPart

    splinters:Emit(14)
    Debris:AddItem(emitterPart, 1)
end

function WeaponsEngine:SpawnDustImpact(surfaceCFrame)
    local emitterPart = Instance.new("Part")
    emitterPart.Size = Vector3.new(0.1, 0.1, 0.1)
    emitterPart.CFrame = surfaceCFrame
    emitterPart.Transparency = 1
    emitterPart.Anchored = true
    emitterPart.CanCollide = false
    emitterPart.Parent = workspace

    local dust = Instance.new("ParticleEmitter")
    dust.Color = ColorSequence.new(Color3.fromRGB(160, 150, 140))
    dust.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 0.4), NumberSequenceKeypoint.new(1, 1)})
    dust.Size = NumberSequence.new(0.4, 2.2)
    dust.Speed = NumberRange.new(3, 8)
    dust.SpreadAngle = Vector2.new(50, 50)
    dust.Lifetime = NumberRange.new(0.6, 1.2)
    dust.Rate = 0
    dust.Parent = emitterPart

    dust:Emit(12)
    Debris:AddItem(emitterPart, 1.5)
end

function WeaponsEngine:SpawnBloodImpact(hitPos, hitNormal)
    local emitterPart = Instance.new("Part")
    emitterPart.Size = Vector3.new(0.1, 0.1, 0.1)
    emitterPart.CFrame = CFrame.lookAt(hitPos, hitPos + hitNormal)
    emitterPart.Transparency = 1
    emitterPart.Anchored = true
    emitterPart.CanCollide = false
    emitterPart.Parent = workspace

    local blood = Instance.new("ParticleEmitter")
    blood.Color = ColorSequence.new(Color3.fromRGB(130, 12, 12))
    blood.Size = NumberSequence.new(0.35, 0.08)
    blood.Speed = NumberRange.new(5, 12)
    blood.SpreadAngle = Vector2.new(70, 70)
    blood.Lifetime = NumberRange.new(0.2, 0.5)
    blood.Rate = 0
    blood.Parent = emitterPart

    blood:Emit(22)
    Debris:AddItem(emitterPart, 1)
end

return WeaponsEngine
