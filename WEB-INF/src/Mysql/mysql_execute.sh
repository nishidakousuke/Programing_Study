#!/bin/bash

mysql_dir="/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Mysql"

content=`cat ${mysql_dir}/mysql_code.txt`

# 作れるテーブルの数を制限する
TABLECREATECHECK=`echo ${content} | grep -i "create table" | wc -c`
if [ ${TABLECREATECHECK} -gt 0 ]; then
    TABLENUM=`mysql -h tomcat_test_mysql_1 -u user -puserpass programming -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'programming';" | sed -n 2p`
    if [ ${TABLENUM} -ge 5 ]; then
        echo "You cannot create more than five tables." > ${mysql_dir}/mysql_result3.txt
        touch ${mysql_dir}/exists_flag.txt
        exit
    fi
fi

# 入力されたsql構文を実行してファイルに保存する
mysql -h tomcat_test_mysql_1 -u user -puserpass programming -e "${content}" >& ${mysql_dir}/mysql_result.txt
# column -t コマンドにより、出力結果を成形する。
column -t ${mysql_dir}/mysql_result.txt > ${mysql_dir}/mysql_result2.txt
# HTMLで表示させると改行がなくなるため、-zオプションにより\nを<br>に変換
sed -z 's/\n/<br>/g' ${mysql_dir}/mysql_result2.txt > ${mysql_dir}/mysql_result3.txt

#テーブル情報を表示させるための指示
mysql -h tomcat_test_mysql_1 -u user -puserpass programming -e "select * from item;" >& ${mysql_dir}/table_show.txt
# column -t コマンドにより、出力結果を成形する。
column -t ${mysql_dir}/table_show.txt > ${mysql_dir}/table_show2.txt
# HTML表示用の改行をつける
sed -z 's/\n/<br>/g' ${mysql_dir}/table_show2.txt > ${mysql_dir}/table_show3.txt

#現在存在するテーブル名をファイルに保存する
mysql -h tomcat_test_mysql_1 -u user -puserpass programming -e "show tables" >& ${mysql_dir}/table_contents.txt
#1行目は不要な記述のため削除する
sed '1d' ${mysql_dir}/table_contents.txt > ${mysql_dir}/table_contents2.txt

touch ${mysql_dir}/exists_flag.txt
