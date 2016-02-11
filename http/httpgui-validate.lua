return function(rd)
    local function validateRange(arg, min, max)
        return arg >= min and arg <= max
    end

    local function validateRealm(arg)
        return validateRange(#arg, 5, 64)
    end

    local function validateUser(arg)
        return validateRange(#arg, 5, 32)
    end

    local function validatePwd(arg)
        return validateRange(#arg, 8, 64)
    end
    
    local function validateBoolean(arg)
        if arg == "true" or arg == "false" then
            return true
        end
        return false
    end

    local validatetable = {
            ["httpservConfig.auth.enabled"] = validateBoolean,
            ["httpservConfig.auth.user"] = validateUser,
            ["httpservConfig.auth.password"] = validatePwd,
            ["httpservConfig.auth.realm"] = validateRealm,
    }
    
    local badvalues = {}
    for name, value in pairs(rd) do
        if validatetable[name] then
            if not validatetable[name](value) then
                badvalues[name] = value
            end
        end
    end

    return badvalues
end
