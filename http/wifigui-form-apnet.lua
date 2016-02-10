return function (util, connection, wifiConfig, valuetable, badvalues)
    local getRadioChecked = util.getRadioChecked
    local getTextFilledValue = util.getTextFilledValue
    local getRadioValue = util.getRadioValue
    local getTextColor = util.getTextColor
    local getInputTypeTextString = util.getInputTypeTextString
    local getInputTypeRadioString = util.getInputTypeRadioString

    local enabled = getRadioValue("wifiConfig.accessPointDHCPConfig.enabled", valuetable) or wifiConfig.accessPointDHCPConfig.enabled
    local ip      = "wifiConfig.accessPointIpConfig.ip"
    local netmask = "wifiConfig.accessPointIpConfig.netmask"
    local gateway = "wifiConfig.accessPointIpConfig.gateway"
    local mac     = "wifiConfig.accessPointIpConfig.mac"
    local start   = "wifiConfig.accessPointDHCPConfig.start"

    connection:send('<h2>Access Point Network</h2>\n')
    connection:send('<table>\n')
    connection:send(getInputTypeTextString('IP Address:',     wifiConfig.accessPointIpConfig.ip,      ip,      getTextFilledValue(ip,       valuetable), getTextColor(ip,       badvalues)))
    connection:send(getInputTypeTextString('Network mask:',   wifiConfig.accessPointIpConfig.netmask, netmask, getTextFilledValue(netmask,  valuetable), getTextColor(netmask,  badvalues)))
    connection:send(getInputTypeTextString('Gateway:',        wifiConfig.accessPointIpConfig.gateway, gateway, getTextFilledValue(gateway,  valuetable), getTextColor(gateway,  badvalues)))
    connection:send(getInputTypeTextString('MAC:',            wifiConfig.accessPointIpConfig.mac,     mac,     getTextFilledValue(mac,      valuetable), getTextColor(mac,      badvalues)))
    connection:send('</table><br>\n')
    connection:send('DHCP Server:<br>\n')
    connection:send(getInputTypeRadioString("wifiConfig.accessPointDHCPConfig.enabled", "1", getRadioChecked(enabled, 1), "Enabled"))
    connection:send(getInputTypeRadioString("wifiConfig.accessPointDHCPConfig.enabled", "0", getRadioChecked(enabled, 0), "Disabled"))
    connection:send('<table>\n')
    connection:send(getInputTypeTextString('DHCP pool start:', wifiConfig.accessPointDHCPConfig.start, start,   getTextFilledValue(start,    valuetable), getTextColor(start,    badvalues)))
    connection:send('</table><br>\n')
    
end
