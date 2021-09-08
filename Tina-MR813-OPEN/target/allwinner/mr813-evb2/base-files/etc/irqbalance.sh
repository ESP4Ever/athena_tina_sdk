#!/bin/sh
set -x

gmac0=`cat /proc/interrupts | grep gmac0 | awk -F: '{print $1}'`
echo 4 > /proc/irq/${gmac0}/smp_affinity

dma_controller=`cat /proc/interrupts | grep dma | awk -F: '{print $1}'`
echo 8 > /proc/irq/${dma_controller}/smp_affinity

sunxi_usb_udc=`cat /proc/interrupts | grep sunxi_usb_udc | awk -F: '{print $1}'`
echo 2 > /proc/irq/${sunxi_usb_udc}/smp_affinity
