#!/bin/sh

while(true)
do
    size=`echo $(ls -l /mnt/UDISK/manager_log/manager.log) | awk '{ print $5 }'`
    file=`echo $(ls -l /mnt/UDISK/manager_log/manager.log) | awk '{ print $9 }'`

    echo $size
    echo $file

    if [ $size -gt 524288000 ];then
      echo "manager.log > 500M,and clear the log file!"
      date
      : > /mnt/UDISK/manager_log/manager.log
    fi

    sleep 60s
done


