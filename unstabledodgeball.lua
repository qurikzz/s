if not game:IsLoaded() then
    game.Loaded:Wait()
end

if game.PlaceId ~= 13184548429 then
    return
end

if _G.ScriptLoaded then
    return
end
_G.ScriptLoaded = true

local s = game.Players.LocalPlayer:GetMouse()
_G.Ya = false

s.Button1Down:Connect(function()
    if _G.Ya ~= true then return end
    game:GetService("ReplicatedStorage").dodgeball:FireServer(Vector3.new(0, 0, 0), s.Target)
end)

local function cUI()
    local modeText = _G.Ya and "<font color='rgb(0,255,0)'>ON</font>" or "<font color='rgb(255,0,0)'>OFF</font>"
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
    TextButton.Text = string.format("🏐 Toggle Mode\n<font size='12'>Mode: %s</font>", modeText)
    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextButton.TextScaled = true
    TextButton.Font = Enum.Font.FredokaOne
    TextButton.BorderSizePixel = 0
    TextButton.RichText = true
    TextButton.ClipsDescendants = false
    TextButton.TextStrokeTransparency = 1

    UICorner.CornerRadius = UDim.new(1, 0)
    UICorner.Parent = TextButton

    UIStroke.Parent = TextButton
    UIStroke.Color = Color3.new(0.109804, 0.270588, 0.321569)
    UIStroke.Thickness = 4.070723056793213
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

    TextButton.MouseButton1Down:Connect(function()
        _G.Ya = not _G.Ya
        modeText = _G.Ya and "<font color='rgb(0,255,0)'>ON</font>" or "<font color='rgb(255,0,0)'>OFF</font>"
        TextButton.Text = string.format("🏐 Toggle Mode\n<font size='12'>Mode: %s</font>", modeText)
    end)
end

cUI()