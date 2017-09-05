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
if [ ! -d /sys/kernel/config/usb_gadget/g1 ]; then
mkdir g1
cd g1
echo 0x8087 > idVendor
echo 0x101e > idProduct
mkdir strings/0x409
echo 012345678 > strings/0x409/serialnumber
echo Intel > strings/0x409/manufacturer
echo IoTplatform > strings/0x409/product
mkdir functions/acm.GS0
mkdir functions/ffs.adb
mkdir configs/c.1
mkdir configs/c.1/strings/0x409
echo "adb+cdc" > configs/c.1/strings/0x409/configuration
echo 120 > configs/c.1/MaxPower
ln -s functions/acm.GS0 configs/c.1
ln -s functions/ffs.adb/ configs/c.1
mkdir /dev/usb-ffs
mkdir /dev/usb-ffs/adb
mount -t functionfs adb /dev/usb-ffs/adb
adbd &
sleep 2
fi
while true; do
UDC_VAL=`ls /sys/class/udc`
UDC_VAL=$(echo $UDC_VAL|tr -d '\n')
UDC_MOUNTED=`cat /sys/kernel/config/usb_gadget/g1/UDC`
UDC_MOUNTED=$(echo $UDC_MOUNTED|tr -d '\n')
if [ x$UDC_MOUNTED == x ]; then
echo $UDC_VAL > /sys/kernel/config/usb_gadget/g1/UDC
if [ $? == 0 ]; then
#echo "USB configured"
sleep 10
else
#echo "USB configuration failed"
sleep 1
fi
else
if [ x$UDC_VAL == x ]; then
#echo "USB detached, sleeping"
sleep 1
else
#echo "USB already configured, sleeping"
sleep 10
fi
fi
done
