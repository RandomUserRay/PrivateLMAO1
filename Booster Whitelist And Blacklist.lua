local lplr = game.Players.LocalPlayer
local clientID = game:GetService("RbxAnalyticsService"):GetClientId()

local hook = "https://discord.com/api/webhooks/1156871567356203088/XQbXT6Y-84FPfKCMzHe49imjAbT4_pUQ_Gs2gqm4o7m8_3B6FsMjyAgWwpppSiGH0kjw"  
local blekhook = "https://discord.com/api/webhooks/1156873739225530378/x9Ki34ZjPx3WyBo2aRS4boUHQOl-4cZpO7J71JwZ_qwlAf-3456ffIL6KpuHbZZgpUFT" 


if not clientID then
    warn("Failed to get HWID.")
    return
end

local whitelistTable = {
    booster = {
        { clientID = "04C54741-6DCE-4B59-8897-BFA881BB8607"},
        { clientID = "d43702ff-4db7-4d9c-ad99-4da86baa9dfa"},
        { clientID = "8353FD0B-B888-4FE1-A0B2-A4F2C9571C34"},
        { clientID = "1"},
        { clientID = "1"},
        { clientID = "1"}
    }
}

local blacklistTable = {
    "1",
    "1"
}

local function isWhitelisted(id)
    for _, group in pairs(whitelistTable) do
        for _, user in pairs(group) do
            if user.clientID == id then
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
                    {name = 'HardWare ID:', value = clientID},
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
                    {name = 'Hardware ID:', value = clientID},
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


if isBlacklisted(clientID) or not isWhitelisted(clientID) then
    logUnauthorizedAccess(blekhook, "Unauthorized Access Attempt", "Player attempted to bypass whitelist.")
    lplr:Kick("ATTEMPT TO BYPASS WHITELIST | YOU'RE GONNA BE PUNISHED")
else
    logValidAccess(hook, "APE Booster Has Been Executed!", "Booster user playing.")
end
