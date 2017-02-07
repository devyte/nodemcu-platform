-- httpserver-servefunction
-- Author: Daniel Salazar
-- Based on work by Marcos Kirsch


return function (connection, payload)
    local conf = dofile("confload.lc")("httpserver-conf.lc")
    local auth
    local user = "Anonymous"

    -- parse payload and decide what to serve.
    if conf.auth.enabled then
        auth = dofile("httpserver-basicauth.lc")
        user = auth.authenticate(payload, conf) -- authenticate returns nil on failed auth
    end

    local req = dofile("httpserver-request.lc")(payload)

    local serveFunction = nil
    local methodIsAllowed = {GET=true, POST=true, PUT=true}

    if user and req.methodIsValid and methodIsAllowed[req.method] and #(req.uri.file) <= 31 then
        print(req.method .. ": " .. req.request)
        local uri = req.uri

        local fileExists = file.exists(uri.file)
        if not fileExists then
            fileExists = file.exists(uri.file .. ".gz")
            if fileExists then
                uri.file = uri.file .. ".gz"
                uri.isGzipped = true
            end
        end

        if not fileExists then
            uri.args = {code = 404, errorString = "Not Found"}
            serveFunction = dofile("httpserver-error.lc")
        elseif uri.isScript then
            serveFunction = dofile(uri.file)
        else
            local allowStatic = {GET=true, HEAD=true, POST=false, PUT=false, DELETE=false, TRACE=false, OPTIONS=false, CONNECT=false, PATCH=false}
            if allowStatic[req.method] then
                uri.args = {file = uri.file, ext = uri.ext, gzipped = uri.isGzipped}
                serveFunction = dofile("httpserver-static.lc")
            else
                uri.args = {code = 405, errorString = "Method not supported"}
                serveFunction = dofile("httpserver-error.lc")
            end
        end
    else
        serveFunction = dofile("httpserver-error.lc")
        if not user then
            req.uri.args = {code = 401, errorString = "Not Authorized", headers = {auth.authErrorHeader(conf)}}
        elseif req.methodIsValid then
            req.uri.args = {code = 501, errorString = "Not Implemented"}
        else
            req.uri.args = {code = 400, errorString = "Bad Request"}
        end
    end
    return serveFunction, req
end
