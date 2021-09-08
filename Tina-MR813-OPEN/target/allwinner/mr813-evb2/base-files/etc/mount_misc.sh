#!/bin/sh

MISC_PARTION=/dev/by-name/misc

fsck.ext4 -y ${MISC_PARTION}
if [ _$? != _0 ]
then
	mkfs.ext4 -m 0 ${MISC_PARTION}
	mount -t ext4 ${MISC_PARTION} /mnt/misc
	sync
else
	mount -t ext4 ${MISC_PARTION} /mnt/misc
fi

echo "mount misc ok!!!"
