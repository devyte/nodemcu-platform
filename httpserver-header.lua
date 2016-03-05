-- httpserver-header.lua
-- Part of nodemcu-httpserver, knows how to send an HTTP header.
-- Author: Marcos Kirsch

return function (connection, code, extension, gzip)

   local function getHTTPStatusString(code)
      local codez = {[200]="OK", [400]="Bad Request", [404]="Not Found",}
      local myResult = codez[code] --
      -- enforce returning valid http codes all the way throughout?
      if myResult then 
        return myResult
      end
      return "Not Implemented"
   end

   local function getMimeType(ext)
      -- A few MIME types. Keep list short. If you need something that is missing, let's add it.
    local mt = {css = "text/css", gif = "image/gif", html = "text/html", ico = "image/x-icon", jpeg = "image/jpeg", jpg = "image/jpeg", js = "application/javascript", json = "application/json", png = "image/png", xml = "text/xml"}
    local contentType = {}
    if mt[ext] then 
        return mt[ext] --
    end
      
    return "text/plain" 
   end

   local mimeType = getMimeType(extension)

   connection:send("HTTP/1.0 " .. code .. " " .. getHTTPStatusString(code) .. "\r\nServer: nodemcu-httpserver\r\nContent-Type: " .. mimeType .. "\r\n")
   if gzip then
       connection:send("Cache-Control: max-age=2592000\r\n")
       connection:send("Content-Encoding: gzip\r\n")
   end
   connection:send("Connection: close\r\n\r\n")
end

