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

    connection:send('<h2>Station Network</h2>\n')
    connection:send('<table>\n')
    connection:send(getInputTypeTextString('Hostname:',     wifiConfig.stationPointConfig.hostname, hostname, getTextFilledValue(hostname, valuetable), getTextColor(hostname, badvalues)))
    connection:send(getInputTypeTextString('IP Address:',   wifiConfig.stationPointIpConfig.ip,      ip,      getTextFilledValue(ip,       valuetable), getTextColor(ip,       badvalues)))
    connection:send(getInputTypeTextString('Network mask:', wifiConfig.stationPointIpConfig.netmask, netmask, getTextFilledValue(netmask,  valuetable), getTextColor(netmask,  badvalues)))
    connection:send(getInputTypeTextString('Gateway:',      wifiConfig.stationPointIpConfig.gateway, gateway, getTextFilledValue(gateway,  valuetable), getTextColor(gateway,  badvalues)))
    connection:send(getInputTypeTextString('MAC:',          wifiConfig.stationPointIpConfig.mac,     mac,     getTextFilledValue(mac,      valuetable), getTextColor(mac,      badvalues)))
    connection:send('</table><br>\n')
end
