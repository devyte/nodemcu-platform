local httpservConfig = {}

-- Basic Authentication Conf
httpservConfig.auth = {}
httpservConfig.auth.enabled = true
httpservConfig.auth.realm = "ESP-"..node.chipid().." httpserver" -- displayed in the login dialog users get
httpservConfig.auth.user = "develo"
httpservConfig.auth.password = "theballismine" -- PLEASE change this

return httpservConfig
