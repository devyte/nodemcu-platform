local sendformutils = {}

function sendformutils.getRadioChecked(value, arg)
    if value == arg then
        return " checked"
    end
    return ""
end

function sendformutils.getTextFilledValue(key, valuetable)
    if valuetable == nil or valuetable[key] == nil then
        return ""
    end
    return ' value="'..valuetable[key]..'"'
end

function sendformutils.getRadioValue(key, valuetable)
    if valuetable == nil or valuetable[key] == nil then
        return nil
    end
    return loadstring("return "..valuetable[key])()
end

function sendformutils.getTextColor(key, badvalues)
    if badvalues == nil or badvalues[key] == nil then
        return ""
    end
    return ' style="color:#FF0000"'
end

function sendformutils.getInputTypeRadioString(name, value, checked, label )
    return table.concat({'<input type="radio" name="', name, '" value="', value, '"', checked, '>', label, '<br>\r\n'})
end

function sendformutils.getInputTypeTextString(label, labelvalue, name, value, color)
    return table.concat({label, ' ', labelvalue, '<input type="text" name="', name, '"', value, color, '><br>\r\n'})
end

return sendformutils
