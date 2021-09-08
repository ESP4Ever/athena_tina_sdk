#!/bin/sh

mkdir -p /mnt/UDISK/test/
rm -rf  /mnt/UDISK/manager
rm -rf  /mnt/UDISK/robot-software
rm -rf  /mnt/UDISK/manager_config
rm -rf  /mnt/UDISK/imu-test

cp -rf /robot/manager.sh_ok /mnt/UDISK/test/manager.sh_ok

if [ -e "/mnt/UDISK/test/manager.sh_ok" ];then
  mv /mnt/UDISK/test/manager.sh_ok /mnt/UDISK/test/manager.sh
else
  log "do noting"
fi

cp -rdf   /robot/robot-software/   /mnt/UDISK/robot-software/
cp -rdf   /robot/manager           /mnt/UDISK/manager
cp -rdf   /robot/manager_config    /mnt/UDISK/manager_config
cp -rdf   /robot/imu-test          /mnt/UDISK/imu-test

sync

killall manager
/mnt/UDISK/manager /mnt/UDISK/ > /mnt/UDISK/manager_log/manager.log 2>&1 &
