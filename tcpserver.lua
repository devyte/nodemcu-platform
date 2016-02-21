return function (port, _servermodules)
    assert((not not wifi.sta.getip()) or (not not wifi.ap.getip()), "tcpserver: No viable IP found")
    assert(_servermodules ~= nil, "tcpserver: no server modules specified")
    local servermodules
    
    --for i,s in ipairs(_servermodules) do
    --    servermodules[s] = true
    --end
    servermodules = _servermodules
    
    local function detector(conn, payload)
        for m,e in pairs(servermodules) do
            tmr.wdclr()
            --load the server module
            local modfname = m..".lc"
            if file.exists(modfname) then

                local server = dofile(modfname)(conn)
            
                if server and server.detect and server.install and server.onReceive then
                    if server.detect(payload) then
                        print("tcpserver -> "..m)
                        server.install(conn)
                        server.onReceive(conn, payload) --forward current payload to detected server
                        collectgarbage()
                        return
                    end

                    --unload the server module
                    server = nil
                    collectgarbage()
                else
                    print(m.." does not seem to be a server module")
                end
            else
                print(m.." module file was not found")
            end
        end

        --no server matched, so close
        print("tcpserver: unknown protocol")
        conn:close()    
    end

    local function tcpserverListen(conn)
        assert(conn ~= nil, "tcpserverInstall: nil conn") 
        conn:on("receive", detector)
    end    

    local s = net.createServer(net.TCP, 180) -- 180 seconds client timeout
    s:listen(port, tcpserverListen)
    
    -- false and nil evaluate as false
    local ip = wifi.sta.getip()
    if not ip then 
        ip = wifi.ap.getip() 
    end
    print(ip)
    print("tcpserver running on port ".. port)

    local tcpserver = {}
    function tcpserver:close()
        s:close()
    end

--[[--  
    function tcpserver:addModule(serverodule)
        assert(servermodule, "servermodule is nil")
        if file.open(servermodule..".lc") then
            file.close()
            table.insert(servermodules, servermodule)
        else
            print("Server module "..servermodule.." not found")
        end
    end
    
    function tcpserver:removeModule(servermodule)
        table.remove()
    end
    function tcpserver:getModules()
        return servermodules
    end
--]]--  
    return tcpserver
end
