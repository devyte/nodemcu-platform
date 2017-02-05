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

  - A wifi GUI to configure all wifi parameters.
  - A garage door opener app (original example by Marcos Kirsch).
  - Other example webpages.

## Installation
  1. [Flash nodemcu firmware](https://nodemcu.readthedocs.io/en/dev/en/flash/)
  2. Clear the filesystem: `file.format()`
  3. Upload all files in this repo (except maybe the README) using ESPlorer or similar, including those in the `http` directory (don't worry about the dir name, the `init.lua` triggers these files to be renamed to `http/*` on the flash)
  4. Reboot nodemcu
  5. Connect to ESP-someid wifi hotspot and visit <http://192.168.4.1>
  6. Follow Wifi Configuration, edit wifi parameters to your liking, Submit

### Default credentials and where to change them

Out of the box, the platform sets up the following resources and credentials that you will likely want to change after you try out a test run:

#### A WiFi access point – `wifi-confmakedefault.lua`

  - SSID: `ESP-<chip ID>`
  - Password: `theballismine`
  - Gateway IP: 192.168.4.1

#### WiFi station joining – `wifi-confmakedefault.lua`

Joining an existing WiFi network. This can be changed from the web UI, but you likely want a default for your project development.

  - SSID: `devnet`
  - Password: `theballismine`

#### Web UI for WiFi configuration – `httpserver-confmakedefault.lua`

  - <http://192.168.4.1>
  - Basic Auth username: `develo`
  - Basic Auth password: `theballismine`

#### luaserver, the NodeMCU Lua REPL over telnet

    $ telnet 192.168.4.1 80

Send a carriage return or line feed as the first input after connecting. The `tcpserver` interprets this as a request for the `luaserver` instead of the `httpserver`. You should see a welcome message and prompt.

## Application development guidelines
The idea behind this platform is to allow focus on the development of your own application, and reduce your worrying about things like wifi setup, compiling lua, or remote communication.
Some comments and guidelines:
  1. The nodemcu SPIFFS file system doesn't support subdirs. However, filenames can have "/" in them, which means you can achieve similar functionality. 
  2. Keep the "root" directory clear of application-specific files. The idea is to put all platform files in the root, and all application files under http or similar. This is why the http subdir exists in the repo: files like index.html and wifigui.lc are under http.
  3. The total filename length, including "dirs" and "/" is 31 bytes long. Be very careful with this, at the time of this writing there seems to be some bug that allows 32 bytes, but such a filename corrupts the file system, and you can't delete such files anymore. That means file.format() all over again.
  4. Remember that the fs is the free space of the on-board flash. Try not to trash it by writing files over and over again, that just reduces the flash life span.
  5. Memory is very tight. Keep .lua files small and modular. Break files into smaller pieces, and make each one return a function, which you can then dofile("piece.lc")(). This loads a piece of your script, executes it, then frees mem. Go on to the next file after that. As an example, the wifigui.lc file, which is just an html form created on the fly, required breaking into many pieces to allow it to run without running out of heap. 
  6. After each dofile(), call collectgarbage().
  7. Whatever you do, don't do many string concats in a row, e.g.: local str = "str1".."str2".."str3" ..... .."str20" and so on. It's very temtping to do that when implementing a .lc that gets served like a webpage. Multiple concatenations make for extremely lousy performance, and a large memory requirement, particularly if done inside a tight loop. Instead, collect strings in a table, then do table.concat(tab) once at the end.

## Planned work
  1. Websocket server module, to run alongside the httpserver module
  2. Modbus server module
  3. Additional web UIs
 
