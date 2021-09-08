#!/bin/sh
mkdir -p /data/log/

SN_PATH=/mnt/private/ULI/factory/sn.txt
CPUID=`cat /sys/class/sunxi_info/sys_info |grep sunxi_serial | awk '{print $3}'`
CPUID_PATH=/mnt/private/ULI/factory/cpuid.txt

umount /mnt/private/ 
mkfs.vfat /dev/by-name/private
mount  /dev/by-name/private /mnt/private -t vfat
mkdir -p /mnt/private/ULI/factory/

echo -n ${SN} > ${SN_PATH}

echo -n ${CPUID} > ${CPUID_PATH}

echo `date` ${SN} >> /data/log/sys_set_private.log

sync

umount /mnt/private/

mkdir -p /mnt/private
mount -o ro /dev/by-name/private /mnt/private -t vfat
