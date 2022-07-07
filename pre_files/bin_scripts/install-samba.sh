#!/bin/bash
# Only support Debian 10

if [ `whoami` != "root" ]; then
    echo "sudo or root is required!"
    exit 1
fi

if [ ! -f "/etc/debian_version" ]; then
    echo "Boss, do you want to try debian?"
    exit 1
fi
check_samba(){
  type samba > /dev/null 2>&1
  if [ $? -eq 0 ] ;then
    echo "samba软件已存在，请不要重复安装"
    exit 1
  else
    install_samba
  fi
}
install_samba(){
  apt update && apt install samba -y
  cat <<EOT > /etc/samba/smb.conf
[global]
   workgroup = WORKGROUP
   server string = %h server (Samba, Ubuntu)
   client min protocol = NT1
   server min protocol = NT1
   log file = /var/log/samba/log.%m
   max log size = 1000
   logging = file
   panic action = /usr/share/samba/panic-action %d
   server role = standalone server
   obey pam restrictions = yes
   unix password sync = yes
   passwd program = /usr/bin/passwd %u
   passwd chat = *Enter\snew\s*\spassword:* %n\n *Retype\snew\s*\spassword:* %n\n *password\supdated\ssuccessfully* .
   pam password change = yes
   map to guest = bad user
[printers]
   comment = All Printers
   browseable = no
   path = /var/spool/samba
   printable = yes
   guest ok = no
   read only = yes
   create mask = 0700
[print$]
   comment = Printer Drivers
   path = /var/lib/samba/printers
   browseable = yes
   read only = yes
   guest ok = no
[downloads]
  path = /home/ubuntu/downloads
  read only = no
  guest ok = yes
  create mask = 0777
  directory mask = 0777
  browseable = yes

EOT

  # limit log size
  sed -ri -e '/^\s+size\s+.*/d' /etc/logrotate.d/samba
  sed -ri -e 's/^(\s+)(rotate\s+).*/\1\21\n\1size 1M/g' /etc/logrotate.d/samba

  systemctl restart smbd
}
check_samba

