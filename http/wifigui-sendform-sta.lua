return function (util, connection, wifiConfig, valuetable, badvalues)
    local getRadioChecked = util.getRadioChecked
    local getTextFilledValue = util.getTextFilledValue
    local getRadioValue = util.getRadioValue
    local getTextColor = util.getTextColor
    local getInputTypeTextString = util.getInputTypeTextString
    local getInputTypeRadioString = util.getInputTypeRadioString

    
    local auto = getRadioValue("wifiConfig.stationPointConfig.auto", valuetable) or wifiConfig.stationPointConfig.auto
    local ssid  = "wifiConfig.stationPointConfig.ssid"
    local pwd   = "wifiConfig.stationPointConfig.pwd"
    
    local ftable = {'<h2>Station</h2>\r\n',
    getInputTypeTextString('Wifi Name: ', wifiConfig.stationPointConfig.ssid, ssid, getTextFilledValue(ssid,  valuetable), getTextColor(ssid,  badvalues)),
    getInputTypeTextString('Password:  ', wifiConfig.stationPointConfig.pwd,  pwd,  getTextFilledValue(pwd,   valuetable), getTextColor(pwd,   badvalues)),
    '<br>\r\n',
    'Auto Connect:<br>\r\n',
    getInputTypeRadioString("wifiConfig.stationPointConfig.auto", "1", getRadioChecked(auto, 1), "Enabled"),
    getInputTypeRadioString("wifiConfig.stationPointConfig.auto", "0", getRadioChecked(auto, 0), "Disabled"),
    '<br>\r\n'}

    connection:send(table.concat(ftable))
    ftable=nil
    collectgarbage()
    
    local hostname = "wifiConfig.stationPointConfig.hostname"
    local ip       = "wifiConfig.stationPointIpConfig.ip"
    local netmask  = "wifiConfig.stationPointIpConfig.netmask"
    local gateway  = "wifiConfig.stationPointIpConfig.gateway"
    local mac      = "wifiConfig.stationPointIpConfig.mac"
    
    local ftable = {'<h2>Station Network</h2>\r\n',
    getInputTypeTextString('Hostname:     ', wifiConfig.stationPointConfig.hostname, hostname, getTextFilledValue(hostname, valuetable), getTextColor(hostname, badvalues)),
    getInputTypeTextString('IP Address:   ', wifiConfig.stationPointIpConfig.ip,      ip,      getTextFilledValue(ip,       valuetable), getTextColor(ip,       badvalues)),
    getInputTypeTextString('Network mask: ', wifiConfig.stationPointIpConfig.netmask, netmask, getTextFilledValue(netmask,  valuetable), getTextColor(netmask,  badvalues)),
    getInputTypeTextString('Gateway:      ', wifiConfig.stationPointIpConfig.gateway, gateway, getTextFilledValue(gateway,  valuetable), getTextColor(gateway,  badvalues)),
    getInputTypeTextString('MAC:          ', wifiConfig.stationPointIpConfig.mac,     mac,     getTextFilledValue(mac,      valuetable), getTextColor(mac,      badvalues)),
    '<br>\r\n'}

    connection:send(table.concat(ftable))
    ftable=nil
end
