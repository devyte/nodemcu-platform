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
    
    local ftable = table.concat({
    '<h2>Station</h2>\n',
    '<table>\n',
    getInputTypeTextString('Wifi Name (SSID): ', wifiConfig.stationPointConfig.ssid, ssid, getTextFilledValue(ssid,  valuetable), getTextColor(ssid,  badvalues)),
    getInputTypeTextString('Password:  ',        wifiConfig.stationPointConfig.pwd,  pwd,  getTextFilledValue(pwd,   valuetable), getTextColor(pwd,   badvalues)),
    '</table><br>\r\n',
    'Auto Connect:<br>\r\n',
    getInputTypeRadioString("wifiConfig.stationPointConfig.auto", "1", getRadioChecked(auto, 1), "Enabled"),
    getInputTypeRadioString("wifiConfig.stationPointConfig.auto", "0", getRadioChecked(auto, 0), "Disabled"),
    '<br>\n'
    })

    collectgarbage()
    connection:send(ftable)
end
