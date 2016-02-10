return function (method, connection, wifiConfig, valuetable, badvalues)
    local util = dofile("http/wifigui-form-util.lc")

    connection:send('HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nCache-Control: private, no-store\r\n\r\n')
    connection:send('<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><title>Wifi Configuration</title></head>\n')
    connection:send('<body>')
    connection:send('<h1>Wifi Configuration</h1>\n')

    if badvalues and next(badvalues) ~= nil then
        connection:send('<h2 style="color:#FF0000">Invalid values submitted</h2>\r\n')
    end
    connection:send('<form method="POST">\r\n')

    collectgarbage()
    dofile("http/wifigui-form-gen.lc")(util, connection, wifiConfig, valuetable, badvalues)
    collectgarbage()
    dofile("http/wifigui-form-ap.lc") (util, connection, wifiConfig, valuetable, badvalues)
    collectgarbage()
    dofile("http/wifigui-form-apnet.lc") (util, connection, wifiConfig, valuetable, badvalues)
    collectgarbage()
    dofile("http/wifigui-form-sta.lc")(util, connection, wifiConfig, valuetable, badvalues)
    collectgarbage()
    dofile("http/wifigui-form-stanet.lc")(util, connection, wifiConfig, valuetable, badvalues)
    collectgarbage()

    connection:send('<input type="submit" value="Submit">\r\n<input type=reset>\r\n<button type="cancel" onclick="window.location=\'/\';return false;">Cancel</button>\r\n</form>\r\n</body></html>')
end
