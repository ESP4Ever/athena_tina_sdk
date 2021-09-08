#!/bin/sh

while true
do
        date "+%Y-%m-%d-%H-%M-%S" > /mnt/UDISK/time.txt
        sync
        sleep 1
done
