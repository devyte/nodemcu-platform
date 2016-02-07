return function (util, connection, wifiConfig, valuetable, badvalues)
    local getRadioChecked = util.getRadioChecked
    local getTextFilledValue = util.getTextFilledValue
    local getRadioValue = util.getRadioValue
    local getTextColor = util.getTextColor
    local getInputTypeTextString = util.getInputTypeTextString
    local getInputTypeRadioString = util.getInputTypeRadioString
  
    local hostname = "wifiConfig.stationPointConfig.hostname"
    local ip       = "wifiConfig.stationPointIpConfig.ip"
    local netmask  = "wifiConfig.stationPointIpConfig.netmask"
    local gateway  = "wifiConfig.stationPointIpConfig.gateway"
    local mac      = "wifiConfig.stationPointIpConfig.mac"
    
    local ftable = table.concat({
    '<h2>Station Network</h2>\n',
    '<table>\n',
    getInputTypeTextString('Hostname:     ', wifiConfig.stationPointConfig.hostname, hostname, getTextFilledValue(hostname, valuetable), getTextColor(hostname, badvalues)),
    getInputTypeTextString('IP Address:   ', wifiConfig.stationPointIpConfig.ip,      ip,      getTextFilledValue(ip,       valuetable), getTextColor(ip,       badvalues)),
    getInputTypeTextString('Network mask: ', wifiConfig.stationPointIpConfig.netmask, netmask, getTextFilledValue(netmask,  valuetable), getTextColor(netmask,  badvalues)),
    getInputTypeTextString('Gateway:      ', wifiConfig.stationPointIpConfig.gateway, gateway, getTextFilledValue(gateway,  valuetable), getTextColor(gateway,  badvalues)),
    getInputTypeTextString('MAC:          ', wifiConfig.stationPointIpConfig.mac,     mac,     getTextFilledValue(mac,      valuetable), getTextColor(mac,      badvalues)),
    '</table><br>\n'
    })

    collectgarbage()
    connection:send(ftable)
end
