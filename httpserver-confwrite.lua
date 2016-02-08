return function(httpservConfig,httpserverconflua)
    assert(httpservConfig ~= nil, "conf can't be nil")
    assert(httpserverconflua ~= nil, "conflua output filename can't be nil")
    
    local httpserverconfluatmp = httpserverconflua..".tmp"
    file.remove(httpserverconfluatmp)
    file.open(httpserverconfluatmp, "w")
    local w = file.writeline

    w('local httpservConfig = {}')
    w('')
    w('httpservConfig.auth = {}')
    w('httpservConfig.auth.enabled = '..tostring(httpservConfig.auth.enabled))
    w('httpservConfig.auth.realm = "'..httpservConfig.auth.realm..'"')
    w('httpservConfig.auth.user = "'..httpservConfig.auth.user..'"')
    w('httpservConfig.auth.password = "'..httpservConfig.auth.password..'"')
    w('')
    w('return httpservConfig')
    file.close()

    --play it safe: backup the curr config
    local httpserverconfluabak =  httpserverconflua..".bak" 
    file.remove(httpserverconfluabak)
    file.rename(httpserverconflua, httpserverconfluabak)

    --rename the new config stored in the tmp file to the user config
    local ret = true
    if not file.rename(httpserverconfluatmp, httpserverconflua) then
        -- failed, so restore backup, cleanup and bail out
        file.rename(httpserverconfluabak, httpserverconflua)
        file.remove(httpserverconfluatmp)
        print("httpserver-confwrite error: Unable to save to file "..httpserverconflua)
        ret = false
    else
        --save went ok, so remove backup
        file.remove(httpserverconfluabak)
    end
    
    collectgarbage()
    return ret
end
