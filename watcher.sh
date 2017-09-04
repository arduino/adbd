#!/bin/bash
modprobe dwc3
modprobe dwc3-pci
modprobe configfs 
modprobe libcomposite 
modprobe usb_f_serial 
modprobe usb_f_fs 
#insmod /root/usb_f_fs.ko
modprobe usb_f_acm 
sleep 2 
cd /sys/kernel/config/usb_gadget/
mkdir -p g1 
cd g1 
echo 0x8087 > idVendor 
echo 0x101e > idProduct 
mkdir strings/0x409 
echo 012345678 > strings/0x409/serialnumber 
echo Intel > strings/0x409/manufacturer 
echo Joule > strings/0x409/product 
mkdir -p functions/acm.GS0 
mkdir -p functions/ffs.adb 
mkdir -p configs/c.1 
mkdir -p configs/c.1/strings/0x409 
echo "adb+cdc" > configs/c.1/strings/0x409/configuration 
echo 120 > configs/c.1/MaxPower 
ln -s functions/acm.GS0 configs/c.1 
ln -s functions/ffs.adb/ configs/c.1 
mkdir -p /dev/usb-ffs 
mkdir -p /dev/usb-ffs/adb 
mount -t functionfs adb /dev/usb-ffs/adb 
adbd & 
sleep 2
set -x
UDC_VAL=`ls /sys/class/udc`
UDC_VAL=$(echo $UDC_VAL|tr -d '\n')
echo $UDC_VAL > UDC
if [ $? != 0 ]; then
    exit $?
else
while true; do
    sleep 100
done
fi

