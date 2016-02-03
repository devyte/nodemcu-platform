return function (port, _servermodules)
    assert((not not wifi.sta.getip()) or (not not wifi.ap.getip()), "tcpserver: No viable IP found")
    assert(_servermodules ~= nil, "tcpserver: no server modules specified")
    
    local servermodules = _servermodules
    
    local function detector(conn, payload)
       
         for i,m in ipairs(servermodules) do
            tmr.wdclr()
            --load the server module
            local servermodule = dofile(m..".lc")
            local detect = {}
            local install = {}
            local onReceive = {}
            detect, install, onReceive = servermodule(conn)
            
            assert(detect~=nil, m.." detect() is missing")
            assert(install~=nil, m.." install() is missing")
            assert(onReceive~=nil, m.." onReceive() is missing")
            
            if detect(payload) then
                print("tcpserver -> "..m)
                detect = nil
                install(conn)
                onReceive(conn, payload) --forward current payload to detected server
                collectgarbage()
                return
            end
            
            --unload the server module
            detect = nil
            install = nil
            onReceive =  nil
            servermodule = nil
            collectgarbage()
        end
        
        --no server matched, so close
        print("tcpserver: unknown protocol")
        conn:close()    
    end


    local function tcpserver(conn)
        assert(conn ~= nil, "tcpserverInstall: nil conn") 
        conn:on("receive", detector)
    end    


    local s = net.createServer(net.TCP, 180) -- 180 seconds client timeout
    s:listen(port, tcpserver)
    
    -- false and nil evaluate as false
    local ip = wifi.sta.getip()
    if not ip then 
        ip = wifi.ap.getip() 
    end
    print(ip)
    print("tcpserver running on port ".. port)
    return s
end
