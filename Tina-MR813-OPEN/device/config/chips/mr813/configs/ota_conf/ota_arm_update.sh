#!/bin/sh
set -x
OTA_MARK=/mnt/UDISK/ota_mark
OTA_STATE=/mnt/UDISK/ota_state
BOOT_FILE=/tmp/update/boot.img
ROOT_FS_FILE=/tmp/update/rootfs.img
BOOT0_DTS_FILE=/tmp/update/toc0.fex
UBOOT_DTS_FILE=/tmp/update/toc1.fex

echo "Kill node_com_test to prevent imu timeout!"
killall -9 node_com_test

echo -n 2 > ${OTA_STATE}
sync

BOOT_MODE=`fw_printenv boot_partition`

echo ${BOOT_MODE} | grep boot1

if [ $? -eq 0 ]
then	
	BOOT_PART=/dev/by-name/boot2
	ROOT_FS_PART=/dev/by-name/rootfs2
	BOOT_PARTITION=boot2
	ROOT_PARTITION=rootfs2
else
	BOOT_PART=/dev/by-name/boot1
	ROOT_FS_PART=/dev/by-name/rootfs1
	BOOT_PARTITION=boot1
	ROOT_PARTITION=rootfs1
fi

fw_setenv parts_clean rootfs_data
ota-burnboot0 ${BOOT0_DTS_FILE}
ota-burnuboot ${UBOOT_DTS_FILE}
dd if=${BOOT_FILE} of=${BOOT_PART} 
dd if=${ROOT_FS_FILE} of=${ROOT_FS_PART}

if [ $? -eq 0 ]
then	

	mount ${ROOT_FS_PART} /mnt/exUDISK/
	if [ $? -eq 0 ]
	then
		fw_setenv boot_partition ${BOOT_PARTITION}
		fw_setenv root_partition ${ROOT_PARTITION}
		echo 0 > ${OTA_MARK}
		chmod +x /tmp/update/after_upgrade.sh
		sh /tmp/update/after_upgrade.sh
		echo -n 3 > ${OTA_STATE}
		# give the ota control programe time to report the state
		sleep 1
		echo -n 4 > ${OTA_STATE}
		sync
		exit	
	else
		echo -n -33060 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
	fi
else
		echo -n -33061 > ${OTA_MARK}
		echo -n 4 > ${OTA_STATE}
		sync
		exit
fi  



