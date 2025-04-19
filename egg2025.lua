local folderName = "EggLocations2025"
local eggNames = {
    "PrisonEgg", "MuseumEgg", "DriveThruEgg", "RacewayEgg", "BridgeEgg",
    "SpawnEgg", "StageEgg", "GasStationEgg", "CampsiteEgg", "CafeEgg",
    "ShopiezEgg", "ObbyEgg", "ExitEgg", "CarWashEgg", "StatueEgg"
}

local Players = game:GetService("Players")
local VirtualInput = game:GetService("VirtualInputManager")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

player.CameraMode = Enum.CameraMode.LockFirstPerson
player.CameraMinZoomDistance = 0.5
player.CameraMaxZoomDistance = 0.5

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

for _, name in ipairs(eggNames) do
    local part = folder:FindFirstChild(name)
    if part and part:IsA("BasePart") then
        teleportTo(part)
        lookDown()
        task.wait(0.3)
        pressE()
        task.wait(1)
    else
        warn("Missing or invalid egg: " .. name)
    end
end

player.CameraMode = Enum.CameraMode.Classic
player.CameraMinZoomDistance = 0.1
player.CameraMaxZoomDistance = 100
