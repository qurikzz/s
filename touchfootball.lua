if not game:IsLoaded() then
    game.Loaded:Wait()
end

if _G.ScriptLoaded then return end
_G.ScriptLoaded = true
_G.CheckTeam = true
_G.teamLetter = nil
_G.IgnoreMeasuring = true

local players = game:GetService("Players")
local runService = game:GetService("RunService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local localPlayer = players.LocalPlayer

local function hookLagMeasurement()
    local FILE = replicatedStorage.MeasureLag
    local METHOD = "FireServer"
    
    local namecall; namecall = hookmetamethod(game, '__namecall', function(caller, ...)
        if not checkcaller() and caller == FILE and getnamecallmethod() == METHOD and _G.IgnoreMeasuring then 
            return 
        end
        return namecall(caller, ...)
    end)
end
hookLagMeasurement()

local function determineTeamLetter()
    local statusGui = localPlayer.PlayerGui.Status
    local character = localPlayer.Character
    local teamObject = character:FindFirstChild("Team")
    
    if teamObject then
        local fullNameLabelA = statusGui:FindFirstChild("FullNameLabelA")
        local fullNameLabelB = statusGui:FindFirstChild("FullNameLabelB")
        if teamObject.Value == fullNameLabelA.Text then
            return "A"
        elseif teamObject.Value == fullNameLabelB.Text then
            return "B"
        end
    end
    return nil
end

runService.Heartbeat:Connect(function()
    if not _G.CheckTeam then return end
    pcall(function() _G.teamLetter = determineTeamLetter() end)
end)

local function Score()
    replicatedStorage.KickBall:FireServer(Vector3.new(0, 0, 0),Vector3.new(0, 0, 0),Vector3.new(0, 0, 0),0,"djhtelkds")
    replicatedStorage.GoalEvent:FireServer(_G.teamLetter)
end

local function cUI()
    local Positions = UDim2.new(0.7, 0, 0.040, 0)
    local Sizes = UDim2.new(0, 150, 0, 50)

    local ms = Instance.new("ScreenGui")
    local stuffdd = Instance.new("Frame")
    local TextButton = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local UIStroke = Instance.new("UIStroke")

    ms.Name = "hey"
    ms.Parent = game:WaitForChild("CoreGui")
    ms.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    stuffdd.Name = "1"
    stuffdd.Parent = ms
    stuffdd.BackgroundTransparency = 1
    stuffdd.Position = Positions
    stuffdd.Size = Sizes

    TextButton.Parent = stuffdd
    TextButton.BackgroundColor3 = Color3.new(0.231373, 0.694118, 0.988235)
    TextButton.Size = UDim2.new(1, 0, 0.8, 0)
    TextButton.Text = "⚽ Score"
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.TextScaled = true
    TextButton.Font = Enum.Font.FredokaOne
    TextButton.BorderSizePixel = 0
    TextButton.RichText = false
    TextButton.ClipsDescendants = false
    TextButton.TextStrokeTransparency = 1

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = TextButton

    UIStroke.Parent = TextButton
    UIStroke.Color = Color3.new(0.109804, 0.270588, 0.321569)
    UIStroke.Thickness = 4.070723056793213
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    TextButton.MouseButton1Down:Connect(function()
        TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.TextColor3 = Color3.new(0.231373, 0.694118, 0.988235)
        if localPlayer.Character:FindFirstChild("Team") then
            TextButton.Text = "Scoring"
            Score()
        else
            TextButton.Text = "Please, wait..."
        end
        task.wait(0.3)
        TextButton.BackgroundColor3 = Color3.new(0.231373, 0.694118, 0.988235)
        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.Text = "⚽ Score"
    end)
end

cUI()