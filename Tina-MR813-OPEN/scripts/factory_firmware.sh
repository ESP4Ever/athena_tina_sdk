#!/bin/sh

set -x
FIRMWARE_VERSION=`cat $(pwd)/../../config/version.json | jq '.fw_arm_ver' | sed 's/\"//g' `
BOARD=`cat $(pwd)/../../config/version.json | jq '.product' | sed 's/\"//g'`

FACTORY_IMG_DEBUG=${BOARD}_factory-${FIRMWARE_VERSION}.img
UPDATE_IMG_DEBUG=${BOARD}_update-${FIRMWARE_VERSION}.img



OTA_PATCH=$(pwd)/ota
OTA_FILE_ENCRY_SIGN_PTAH=$(pwd)/../../scripts/ota_sign/ota_file_encry_sign.sh

cp -rf $(pwd)/../../device/config/chips/mr813/configs/ota_conf/.  ${OTA_PATCH}/
cp -rf $(pwd)/../../package/robot/mcu/imuSpieMotorOTA_*.bin  ${OTA_PATCH}/imu_mcu.bin
cp -rf $(pwd)/../../package/robot/mcu/powerOTA_*.bin  ${OTA_PATCH}/power_mcu.bin
cp -rf $(pwd)/../../package/robot/mcu/imuExtOTA_*.bin ${OTA_PATCH}/imuExt_mcu.bin
cp -rf $(pwd)/image/toc0.fex  ${OTA_PATCH}/
cp -rf $(pwd)/image/toc1.fex  ${OTA_PATCH}/
cp -rf $(pwd)/image/boot.fex  ${OTA_PATCH}/boot.img
cp -rf $(pwd)/rootfs.img      ${OTA_PATCH}/rootfs.img

md5sum ${OTA_PATCH}/boot.img  > ${OTA_PATCH}/boot_md5sum
md5sum ${OTA_PATCH}/rootfs.img  > ${OTA_PATCH}/rootfs_md5sum
md5sum ${OTA_PATCH}/imu_mcu.bin  > ${OTA_PATCH}/imu_mcu_md5sum
md5sum ${OTA_PATCH}/imuExt_mcu.bin > ${OTA_PATCH}/imuExt_mcu_md5sum
md5sum ${OTA_PATCH}/power_mcu.bin  > ${OTA_PATCH}/power_mcu_md5sum
rm $(pwd)/../${BOARD}_*

$(pwd)/../../tools/afptool/afptool -pack ${OTA_PATCH}/  ${OTA_PATCH}/update.img
${OTA_FILE_ENCRY_SIGN_PTAH} ${OTA_PATCH}/ ${OTA_PATCH}/OTA_Key.pem

mv ${OTA_PATCH}/update_double_encry_sign.img  $(pwd)/../${UPDATE_IMG_DEBUG}

md5sum ../${UPDATE_IMG_DEBUG} > ../${UPDATE_IMG_DEBUG}.md5sum

mv $1 ../${FACTORY_IMG_DEBUG}
md5sum ../${FACTORY_IMG_DEBUG} > ../${FACTORY_IMG_DEBUG}.md5sum
