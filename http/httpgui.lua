return function (connection, req, args)
    local httpservConfig = dofile("httpserver-conf.lc")
    collectgarbage()
    assert(httpservConfig ~= nil, "httpservConfig is nil")
 

    if req.method == "GET" then
        dofile("http/httpgui-form.lc")(req.method, connection, httpservConfig)
        collectgarbage()
    elseif req.method == "POST" then      
        local rd = req.getRequestData()
        local badvalues = dofile("http/httpgui-validate.lc")(rd)
        collectgarbage()
        
        if next(badvalues) == nil then
            if next(rd) ~= nil then
                -- at this point all values should be ok, so...
                -- fix strings
                dofile("http/httpgui-requote.lc")(rd)
                collectgarbage()
                --merge values into the httpservConfig
                tmr.wdclr()
                for name, value in pairs(rd) do
                    local f = loadstring("return function(httpservConfig) "..name.."="..value.." end")()
                    f(httpservConfig)
                    f = nil
                    collectgarbage()
                end
                --write out the config, compile, apply config
                dofile("httpserver-confwrite.lc")(httpservConfig, "httpserver-conf.lua")
                dofile("compile.lc")("httpserver-conf.lua")
                collectgarbage()
            end
            
            --serve the form again
            dofile("http/httpgui-form.lc")(req.method, connection, httpservConfig)
            collectgarbage()
        else
            dofile("http/httpgui-form.lc")(req.method, connection, httpservConfig, rd, badvalues)
        end
    else
        connection:send("NOT IMPLEMENTED")
    end
   
    collectgarbage()
end
