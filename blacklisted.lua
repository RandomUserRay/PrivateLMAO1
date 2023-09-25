local lplr = game.Players.LocalPlayer
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

local blacklistTable = {
    "1",
    "2CC88FC1-CD34-4EE4-9284-46B33A892E25"
}

local function isBlacklisted(id)
    for _, blacklistedId in ipairs(blacklistTable) do
        if blacklistedId == id then
            return true
        end
    end
    return false
end

if isBlacklisted(HWID) then
    lplr:Kick("you have been Blacklisted from APE | Dms RayHafz or Aidksi To Appeal")
end
