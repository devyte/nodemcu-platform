return function(port)
    assert((not not wifi.sta.getip()) or (not not wifi.ap.getip()), "tcpserver: No viable IP found")
--FIXME: should also assert 0 < port <= 65K

    local luasrv = net.createServer(net.TCP, 180)
    luasrv:listen(port, function(socket)
        local fifo = {}
        local fifo_drained = true

        local function onSent(c)
            if #fifo > 0 then
                c:send(table.remove(fifo, 1))
            else
                fifo_drained = true
            end
        end

        local function s_output(str)
            table.insert(fifo, str)
            if socket ~= nil and fifo_drained then
                fifo_drained = false
                onSent(socket)
            end
        end

        local function onReceive(c, payload)
        uart.write(0, payload..'\n')
            node.input(payload)
        end

        local function onDisconnect(c)
            node.output(nil)
        end

        node.output(s_output, 0)

        socket:on("receive", onReceive)
        socket:on("disconnection", onDisconnect)
        socket:on("sent", onSent)

        print("Welcome to NodeMCU world.")
    end)

    print("luaserver running on port "..port)
    return luasrv
end

