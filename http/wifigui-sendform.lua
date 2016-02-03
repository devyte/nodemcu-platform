return function (method, connection, wifiConfig, valuetable, badvalues)
    local util = dofile("http/wifigui-sendform-util.lc")
    
    connection:send(table.concat({
            'HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nCache-Control: private, no-store\r\n\r\n',
            '<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><title>Wifi Configuration</title></head>\r\n',
            '<body>',
            '<h1>Wifi Configuration</h1>\r\n'
            }))
    
    if badvalues and next(badvalues) ~= nil then
        connection:send('<h2 style="color:#FF0000">Invalid values submitted</h2>')
    end
    connection:send('<form method="POST">\r\n')

    dofile("http/wifigui-sendform-gen.lc")(util, connection, wifiConfig, valuetable, badvalues)
    collectgarbage()
    dofile("http/wifigui-sendform-ap.lc") (util, connection, wifiConfig, valuetable, badvalues)
    collectgarbage()
    dofile("http/wifigui-sendform-sta.lc")(util, connection, wifiConfig, valuetable, badvalues)
    collectgarbage()

    connection:send('<input type="submit" value="Submit">\r\n<input type=reset>\r\n<button type="cancel" onclick="window.location=\'/\';return false;">Cancel</button>\r\n</form>\r\n</body></html>')
end
