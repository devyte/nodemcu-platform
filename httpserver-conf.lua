-- httpserver-conf.lua
-- Part of nodemcu-httpserver, contains static configuration for httpserver.
-- Author: Sam Dieck

local conf = {}

-- Basic Authentication Conf
conf.auth = {}
conf.auth.enabled = true
conf.auth.realm = "nodemcu-httpserver" -- displayed in the login dialog users get
conf.auth.user = "develo"
conf.auth.password = "lapelotaesmia" -- PLEASE change this

return conf
