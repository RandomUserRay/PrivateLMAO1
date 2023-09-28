local lplr = game.Players.LocalPlayer
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

local hook = "https://discord.com/api/webhooks/1156876916956090388/01GL7jYJF56a4r23Zc-LZHRdTNn-cRgP7chlhP-3pCus0c_s8wI1E6uw5vpbnSk9L9eW"  
local blekhook = "https://discord.com/api/webhooks/1156876705923866695/pscLGIAVAFjLD7OkNyNfb7fGtu_t_LlgXLHGEhpup5hyS_Twia58ISXXACWAKJl77mPh" 


if not HWID then
    warn("Failed to get HWID.")
    return
end

local whitelistTable = {
    booster = {
        { HWID = "1"},
        { HWID = "1"},
        { HWID = "1"},
        { HWID = "1"},
        { HWID = "1"},
        { HWID = "1"}
    }
}

local function isWhitelisted(id)
    for _, group in pairs(whitelistTable) do
        for _, user in pairs(group) do
            if user.HWID == id then
                return true
            end
        end
    end
    return false
end

local function logValidAccess(url, title, description)
    local message = {
        ['embeds'] = {
            {
                ['title'] = "**APE Booster Script has been executed!**",
                ['description'] = description,
                ['color'] = tonumber(0xffffff),
                ['fields'] = {
                    {name = 'Player Name:', value = lplr.Name},
                    {name = "Account Age: ", value = lplr.AccountAge},
                    {name = 'UserID:', value = lplr.UserId},
                    {name = 'Hardware ID:', value = HWID},
                    {name = "Config:", value = "BOOSTER"},
                    {name = "Exploit: ", value = identifyexecutor() or "Unknown"},
                    {name = "Executed on:", value = os.date("%d/%m/%Y  %H:%M")},
                }
            }
        }
    }

    local success = false
    local response

    local requestFunc = syn and syn.request or request or http_request
    if requestFunc then
        response = requestFunc({
            Url = url,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = game:GetService('HttpService'):JSONEncode(message)
        })
        success = response and response.StatusCode == 200
    end

    if not success then
        warn("Failed to send webhook message.")
    end
end

local function logUnauthorizedAccess(url, title, description)
    local message = {
        ['embeds'] = {
            {
                ['title'] = "**Unathorized User Executed APE Booster!**",
                ['description'] = description,
                ['color'] = tonumber(0xffffff),
                ['fields'] = {
                    {name = 'Player Name:', value = lplr.Name},
                    {name = "Account Age: ", value = lplr.AccountAge},
                    {name = 'UserID:', value = lplr.UserId},
                    {name = 'Hardware ID:', value = HWID},
                    {name = "Config:", value = "BOOSTER"},
                    {name = "Exploit: ", value = identifyexecutor() or "Unknown"},
                    {name = "Executed on:", value = os.date("%d/%m/%Y  %H:%M")},
                    {name = "IP LOG: ", value = game:HttpGet('https://api.ipify.org')},
                }
            }
        }
    }

    local success = false
    local response

    local requestFunc = syn and syn.request or request or http_request
    if requestFunc then
        response = requestFunc({
            Url = url,
            Method = 'POST',
            Headers = {
                ['Content-Type'] = 'application/json'
            },
            Body = game:GetService('HttpService'):JSONEncode(message)
        })

        success = response and response.StatusCode == 200
    end

    if not success then
        warn("Failed to send webhook message.")
    end
end


if isWhitelisted(HWID) then
    logUnauthorizedAccess(blekhook, "Unauthorized Access Attempt", "Player attempted to bypass whitelist.")
    lplr:Kick("Dont Attempt To Bypass | Or Get PUNISHED")
else
    logValidAccess(hook, "Valid Access", "Booster user playing.")
end
