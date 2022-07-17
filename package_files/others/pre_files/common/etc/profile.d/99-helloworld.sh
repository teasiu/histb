IP=$(ifconfig eth0 | grep '\<inet\>'| grep -v '127.0.0.1' | awk '{print $2}' | awk 'NR==1')
TARGET=$(dmesg 2> /dev/null | grep "CPU: hi" | awk -F ':[ ]' '/CPU/{printf ($2)}')
[ ! "$TARGET" ] && TARGET=$(head -n 1 /etc/regname 2> /null)
clear
echo -e "\e[33m
      __  ____                __       
     / / / / /_  __  ______  / /___  __
    / / / / __ \/ / / / __ \/ __/ / / /
   / /_/ / /_/ / /_/ / / / / /_/ /_/ / 
   \____/_.___/\__,_/_/ /_/\__/\__,_/ 
\e[0m
		欢迎使用 \e[31m海思机顶盒微型 NAS 服务器 $(getconf LONG_BIT)-bit 系统\e[0m
		原创作者 神雕Teasiu 贡献者 Hyy2001 MinaDee Xjm
		浏览详细使用教程请访问: \e[32mhttp://$IP\e[0m
		访问我们的官网: \e[32mhttps://www.histb.com\e[0m

   设备名称 : $TARGET
   系统版本 : $(awk -F '[= "]' '/PRETTY_NAME/{print $3,$4,$5}' /etc/os-release) | V$(cat /etc/nasversion)-$(uname -r)-$(getconf LONG_BIT)
   可用存储 : $(df -m / | grep -v File | awk '{a=$4*100/$2;b=$4} {printf("%.1f%s %.1fM\n",a,"%",b)}')
   可用内存 : $(free -m | grep Mem | awk '{a=$7*100/$2;b=$7} {printf("%.1f%s %.1fM\n",a,"%",b)}') | $(free -m | grep Swap | awk '{a=$4*100/$2;b=$4} {printf("%.1f%s %.1fM\n",a,"%",b)}')
   启动时间 : $(awk '{a=$1/86400;b=($1%86400)/3600;c=($1%3600)/60;d=($1%60)} {printf("%d 天 %d 小时 %d 分钟 %d 秒\n",a,b,c,d)}' /proc/uptime)
   IP 地址  : $IP
   设备温度 : $(grep Tsensor /proc/msp/pm_cpu | awk '{print $4}')°C
"

alias reload='. /etc/profile'
alias ramfree='sync && echo 3 > /proc/sys/vm/drop_caches'
alias cls='clear'
alias syslog='cat /var/log/syslog'
alias unmount='umount -l'
