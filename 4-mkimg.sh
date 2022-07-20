#!/bin/bash

OUTPUT="Ubuntu-$(awk 'NR==1' target_arch 2> /dev/null)-$(awk 'NR==2' target_arch 2> /dev/null)-hi3798$(awk 'NR==1' target 2> /dev/null)-$(date +%Y%m%d)-MD5.img"
TMPFS="tmp"
echo "Firmware Model: $OUTPUT"
echo "Firmware will output into: $(pwd), Please wait ..."

dd if=/dev/zero of=$OUTPUT count=1000 obs=1 seek=1280M
mkfs.ext4 $OUTPUT
umount $TMPFS 2> /dev/null ; rm -r "$TMPFS" 2> /dev/null ; mkdir -p $TMPFS ; sleep 1
mount $OUTPUT $TMPFS
cp -a rootfs/* $TMPFS
sync
umount $TMPFS 2> /dev/null ; rm -r "$TMPFS" 2> /dev/null
e2fsck -p -f $OUTPUT
resize2fs -M $OUTPUT

echo "Calculating MD5 for Firmware ..."
FW1="${OUTPUT/MD5/$(md5sum ${OUTPUT} 2> /dev/null| cut -c1-5)}"
mv -f "${OUTPUT}" "$FW1"

echo "Packing Firmware with command gzip ..."
gzip -c -1 "$FW1" > "${OUTPUT}.gz"

echo "Calculating MD5 for Packed Firmware ..."
FW2="${OUTPUT/MD5/$(md5sum ${OUTPUT}.gz 2> /dev/null | cut -c1-5)}.gz"
mv -f "${OUTPUT}.gz" "$FW2"

echo
echo "Packed Firmware: $FW2"
echo "Packed Firmware Size: $(du -h $FW2 2> /dev/null | awk '{print $1}')"