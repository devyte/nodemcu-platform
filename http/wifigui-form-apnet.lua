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
    
    local ftable = table.concat({
    '<h2>Access Point Network</h2>\n',
    '<table>\n',
    getInputTypeTextString('IP Address:   ',    wifiConfig.accessPointIpConfig.ip,      ip,      getTextFilledValue(ip,       valuetable), getTextColor(ip,       badvalues)),
    getInputTypeTextString('Network mask: ',    wifiConfig.accessPointIpConfig.netmask, netmask, getTextFilledValue(netmask,  valuetable), getTextColor(netmask,  badvalues)),
    getInputTypeTextString('Gateway:      ',    wifiConfig.accessPointIpConfig.gateway, gateway, getTextFilledValue(gateway,  valuetable), getTextColor(gateway,  badvalues)),
    getInputTypeTextString('MAC:          ',    wifiConfig.accessPointIpConfig.mac,     mac,     getTextFilledValue(mac,      valuetable), getTextColor(mac,      badvalues)),
    '</table><br>\n',
    'DHCP Server:<br>\n',
    getInputTypeRadioString("wifiConfig.accessPointDHCPConfig.enabled", "1", getRadioChecked(enabled, 1), "Enabled"),
    getInputTypeRadioString("wifiConfig.accessPointDHCPConfig.enabled", "0", getRadioChecked(enabled, 0), "Disabled"),
    '<table>\n',
    getInputTypeTextString('DHCP pool start: ', wifiConfig.accessPointDHCPConfig.start, start,   getTextFilledValue(start,    valuetable), getTextColor(start,    badvalues)),
    '</table><br>\n',
    })
    
    collectgarbage()
    connection:send(ftable)
end
