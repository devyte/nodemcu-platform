return function(port)

    local httpsrv = net.createServer(net.TCP, 180)
    httpsrv:listen(port, function(socket)

    fullPayload = nil
    bBodyMossing = nil

    local function onReceive(connection, payload)
        collectgarbage()
--print("httpserver: onReceive() heap="..node.heap())
        payload, fullPayload, bBodyMissing = dofile("httpserver-payload.lc")(payload, fullPayload, bBodyMissing)
        collectgarbage()
        if bBodyMissing then
--print("onReceive(): incomplete payload, will concat")
            return
        end

        local serveFunction, req = dofile("httpserver-servefunction.lc")(connection, payload)
        payload = nil
        collectgarbage()

--print("startServing() heap="..node.heap())
        local tbconn = dofile("tbconnection.lc")(connection)
        tbconn:run(serveFunction, req, req.uri.args)
        tbconn = nil
--print("startServing() end  heap="..node.heap())

        serveFunction = nil
        req = nil
        collectgarbage()
--print("httpserver: onReceive() end  heap="..node.heap())
    end




    end)

    print("httpserver running on port "..port)
    return httpsrv
end
