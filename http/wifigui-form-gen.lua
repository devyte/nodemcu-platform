return function (util, connection, wifiConfig, valuetable, badvalues)
    local getRadioChecked = util.getRadioChecked
    local getRadioValue = util.getRadioValue
    local getInputTypeRadioString = util.getInputTypeRadioString

    local mode = getRadioValue("wifiConfig.mode", valuetable) or wifiConfig.mode
    local phymode = getRadioValue("wifiConfig.phymode", valuetable) or wifiConfig.phymode

    connection:send('<h2>General</h2>\n')
    connection:send('Operation Mode:<br>\n')
    connection:send(getInputTypeRadioString("wifiConfig.mode", "wifi.STATIONAP", getRadioChecked(mode, wifi.STATIONAP), "Station and Access Point"))
    connection:send(getInputTypeRadioString("wifiConfig.mode", "wifi.STATION",   getRadioChecked(mode, wifi.STATION),   "Station only"))
    connection:send(getInputTypeRadioString("wifiConfig.mode", "wifi.SOFTAP",    getRadioChecked(mode, wifi.SOFTAP),    "Access Point only"))
    connection:send('<br>\n')
    connection:send('Radio Mode:<br>\n')
    connection:send(getInputTypeRadioString("wifiConfig.phymode", "wifi.PHYMODE_N", getRadioChecked(phymode, wifi.PHYMODE_N), "802.11n"))
    connection:send(getInputTypeRadioString("wifiConfig.phymode", "wifi.PHYMODE_G", getRadioChecked(phymode, wifi.PHYMODE_G), "802.11g"))
    connection:send(getInputTypeRadioString("wifiConfig.phymode", "wifi.PHYMODE_B", getRadioChecked(phymode, wifi.PHYMODE_B), "802.11b"))
    connection:send('<br>\n')

end
