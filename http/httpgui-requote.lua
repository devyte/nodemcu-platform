return function(rd)
    local quotetable = {
            ["httpservConfig.auth.user"] = true,
            ["httpservConfig.auth.password"] = true,
            ["httpservConfig.auth.realm"] = true,
    }

    for name,value in pairs(rd) do
        if quotetable[name] then
            rd[name] = "\""..value.."\""
        end
    end
end
