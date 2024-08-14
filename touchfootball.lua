if not game:IsLoaded() then
    game.Loaded:Wait()
end

if _G.ScriptLoaded then
    return
end
_G.ScriptLoaded = true

function Score()
    repeat wait() until game.Players.LocalPlayer.Character
    repeat wait() until game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    local plr = game.Players.LocalPlayer
    local char = plr.Character
    local hrp = char.HumanoidRootPart
    local oldpos = hrp.CFrame
    local file
    local letter
    if game.Players.LocalPlayer.Character:FindFirstChild("Team") then
        file = game.Players.LocalPlayer.Character.Team
        if file.Value == game.Players.LocalPlayer.PlayerGui.Status.FullNameLabelA.Text then
            letter = "B"
        elseif file.Value == game.Players.LocalPlayer.PlayerGui.Status.FullNameLabelB.Text then
            letter = "A"
        end
    else
        file = game.Players.LocalPlayer.Character["UpperTorso"].SurfaceGui.Team
        if file.Text == game.Players.LocalPlayer.PlayerGui.Status.FullNameLabelA.Text then
            letter = "B"
        elseif file.Text == game.Players.LocalPlayer.PlayerGui.Status.FullNameLabelB.Text then
            letter = "A"
        end
    end
    pcall(function()
        repeat wait() until workspace.FootballField:FindFirstChild("SoccerBall")
        for i = 1, 7 do
            hrp.CFrame = workspace.FootballField.Pitch["Goal"..letter].GoalNetTop.CFrame - Vector3.new(0, 5, 0)
            workspace.FootballField.SoccerBall.CFrame = hrp.CFrame
            task.wait(0.5)
        end
        hrp.CFrame = oldpos
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
