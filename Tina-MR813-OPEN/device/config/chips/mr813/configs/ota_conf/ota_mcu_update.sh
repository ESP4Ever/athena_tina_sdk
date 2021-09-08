#!/bin/sh

set -x

OTA_STATE=/mnt/UDISK/ota_state
UART_PORT=$1

stty -F ${UART_PORT} $2 cs8 -parodd parenb -cstopb -echo

cat ${UART_PORT} > /tmp/C.log &

cnt=0
while [ $cnt -lt 30 ]  
do  
	cat /tmp/C.log | grep "CC"
	
	if [ _$? = _0 ];then
		echo "wait C ok!!!" 
		killall cat
		break
	else
		echo "waiting C....." 
	fi
	
	sleep 1
	cnt=$(( $cnt + 1 ))
done

if [ $cnt -eq 30 ] ; then

	echo "wait C fail!!!"
	echo -n 4 > ${OTA_STATE}
	sync
	reboot
fi

NAME=`basename ${UART_PORT}`
/usr/bin/ymodem -u $2-8-1-0 -b /tmp/update/$3_mcu.bin  -d ${UART_PORT} > /mnt/UDISK/ymodem${NAME}_log.txt 2>&1

if [ _$? = _0 ];then

	echo "ymodem update_OK"
else
	echo "/usr/bin/ymodem fail!!!" 
	echo -n 4 > ${OTA_STATE}
	sync
	exit
fi











