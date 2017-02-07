-- httpserver-error.lua
-- Part of nodemcu-httpserver, handles sending error pages to client.
-- Author: Marcos Kirsch

return function (connection, req, args)

   local function sendHeader(conn, code, errorString, extraHeaders, mimeType)
      conn:send("HTTP/1.0 " .. code .. " " .. errorString .. "\r\nServer: nodemcu-httpserver\r\nContent-Type: " .. mimeType .. "\r\n")
      for i, header in ipairs(extraHeaders) do
         conn:send(header .. "\r\n")
      end 
      conn:send("connection: close\r\n\r\n")
   end

   print("Error " .. args.code .. ": " .. args.errorString)
   args.headers = args.headers or {}
   sendHeader(connection, args.code, args.errorString, args.headers, "text/html")
   connection:send("<html><head><title>" .. args.code .. " - " .. args.errorString .. "</title></head><body><h1>" .. args.code .. " - " .. args.errorString .. "</h1></body></html>\r\n")
end
