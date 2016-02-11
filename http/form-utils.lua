local formutils = {}

function formutils.getRadioChecked(value, arg)
    if value == arg then
        return " checked"
    end
    return ""
end

function formutils.getTextFilledValue(key, valuetable)
    if valuetable == nil or valuetable[key] == nil then
        return ""
    end
    return ' value="'..valuetable[key]..'"'
end

function formutils.getRadioValue(key, valuetable)
    if valuetable == nil or valuetable[key] == nil then
        return nil
    end
    return loadstring("return "..valuetable[key])()
end

function formutils.getTextColor(key, badvalues)
    if badvalues == nil or badvalues[key] == nil then
        return ""
    end
    return ' style="color:#FF0000"'
end

function formutils.getInputTypeRadioString(name, value, checked, label )
    return table.concat({'<input type="radio" name="', name, '" value="', value, '"', checked, '>', label, '<br>\r\n'})
end

function formutils.getInputTypeTextString(label, labelvalue, name, value, color)
    return table.concat({'<tr>\n<td>', label, '</td><td>', labelvalue, '</td><td><input type="text" name="', name, '"', value, color, '></td>\n</tr>\n'})
end

return formutils
