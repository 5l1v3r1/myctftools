#!/bin/bash
echo "                       "
echo "( what are you doing? )"
echo  ---------------------
echo "      o   ^__^ "
echo "       o  (oo)\_______"
echo "          (__)\       )\/\ "
echo "              ||----w |    "  
echo "              ||     ||    "
echo 
echo "...."�м����־�����ű�v2.0"..."
echo ------------------------------------------------------------
echo "�Զ������м����־��������־�д��ڵ�SQLע�롢XSS�ű������ȹ�����Ϊɸѡ����"
echo "���ű�Ŀǰ��֧��IIS��apache��weblogic�м��"
echo "�¼��������getshell�������ļ����Լ�LFI�ļ�����������HTTP��Ӧ��200��500�ķ���"
echo "ִ�нű�֮ǰ���뽫Ҫ��������־������/usr/Ŀ¼��"
echo ----------------------���س���ʼ����---------------------------
read key
file=/usr/nmgxy/
if [ -e "$file" ];then 
echo "��־Ŀ¼���ڣ������������̣��ò��������/usr/nmgxy/Ŀ¼����������"
echo "���س�����ʼ������ݣ���������Ctrl+c"
read key
rm -r /usr/nmgxy/*
mkdir -p /usr/nmgxy/LFI/ /usr/nmgxy/exp/ /usr/nmgxy/sql/ /usr/nmgxy/scan/ /usr/nmgxy/xss/ /usr/nmgxy/getshell/ /usr/nmgxy/dir/
else
mkdir -p /usr/nmgxy/ /usr/nmgxy/LFI/ /usr/nmgxy/exp/ /usr/nmgxy/sql/ /usr/nmgxy/scan/ /usr/nmgxy/xss/ /usr/nmgxy/getshell/ /usr/nmgxy/dir/
fi
echo "���������־������/usr/nmgxy/Ŀ¼��"
echo ---------------------��־Ŀ���ļ�---------------------------
if ls -l /usr/ | egrep "access";then
echo --------------------ͳ�Ƴ��ִ�������ǰ20��IP��ַ-----------------
cat /usr/access*.* |awk '{print $1}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/top20.log
echo "ͳ�����"
echo ------------------------SQLע�빥��sql.log----------------
echo "��ʼ��������SQLע��Ĺ�����Ϊ���������������/usr/nmgxy/sql/Ŀ¼��"
more /usr/access*.* |egrep "%20select%20|%20and%201=1|%20and%201=2|%20exec|%27exec| information_schema.tables|%20information_schema.tables|%20where%20|%20union%20|%20SELECT%20|%2ctable_name%20|cmdshell|%20table_schema" >/usr/nmgxy/sql/sql.log
echo "��������"
awk '{print "����⵽SQLע�빥��" NR"��"}' /usr/nmgxy/sql/sql.log|tail -n1
echo "��ʼͳ��SQLע�빥���¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/sql/sql.log |awk -F "[" '{print $1}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/sql/top20.log
echo ----------------------------------------------------------
more /usr/nmgxy/sql/top20.log
echo "ͳ�ƽ���"
echo -------------------------ɨ����scan.log-------------------
echo "��ʼ��������ɨ��Ĺ�����Ϊ���������������/usr/nmgxy/scan/Ŀ¼��"
more /usr/access*.* |egrep "sqlmap|acunetix|Netsparker|nmap|HEAD" >/usr/nmgxy/scan/scan.log
echo "��������"
awk '{print "����⵽ɨ�蹥��" NR"��"}' /usr/nmgxy/scan/scan.log|tail -n1
echo "��ʼͳ��ɨ�蹥���¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/scan/scan.log |awk -F "[" '{print $1}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/scan/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/scan/top20.log
echo "ͳ�ƽ���"
echo -------------------------�����ļ�ɨ��dir.log-------------------
echo "��ʼ��������ɨ��Ĺ�����Ϊ���������������/usr/nmgxy/dir/Ŀ¼��"
more /usr/access*.* |egrep "\.zip|\.rar|\.mdb|\.inc|\.sql|\.config|\.bak|/login.inc.php|/.svn/|/mysql/|config.inc.php|\.bak|wwwroot|��վ����|/gf_admin/|/DataBackup/|/Web.config|/web.config|/1.txt|/test.txt" >/usr/nmgxy/dir/dir.log
echo "��������"
echo "���η��������HTTP��Ӧ��Ϊ200��500���������Ϊ/usr/nmgxy/dir/ok.log"
more /usr/nmgxy/dir/dir.log | awk '{if($9=200) {print $1" "$2" "$3" "$4" "$6" "$7" "$8" "$9}}' >/usr/nmgxy/dir/ok.log
more /usr/nmgxy/dir/dir.log | awk '{if($9=500) {print $1" "$2" "$3" "$4" "$6" "$7" "$8" "$9}}' >>/usr/nmgxy/dir/ok.log
echo "���η�������"
awk '{print "����⵽��������ļ�ɨ��" NR"��"}' /usr/nmgxy/dir/dir.log|tail -n1
echo "��ʼͳ�������ļ�ɨ���¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/dir/dir.log |awk -F "[" '{print $1}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/dir/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/dir/top20.log
echo "ͳ�ƽ���"
echo -------------------------©������exp.log-------------------
echo "��ʼ��������©�����õĹ�����Ϊ���������������/usr/nmgxy/exp/Ŀ¼��"
more /usr/access*.* |egrep "struts|jmx-console|ajax_membergroup.php|iis.txt|phpMyAdmin|getWriter|dirContext|phpmyadmin|acunetix.txt|/e/|/SouthidcEditor/|/DatePicker/" >/usr/nmgxy/exp/exp.log
echo "��������"
awk '{print "����⵽©������" NR"��"}' /usr/nmgxy/exp/exp.log|tail -n1
echo "��ʼͳ��©�����ù����¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/exp/exp.log |awk -F "[" '{print $1}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/exp/top20.log
echo ---------------------------------------------------------------
cat /usr/nmgxy/exp/top20.log
echo "ͳ�ƽ���"
echo -------------------------�ļ�����LFI.log--------------------
echo "��ʼ�������������ļ�����©���Ĺ�����Ϊ���������������/usr/nmgxy/LFI/Ŀ¼��"
more /usr/access*.* |egrep "/passwd|%00|/win.ini|/my.ini|/MetaBase.xml|/ServUDaemon.ini|cmd.exe" >/usr/nmgxy/LFI/LFI.log
echo "��������"
echo "���η��������HTTP��Ӧ��Ϊ200��500���������Ϊ/usr/nmgxy/LFI/ok.log"
more /usr/nmgxy/LFI/LFI.log | awk '{if($9=200) {print $1" "$2" "$3" "$4" "$6" "$7" "$8" "$9}}' >/usr/nmgxy/LFI/ok.log
more /usr/nmgxy/LFI/LFI.log | awk '{if($9=500) {print $1" "$2" "$3" "$4" "$6" "$7" "$8" "$9}}' >>/usr/nmgxy/LFI/ok.log
echo "���η�������"
awk '{print "����⵽LFI�����ļ�����" NR"��"}' /usr/nmgxy/LFI/LFI.log|tail -n1
echo "��ʼͳ��©�����ù����¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/LFI/LFI.log |awk -F "[" '{print $1}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/LFI/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/LFI/top20.log
echo "ͳ�ƽ���"
echo -------------------------getshell-getshell.log----------------
echo "��ʼ��������getshell�Ĺ�����Ϊ���������������/usr/nmgxy/getshell/Ŀ¼��"
more /usr/access*.* |egrep " eval|%eval|%execute|%3binsert|%20makewebtaski%20|/div.asp|/1.asp|/1.jsp|/1.php|/1.aspx|xiaoma.jsp|tom.jsp|py.jsp|k8cmd.jsp|/k8cmd|ver007.jsp|ver008.jsp|ver007|ver008|%if|\.aar" >>/usr/nmgxy/getshell/getshell.log
echo "��������"
echo "���η��������HTTP��Ӧ��Ϊ200��500���������Ϊ/usr/nmgxy/getshell/ok.log"
more /usr/nmgxy/getshell/getshell.log | awk '{if($9=200) {print $1" "$2" "$3" "$4" "$6" "$7" "$8" "$9}}' >/usr/nmgxy/getshell/ok.log
more /usr/nmgxy/getshell/getshell.log | awk '{if($9=500) {print $1" "$2" "$3" "$4" "$6" "$7" "$8" "$9}}' >>/usr/nmgxy/getshell/ok.log
echo "���η�������"
awk '{print "����⵽getshell��Ϊ" NR "��"}' /usr/nmgxy/getshell/getshell.log|tail -n1
echo "��ʼͳ��©�����ù����¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/getshell/getshell.log |awk -F "[" '{print $1}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/getshell/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/getshell/top20.log
echo "ͳ�ƽ���"
echo -------------------------xss��վ�ű�����xss.log--------------------
echo "��ʼ��������XSS��վ�ű������Ĺ�����Ϊ���������������/usr/nmgxy/xss/Ŀ¼��"
more /usr/access*.* |egrep "<script|javascript| onerror| oneclick| onload|<img|alert|document|cookie" >/usr/nmgxy/xss/xss.log
echo "��������"
awk '{print "����⵽XSS��վ�ű�����" NR"��"}' /usr/nmgxy/xss/xss.log|tail -n1
echo "��ʼͳ��XSS��վ�ű������¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/xss/xss.log |awk -F "[" '{print $1}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/xss/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/xss/top20.log
echo "ͳ�ƽ���"
echo "��������ɣ��뵽/usr/nmgxy/Ŀ¼�²鿴���"
else
echo "IIS��־����"
echo --------------------ͳ�Ƴ��ִ�������ǰ20��IP��ַ-----------------
cat /usr/ex*.log |awk '{print $10}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/top20.log
echo "ͳ�����"
echo ------------------------SQLע�빥��sql.log----------------
echo "��ʼ��������SQLע��Ĺ�����Ϊ���������������/usr/nmgxy/sql/Ŀ¼��"
more /usr/ex*.log |egrep "%20select%20|%20and%201=1|%20and%201=2|%20where%20|%20union%20|%20SELECT%20|%2ctable_name%20|cmdshell|%20sysobjects|IS_SRVROLEMEMBER|%20is_srvrolemember|%20IS_MEMBER|db_owner|%20HAS_DBACCESS|%20has_dbaccess" >/usr/nmgxy/sql/sql.log
echo "��������"
awk '{print "����⵽SQLע�빥��" NR"��"}' /usr/nmgxy/sql/sql.log|tail -n1
echo "��ʼͳ��SQLע�빥���¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/sql/sql.log |awk '{print $10}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/sql/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/sql/top20.log
echo "ͳ�ƽ���"
echo -------------------------ɨ����scan.log-------------------
echo "��ʼ��������ɨ��Ĺ�����Ϊ���������������/usr/nmgxy/scan/Ŀ¼��"
more /usr/ex*.log |egrep "sqlmap|acunetix|Netsparker|nmap|HEAD" >/usr/nmgxy/scan/scan.log
echo "��������"
awk '{print "����⵽ɨ�蹥��" NR"��"}' /usr/nmgxy/scan/scan.log|tail -n1
echo "��ʼͳ��ɨ�蹥���¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/scan/scan.log |awk '{print $10}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/scan/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/scan/top20.log
echo "ͳ�ƽ���"
echo -------------------------�����ļ�ɨ��dir.log-------------------
echo "��ʼ��������ɨ��Ĺ�����Ϊ���������������/usr/nmgxy/dir/Ŀ¼��"
more /usr/ex*.log |egrep "\.rar|\.zip|\.mdb|\.inc|\.sql|\.config|\.bak|/login.inc.php|/.svn/|/mysql/|/config.inc.php|\.bak|wwwroot|��վ����|/gf_admin/|/DataBackup/|/Web.config|/web.config|/1.txt|/test.txt" >/usr/nmgxy/dir/dir.log
echo "��������"
echo "���η��������HTTP��Ӧ��Ϊ200��500���������Ϊ/usr/nmgxy/dir/ok.log"
more /usr/nmgxy/dir/dir.log | egrep " 200" >/usr/nmgxy/dir/ok.log
more /usr/nmgxy/dir/dir.log | egrep " 500" >>/usr/nmgxy/dir/ok.log
echo "���η�������"
awk '{print "����⵽��������ļ�ɨ��" NR"��"}' /usr/nmgxy/dir/dir.log|tail -n1
echo "��ʼͳ�������ļ�ɨ���¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/dir/dir.log |awk '{print $10}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/dir/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/dir/top20.log
echo "ͳ�ƽ���"
echo -------------------------©������exp.log-------------------
echo "��ʼ��������©�����õĹ�����Ϊ���������������/usr/nmgxy/exp/Ŀ¼��"
more /usr/ex*.log |egrep "/jeecms/|/web-console/|struts|/jmx-console/|ajax_membergroup.php|/iis.txt|phpMyAdmin|getWriter|dirContext|phpmyadmin|acunetix.txt|/e/|/SouthidcEditor/|/DatePicker/" >/usr/nmgxy/exp/exp.log
echo "��������"
awk '{print "����⵽©������" NR"��"}' /usr/nmgxy/exp/exp.log|tail -n1
echo "��ʼͳ��©�����ù����¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/exp/exp.log |awk '{print $10}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/exp/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/exp/top20.log
echo "ͳ�ƽ���"
echo -------------------------�ļ�����LFI.log--------------------
echo "��ʼ�������������ļ�����©���Ĺ�����Ϊ���������������/usr/nmgxy/LFI/Ŀ¼��"
more /usr/ex*.log |egrep "/passwd|%00|/win.ini|/my.ini|/MetaBase.xml|/ServUDaemon.ini" >/usr/nmgxy/LFI/LFI.log
echo "��������"
echo "���η��������HTTP��Ӧ��Ϊ200��500���������Ϊ/usr/nmgxy/LFI/ok.log"
more /usr/nmgxy/LFI/LFI.log | egrep " 200" >/usr/nmgxy/LFI/ok.log
more /usr/nmgxy/LFI/LFI.log | egrep " 500" >>/usr/nmgxy/LFI/ok.log
awk '{print "����⵽LFI�����ļ�����" NR"��"}' /usr/nmgxy/LFI/LFI.log|tail -n1
echo "���η�������"
echo "��ʼͳ��©�����ù����¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/LFI/LFI.log |awk '{print $10}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/LFI/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/LFI/top20.log
echo "ͳ�ƽ���"
echo -------------------------getshell-getshell.log----------------
echo "��ʼ��������getshell�Ĺ�����Ϊ���������������/usr/nmgxy/getshell/Ŀ¼��"
more /usr/ex*.log |egrep "%20exec|%27exec|%3bexec|%27%3Bexec|%eval|%20eval|%execute|%3Binsert|%20makewebtaski|%20disk%20|%3Balter|%3Bdeclare|dbo|hack523|sysname|/1.asp|/1.jsp|/1.php|/1.aspx|xiaoma.asp|yijuhua.asp|yjh.asp|hack.asp|k8cmd.jsp|/k8cmd|ver007.jsp|ver008.jsp|ver007|ver008|\.asa|\.cer|\.ashx|asp;|asa;" >>/usr/nmgxy/getshell/getshell.log
echo "��������"
echo "���η��������HTTP��Ӧ��Ϊ200��500���������Ϊ/usr/nmgxy/getshell/ok.log"
more /usr/nmgxy/getshell/getshell.log | egrep " 200" >/usr/nmgxy/getshell/ok.log
more /usr/nmgxy/getshell/getshell.log | egrep " 500" >>/usr/nmgxy/getshell/ok.log
echo "���η�������"
awk '{print "����⵽getshell��Ϊ" NR "��"}' /usr/nmgxy/getshell/getshell.log|tail -n1
echo "��ʼͳ��©�����ù����¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/getshell/getshell.log |awk '{print $10}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/getshell/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/getshell/top20.log
echo "ͳ�ƽ���"
echo -------------------------xss��վ�ű�����xss.log--------------------
echo "��ʼ��������XSS��վ�ű������Ĺ�����Ϊ���������������/usr/nmgxy/xss/Ŀ¼��"
more /usr/ex*.log |egrep "<script|javascript|%20onerror|%20oneclick|%20onload|<img|alert|document|cookie" >/usr/nmgxy/xss/xss.log
echo "��������"
awk '{print "����⵽XSS��վ�ű�����" NR"��"}' /usr/nmgxy/xss/xss.log|tail -n1
echo "��ʼͳ��XSS��վ�ű������¼��У�����Ƶ������ǰ20��IP��ַ"
cat /usr/nmgxy/xss/xss.log |awk '{print $10}' |sort |uniq -c |sort -rn |head -20 >/usr/nmgxy/xss/top20.log
echo ---------------------------------------------------------------
more /usr/nmgxy/xss/top20.log
echo "ͳ�ƽ���"
echo "��������ɣ��뵽/usr/nmgxy/Ŀ¼�²鿴���"
fi
echo "by �������"