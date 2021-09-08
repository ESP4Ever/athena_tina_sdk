#!/bin/sh

cp -rf $1/../package/allwinner/external_lib/.  $2/usr/lib/
cp -rf $1/../package/allwinner/openssl/.  $2/usr/bin/
cp -rf $1/../package/allwinner/afptool/.  $2/usr/bin/
cp -rf $1/../package/allwinner/unzip/.  $2/usr/bin/
cp -rf $1/../package/libs/ntp/bin/.    $2/usr/bin/
cp -rf $1/../package/robot/help  $2/usr/bin/
cp -rf $1/../device/config/chips/mr813/configs/ota_conf/ota_*.sh  $2/robot/ota/
cp -rf $1/../package/robot/com/node_com_test  $2/robot/com/
cp -rf $1/../package/robot/sys/sys_set_private.sh  $2/robot/sys/
cp -rf $1/../package/robot/sys/rtc_time_save.sh  $2/robot/sys/
cp -rf $1/../package/robot/sys/rtc_time_set  $2/robot/sys/
cp -rf $1/../package/robot/test/uart_test  $2/robot/test/
cp -rf $1/../package/robot/test/view_version.sh   $2/robot/test/
cp -rf $1/../package/robot/test/update_timer  $2/robot/
cp -rf $1/../package/robot/initialize.sh  $2/robot/
cp -rf $1/../package/robot/manager.sh_ok  $2/robot/
cp -rf $1/../package/robot/manager  $2/robot/
cp -rf $1/../package/robot/README.md  $2/robot/
cp -rf $1/../package/robot/imu-test/.   $2/robot/imu-test/
cp -rf $1/../package/robot/manager_config/.   $2/robot/manager_config/
cp -rf $1/../package/allwinner/ymodem/ymodem  $2/usr/bin/

cp -rf $1/../package/robot/robot-software/.  $2/robot/robot-software/
rm -rf $2/robot/robot-software/robot

$1/../scripts/update_version.sh $1 $2
