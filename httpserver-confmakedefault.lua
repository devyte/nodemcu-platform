local conf = {}

-- Basic Authentication Conf
conf.auth = {}
conf.auth.enabled = true
conf.auth.realm = "ESP-"..node.chipid().." httpserver" -- displayed in the login dialog users get
conf.auth.user = "develo"
conf.auth.password = "lapelotaesmia" -- PLEASE change this

return conf
