if not game:IsLoaded() then game.Loaded:Wait() end
if game.PlaceId ~= 14708545931 then return end
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
        if distanceToPlayerGoal <= 100 then
            character:MoveTo(ball.Position - Vector3.new(0, 3, 0))
            task.wait()
            local blockButton = player.PlayerGui.Gui.ActionsContainer:FindFirstChild("BlockButton")
            if blockButton then
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, blockButton, 0)
                game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, blockButton, 0)
            end
            character:MoveTo(oldPosition)
        end
    end
end
game:GetService("RunService").Heartbeat:Connect(function()
    pcall(function()
        lmao()
    end)
end)