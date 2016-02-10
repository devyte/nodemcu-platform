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

    connection:send('<h2>Station</h2>\n')
    connection:send('<table>\n')
    connection:send(getInputTypeTextString('Wifi Name (SSID):', wifiConfig.stationPointConfig.ssid, ssid, getTextFilledValue(ssid,  valuetable), getTextColor(ssid,  badvalues)))
    connection:send(getInputTypeTextString('Password:',         wifiConfig.stationPointConfig.pwd,  pwd,  getTextFilledValue(pwd,   valuetable), getTextColor(pwd,   badvalues)))
    connection:send('</table><br>\n')
    connection:send('Auto Connect:<br>\n')
    connection:send(getInputTypeRadioString("wifiConfig.stationPointConfig.auto", "1", getRadioChecked(auto, 1), "Enabled"))
    connection:send(getInputTypeRadioString("wifiConfig.stationPointConfig.auto", "0", getRadioChecked(auto, 0), "Disabled"))
    connection:send('<br>\n')
end
