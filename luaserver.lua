return function(connarg)
-- a simple telnet server

    local conn = connarg
    
    local function detect(payload)
        local b = string.sub(payload, 1, 1)
        return b == "\r" or b == "\n"
    end

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
        if conn ~= nil and fifo_drained then
            fifo_drained = false
            onSent(conn)
        end
    end

    local function onReceive(c, payload)
        node.input(payload)
    end

    local function onDisconnection(c)
        node.output(nil)        -- un-regist the redirect output function, output goes to serial
    end


    local function install(c)    
        node.output(s_output, 0)   -- re-direct output to function s_ouput.

        c:on("receive", onReceive)
        c:on("disconnection", onDisconnection)
        c:on("sent", onSent)

        print("Welcome to NodeMcu world.")
    end

    return detect, install, onReceive
end
