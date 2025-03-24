function loadWhitelist()
    local url = "https://raw.githubusercontent.com/Bexxper/CPS-Whitelist/refs/heads/main/Whitelist.txt"
    local response = httprequest(url, "get")
    local whitelist = {}

    if response then
        for growID in response:gmatch("[^\r\n]+") do
            whitelist[growID] = true
        end
    else
        log("Error: Failed to load whitelist from " .. url)
    end
    return whitelist
end

whitelist = loadWhitelist()

if not whitelist then
  log("Whitelist failed to load. No players will be allowed.")
end

function isGrowIDAllowed(growID)
    return whitelist[growID]
end
