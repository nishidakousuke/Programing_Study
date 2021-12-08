#!/bin/bash

c_dir="/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/C"

gcc -o ${c_dir}/sample ${c_dir}/c_source-code.c >& ${c_dir}/gcc_output.txt

if [ $? = 0 ]; then
  ${c_dir}/sample >& ${c_dir}/c_result1.txt
else
  cat ${c_dir}/gcc_output.txt > ${c_dir}/c_result1.txt
fi

#sed 's/\/usr\/local\/tomcat\/webapps\/Programing_Study\/WEB-INF\/src\/Ruby\/ruby_source-code.sh/sample.rb/g' ${ruby_dir}/ruby_result1.txt > ${ruby_dir}/ruby_result2.txt

touch ${c_dir}/exists_flag.txt
