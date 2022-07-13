#!/bin/bash
dd of=/dev/mmcblk0p2 if=/usr/bin/bootargs4.bin bs=1024 count=1024
sleep 2
reboot
