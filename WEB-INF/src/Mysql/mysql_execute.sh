#!/bin/bash

mysql_dir="/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql"

content=`cat ${mysql_dir}/mysql_code.txt`
# 入力されたsql構文を実行してファイルに保存する
mysql -h tomcat_test_mysql_1 -u root -prootpass programming -e "${content}" >& ${mysql_dir}/mysql_result.txt
# column -t コマンドにより、出力結果を成形する。
column -t ${mysql_dir}/mysql_result.txt > ${mysql_dir}/mysql_result2.txt
# HTMLで表示させると改行がなくなるため、-zオプションにより\nを<br>に変換
sed -z 's/\n/<br>/g' ${mysql_dir}/mysql_result2.txt > ${mysql_dir}/mysql_result3.txt

#テーブル情報を表示させるための指示
mysql -h tomcat_test_mysql_1 -u root -prootpass programming -e "select * from item;" >& ${mysql_dir}/table_show.txt
# column -t コマンドにより、出力結果を成形する。
column -t ${mysql_dir}/table_show.txt > ${mysql_dir}/table_show2.txt
# HTML表示用の改行をつける
sed -z 's/\n/<br>/g' ${mysql_dir}/table_show2.txt > ${mysql_dir}/table_show3.txt

touch ${mysql_dir}/exists_flag.txt
