#!/bin/sh

ifconfig eth0 192.168.55.233 netmask 255.255.255.0 up multicast
route add -net 224.0.0.0 netmask 240.0.0.0 dev eth0

mkdir -p /mnt/UDISK/manager_log

MANAGER_TEST_PATH=/mnt/UDISK/test/manager.sh

/robot/update_timer 192.168.55.1 &

sleep 10s

if [  -f "${MANAGER_TEST_PATH}" ]; then
    /mnt/UDISK/manager /mnt/UDISK/ >> /mnt/UDISK/manager_log/manager.log 2>&1 &
else
    /robot/manager /robot/ >> /mnt/UDISK/manager_log/manager.log 2>&1 &
fi

/etc/check_log.sh 2>&1 &
