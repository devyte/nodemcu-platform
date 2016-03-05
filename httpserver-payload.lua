return function(payload, fullPayload, bBodyMissing)
-- collect data packets until the size of http body meets the Content-Length stated in header
   
    if payload:find("Content%-Length:") or bBodyMissing then
        if fullPayload then 
            fullPayload = fullPayload .. payload 
        else
            fullPayload = payload 
        end
        if (tonumber(string.match(fullPayload, "%d+", fullPayload:find("Content%-Length:")+16)) > #fullPayload:sub(fullPayload:find("\r\n\r\n", 1, true)+4, #fullPayload)) then
            bBodyMissing = true
        else
            --print("HTTP packet assembled! size: "..#tmp_payload)
            payload = fullPayload
            fullPayload, bBodyMissing = nil
        end
    end
    return payload, fullPayload, bBodyMissing
end
