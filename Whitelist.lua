function loadWhitelist()
    local url = "https://raw.githubusercontent.com/Bexxper/CPS-Whitelist/refs/heads/main/Whitelist.txt"
    local response = httprequest(url, "get")
    local whitelist = {}

    if response then
        for uid in response:gmatch("[^\r\n]+") do  -- Reads each line from the response
            local numUID = tonumber(uid)           -- Attempts to convert each line to a number
            if numUID then                         -- If successful...
                whitelist[numUID] = true           -- ...add it to the whitelist
            else                                  -- Otherwise...
                log("Warning: Invalid UID in whitelist: " .. uid) -- ...log a warning
            end
        end
    else
        log("Error: Failed to load whitelist from " .. url)  -- Handle network errors
    end
    return whitelist
end

-- Load the whitelist
whitelist = loadWhitelist()

-- If the whitelist fails to load, a fallback mechanism is needed.
if not whitelist then
  log("Whitelist failed to load.  No players will be allowed.")
  -- Consider adding a fallback action, such as shutting down the server.
  -- os.exit() -- Use cautiously! This will terminate the script.
end

function isUIDAllowed(uid)
    return whitelist[tonumber(uid)] == true  -- Added tonumber for safety.
end
