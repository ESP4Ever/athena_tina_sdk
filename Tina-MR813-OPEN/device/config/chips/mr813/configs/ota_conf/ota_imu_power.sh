#!/bin/sh

killall -9 node_com_test

sleep 2

if [[ $1 == power ]]
then
	/robot/com/node_com_test /dev/ttyS3 115200
fi

if [[ $1 == imu ]]
then
	/robot/com/node_com_test /dev/ttyS1 921600
fi
