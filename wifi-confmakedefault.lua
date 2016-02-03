local wifiConfig = {}

-- wifi.STATION    -- station: join a WiFi network
-- wifi.SOFTAP     -- access point: create a WiFi network
-- wifi.STATIONAP  -- both station and access point
wifiConfig.mode = wifi.STATIONAP
wifiConfig.phymode = wifi.PHYMODE_N

wifiConfig.accessPointConfig = {}
wifiConfig.accessPointConfig.ssid = "ESP-"..node.chipid()   -- Name of the SSID you want to create
wifiConfig.accessPointConfig.pwd = "theballismine"    -- WiFi password - at least 8 characters
wifiConfig.accessPointConfig.auth = wifi.WPA2_PSK --OPEN/WPA_PSK/WPA2_PSK/WPA_WPA2_PSK
wifiConfig.accessPointConfig.channel = 6 -- 1-14
wifiConfig.accessPointConfig.hidden = 0
wifiConfig.accessPointConfig.max = 4 -- max clients: 1-4
wifiConfig.accessPointConfig.beacon = 100 -- beacon interval 100-60000

wifiConfig.accessPointIpConfig = {}
wifiConfig.accessPointIpConfig.ip = "192.168.111.1"
wifiConfig.accessPointIpConfig.netmask = "255.255.255.0"
wifiConfig.accessPointIpConfig.gateway = "192.168.111.1"
wifiConfig.accessPointIpConfig.mac = wifi.ap.getmac() -------------------- wifi.ap.setmac()

wifiConfig.accessPointDHCPConfig = {}
wifiConfig.accessPointDHCPConfig.enabled = 1 -------------------------wifi.ap.dhcp.start()/stop()
wifiConfig.accessPointDHCPConfig.start = "192.168.111.100"

wifiConfig.stationPointConfig = {}
wifiConfig.stationPointConfig.ssid = "devnet"        -- Name of the WiFi network you want to join
wifiConfig.stationPointConfig.pwd =  "theballismine"                -- Password for the WiFi network
wifiConfig.stationPointConfig.auto = 1
wifiConfig.stationPointConfig.hostname = "ESP-"..node.chipid()

wifiConfig.stationPointIpConfig = {}
wifiConfig.stationPointIpConfig.ip = "0.0.0.0"
wifiConfig.stationPointIpConfig.netmask = "0.0.0.0"
wifiConfig.stationPointIpConfig.gateway = "0.0.0.0"
wifiConfig.stationPointIpConfig.mac = wifi.sta.getmac()

return wifiConfig
