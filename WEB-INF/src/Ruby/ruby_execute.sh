#!/bin/bash

ruby_dir="/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby"

sed "s/require 'sample2.rb'/require '\/usr\/local\/tomcat\/webapps\/Programing_Study\/WEB-INF\/src\/Ruby\/sample2.rb'/g" ${ruby_dir}/sample1.rb > ${ruby_dir}/sample1a.rb

ruby ${ruby_dir}/sample1a.rb >& ${ruby_dir}/ruby_result1.txt

sed 's/\/usr\/local\/tomcat\/webapps\/Programing_Study\/WEB-INF\/src\/Ruby\/sample1a.rb/sample1.rb/g' ${ruby_dir}/ruby_result1.txt > ${ruby_dir}/ruby_result2.txt

touch ${ruby_dir}/exists_flag.txt
