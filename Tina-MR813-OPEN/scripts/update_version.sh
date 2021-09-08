#!/bin/sh
set -x

BOARD=p2151
cp $1/../config/version.json  $2/etc/os-release
	
#MCU_VER=`cd $(BUILD_PATH)/app/mcu_pkg/install/root/mcu/ ; ls *factory* | cut -c8-12  `; \
#sed -i -e "s/MCU_VER/$$MCU_VER/" $(OUTPUT_ROOT)/etc/os-release
	
DATE=`date "+%Y-%m-%d %H:%M:%S"`
sed -i -e "s/DATE/${DATE}/" $2/etc/os-release
	
#BOARD=${BOARD}
#sed -i -e "s/BOARD/${BOARD}/" $2/etc/os-release
