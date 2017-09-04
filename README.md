## Build and installation

Ubuntu deps

    sudo apt install libcap-dev libglib2.0-dev


Configuration and building
    ./configure
    make
    sudo make install

#Get started

Copy adbd binary to /usr/bin/ folder
Launch watcher.sh AS ROOT (it will enter an infinite loop, avoid closing its shell)
Attach a USB micro cable to port CN13 on the UP^2 (near the standalone USB type A connector)
On Create, a board should appear in the menu (Intel x86_64 Boards / IoT Gateways on $portName )
Try executng an upload; the correct adb (desktop) tool will be downloaded

By using SerialUSB object in your code you will see the output on the Serial monitor

In case nothing happens, try configuring the BIOS with as in the attached pictures under bios/
The password to enable the developer menu is "upassw0rd" (without quotes)
