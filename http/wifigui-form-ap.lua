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

    local ftable = table.concat({
    '<h2>Access Point</h2>\n',
    '<table>\n',
    getInputTypeTextString('Wifi Name (SSID):     ', wifiConfig.accessPointConfig.ssid, ssid, getTextFilledValue(ssid, valuetable), getTextColor(ssid, badvalues)),
    getInputTypeTextString('Wifi Password: ', wifiConfig.accessPointConfig.pwd,  pwd,  getTextFilledValue(pwd,  valuetable), getTextColor(pwd,  badvalues)),
    '</table><br>\n',
    'Authorization type:<br>\n',
    getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.OPEN",         getRadioChecked(auth, wifi.OPEN),         "Open"),
    getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.WPA_PSK",      getRadioChecked(auth, wifi.WPA_PSK),      "WPA_PSK"),
    getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.WPA2_PSK",     getRadioChecked(auth, wifi.WPA2_PSK),     "WPA2_PSK"),
    getInputTypeRadioString("wifiConfig.accessPointConfig.auth", "wifi.WPA_WPA2_PSK", getRadioChecked(auth, wifi.WPA_WPA2_PSK), "WPA_WPA2_PSK"),
    '<table>\n',
    getInputTypeTextString('Wifi Channel:          ', wifiConfig.accessPointConfig.channel, channel, getTextFilledValue(channel, valuetable), getTextColor(channel, badvalues)),
    getInputTypeTextString('Max number of clients: ', wifiConfig.accessPointConfig.max,     max,     getTextFilledValue(max,     valuetable), getTextColor(max,     badvalues)),
    getInputTypeTextString('Beacon interval (ms):  ', wifiConfig.accessPointConfig.beacon,  beacon,  getTextFilledValue(beacon,  valuetable), getTextColor(beacon,  badvalues)),
    '</table><br>\n',
    'Wifi Privacy:<br>\n',
    getInputTypeRadioString("wifiConfig.accessPointConfig.hidden", "0",               getRadioChecked(hidden, 0),                "Visible"),
    getInputTypeRadioString("wifiConfig.accessPointConfig.hidden", "1",               getRadioChecked(hidden, 1),                "Hidden"),
    '<br>\r\n'
    })

    collectgarbage()
    connection:send(ftable)
end
