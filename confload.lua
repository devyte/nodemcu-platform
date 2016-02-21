-- Author: Daniel Salazar
-- Reads and returns a something.lc conf file.
-- If default conf file doesn't exist (something-default.lc), it gets created by *makedefault.lc
-- If conf file doesn't exist (something.lc), it gets created from the default.
-- Requirements: the conf file must have 2 scripts implemented, which must 
-- follow a naming convention
-- somethingmakedefault.lc: script that generates and returns a default conf object
-- somethingwrite.lc: script that takes a conf obj and writes it to a *.lua file (uncompiled)
-- In addition, a compile.lc script must exist, which compiles the .lua conf to .lc.
-- Example:
-- wifiConf = dofile("wifi-conf.lc")
-- httpservConf = dofile("httpserver-conf.lc")

-- fnConf: conf file name, must be of form "something.lc"
-- return: a conf object
return function(fnConf)
    local dot = fnConf:find("%.")
    assert(dot ~= nil, "confload: conf file name doesn't have extension")
    local fnBody = fnConf:sub(1, dot-1)
    local fnExt = fnConf:sub(dot+1, -1)

    local conf
    
    --check if the default config file exists, if not create it
    if not file.exists(fnBody.."-default."..fnExt) then
        print(fnBody.."-default."..fnExt.." (default config) not found, creating...")
        conf = dofile(fnBody.."makedefault.lc")
        dofile(fnBody.."write.lc")(conf, fnBody.."-default.lua")
        dofile("compile.lc")(fnBody.."-default.lua")
    end
    
    --check if the user config file exists, if not save the default config to it
    if not file.exists(fnConf) then
        print(fnConf.." (user config) not found, creating from default...")
        conf = dofile(fnBody.."makedefault.lc")
        dofile(fnBody.."write.lc")(conf, fnBody..".lua")
        dofile("compile.lc")(fnBody..".lua")
    end
    
    conf = dofile(fnConf)
    return conf
end
