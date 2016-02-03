-- httpserver-conf.lua
-- Part of nodemcu-httpserver, contains static configuration for httpserver.
-- Author: Sam Dieck

local conf = {}

-- Basic Authentication Conf
local auth = {}
auth.enabled = true
auth.realm = "nodemcu-httpserver" -- displayed in the login dialog users get
auth.user = "develo"
auth.password = "lapelotaesmia" -- PLEASE change this
conf.auth = auth

return conf
