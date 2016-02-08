return function (util, connection, wifiConfig, valuetable, badvalues)
    local getRadioChecked = util.getRadioChecked
    local getRadioValue = util.getRadioValue
    local getInputTypeRadioString = util.getInputTypeRadioString

    local mode = getRadioValue("wifiConfig.mode", valuetable) or wifiConfig.mode
    local phymode = getRadioValue("wifiConfig.phymode", valuetable) or wifiConfig.phymode
    
    local ftable = table.concat({'<h2>General</h2>\r\n',
    'Operation Mode:<br>\r\n',
    getInputTypeRadioString("wifiConfig.mode", "wifi.STATIONAP", getRadioChecked(mode, wifi.STATIONAP), "Station and Access Point"),
    getInputTypeRadioString("wifiConfig.mode", "wifi.STATION",   getRadioChecked(mode, wifi.STATION),   "Station only"),
    getInputTypeRadioString("wifiConfig.mode", "wifi.SOFTAP",    getRadioChecked(mode, wifi.SOFTAP),    "Access Point only"),
    '<br>\r\n',
    'Radio Mode:<br>\r\n',
    getInputTypeRadioString("wifiConfig.phymode", "wifi.PHYMODE_N", getRadioChecked(phymode, wifi.PHYMODE_N), "802.11n"),
    getInputTypeRadioString("wifiConfig.phymode", "wifi.PHYMODE_G", getRadioChecked(phymode, wifi.PHYMODE_G), "802.11g"),
    getInputTypeRadioString("wifiConfig.phymode", "wifi.PHYMODE_B", getRadioChecked(phymode, wifi.PHYMODE_B), "802.11b"),
    '<br>\r\n'})

    collectgarbage()
    connection:send(ftable)
end
