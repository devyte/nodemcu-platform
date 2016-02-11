return function (method, connection, wifiConfig, valuetable, badvalues)
    local utils = dofile("http/form-utils.lc")

    connection:send('HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nCache-Control: private, no-store\r\n\r\n')
    connection:send('<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><title>Web Server Configuration</title></head>\n')
    connection:send('<body>')
    connection:send('<h1>Web Server Configuration</h1>\n')

    if badvalues and next(badvalues) ~= nil then
        connection:send('<h2 style="color:#FF0000">Invalid values submitted</h2>\r\n')
    end
    connection:send('<form method="POST">\r\n')

    collectgarbage()
    dofile("http/httpgui-form-gen.lc")(utils, connection, wifiConfig, valuetable, badvalues)
    collectgarbage()

    connection:send('<input type="submit" value="Submit" title="Apply values">\r\n<input type=reset title="Reset all fields">\r\n<button type="cancel" title="Cancel and go back to main webpage" onclick="window.location=\'/\';return false;">Cancel</button>\r\n</form>\r\n</body></html>')
end
