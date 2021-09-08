#!/bin/sh
set -x 
OTA_MARK=/mnt/UDISK/ota_mark
OTA_STATE=/mnt/UDISK/ota_state
NORMAL_FS_MNT=/tmp/normal_fs
FW_FILE=/tmp/fw.bin             
UPDATE_DIR=/tmp/update/

BOOT_FILE=/tmp/update/boot.img
ROOT_FS_FILE=/tmp/update/rootfs.img
MCU1_FILE=/tmp/update/imu_mcu.bin
MCU2_FILE=/tmp/update/power_mcu.bin
MCU3_FILE=/tmp/update/imuExt_mcu.bin

BOOT_FILE_MD5SUM=/tmp/update/boot_md5sum
ROOT_FS_FILE_MD5SUM=/tmp/update/rootfs_md5sum
MCU1_FILE_MD5SUM=/tmp/update/imu_mcu_md5sum
MCU2_FILE_MD5SUM=/tmp/update/power_mcu_md5sum
MCU3_FILE_MD5SUM=/tmp/update/imuExt_mcu_md5sum

mkdir -p ${UPDATE_DIR}


if [ -f ${FW_FILE} ]
then
	rm -rf  ${FW_FILE}_tmp 
	rm -rf /tmp/firmware.signature
	rm -rf /tmp/update.img

	openssl  smime -decrypt  -in  ${FW_FILE}  -binary -inform DEM -inkey /etc/publickey.pem  -out  ${FW_FILE}_tmp 
	rm -rf  ${FW_FILE}
	unzip -P cMPXOzSlYQlJI8RkrW1ddkyw6hfRUFYPCNOtUJTAqAwYHdAphg ${FW_FILE}_tmp  -d /tmp
	rm -rf  ${FW_FILE}_tmp 
	VERIFY_RESULT=`openssl dgst -sha256 -verify /etc/OTA_Key_pub.pem -signature /tmp/firmware.signature /tmp/update.img`


	if [ x"${VERIFY_RESULT:9:2}" != x"OK" ]
	then
		echo -n -33050 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
	fi

	if [ $? -ne 0 ]
	then
		echo -n -33050 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
	fi

	RET=`afptool -unpack /tmp/update.img ${UPDATE_DIR} `

	if [ "${RET}" == "" ]
	then
		echo -n -33050 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
	fi

	chmod +x /tmp/update/before_upgrade.sh
	sh /tmp/update/before_upgrade.sh

	sync

	rm -rf /tmp/update.img

	FW_MCU1_MD5SUM=`cat ${MCU1_FILE_MD5SUM} | cut -d ' ' -f1`
	MCU1_MD5SUM=`md5sum ${MCU1_FILE} | cut -d ' ' -f1`

	if [[ ${MCU1_MD5SUM} == ${FW_MCU1_MD5SUM} ]];then
		log "mcu1 md5sum check success!!!"
	else
		log "mcu1 md5sum check fail!!!"
		echo -n -33051 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
	fi

	FW_MCU2_MD5SUM=`cat ${MCU2_FILE_MD5SUM} | cut -d ' ' -f1`
	MCU2_MD5SUM=`md5sum ${MCU2_FILE} | cut -d ' ' -f1`

	if [[ ${MCU2_MD5SUM} == ${FW_MCU2_MD5SUM} ]];then
		log "mcu2 md5sum check success!!!"
	else
		log "mcu2 md5sum check fail!!!"
		echo -n -33052 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
	fi

	FW_MCU3_MD5SUM=`cat ${MCU3_FILE_MD5SUM} | cut -d ' ' -f1`
	MCU3_MD5SUM=`md5sum ${MCU3_FILE} | cut -d ' ' -f1`

	if [[ ${MCU3_MD5SUM} == ${FW_MCU3_MD5SUM} ]];then
		log "mcu3 md5sum check success!!!"
	else
		log "mcu3 md5sum check fail!!!"
		echo -n -33053 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
	fi

	FW_BOOT_MD5SUM=`cat ${BOOT_FILE_MD5SUM} | cut -d ' ' -f1`
	BOOT_MD5SUM=`md5sum ${BOOT_FILE} | cut -d ' ' -f1`

	if [[ ${BOOT_MD5SUM} == ${FW_BOOT_MD5SUM} ]];then
		echo "boot md5sum check success!!!"
	else
		echo -n -33054 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
	fi	

	FW_ROOT_FS_MD5SUM=`cat ${ROOT_FS_FILE_MD5SUM} | cut -d ' ' -f1`
	ROOT_FS_MD5SUM=`md5sum ${ROOT_FS_FILE} | cut -d ' ' -f1`

	if [[ ${ROOT_FS_MD5SUM} == ${FW_ROOT_FS_MD5SUM} ]];then
		echo "rootfs md5sum check success!!!"
	else
		echo -n -33055 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
	fi

	if [ ! -f "${BOOT_FILE}" ] || [ ! -f "${ROOT_FS_FILE}" ] ;then
		echo -n -33056 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
	fi
	echo -n 1 > ${OTA_STATE}
	sync

	if [ -d "/mnt/UDISK/ota_report" ]; then
		rm -rf /mnt/UDISK/ota_report
		sync
	fi
	mkdir -p /mnt/UDISK/ota_report
	sync

	if [ -e "/dev/ttyUSB0" ]
	then
		/robot/com/node_com_test /dev/ttyUSB0 921600
	else
		echo "ttyUSB0 Offline" >> /mnt/UDISK/ota_log
		/robot/com/node_com_test /dev/ttyS1 921600
	fi
else
	echo -n -33057 > ${OTA_MARK}
	echo -n 4 > ${OTA_STATE}
	sync
	exit
fi

