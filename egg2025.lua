local folderName = "EggLocations2025"
-- Notification GUI
local StarterGui = game:GetService("StarterGui")

local function showNotification()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "HeirHavocNotification"
    screenGui.ResetOnSpawn = false

    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = screenGui
    textLabel.AnchorPoint = Vector2.new(1, 1)
    textLabel.Position = UDim2.new(1, -10, 1, -10)
    textLabel.Size = UDim2.new(0, 200, 0, 50)
    textLabel.BackgroundTransparency = 0.2
    textLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Text = "made by heirhavoc"
    textLabel.Font = Enum.Font.GothamBold
    textLabel.TextSize = 18
    textLabel.BorderSizePixel = 0
    textLabel.TextWrapped = true

    screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

    -- Optional: Fade out after a few seconds
    task.delay(3, function()
        for i = 1, 10 do
            textLabel.TextTransparency = i / 10
            textLabel.BackgroundTransparency = 0.2 + (i / 10)
            task.wait(0.05)
        end
        screenGui:Destroy()
    end)
end

showNotification()

-- Rest of your script below...

local eggNames = {
    "PrisonEgg", "MuseumEgg", "DriveThruEgg", "RacewayEgg", "BridgeEgg",
    "SpawnEgg", "StageEgg", "GasStationEgg", "CampsiteEgg", "CafeEgg",
    "ShopiezEgg", "ObbyEgg", "ExitEgg", "CarWashEgg", "StatuesEgg"
}

local Players = game:GetService("Players")
local VirtualInput = game:GetService("VirtualInputManager")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local originalCFrame = hrp.CFrame
local originalCameraCFrame = camera.CFrame

player.CameraMode = Enum.CameraMode.LockFirstPerson
player.CameraMinZoomDistance = 0.5
player.CameraMaxZoomDistance = 0.5

local lockCamera = true

local function teleportTo(part)
    hrp.CFrame = part.CFrame + Vector3.new(0, 5, 0)
    task.wait(0.1)
end

local function pressE()
    VirtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
    task.wait(0.1)
    VirtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
end

local function lookDown()
    local pos = camera.CFrame.Position
    local lookDir = Vector3.new(0, -1, 0)
    camera.CFrame = CFrame.new(pos, pos + lookDir)
end

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local folder = workspace:FindFirstChild(folderName)
if not folder or not folder:IsA("Folder") then
    warn("Folder 'EggLocations2025' not found in workspace.")
    return
end

-- Camera locking loop
local camConn = RunService.RenderStepped:Connect(function()
    if lockCamera then
        lookDown()
    end
end)

for _, name in ipairs(eggNames) do
    local part = folder:FindFirstChild(name)
    if part and part:IsA("BasePart") then
        teleportTo(part)
        task.wait(0.05)
        pressE()
        task.wait(0.04)
    else
        warn("Missing or invalid egg: " .. name)
    end
end

task.wait(1)

lockCamera = false
camConn:Disconnect()

hrp.CFrame = originalCFrame
camera.CFrame = originalCameraCFrame

player.CameraMode = Enum.CameraMode.Classic
player.CameraMinZoomDistance = 0.1
player.CameraMaxZoomDistance = 100
