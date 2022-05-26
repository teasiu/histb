<!DOCTYPE html> 
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
      width: 200px; 
      height: 20px; 
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
  </style> 
</head> 
<body> 

  <h3>文件上传</h3> 

<br>最大上传500M单文件，支持任意格式。
  
  <div id="parent"> 
    <div id="son"></div> 
  </div> 
  <p id="con"></p> 
  <input type="file" name="userfile" id="userfile3"><br><br> 
  <input type="button" name="btn" value="文件上传" onclick="sub()"> 
</body> 

 
</html>
