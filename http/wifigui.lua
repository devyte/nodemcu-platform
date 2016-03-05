return function (connection, req, args)
--print("wifigui.lc heap="..node.heap())
    local wifiConfig = dofile("wifi-conf.lc")
    collectgarbage()
    assert(wifiConfig ~= nil, "wifiConfig is nil")
 

    if req.method == "GET" then
        dofile("http/wifigui-form.lc")(req.method, connection, wifiConfig)
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
                    local f = loadstring("return function(wifiConfig) "..name.."="..value.." end")()
                    f(wifiConfig)
                    f = nil
                    collectgarbage()
                end
                --write out the config, compile, apply config
                dofile("wifi-confwrite.lc")(wifiConfig, "wifi-conf.lua")
                dofile("compile.lc")("wifi-conf.lua")
                --serve the form again (has to be done before wigi.lc, or connection could be due to wifi reset
                dofile("http/wifigui-form.lc")(req.method, connection, wifiConfig)
                --wifi reset
                connection:close() --need to close connection 1st, or memleak, but no more sends after!
                dofile("wifi.lc")
                collectgarbage()
            else
                --serve the form again
                dofile("http/wifigui-form.lc")(req.method, connection, wifiConfig)
                collectgarbage()
            end
        else
            dofile("http/wifigui-form.lc")(req.method, connection, wifiConfig, rd, badvalues)
        end
    else
        connection:send("NOT IMPLEMENTED")
    end
   
    collectgarbage()
--print("wifigui.lc end heap="..node.heap())
end
