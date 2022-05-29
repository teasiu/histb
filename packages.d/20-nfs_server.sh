# nfs-kernel-server
cat << EOF | LC_ALL=C LANGUAGE=C LANG=C chroot ${ROOTFS}
apt-get install -y nfs-kernel-server
EOF

cat <<EOT > ${ROOTFS}/etc/exports
/home/ubuntu/downloads *(rw,sync,no_root_squash,no_subtree_check)
EOT
