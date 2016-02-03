return function (connection, req, args)
    local wifiConfig = dofile("wifi-conf.lc")
    collectgarbage()
    assert(wifiConfig ~= nil, "wifiConfig is nil")
 

    if req.method == "GET" then
        dofile("http/wifigui-sendform.lc")(req.method, connection, wifiConfig)
        collectgarbage()
    elseif req.method == "POST" then      
        local rd = req.getRequestData()
        local badvalues = dofile("http/wifigui-validate.lc")(rd)
        collectgarbage()
        
        if next(badvalues) == nil then
            if next(rd) ~= nil then
                -- at this point all values should be ok, so...
                -- fix strings
                dofile("http/wifigui-requote.lc")(rd)
                collectgarbage()
                --merge values into the wifiConfig
                tmr.wdclr()
                for name, value in pairs(rd) do
                    local str = "return function(wifiConfig) "..name.."="..value.." end"
                    local f = loadstring(str)()
                    assert(f, "f is nil")
                    f(wifiConfig)
                    str = nil
                    f = nil
                    collectgarbage()
                end
                --write out the config & compile
                dofile("wifi-confwrite.lc")(wifiConfig, "wifi-conf-tmp.lua")
                collectgarbage()
                dofile("compile.lc")("wifi-conf-tmp.lua")
                if file.open("wifi-conf.lc") then
                    --file existed, so play it safe
                    file.close()
                    file.remove("wifi-conf.lc.bak")
                    if not file.rename("wifi-conf.lc", "wifi-conf.lc.bak") then
                        print("wifigui error: can't backup wifi-conf.lc")
                        connection:send("wifigui error: can't backup wifi-conf.lc")
                        collectgarbage()
                        return
                    end
                    if not file.rename("wifi-conf-tmp.lc", "wifi-conf.lc") then
                        print("wifigui error: can't save config to wifi-conf.lc")
                        connection:send("wifigui error: can't save config to wifi-conf.lc")
                        collectgarbage()
                        return
                    end
                    file.remove("wifi-conf.lc.bak")
                else
                    --new config, shouldn't happen, but...
                    if not file.rename("wifi-conf-tmp.lc","wifi-conf.lc") then
                        print("wifigui error: can't save config to wifi-conf.lc")
                        connection:send("wifigui error: can't save config to wifi-conf.lc")
                        collectgarbage()
                        return                    
                    end
                end
                dofile("wifi.lc")
                collectgarbage()
            end
            
            --serve the form aain
            dofile("http/wifigui-sendform.lc")(req.method, connection, wifiConfig)
            collectgarbage()
        else
            dofile("http/wifigui-sendform.lc")(req.method, connection, wifiConfig, rd, badvalues)
        end
    else
        connection:send("NOT IMPLEMENTED")
    end
   
    collectgarbage()
end
