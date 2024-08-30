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
TextButton.Text = "Toggle Click to Delete"
TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
TextButton.TextScaled = true
TextButton.Font = Enum.Font.SourceSans

TextButton.MouseButton1Down:Connect(function()
    _G.Ya = not _G.Ya
    if _G.Ya then
        TextButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    else
        TextButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    end
end)

TextButton.BackgroundColor3 = _G.Ya and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)