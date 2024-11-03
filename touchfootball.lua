if not game:IsLoaded() then
    game.Loaded:Wait()
end

if _G.ScriptLoaded then
    return
end
_G.ScriptLoaded = true

_G.CheckTeam = true
_G.teamLetter = nil

local players = game:GetService("Players")
local runService = game:GetService("RunService")

local function determineTeamLetter(character, statusGui)
    local teamObject
    local fullNameLabelA = statusGui:FindFirstChild("FullNameLabelA")
    local fullNameLabelB = statusGui:FindFirstChild("FullNameLabelB")
    
    if not fullNameLabelA or not fullNameLabelB then return nil end

    if character:FindFirstChild("Team") then
        teamObject = character.Team
        if teamObject.Value == fullNameLabelA.Text then
            return "B"
        elseif teamObject.Value == fullNameLabelB.Text then
            return "A"
        end
    else
        local upperTorso = character:FindFirstChild("UpperTorso")
        if upperTorso then
            teamObject = upperTorso:FindFirstChild("SurfaceGui"):FindFirstChild("Team")
            if teamObject and teamObject.Text then
                if teamObject.Text == fullNameLabelA.Text then
                    return "B"
                elseif teamObject.Text == fullNameLabelB.Text then
                    return "A"
                end
            end
        end
    end
    return nil
end

runService.Heartbeat:Connect(function()
    if not _G.CheckTeam then return end
    pcall(function()
        local player = players.LocalPlayer
        local character = player.Character
        local statusGui = player.PlayerGui:FindFirstChild("Status")
        
        if not statusGui then return end
        
        _G.teamLetter = determineTeamLetter(character, statusGui)
    end)
end)

local function Score()
    pcall(function()
        local player = players.LocalPlayer
        repeat task.wait() until player.Character
        local character = player.Character
        repeat task.wait() until character:FindFirstChild("HumanoidRootPart")

        local hrp = character.HumanoidRootPart
        local oldPos = hrp.Position

        local field = workspace:FindFirstChild("FootballField")
        local ball = field and field:FindFirstChild("SoccerBall")
        repeat task.wait() until ball
        local goalPost
        if game.PlaceId == 105531756926941 then
            goalPost = field.Pitch["Goal" .. _G.teamLetter].NetBack.Position
        else
            goalPost = field.Pitch["Goal" .. _G.teamLetter].GoalNetBack.Position
        end
        for i = 1, 22 do
            character:MoveTo(goalPost - Vector3.new(0, 5, 0))
            task.wait()
            ball.CFrame = hrp.CFrame
            task.wait()
            character:MoveTo(oldPos)
        end
    end)
end

local Positions = UDim2.new(0.822, 0, 0.040, 0)
local Sizes = UDim2.new(0, 76, 0, 70)

local ms = Instance.new("ScreenGui")
local stuffdd = Instance.new("Frame")
local TextButton = Instance.new("TextButton")

ms.Name = "hey"
ms.Parent = game:WaitForChild("CoreGui")
ms.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

stuffdd.Name = "1"
stuffdd.Parent = ms
stuffdd.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
stuffdd.Position = Positions
stuffdd.Size = Sizes

TextButton.Parent = stuffdd
TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextButton.Size = Sizes
TextButton.Text = "Score"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextScaled = true
TextButton.Font = Enum.Font.SourceSans

TextButton.MouseButton1Down:Connect(Score)