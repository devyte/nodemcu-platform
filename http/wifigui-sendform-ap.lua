return function (util, connection, wifiConfig, valuetable, badvalues)
    local getRadioChecked = util.getRadioChecked
    local getTextFilledValue = util.getTextFilledValue
    local getRadioValue = util.getRadioValue
    local getTextColor = util.getTextColor
    local getInputTypeTextString = util.getInputTypeTextString
    local getInputTypeRadioString = util.getInputTypeRadioString

    local auth   = getRadioValue("wifiConfig.accessPointConfig.auth", valuetable) or wifiConfig.accessPointConfig.auth
    local hidden = getRadioValue("wifiConfig.accessPointConfig.hidden", valuetable) or wifiConfig.accessPointConfig.hidden
    local ssid    = "wifiConfig.accessPointConfig.ssid"
    local pwd     = "wifiConfig.accessPointConfig.pwd"
    local channel = "wifiConfig.accessPointConfig.channel"
    local max     = "wifiConfig.accessPointConfig.max"
    local beacon =  "wifiConfig.accessPointConfig.beacon"

    local ftable = {'<h2>Access Point</h2>\r\n',
    getInputTypeTextString('Wifi Name:     ', wifiConfig.accessPointConfig.ssid, ssid, getTextFilledValue(ssid, valuetable), getTextColor(ssid, badvalues)),
    getInputTypeTextString('Wifi Password: ', wifiConfig.accessPointConfig.pwd,  pwd,  getTextFilledValue(pwd,  valuetable), getTextColor(pwd,  badvalues)),
    '<br>\r\n',
    'Authorization type:<br>\r\n',
    getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.OPEN",         getRadioChecked(auth, wifi.OPEN),         "Open"),
    getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.WPA_PSK",      getRadioChecked(auth, wifi.WPA_PSK),      "WPA_PSK"),
    getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.WPA2_PSK",     getRadioChecked(auth, wifi.WPA2_PSK),     "WPA2_PSK"),
    getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.WPA_WPA2_PSK", getRadioChecked(auth, wifi.WPA_WPA2_PSK), "WPA_WPA2_PSK"),
    '<br>\r\n',
    getInputTypeTextString('Wifi Channel:          ', wifiConfig.accessPointConfig.channel, channel, getTextFilledValue(channel, valuetable), getTextColor(channel, badvalues)),
    getInputTypeTextString('Max number of clients: ', wifiConfig.accessPointConfig.max,     max,     getTextFilledValue(max,     valuetable), getTextColor(max,     badvalues)),
    getInputTypeTextString('Beacon interval (ms):  ', wifiConfig.accessPointConfig.beacon,  beacon,  getTextFilledValue(beacon,  valuetable), getTextColor(beacon,  badvalues)),
    '<br>\r\n',
    'Wifi Privacy:<br>\r\n',
    getInputTypeRadioString("wifiConfig.accessPointConfig.hidden", "0",               getRadioChecked(hidden, 0),                "Visible"),
    getInputTypeRadioString("wifiConfig.accessPointConfig.hidden", "1",               getRadioChecked(hidden, 1),                "Hidden"),
    '<br>\r\n'}
  
    connection:send(table.concat(ftable))
    ftable=nil

    collectgarbage()

    local enabled = getRadioValue("wifiConfig.accessPointDHCPConfig.enabled", valuetable) or wifiConfig.accessPointDHCPConfig.enabled
    local ip      = "wifiConfig.accessPointIpConfig.ip"
    local netmask = "wifiConfig.accessPointIpConfig.netmask"
    local gateway = "wifiConfig.accessPointIpConfig.gateway"
    local mac     = "wifiConfig.accessPointIpConfig.mac"
    local start   = "wifiConfig.accessPointDHCPConfig.start"
    
    local ftable = {'<h2>Access Point Network</h2>\r\n',
    getInputTypeTextString('IP Address:   ',    wifiConfig.accessPointIpConfig.ip,      ip,      getTextFilledValue(ip,       valuetable), getTextColor(ip,       badvalues)),
    getInputTypeTextString('Network mask: ',    wifiConfig.accessPointIpConfig.netmask, netmask, getTextFilledValue(netmask,  valuetable), getTextColor(netmask,  badvalues)),
    getInputTypeTextString('Gateway:      ',    wifiConfig.accessPointIpConfig.gateway, gateway, getTextFilledValue(gateway,  valuetable), getTextColor(gateway,  badvalues)),
    getInputTypeTextString('MAC:          ',    wifiConfig.accessPointIpConfig.mac,     mac,     getTextFilledValue(mac,      valuetable), getTextColor(mac,      badvalues)),
    '<br>\r\n',
    'DHCP Server:<br>\r\n',
    getInputTypeRadioString("wifiConfig.accessPointDHCPConfig.enabled", "1", getRadioChecked(enabled, 1), "Enabled"),
    getInputTypeRadioString("wifiConfig.accessPointDHCPConfig.enabled", "0", getRadioChecked(enabled, 0), "Disabled"),
    '<br>\r\n',
    getInputTypeTextString('DHCP pool start: ', wifiConfig.accessPointDHCPConfig.start, start,   getTextFilledValue(start,    valuetable), getTextColor(start,    badvalues)),
    '<br>\r\n'}
    
    connection:send(table.concat(ftable))
    ftable=nil
end
