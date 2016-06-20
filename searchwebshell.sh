#!/bin/bash

search_dir=/Users/hancool/pentest/web/webshell
output_dir=/tmp/shell

mkdir -p $output_dir
rm -rf $output_dir/*

#grep -r --include *.php  '[^a-z][eval|assert]($_POST' $search_dir > $output_dir/eval.txt
#grep -r --include *.php  '[^a-z]system([$_POST|$_GET]' $search_dir > $output_dir/system.txt
#grep -r --include *.php  'file_put_contents(.*$_POST[.*]);' $search_dir > $output_dir/file_put_contents.txt
#find $search_dir -name "*.php" -type f -print0 | xargs -0 egrep "(phpspy|c99sh|milw0rm|eval(gzuncompress(base64_decoolcode))|eval(base64_decoolcode)|spider_bc|gzinflate)" | awk -F: '{print $1}' | sort | uniq > $output_dir/php.txt
find $search_dir -name "*.php" -type f -print0 | xargs -0 egrep 'assert|phpspy|c99sh|milw0rm|eval|\(gunerpress|\(base64_decoolcode|spider_bc|shell_exec|passthru|\(\$\_\POST\[|eval \(str_rot13|\.chr\(|\$\{\"\_P|eval\(\$\_R|file_put_contents\(\.\*\$\_|base64_decode|\@preg_replace' | awk -F: '{print $1}' | sort | uniq > $output_dir/php.txt

find $output_dir -type f -print | xargs cat