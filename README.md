# nodemcu-platform

A platform to serve as a base for nodemcu-firmware Lua applications.

## Highlights:

### init.lua
Minimal content (runs modules as opposed to executing code)

### Automatic compile on bootup
On bootup all .lua files are compiled and then removed, leaving only the .lc files (makes no sense to keep .lua files on the nodemcu fs)

### Objectized wifi configuration
All wifi parameters are placed in a single struct-like object, which also serves as a configuration file

### tcpserver
A multi-protocol TCP server that allows running multiple server modules (gets around the 1-TCP server limitation).

### httpserver module
Based on Marcos Kirsch's implementation, but improved and rewritten as a module for the tcpserver. Includes a few fixes missing from his  code.

### luaserver module
Aka telnet server in the nodemcu examples, but rewritten as a module for the tcpserver. Allows access to the Lua interpreter over the network. Can work at the same time as the httserver module.

### tftpserver (UDP)
Allows easy upload of files over the network (as opposed to the serial port). Joint work with Rene van der Zee.

### Webpage front-end
A wifi gui to configure all wifi parameters, a garage door opener app (original example by Marcos Kirsch), other example webpages.
