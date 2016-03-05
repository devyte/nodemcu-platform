return function (port, _servermodules)
    assert((not not wifi.sta.getip()) or (not not wifi.ap.getip()), "tcpserver: No viable IP found")
    assert(_servermodules ~= nil, "tcpserver: no server modules specified")
    local servermodules = _servermodules
    

    local function detector(conn, payload)
        local serverOnReceive = dofile("tcpserver-detector.lc")(servermodules, payload, conn)
        collectgarbage()
        if not serverOnReceive then
            --no server matched, so close
            print("tcpserver: unknown protocol")
            conn:close()
            return
        end
        --forward payload to server onReceive
        serverOnReceive(conn, payload)
    end


    local s = net.createServer(net.TCP, 180) -- 180 seconds client timeout
    s:listen(port, function(conn)
                       conn:on("receive", detector)
                   end)
    
    print("tcpserver running on port ".. port)

    local tcpserver = {}
    function tcpserver:close()
        servermodules = nil
        s:close()
        s = nil
        collectgarbage()
    end

    function tcpserver:getModules()
        return servermodules
    end

    function tcpserver:setModule(m, e)
        if servermodules[m] ~= nil then
            servermodules[m] = e
        end
    end

    return tcpserver
end
