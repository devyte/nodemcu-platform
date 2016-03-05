return function(servermodules, payload, conn)
    for m,e in pairs(servermodules) do
        if e then --if enabled
            --load the server module
            local modfname = m..".lc"
            if file.exists(modfname) then
                local server = dofile(modfname)(conn)
                if server and server.detect and server.install and server.onReceive then
                    if server.detect(payload) then
                        print("tcpserver -> "..m)
                        server.install(conn)
    --                        server.onReceive(conn, payload) --forward current payload to detected server
                        collectgarbage()
                        return server.onReceive --return onReceive callback upwards
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
    end
    --no module detected
    return nil
end
