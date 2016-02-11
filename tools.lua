tools = {}

--wrapper to print ip info
function tools.printip()
    local ip, mask, gateway = wifi.sta.getip();
    if(ip) then
        print("ip="..ip.." mask="..mask.." gateway="..gateway);
    else
        print("no ip");
    end
end

--list visible wifi networks
function tools.listap() -- (SSID : Authmode, RSSI, BSSID, Channel)
    --callback for listap()
    local function listap_callback(ap_list)
        if(ap_list) then
            print("\n\t\t\tSSID\t\t\t\t\tBSSID\t\t\t  RSSI\t\tAUTHMODE\t\tCHANNEL")
            for bssid,v in pairs(ap_list) do
                local ssid, rssi, authmode, channel = string.match(v, "([^,]+),([^,]+),([^,]+),([^,]*)")
                print(string.format("%32s",ssid).."\t"..bssid.."\t  "..rssi.."\t\t"..authmode.."\t\t\t"..channel)
            end
        else
            print("no networks found");
        end
    end
    
    local wifistatus2str = {[0]="IDLE",[1]="CONNECTING",[2]="WRONG_PASSWORD",[3]="NO_AP_FOUND",[4]="CONNECT_FAIL",[5]="GOT_IP"}
    local wifimode = wifistatus2str[wifi.sta.status()];
    print("wifi status="..wifimode);
    wifi.sta.getap(1, listap_callback);
end


function tools.listGlobal(glob)
    for k,v in pairs(glob) do
        print("k="..tostring(k).." v="..tostring(v))
    end
end

function tools.listG()
    print("Globals:")
    tools.listGlobal(_G)
end


function tools.mv(regex, dest)
    if(regex == nil or dest == nil or dest == "") then
        return
    end

    --wrap to force consuming all
    local regex = "^("..regex..")$"
    local file_list = file.list()
    if dest == ".." then
        for k,v in pairs(file_list) do
            if(string.match(k, regex) ~= nil) then
                diridx = string.find(k, "/")
                if(diridx ~= nil) then
                    local destname = string.sub(k, diridx+1, -1)
                    if(file.open(destname) ~= nil) then
                        file.close(destname)
                        file.remove(destname)
                    end
                    local ret = file.rename(k, destname)
                    assert(ret, "Failed to rename "..k)
                end
            end
        end
     else 
        for k,v in pairs(file_list) do
            if(string.match(k, regex) ~= nil) then
                local destname = dest.."/"..k
                if(file.open(destname) ~= nil) then
                    file.close(destname)
                    file.remove(destname)
                end
                local ret = file.rename(k, destname)
                assert(ret, "Failed to rename "..k)
            end
        end
    end
end


function tools.mv2http()
     local filelist = {
          "args.*",
          "file_list.*",
          "node_info.*",
          "post.*",
          "index.html",
          "garage_door_opener.*",
          "underconstruction.gif",
          "zipped.html.gz",
          "apple.*png",
          "wifigui.*",
          "httpgui.*",
          "form.*"
          }

     for i,f in ipairs(filelist) do
          tools.mv(f, "http")
     end
end


--list files on flash
function tools.ll(regex)
     if(regex == nil) then
          regex = ".*"
     end
     --wrap to force consuming all
    local regex = "^("..regex..")$"

    local file_list = file.list()

    local sorted_file_list = {}
    for n,s in pairs(file_list) do
        if(string.match(n, regex) ~= nil) then
            table.insert(sorted_file_list, n) 
        end
    end
    table.sort(sorted_file_list)
    
    for i,n in ipairs(sorted_file_list) do 
        print(string.format("%-31s %7s", n, file_list[n]))
    end
end
    
function tools.more(fn)
    if file.open(fn, "r") == nil then
        print("Can't open file "..fn)
        file.close()
        return
    end

    local line = file.readline()
    while(line) do
        if line:sub(-1) == "\n" then
            print(line:sub(1,-2))
        else
            print(line)
        end
        line = file.readline()
    end
    file.close()
end

--gpio to pin number lut
--gpio2pin = {[0]=3,[1]=10,[2]=4,[3]=9,[4]=2,[5]=1,[10]=12,[12]=6,[13]=7,[14]=5,[15]=8,[16]=0}
--e.g.: pin = gpio2pin[2] -- map ESP8266 GPIO2 to NodeMCU pin 4
