#!/bin/bash

ruby_dir="/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby"

ruby ${ruby_dir}/ruby_source-code.sh >& ${ruby_dir}/ruby_result1.txt

sed 's/\/usr\/local\/tomcat\/webapps\/Programing_Study\/WEB-INF\/src\/Ruby\/ruby_source-code.sh/sample.rb/g' ${ruby_dir}/ruby_result1.txt > ${ruby_dir}/ruby_result2.txt

touch ${ruby_dir}/exists_flag.txt
