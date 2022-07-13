<!DOCTYPE html> 
<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes" />
<html lang="en"> 
<head> 
  <meta charset="UTF-8"> 
  <title>上传文件</title> 
  <script type="text/javascript"> 
    function sub() { 
      var obj = new XMLHttpRequest(); 
      obj.onreadystatechange = function() { 
        if (obj.status == 200 && obj.readyState == 4) { 
            document.getElementById('con').innerHTML = obj.responseText; 
        } 
      } 
      obj.upload.onprogress = function(evt) { 
        var per = Math.floor((evt.loaded / evt.total) * 100) + "%"; 
        document.getElementById('parent').style.display = 'block'; 
        document.getElementById('son').style.width = per; 
        document.getElementById('son').innerHTML = per; 
      } 
      var fm = document.getElementById('userfile3').files[0]; 
      var fd = new FormData(); 
      fd.append('userfile', fm); 
      obj.open("post", "_h5ai.up.php"); 
     obj.send(fd); 
    } 
  </script> 
  <style type="text/css"> 
      #parent {  
      margin: 0 auto; 
      text-align: center;
      width: 70%; 
      height: 30px; 
      border: 2px solid gray; 
      background: lightgray; 
      display: none; 
     
    } 
    #son { 
      width: 0; 
      height: 100%; 
      background: lightgreen; 
      text-align: center; 
    } 
  body{
    text-align: center; 
  }

.button {
background-color: #4CAF50;
border: none;
color: white;
padding: 15px 32px;
text-align: center;
font-size: 16px;
cursor: pointer;
outline:0px;
     -webkit-appearance:none;
}

.file{
padding: 20px 62px;
text-align: center;
font-size: 16px;
cursor: pointer;
outline:0px;
     -webkit-appearance:none;
}
.File-Box{
position: relative;
width:150px;
height:150px;
margin: 100px auto;
}
.File-Box input[type=file]{
cursor:pointer;
width:100%;
height:100%;
z-index: 2;
opacity:0;
position: absolute;
}
.Show-Box{
display: block;
z-index: 1;
width:100%;
height:100%;
position: absolute;
background:#dfdfdf;
border:1px solid #cccccc;
}
.Show-Box div{
font-size: 80px;
color: #999999;
text-align: center;
}
.Show-Box span{
display: block;
font-size: 14px;
text-align: center;
color: #666666;
width:100%;
line-height: 15px;
}
.File-Box:hover .Show-Box div,.File-Box:hover .Show-Box span{
color:#90c0f5;
}


  </style> 

</head> 
<body> 

  <h3>文件上传</h3> 
<br>最大上传500M单文件，支持任意格式。

<div id="parent"> 
<div id="son"></div>  
</div>
  <p id="con"></p> .

 <input type="file"  name="userfile" class='file' id="userfile3">


<br><br>
<input type="button" name="btn"  class='button' value="文件上传" onclick="sub()">

</body> 

</html>
