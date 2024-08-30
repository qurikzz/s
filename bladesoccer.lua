if not game:IsLoaded() then game.Loaded:Wait() end
if not table.find({14708545931, 17145109661}, game.PlaceId) then return end
if _G.ScriptLoaded then return end
_G.ScriptLoaded = true
function lmao()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local oldPosition = character.HumanoidRootPart.Position
    local playerGoal, ball
    local playerGoalColor
    if player.TeamColor == game.Teams.Red.TeamColor then
        playerGoalColor = "Red"
    elseif player.TeamColor == game.Teams.Blue.TeamColor then
        playerGoalColor = "Blue"
    end
    
    playerGoal = workspace:FindFirstChild(playerGoalColor.."Goal")
    ball = workspace:FindFirstChild("Ball")

    if ball and playerGoal then
        local distanceToPlayerGoal = (ball.Position - playerGoal.Position).Magnitude
        if distanceToPlayerGoal <= 75 then
            character.HumanoidRootPart.CFrame = ball.CFrame
            local blockButton = player.PlayerGui.Gui.ActionsContainer:FindFirstChild("BlockButton")
            if blockButton then
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, blockButton, 0)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, blockButton, 0)
            end
            task.wait()
            character:MoveTo(oldPosition)
        end
    end
end
game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        lmao()
    end)
end)