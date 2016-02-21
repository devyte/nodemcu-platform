--local function sendHeader(connection)
   --connection:send("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\nCache-Control: private, no-store\r\n\r\n")

--end

local function sendAttr(connection, attr, val)
   if val then
       connection:send("<tr><td><b>".. attr .. ":</b></td><td>" .. val .. "</td></tr>\n")
   end
end

return function (connection, req, args)
    collectgarbage()
    --sendHeader(connection)
    dofile("httpserver-header.lc")(connection, 200, "html")
    connection:send('<!DOCTYPE html><html lang="en"><head><meta charset="utf-8"><title>Node info</title></head><body><h1>Node info</h1><table>')
    local majorVer, minorVer, devVer, chipid, flashid, flashsize, flashmode, flashspeed = node.info();
    sendAttr(connection, "NodeMCU version"          , majorVer.."."..minorVer.."."..devVer)
    sendAttr(connection, "Chip id"                  , chipid)
    sendAttr(connection, "Flash id"                 , flashid)
    sendAttr(connection, "Flash size"               , flashsize)
    sendAttr(connection, "Flash mode"               , flashmode)
    sendAttr(connection, "Flash speed"              , flashspeed)
    sendAttr(connection, "Memory free (KB)"         , node.heap()/1024)
    sendAttr(connection, 'Memory in use (KB)'       , collectgarbage("count"))

    local r,u,t = file.fsinfo()
    sendAttr(connection, 'Flash fs total'           , t)
    sendAttr(connection, 'Flash fs used'            , u)
    sendAttr(connection, 'Flash fs remaining'       , r)

    local nfiles = 0
    for _ in pairs(file.list()) do nfiles = nfiles + 1 end
    sendAttr(connection, 'Number of files'          , nfiles)

    local wifimode2str = {[wifi.STATION]="STATION", [wifi.SOFTAP]="SOFTAP", [wifi.STATIONAP]="STATIONAP"}
    sendAttr(connection, 'Wifi operation mode'      , wifimode2str[wifi.getmode()])

    local ip, mask, gw = wifi.ap.getip()
    if ip then
        sendAttr(connection, 'Access Point IP'      , ip)
    end
    sendAttr(connection, 'Access Point MAC'         , wifi.ap.getmac())

    local status2str = {[0] = "IDLE", [1] = "CONNECTING", [2] = "WRONG_PASSWORD", [3] = "NO_AP_FOUND", [4] = "CONNECT_FAIL", [5] = "GOT_IP", [255] = "DISABLED"}
    sendAttr(connection, 'Station status'           , status2str[wifi.sta.status()])
    local ip, mask, gw = wifi.sta.getip()
    if ip then
        sendAttr(connection, 'Station IP'           , ip)
    end
    sendAttr(connection, 'Station MAC'              , wifi.sta.getmac())

    connection:send('</table></body></html>')
end
