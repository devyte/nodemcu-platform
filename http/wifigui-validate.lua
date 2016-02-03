return function(rd)
    local function validateRange(arg, min, max)
        return arg >= min and arg <= max
    end

    local function validateIp(arg)
        local s1, s2, s3, s4
        s1,s2,s3,s4 = arg:match("^(%d+)%.(%d+)%.(%d+)%.(%d+)$")
        if not s1 or not s2 or not s3 or not s4 then 
            return false
        end
        local c1 = validateRange(tonumber(s1), 0, 255)
        local c2 = validateRange(tonumber(s2), 0, 255)
        local c3 = validateRange(tonumber(s3), 0, 255)
        local c4 = validateRange(tonumber(s4), 0, 255)
        return c1 and c2 and c3 and c4
    end

    local function validateMAC(arg)
        return nil ~= arg:match("^(%x%x:%x%x:%x%x:%x%x:%x%x:%x%x)$")
    end

    local function validateMax(arg)
        local n = tonumber(arg)
        return not not n and validateRange(n, 1, 4)
    end

    local function validateBeacon(arg)
        local n = tonumber(arg)
        return not not n and validateRange(n, 100, 60000)
    end

    local function validateChannel(arg)
        local n = tonumber(arg)
        return not not n and validateRange(n, 1, 14)
    end

    local function validateSSID(ssid)
        return validateRange(#ssid, 1, 32)
    end

    local function validatePwd(pwd)
        return validateRange(#pwd, 8, 64)
    end

    local function validateHostname(hostname)
        if not validateRange(#hostname, 1, 32) then
            return false
        end

        local rem
        local nrep
        rem, nrep = hostname:gsub("[a-zA-Z0-9-]", "")
        if #rem ~= 0 then
            return false
        end

        if hostname:sub(1, 1) == "-" or hostname:sub(-1, -1) == "-" then
            return false
        end

        return true
    end


    local validatetable = {
            ["wifiConfig.accessPointConfig.ssid"] = validateSSID,
            ["wifiConfig.accessPointConfig.pwd"] = validatePwd,
            ["wifiConfig.accessPointConfig.channel"] = validateChannel,
            ["wifiConfig.accessPointConfig.max"] = validateMax,
            ["wifiConfig.accessPointConfig.beacon"] = validateBeacon,
            ["wifiConfig.accessPointIpConfig.ip"] = validateIp,
            ["wifiConfig.accessPointIpConfig.netmask"] = validateIp,
            ["wifiConfig.accessPointIpConfig.gateway"] = validateIp,
            ["wifiConfig.accessPointIpConfig.mac"] = validateMAC,
            ["wifiConfig.accessPointDHCPConfig.start"] = validateIp,
            ["wifiConfig.stationPointConfig.ssid"] = validateSSID,
            ["wifiConfig.stationPointConfig.pwd"] =  validatePwd,
            ["wifiConfig.stationPointConfig.hostname"] = validateHostname,
            ["wifiConfig.stationPointIpConfig.ip"] = validateIp,
            ["wifiConfig.stationPointIpConfig.netmask"] = validateIp,
            ["wifiConfig.stationPointIpConfig.gateway"] = validateIp,
            ["wifiConfig.stationPointIpConfig.mac"] = validateMAC
    }
    
    local badvalues = {}
    for name, value in pairs(rd) do
        if validatetable[name] then
            if not validatetable[name](value) then
                badvalues[name] = value
            end
        end
    end

    return badvalues
end
