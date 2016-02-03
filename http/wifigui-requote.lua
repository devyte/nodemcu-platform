return function(rd)
    local quotetable = {
            ["wifiConfig.accessPointConfig.ssid"] = true,
            ["wifiConfig.accessPointConfig.pwd"] = true,
            ["wifiConfig.accessPointIpConfig.ip"] = true,
            ["wifiConfig.accessPointIpConfig.netmask"] = true,
            ["wifiConfig.accessPointIpConfig.gateway"] = true,
            ["wifiConfig.accessPointIpConfig.mac"] = true,
            ["wifiConfig.accessPointDHCPConfig.start"] = true,
            ["wifiConfig.stationPointConfig.ssid"] = true,
            ["wifiConfig.stationPointConfig.pwd"] =  true,
            ["wifiConfig.stationPointConfig.hostname"] = true,
            ["wifiConfig.stationPointIpConfig.ip"] = true,
            ["wifiConfig.stationPointIpConfig.netmask"] = true,
            ["wifiConfig.stationPointIpConfig.gateway"] = true,
            ["wifiConfig.stationPointIpConfig.mac"] = true
    }

    for name,value in pairs(rd) do
        if quotetable[name] then
            rd[name] = "\""..value.."\""
        end
    end
end
