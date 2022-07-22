<style>
   body{
text-align: center;
}
</style>
<h1>网口MAC地址修改</h1>
<form action="macedit.php" class="layui-form"  method="POST" accept-charset="GBK">
   请输入：<input type="text" name="mac" value="" style="width:250px" maxlength="12" placeholder="请输入连续字符,例：112233445566">
   
   <input type="submit"  name="submit" value="提交">
</form>
<?php
if($_POST['submit']){
   $mac= $_POST['mac'];
   $file = "/etc/bootargs_input.txt";
   $fd = fopen($file,"r");
   $contents = fread($fd,filesize($file));
   preg_match("/ethaddr=(([\s\S]+?))\nipaddr=/",$contents,$arr);
  $oldmac = $arr[2];  //旧mac
   if(strlen($mac)!=12){
      echo "<br>MAC长度不对，应等于12位";
      exit();
   }

   if(!ctype_xdigit($mac)){  //判断是否为16进制
      echo "<br>MAC不符合要求，您只能输入16进制的数字或字母";
      echo "<br>16进制只能包含0123456789ABCDEF这16个字符";
      exit();
   }
   $mac = strtoupper($mac);   //转换为大写

   if (!is_writable ($file)) {
      echo "<br>文件不可写，无法写入";
      exit();
   }

fclose($fd);
echo "原MAC地址:" .$oldmac;
$mac= preg_replace('~..(?!$)~', '\0:', str_replace(".", "", $mac));
echo "<br>新MAC地址:" .$mac;
$fd = fopen($file,"w");
$contents= str_replace($oldmac,$mac,$contents);
   $res = fputs($fd,$contents);
   if($res!==false){
      echo "<br>写入成功";
   }
   fclose($fd);
   
   $output = shell_exec("sudo bash /usr/bin/chgmac.sh");
   echo "<pre>$output</pre>";
   
}


?>
