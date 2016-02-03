--STEP0: print some info
print('chip: ',node.chipid())
print('heap: ',node.heap())

--STEP1: init hw settings
--gpio.mode(6, gpio.OUTPUT, gpio.PULLUP)
--gpio.mode(7, gpio.OUTPUT, gpio.PULLUP)
--gpio.mode(8, gpio.OUTPUT, gpio.PULLUP)
--gpio.write(6, 0)
--gpio.write(7, 0)
--gpio.write(8, 0)

--STEP2: compile all .lua files to .lc files
local compilelua = "compile.lua"
if file.open(compilelua) ~= nil then
    file.close()
    dofile(compilelua)(compilelua)
end
compilelua = nil
dofile("compile.lc")()

--STEP3: load tools
dofile("tools.lc")

--STEP4: move files to subdirs and unload tools
tools.mv2http()
tools = nil

--STEP5: handle wifi config
dofile("wifi.lc")

--STEP6: start the TCP server in port 80, if an ip is available
tcpsrv = dofile("tcpserver.lc")(80, {"httpserver", "luaserver"})

--STEP7: start the tftp server for easy file upload
tftpsrv = dofile("tftpd.lc")(69)

collectgarbage()
print('heap after init: ', node.heap())
