--STEP1: print some info
print('chip: ',node.chipid())
print('heap: ',node.heap())

--STEP1: change hw settings
--gpio.mode(6, gpio.OUTPUT, gpio.PULLUP)
--gpio.mode(7, gpio.OUTPUT, gpio.PULLUP)
--gpio.mode(8, gpio.OUTPUT, gpio.PULLUP)

gpio.write(6, 0)
gpio.write(7, 0)
gpio.write(8, 0)

--STEP2: compile all .lua files to .lc files
local compilelua = "compile.lua"
if file.open(compilelua) ~= nil then
    file.close()
    dofile(compilelua)(compilelua)
end
compilelua = nil
dofile("compile.lc")()

--STEP3: handle wifi config
dofile("wifi.lc")

--STEP4: start the TCP server in port 80, if an ip is available
tcpsrv = dofile("tcpserver.lc")(80, {"httpserver", "luaserver"})

--STEP5: start the tftp server for easy file upload
--tftpsrv = dofile("tftpd.lc")(69)

--STEP6: load tools
dofile("tools.lc")

--STEP7: move files to subdirs
tools.mv2http()
tools = nil

collectgarbage()
print('heap after init: ',node.heap())
