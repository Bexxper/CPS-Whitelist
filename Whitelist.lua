function loadWhitelist()
    local url = "website"
    local response = httprequest(url, "get")
    local whitelist = {}

    if response then
        for uid in response:gmatch("[^\r\n]+") do
            local numUID = tonumber(uid)
            if numUID then -- Check if conversion to number was successful
                whitelist[numUID] = true
            else
                log("Warning: Invalid UID in whitelist: " .. uid)
            end
        end
    else
        log("Error: Failed to load whitelist from " .. url)
    end
    return whitelist
end

-- Load the whitelist.  Error handling is included.
whitelist = loadWhitelist()
if not whitelist then
    log("Whitelist failed to load. No players will be allowed.")
    --Consider adding a fallback action, such as shutting down the server.
    --os.exit() -- this will stop the script.  Use cautiously.
end

function isUIDAllowed(uid)
    return whitelist[uid] == true
end
