# nodemcu-platform

A platform to serve as a base for nodemcu-firmware Lua applications.

Highlights:
-init.lua with minimal content (runs modules as opposed to executing code)
-automatic compile of all lua files on bootup, and removal afterwards (makes no sense to keep .lua files on the nodemcu fs)
-objectized wifi configuration (single wifiConfig object that holds all parameters)
-tcpserver: a multi-protocol TCP server that allows running multiple server modules (gets around the 1-TCP server limitation)
-General http server: based on Marcos Kirsch's implementation, but improved and rewritten as a module for the tcpserver
-lua server: aka telnet server in the nodemcu examples, but rewritten as a module for the tcpserver
-tftp UDP server: joint work with Rene van der Zee, allows easy upload of files over the network (as opposed to the serial port)
-webpage front-end: a wifi gui to configure all wifi parameters, a garage door opener app (original example by Marcos Kirsch), example webpages
