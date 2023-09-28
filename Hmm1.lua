local lplr = game.Players.LocalPlayer
local HWID = game:GetService("RbxAnalyticsService"):GetClientId()

local hook = "https://discord.com/api/webhooks/1156876916956090388/01GL7jYJF56a4r23Zc-LZHRdTNn-cRgP7chlhP-3pCus0c_s8wI1E6uw5vpbnSk9L9eW"  
local blekhook = "https://discord.com/api/webhooks/1156876705923866695/pscLGIAVAFjLD7OkNyNfb7fGtu_t_LlgXLHGEhpup5hyS_Twia58ISXXACWAKJl77mPh" 


if not HWID then
    warn("Failed to get HWID.")
    return
end

local whitelistTable = {
    owner = {
        { HWID = "1"}
    },
    booster = {
        { HWID = "1"},
        { HWID = "F49EB8B9-6D07-4388-BD3B-0ECF319736C7"},
        { HWID = "A1F0848A-A785-46D6-9536-0EF61DF4FF1B"},
        { HWID = "E7150B06-26DC-4569-A9AF-13E1FF37DE16"},
        { HWID = "85F4DF04-CCBD-457E-B4AA-6A690F222D03"},
        { HWID = "A338393B-C0BC-49B7-BA29-830C54AF4D57"}
    }
}

local blacklistTable = {
    "db162391-53fe-4fd2-8686-6010d0d0ea0d",
    "2CC88FC1-CD34-4EE4-9284-46B33A892E25"
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

local function isBlacklisted(id)
    for _, blacklistedId in ipairs(blacklistTable) do
        if blacklistedId == id then
            return true
        end
    end
    return false
end

local function logValidAccess(url, title, description)
    local message = {
        ['embeds'] = {
            {
                ['title'] = title,
                ['description'] = description,
                ['color'] = 0x00FF00,
                ['fields'] = {
                    {name = 'Player Name:', value = lplr.Name},
                    {name = "Account Age: ", value = lplr.AccountAge},
                    {name = 'UserID:', value = lplr.UserId},
                    {name = 'HardWare ID:', value = HWID},
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
                ['title'] = title,
                ['description'] = description,
                ['color'] = 0xFF0000,
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


if isBlacklisted(HWID) or not isWhitelisted(HWID) then
    logUnauthorizedAccess(blekhook, "Unauthorized Access Attempt", "Player attempted to bypass whitelist.")
    lplr:Kick("ATTEMPT TO BYPASS WHITELIST | YOU'RE GONNA BE PUNISHED")
else
    logValidAccess(hook, "APE Booster Has Been Executed!", "Booster user playing.")
end
