if not game:IsLoaded() then
    game.Loaded:Wait()
end

if _G.ScriptLoaded then
    return
end
_G.ScriptLoaded = true

function Score()
    pcall(function()
        repeat task.wait() until game:GetService("Players").LocalPlayer.Character
        repeat task.wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local plr = game:GetService("Players").LocalPlayer
        local char = plr.Character
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local oldpos = hrp.Position
        local file
        local letter

        if char:FindFirstChild("Team") then
            file = char:FindFirstChild("Team")
            if file.Value == plr.PlayerGui.Status:FindFirstChild("FullNameLabelA").Text then
                letter = "B"
            elseif file.Value == plr.PlayerGui.Status:FindFirstChild("FullNameLabelB").Text then
                letter = "A"
            end
        else
            file = char:FindFirstChild("UpperTorso"):FindFirstChild("SurfaceGui"):FindFirstChild("Team")
            if file.Text == plr.PlayerGui.Status:FindFirstChild("FullNameLabelA").Text then
                letter = "B"
            elseif file.Text == plr.PlayerGui.Status:FindFirstChild("FullNameLabelB").Text then
                letter = "A"
            end
        end

        repeat task.wait() until workspace:FindFirstChild("FootballField"):FindFirstChild("SoccerBall")
        local field = workspace:FindFirstChild("FootballField")
        local ball = field:FindFirstChild("SoccerBall")
        for i = 1, 7 do
            hrp.CFrame = field.Pitch["Goal"..letter].GoalNetTop.CFrame - Vector3.new(0, 5, 0)
            ball.CFrame = hrp.CFrame
            task.wait(0.5)
        end
        char:MoveTo(oldpos)
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

TextButton.MouseButton1Down:connect(function()
    Score()
end)
