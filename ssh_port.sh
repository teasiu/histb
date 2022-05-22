#!/bin/bash

ssh_port=$(grep "\[ssh-" /etc/frp/frpc.ini 2> /dev/null | cut -d '-' -f2 | cut -d ']' -f1)

[ "$ssh_port" ] && echo "$(head -10 /dev/urandom | md5sum | cut -c 1-5)$ssh_port$(head -10 /dev/urandom | sha256sum | cut -c 1-5)" || echo "获取失败"
