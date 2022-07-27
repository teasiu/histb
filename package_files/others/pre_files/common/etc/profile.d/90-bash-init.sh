clear
alias copyright='rm /etc/copyright ; /etc/profile.d/90-bash-init.sh'
IP=$(ifconfig eth0 | grep '\<inet\>'| grep -v '127.0.0.1' | awk '{print $2}' | awk 'NR==1')

if [ ! -e /etc/copyright ] 2> /dev/null
then
	echo -e "欢迎使用 \e[31m海思机顶盒微型 NAS 服务器 $(getconf LONG_BIT)-bit 系统\e[0m

原创作者: \e[32m神雕Teasiu\e[0m
贡献成员: Hyy2001 MinaDee Xjm
教程地址: http://$IP
官网地址: https://www.ecoo.top
社区地址: https://bbs.histb.com | 欢迎访问我们的社区, 你的肯定是对我们最大的支持!

版权声明:\e[31m
	1. 作者唯一闲鱼账号: 神雕teasiu
	2. 本系统仅在官网发布, 任何人均可免费下载安装和使用
	3. 如果你是在不良奸商手上购买本系统, 请尝试协商退款或予以差评
	3. 本系统开通的服务仅仅用于学习研究, 不得用于任何非法用途
	4. 未经作者授权, 不得将系统用于盈利售卖, 不得用于衍生的任何软件变相收费, 否则视为侵权行为
\e[0m
"
	echo -e "提示: \e[31m本内容仅显示一次, 烦请仔细阅读, 后续执行 'copyright' 指令即可再次阅读本页面!\e[0m\n"
	sleep 3
	echo -ne "\e[32m" ; read -p "如果你同意以上内容, 请按下 [回车] 键以继续 ..." Key ;echo -ne "\e[0m"
	date > /etc/copyright
	. /etc/profile
fi
