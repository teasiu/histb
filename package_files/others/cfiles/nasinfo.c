#include <stdio.h>

#define  BUFF_SIZE   1024

int main( void)
{
   const char  *cpuname = "cat /proc/cpuinfo | grep \"model name\" | sort -u | cut -f 2 -d :";
   const char  *cpucore = "cat /proc/cpuinfo | grep \"processor\" | cut -f 2 -d : | wc -l";
   const char  *cpuphy = "cat /proc/cpuinfo | grep \"physical id\" |sort -u | cut -f 2 -d : | sed 's/ //g' | wc -l";
   const char  *cpumhz = "cat /proc/cpuinfo | grep \"cpu MHz\" |sort -u | cut -f 2 -d : | sed 's/ //g'";
   const char  *memtotal = "cat /proc/meminfo | grep MemTotal";
   const char  *ubuntuversion = "cat /etc/os-release | grep \"PRETTY_NAME\" |cut -c 14-31";
   const char  *kernelv = "uname -a | awk '{print $3}'";
   const char  *kernelr = "uname -a | awk '{print $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14, $15}'";
   const char  *ifconfig = "ifconfig | grep -e inet -e  \"inet\" -e Local";
   const char  *regname = "egrep -oa \"hi3798.+reg\" /dev/mmcblk0p1 2> /dev/null | cut -d '_' -f1";
   const char  *bond = "for bond in `ls /proc/net/bonding | grep bond`; do echo \"---------- Bonding - $bond ----------\"; echo \"cat /proc/net/bonding/$bond\" | sh ; done";
   const char  *gateway = "route -n | grep ^0.0.0.0 | awk '{print $2}'";
   const char  *dns = "cat /etc/resolv.conf  | grep nameserver";
   const char  *temp = "grep Tsensor /proc/msp/pm_cpu | awk '{print $4}'";
   const char  *cron = "for user in `ls /var/spool/cron/crontabs`; do echo \"---------- Cron Job - $user ----------\"; echo \"cat /var/spool/cron/crontabs/$user\" | sh ; done";
   const char  *design = "echo '神雕teasiu 贡献者 hyy2001 MinaDee Xjm'";
   const char  *website = "echo www.ecoo.top";
   const char  *vga = "lspci | grep VGA";
   char  buff[BUFF_SIZE];
   FILE *fp;

    printf("\n");
    printf("E酷网海思机顶盒系统信息");
    printf("\n");

   fp = popen( "date", "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "执行时间 : %s", buff);

   pclose( fp);

    printf("\n");
    printf("\033[101m============== 服务器信息  ==============\033[0m\n");
    printf("\n");
    printf("* 硬件信息\n");
    printf("\n");

   fp = popen( "hostname", "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "CPU 型号 : %s", buff);

   pclose( fp);

   fp = popen( regname, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "Reg 名称 : %s", buff);

   pclose( fp);

   fp = popen( temp, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "CPU 温度 : %s", buff);

   pclose( fp);

   fp = popen( cpuname, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "CPU Model :%s", buff);

   pclose( fp);

   fp = popen( cpucore, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "CPU 核心 : %s", buff);

   pclose( fp);

   fp = popen( cpuphy, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "Physical CPU NUM : %s", buff);

   pclose( fp);

   fp = popen( cpumhz, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "CPU Speed : %s", buff);

   pclose( fp);


   fp = popen( memtotal, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);

    printf("\n");
    printf("* 系统信息\n");
    printf("\n");

   fp = popen( design, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "系统作者 : %s", buff);

   pclose( fp);
   
   fp = popen( website, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "官方网站 : %s", buff);

   pclose( fp);   
  
   fp = popen( ubuntuversion, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "OS 版本 : %s", buff);

   pclose( fp);

   fp = popen( kernelv, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "内核版本 : %s", buff);

   pclose( fp);
   
   fp = popen( kernelr, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "内核详情 : %s", buff);

   pclose( fp);

    printf("\n");
    printf("* 运存信息\n");
    printf("\n");

   fp = popen( "free", "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);

   fp = popen( "vmstat", "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);

    printf("\n");
    printf("\033[101m============== 网络信息  ==============\033[0m\n");
    printf("\n");

    printf("* 网络地址\n");
    printf("\n");

   fp = popen( ifconfig, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);

    printf("\n");
    printf("* Bonding 状态\n");
    printf("\n");

   fp = popen( bond, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);


    printf("\n");
    printf("* 路由信息\n");
    printf("\n");

   fp = popen( "netstat -rn", "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);

    printf("\n");
    printf("* 默认网关\n");
    printf("\n");

   fp = popen( gateway, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "网关 : %s", buff);

   pclose( fp);

    printf("\n");
    printf("* DNS\n");
    printf("\n");

   fp = popen( dns, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);

    printf("\n");
    printf("\033[101m============== 存储盘信息  ==============\033[0m\n");
    printf("\n");

    printf("* Filesystem Information\n");

   fp = popen( "cat /etc/fstab", "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);

    printf("\n");

   fp = popen( "df -h", "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);

     printf("\n");
    printf("\033[101m============== ETC 信息  ==============\033[0m\n");
    printf("\n");

    printf("* 在线用户\n");

   fp = popen( "w", "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);

    printf("\n");
    
    printf("* 计划任务列表\n");

   fp = popen( cron, "r");
   if ( NULL == fp)
   {
      perror( "popen() fail");
      return -1;
   }

   while( fgets( buff, BUFF_SIZE, fp) )
      printf( "%s", buff);

   pclose( fp);

    printf("\n");

    printf("\033[101m================ www.ecoo.top出品 =========== \033[0m\n");

    return 0;
}

