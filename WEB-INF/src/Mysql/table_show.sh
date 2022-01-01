#!/bin/bash

mysql_dir="/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql"

#テーブル情報を表示させるための指示
mysql -h tomcat_test_mysql_1 -u root -prootpass programming -e "select * from item;" >& ${mysql_dir}/table_show.txt
sed -z 's/\n/<br>/g' ${mysql_dir}/table_show.txt > ${mysql_dir}/table_show2.txt

touch ${mysql_dir}/exists_flag.txt
