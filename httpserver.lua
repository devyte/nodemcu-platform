-- httpserver
-- Author: Daniel Salazar
-- Based on work by Marcos Kirsch

local function detect(payload)
    local sm, em, method, request, trailer = payload:find("^([A-Z]+) (.-) (HTTP/[1-9]+.[0-9]+)")
    local ret = (method ~= nil) and (request ~= nil) and (trailer ~= nil)
    return ret
end

return function (conn)

    local fullPayload = nil
    local bBodyMissing = nil


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


    local function install(connection)
        connection:on("receive", onReceive)
    end

    return {detect = detect, install = install, onReceive = onReceive}
end
