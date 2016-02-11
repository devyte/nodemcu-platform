return function (utils, connection, httpservConfig, valuetable, badvalues)
    local getRadioChecked = utils.getRadioChecked
    local getTextFilledValue = utils.getTextFilledValue
    local getRadioValue = utils.getRadioValue
    local getTextColor = utils.getTextColor
    local getInputTypeTextString = utils.getInputTypeTextString
    local getInputTypeRadioString = utils.getInputTypeRadioString

    
    local enabled = getRadioValue("httpservConfig.auth.enabled", valuetable) or httpservConfig.auth.enabled
    local realm    = "httpservConfig.auth.realm"
    local user     = "httpservConfig.auth.user"
    local password = "httpservConfig.auth.password"
  
    connection:send('Authorization:<br>\n')
    connection:send(getInputTypeRadioString("httpservConfig.auth.enabled", "true",  getRadioChecked(enabled, true), "Enabled"))
    connection:send(getInputTypeRadioString("httpservConfig.auth.enabled", "false", getRadioChecked(enabled, false), "Disabled"))
    connection:send('<br><table>\n')
    connection:send(getInputTypeTextString('Realm (greeting):', httpservConfig.auth.realm,    realm,    getTextFilledValue(realm,    valuetable), getTextColor(realm, badvalues)))
    connection:send(getInputTypeTextString('User:'            , httpservConfig.auth.user,     user,     getTextFilledValue(user,     valuetable), getTextColor(user,  badvalues)))
    connection:send(getInputTypeTextString('Password:'        , httpservConfig.auth.password, password, getTextFilledValue(password, valuetable), getTextColor(password,  badvalues)))
    connection:send('</table><br>\n')

end
