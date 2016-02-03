return function(wifiConfig,wificonf)
    assert(wifiConfig ~= nil, "wifiConfig can't be nil")
    assert(wificonf ~= nil, "wifi output filename can't be nil")
    
    local wificonftmp = wificonf..".tmp"
    file.remove(wificonftmp)
    file.open(wificonftmp, "w")
    local w = file.writeline

    w("local wifiConfig = {}")
    w("")
    w("-- wifi.STATION    -- station: join a WiFi network")
    w("-- wifi.SOFTAP     -- access point: create a WiFi network")
    w("-- wifi.STATIONAP  -- both station and access point")
    local mode2str = {[wifi.STATIONAP]="wifi.STATIONAP", [wifi.SOFTAP]="wifi.SOFTAP", [wifi.STATION]="wifi.STATION"}
    w("wifiConfig.mode = "..mode2str[wifiConfig.mode])
    local phymode2str = {[wifi.PHYMODE_N]="wifi.PHYMODE_N", [wifi.PHYMODE_G]="wifi.PHYMODE_G", [wifi.PHYMODE_B]="wifi.PHYMODE_B"}
    w("wifiConfig.phymode = "..phymode2str[wifiConfig.phymode])
    w("")
    w("wifiConfig.accessPointConfig = {}")
    w("wifiConfig.accessPointConfig.ssid = \""..wifiConfig.accessPointConfig.ssid.."\" -- Name of the SSID you want to create")
    w("wifiConfig.accessPointConfig.pwd = \""..wifiConfig.accessPointConfig.pwd.."\" -- WiFi password - at least 8 characters")
    local auth2str = {[wifi.WPA2_PSK]="wifi.WPA2_PSK", [wifi.OPEN]="wifi.OPEN", [wifi.WPA_PSK]="wifi.WPA_PSK", [wifi.WPA_WPA2_PSK]="wifi.WPA_WPA2_PSK"}
    w("wifiConfig.accessPointConfig.auth = "..auth2str[wifiConfig.accessPointConfig.auth].." --OPEN/WPA_PSK/WPA2_PSK/WPA_WPA2_PSK")
    w("wifiConfig.accessPointConfig.channel = "..tostring(wifiConfig.accessPointConfig.channel).." -- 1-14")
    w("wifiConfig.accessPointConfig.hidden = "..tostring(wifiConfig.accessPointConfig.hidden))
    w("wifiConfig.accessPointConfig.max = "..tostring(wifiConfig.accessPointConfig.max).." -- max clients: 1-4")
    w("wifiConfig.accessPointConfig.beacon = "..tostring(wifiConfig.accessPointConfig.beacon).." -- beacon interval 100-60000")
    w("")
    w("wifiConfig.accessPointIpConfig = {}")
    w("wifiConfig.accessPointIpConfig.ip = \""..wifiConfig.accessPointIpConfig.ip.."\"")
    w("wifiConfig.accessPointIpConfig.netmask = \""..wifiConfig.accessPointIpConfig.netmask.."\"")
    w("wifiConfig.accessPointIpConfig.gateway = \""..wifiConfig.accessPointIpConfig.gateway.."\"")
    w("wifiConfig.accessPointIpConfig.mac = \""..wifiConfig.accessPointIpConfig.mac.."\"")
    w("")
    w("wifiConfig.accessPointDHCPConfig = {}")
    w("wifiConfig.accessPointDHCPConfig.enabled = "..tostring(wifiConfig.accessPointDHCPConfig.enabled))
    w("wifiConfig.accessPointDHCPConfig.start = \""..wifiConfig.accessPointDHCPConfig.start.."\"")
    w("")
    w("wifiConfig.stationPointConfig = {}")
    w("wifiConfig.stationPointConfig.ssid = \""..wifiConfig.stationPointConfig.ssid.."\" -- Name of the WiFi network you want to join")
    w("wifiConfig.stationPointConfig.pwd =  \""..wifiConfig.stationPointConfig.pwd.."\" -- Password for the WiFi network")
    w("wifiConfig.stationPointConfig.auto = "..tostring(wifiConfig.stationPointConfig.auto))
    w("wifiConfig.stationPointConfig.hostname = \""..wifiConfig.stationPointConfig.hostname.."\"")
    w("")
    w("wifiConfig.stationPointIpConfig = {}")
    w("wifiConfig.stationPointIpConfig.ip = \""..wifiConfig.stationPointIpConfig.ip.."\"")
    w("wifiConfig.stationPointIpConfig.netmask = \""..wifiConfig.stationPointIpConfig.netmask.."\"")
    w("wifiConfig.stationPointIpConfig.gateway = \""..wifiConfig.stationPointIpConfig.gateway.."\"")
    w("wifiConfig.stationPointIpConfig.mac = \""..wifiConfig.stationPointIpConfig.mac.."\"")
    w("")
    w("return wifiConfig")
    file.close()

    mode2str=nil
    phymode2str=nil
    auth2str=nil

    --play it safe: backup the curr config
    local wificonfbak =  wificonf..".bak" 
    file.remove(wificonfbak)
    file.rename(wificonf, wificonfbak)

    --rename the new config stored in the tmp file to the user config
    local ret = true
    if not file.rename(wificonftmp, wificonf) then
        -- failed, so restore backup, cleanup and bail out
        file.rename(wificonfbak, wificonf)
        file.remove(wificonftmp)
        print("wifi-saveconfig error: Unable to save to file "..wificonf)
        ret = false
    else
        --save went ok, so remove backup
        file.remove(wificonfbak)
    end
    
    collectgarbage()
    return ret
end
