function loadWhitelist()
    local url = "https://raw.githubusercontent.com/Bexxper/CPS-Whitelist/refs/heads/main/Whitelist.txt" -- Ganti dengan link whitelist-mu
    local response = httprequest(url, "get")
    local whitelist = {}

    if response then
        for uid in response:gmatch("[^\r\n]+") do
            whitelist[tonumber(uid)] = true
        end
    end
    return whitelist
end

-- Load daftar UID yang diizinkan
whitelistUIDs = loadWhitelist()

function isUIDAllowed(uid)
    return whitelistUIDs[uid] == true
end
