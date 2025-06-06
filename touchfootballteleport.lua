if not game:IsLoaded() then game.Loaded:Wait() end
if game.PlaceId ~= 16447934574 then return end
if _G.ScriptLoaded then return end
_G.ScriptLoaded = true

local ts = game:GetService("TeleportService")

local portals = {
    PortalEliteClanLeague = 16452714764,
    PortalElite = 16876418704,
    PortalPro = 16452698027,
    PortalGold = 16452695324,
    PortalJunior = 16452693191,
    PortalQuests = 81844361462023,
    PortalStreet = 105531756926941,
    PortalFutsal = 16452721151,
    PortalCup = 16453243555,
    Portal1vs1 = 18738477182
}

function tp(pn, pd)
    workspace.Lobby.Portals[pn].Touched:Connect(function()
        ts:Teleport(pd)
    end)
end

for pn, pd in pairs(portals) do
    tp(pn, pd)
end