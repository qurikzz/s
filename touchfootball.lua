if not game:IsLoaded() then
    game.Loaded:Wait()
end

if _G.ScriptLoaded then
    return
end
_G.ScriptLoaded = true

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
TextButton.Size = UDim2.new(1, 0, 0.800000012, 0)
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

_G.CheckTeam = true
_G.teamLetter = nil
_G.IgnoreMeasuring = true

local players = game:GetService("Players")
local runService = game:GetService("RunService")

pcall(function()
    local FILE = game:GetService("ReplicatedStorage").MeasureLag
    local METHOD = "FireServer"
    
    local namecall; namecall = hookmetamethod(game, '__namecall', function(caller, ...)
       local args = {...}
       local method = getnamecallmethod()
    
       if not checkcaller() and caller == FILE and method == METHOD then
          if _G.IgnoreMeasuring then return end
       end
    
       return namecall(caller, unpack(args))
    end)
end)

local function determineTeamLetter(character, statusGui)
    pcall(function()
        local teamObject
        local fullNameLabelA = statusGui:FindFirstChild("FullNameLabelA")
        local fullNameLabelB = statusGui:FindFirstChild("FullNameLabelB")
    
        if character:FindFirstChild("Team") then
            teamObject = character.Team
            if teamObject.Value == fullNameLabelA.Text then
                return "A"
            elseif teamObject.Value == fullNameLabelB.Text then
                return "B"
            end
        else
            local upperTorso = character:FindFirstChild("UpperTorso")
            if upperTorso then
                teamObject = upperTorso:FindFirstChild("SurfaceGui"):FindFirstChild("Team")
                if teamObject and teamObject.Text then
                    if teamObject.Text == fullNameLabelA.Text then
                        return "A"
                    elseif teamObject.Text == fullNameLabelB.Text then
                        return "B"
                    end
                end
            end
        end
        return nil
    end)
end

runService.Heartbeat:Connect(function()
    if not _G.CheckTeam then return end
    pcall(function()
        _G.teamLetter = determineTeamLetter(players.LocalPlayer.Character, players.LocalPlayer.PlayerGui.Status)
    end)
end)

local function Score()
    pcall(function()
        local player = players.LocalPlayer
        repeat task.wait() until player.Character
        local character = player.Character
        repeat task.wait() until character:FindFirstChild("HumanoidRootPart")
        local hrp = character:FindFirstChild("HumanoidRootPart")
        local field = workspace:FindFirstChild("FootballField")
        local ball = field and field:FindFirstChild("SoccerBall")
        local board = player.PlayerGui.Status["Score".._G.teamLetter]
        repeat task.wait() until ball
        repeat task.wait() until board.Text ~= ""
        _G.Amount = tonumber(board.Text) + 1
        ball.CFrame = hrp.CFrame
        game:GetService("ReplicatedStorage").NearGoalEvent:FireServer(_G.teamLetter)
        game:GetService("ReplicatedStorage").GoalEvent:FireServer(_G.teamLetter)
    end)
end

function ok()
    while task.wait() do
        pcall(function()
            Score()
            if player.PlayerGui.Status["Score".._G.teamLetter].Text == tostring(_G.Amount) then
                break
            end
        end)
    end
end

TextButton.MouseButton1Down:Connect(function()
    TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.TextColor3 = Color3.new(0.231373, 0.694118, 0.988235)
    TextButton.Text = "Clicked"
    ok()
    task.wait(0.2)
    TextButton.BackgroundColor3 = Color3.new(0.231373, 0.694118, 0.988235)
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.Text = "⚽ Score"
end)