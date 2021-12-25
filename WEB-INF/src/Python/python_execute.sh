#!/bin/bash

python_dir="/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Python"

python3 ${python_dir}/sample.py >& ${python_dir}/python_result1.txt

sed 's/\/usr\/local\/tomcat\/webapps\/Programing_Study\/WEB-INF\/src\/Python\/sample.py/sample.py/g' ${python_dir}/python_result1.txt > ${python_dir}/python_result2.txt

touch ${python_dir}/exists_flag.txt
