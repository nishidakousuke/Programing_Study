#!/bin/bash

mysql_dir="/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql"
TABLENAME=$1

#現在存在するテーブル名をファイルに保存する
mysql -h tomcat_test_mysql_1 -u root -prootpass programming -e "show tables" >& ${mysql_dir}/table_contents.txt
#1行目は不要な記述のため削除する
sed '1d' ${mysql_dir}/table_contents.txt > ${mysql_dir}/table_contents2.txt

FRONTABLENAME=`head -n 1 ${mysql_dir}/table_contents2.txt`

#テーブル情報を表示させるための指示。sql実行画面にリンクから飛んできた場合と、テーブル名をクリックして表示している場合とで分岐処理
if test -z $TABLENAME; then
  mysql -h tomcat_test_mysql_1 -u root -prootpass programming -e "select * from ${FRONTABLENAME};" >& ${mysql_dir}/table_show.txt
else
  mysql -h tomcat_test_mysql_1 -u root -prootpass programming -e "select * from ${TABLENAME};" >& ${mysql_dir}/table_show.txt
fi

# column -t コマンドにより、出力結果を成形する。
column -t ${mysql_dir}/table_show.txt > ${mysql_dir}/table_show2.txt
# HTML表示用の改行をつける
sed -z 's/\n/<br>/g' ${mysql_dir}/table_show2.txt > ${mysql_dir}/table_show3.txt


touch ${mysql_dir}/exists_flag.txt
