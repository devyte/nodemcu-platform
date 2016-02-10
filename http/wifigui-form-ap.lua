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

    connection:send('<h2>Access Point</h2>\n')
    connection:send('<table>\n')
    connection:send(getInputTypeTextString('Wifi Name (SSID):', wifiConfig.accessPointConfig.ssid, ssid, getTextFilledValue(ssid, valuetable), getTextColor(ssid, badvalues)))
    connection:send(getInputTypeTextString('Wifi Password:'   , wifiConfig.accessPointConfig.pwd,  pwd,  getTextFilledValue(pwd,  valuetable), getTextColor(pwd,  badvalues)))
    connection:send('</table><br>\n')
    connection:send('Authorization type:<br>\n')
    connection:send(getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.OPEN",         getRadioChecked(auth, wifi.OPEN),         "Open"))
    connection:send(getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.WPA_PSK",      getRadioChecked(auth, wifi.WPA_PSK),      "WPA_PSK"))
    connection:send(getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.WPA2_PSK",     getRadioChecked(auth, wifi.WPA2_PSK),     "WPA2_PSK"))
    connection:send(getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.WPA_WPA2_PSK", getRadioChecked(auth, wifi.WPA_WPA2_PSK), "WPA_WPA2_PSK"))
    connection:send('<br><table>\n')
    connection:send(getInputTypeTextString('Wifi Channel:',          wifiConfig.accessPointConfig.channel, channel, getTextFilledValue(channel, valuetable), getTextColor(channel, badvalues)))
    connection:send(getInputTypeTextString('Max number of clients:', wifiConfig.accessPointConfig.max,     max,     getTextFilledValue(max,     valuetable), getTextColor(max,     badvalues)))
    connection:send(getInputTypeTextString('Beacon interval (ms):',  wifiConfig.accessPointConfig.beacon,  beacon,  getTextFilledValue(beacon,  valuetable), getTextColor(beacon,  badvalues)))
    connection:send('</table><br>\n')
    connection:send('Wifi Privacy:<br>\n')
    connection:send(getInputTypeRadioString("wifiConfig.accessPointConfig.hidden", "0",               getRadioChecked(hidden, 0),                "Visible"))
    connection:send(getInputTypeRadioString("wifiConfig.accessPointConfig.hidden", "1",               getRadioChecked(hidden, 1),                "Hidden"))
    connection:send('<br>\n')
    
end
