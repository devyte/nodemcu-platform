return function(port)
    if port == nil then 
        port = 69 --default
    end

    local _tblk=0 --block counter
    local _lock=nil --lock for operations
    local _fn={} --filename store between packets
    local _conn = nil -- connection store

    local _tmrid = 6
    local _retry = 5
    local _tmrtimeout = 1000

    local function reset()
        _tblk=0
        _lock = nil
        _fn = {}
        tmr.stop(_tmrid)
        _conn = nil
        _retry = 5
        collectgarbage()  --gc when finished
    end

    local function sendack(c,n)
        local msb = n/256 --assumes int firmware
        local lsb = n - msb*256
        c:send("\0\4"..string.char(msb, lsb))
    end

    local function sendblk(c)
        local msb = _tblk/256 --assumes int firmware
        local lsb = _tblk - msb*256
        local b=string.char(msb, lsb)

        if(file.open(_fn,"r")==nil) then
            c:send("\0\5\0\1\0") --Error: 1=file not found
            reset()
            return
        end
        local r = ""
        if(file.seek("set", (_tblk-1)*512)~=nil) then
            r = file.read(512)
        end
        file.close()
        if(r == nil) then
            r = ""
        end
        c:send("\0\3"..b..r)
        if(r:len() ~= 512) then
            _lock=4 -- done, wait for ack
        end
    end
    
    local function timeoutCB()
        tmr.stop(_tmrid)
        _retry=_retry-1
        if(_retry~=0) then
            uart.write(0,"*")
            if(_lock==2) then
                sendack(_conn, _tblk-1) --retransmit last ACK
            else -- _lock is 1 or 4
                sendblk(_conn)  --retransmit data
            end
            tmr.alarm(_tmrid, _tmrtimeout, 0, timeoutCB)
            return
        end
        print("Connection timed out")
        if(_lock == 2) then
            file.remove(_fn) --remove incomplete file
        end
        reset()
    end

    local function alarmstop()
        tmr.stop(_tmrid)
    end
    local function alarmstart()
        tmr.alarm(_tmrid, _tmrtimeout, 0, timeoutCB)
    end

    local s=net.createServer(net.UDP)
    s:on("receive", function(c,r) 
        local op=r:byte(2)

        if(op==1 or op==2) then
            if(_lock) then
                return
            end
            _conn=c
            _fn=string.match(r,"..(%Z+)")
            _lock=op
            _tblk=1
        elseif(op==3 or op==4) then
            local b=r:byte(3)*256+r:byte(4)
            if(b~=_tblk) then
                return
            end
            alarmstop()
            _retry=5
        end

        if(op==1) then
            --RRQ
            uart.write(0,"TFTP RRQ '".._fn.."': ")
            if(not file.exists(_fn)) then
                c:send("\0\5\0\1\0") --Error: 1=file not found
                reset()
                return
            end
            sendblk(c)
        elseif(op==2) then
            --WRQ
            uart.write(0,"TFTP WRQ '".._fn.."': ")
            -- overwrite file...
            if(file.open(_fn,"w")==nil) then
                c:send("\0\5\0\2\0") --Error: 2=access violation
                reset()
                return
            end
            file.close()
            sendack(c,0)
        elseif(op==3) then
            --DATA received for a WRQ
            if(_lock~=2) then
                return
            end
            local sz=r:len()-4
            if(file.open(_fn,"a")==nil) then
                c:send("\0\5\0\1\0") --Error: 1=file not found
                reset()
                return
            end
            if(file.write(r:sub(5))==nil) then
                c:send("\0\5\0\3\0") --Error: 3=no space left
                reset()
                return
            end
            sendack(c,_tblk)
            uart.write(0,"#")
            _tblk=_tblk+1
            if(sz~=512) then
                print(" done!")
                reset()
            end
        elseif(op==4) then
            --ACK received for a RRQ
            if(_lock~=1 and _lock~=4) then
                return
            end
            uart.write(0,"#")
            _tblk=_tblk+1
            if(_lock==1) then
                sendblk(c)
            else
                print(" done!")
                reset()
            end
        else
            --ERROR: 4=illegal op
            c:send("\0\5\0\4\0")
            return
        end
        if (_lock) then 
            alarmstart()
        end
    end)
    s:listen(port)
    print("TFTP server running on port "..tostring(port))
    return s
end
