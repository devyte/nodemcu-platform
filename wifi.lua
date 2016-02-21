-- Begin WiFi configuration

--check if default config file exists, if not create it (should only happen the 1st time run after a format)
local wifiConfig = dofile("confload.lc")("wifi-conf.lc")



wifi.setphymode = wifiConfig.phymode

-- Tell the chip to connect to the access point
wifi.setmode(wifiConfig.mode)
local wifimode2str = {[wifi.STATION]="wifi.STATION", [wifi.SOFTAP]="wifi.SOFTAP", [wifi.STATIONAP]="wifi.STATIONAP"}
print('wifi mode set to '..wifimode2str[wifi.getmode()])
wifimode2str = nil

if (wifiConfig.mode == wifi.SOFTAP) or (wifiConfig.mode == wifi.STATIONAP) then
    --accesspoint config
    wifi.ap.setmac(wifiConfig.accessPointIpConfig.mac)
    wifi.ap.config(wifiConfig.accessPointConfig)
    wifi.ap.setip(wifiConfig.accessPointIpConfig)
end
if (wifiConfig.mode == wifi.STATION) or (wifiConfig.mode == wifi.STATIONAP) then
    --stationpoint config
    wifi.sta.setmac(wifiConfig.stationPointIpConfig.mac)
    wifi.sta.config(wifiConfig.stationPointConfig.ssid, wifiConfig.stationPointConfig.pwd, wifiConfig.stationPointConfig.auto)
    --wifi.sta.setip(wifiConfig.stationPointIpConfig)
    wifi.sta.sethostname(wifiConfig.stationPointConfig.hostname)
end

wifiConfig = nil
collectgarbage()

-- End WiFi configuration



-- Connect to the WiFi access point.
-- Once the device is connected, you may start the HTTP server.

if (wifi.getmode() == wifi.STATION) or (wifi.getmode() == wifi.STATIONAP) then
    local joinCounter = 0
    local joinMaxAttempts = 5
    tmr.alarm(0, 3000, 1, function()
       local ip = wifi.sta.getip()
       if ip == nil and joinCounter < joinMaxAttempts then
          print('Connecting to WiFi Access Point ...')
          joinCounter = joinCounter +1
       else
          if joinCounter == joinMaxAttempts then
             print('Failed to connect to WiFi Access Point.')
          else
             print('IP: ',ip)
          end
          tmr.stop(0)
          joinCounter = nil
          joinMaxAttempts = nil
          collectgarbage()
       end
    end)
end
