#!/bin/bash

PROGRAMLANGUAGE=$1
ruby_dir="/usr/local/tomcat/webapps/Programing_Study/WEB-INF/src/Ruby"

# sed "s/require 'sample2.rb'/require '\/usr\/local\/tomcat\/webapps\/Programing_Study\/WEB-INF\/src\/Ruby\/sample2.rb'/g" ${ruby_dir}/sample1.rb > ${ruby_dir}/sample1a.rb

if [ ${PROGRAMLANGUAGE} = "c" ]; then
    cp ${ruby_dir}/sample1 ${ruby_dir}/sample1.c
    gcc -o ${ruby_dir}/sample ${ruby_dir}/sample1.c >& ${ruby_dir}/gcc_output.txt
    if [ $? = 0 ]; then
        ${ruby_dir}/sample >& ${ruby_dir}/ruby_result1.txt
    else
        cat ${ruby_dir}/gcc_output.txt > ${ruby_dir}/ruby_result1.txt
    fi
elif [ ${PROGRAMLANGUAGE} = "java" ]; then
    cp ${ruby_dir}/sample1 ${ruby_dir}/Sample1.java
    javac ${ruby_dir}/Sample1.java >& ${ruby_dir}/javac_output.txt
    if [ $? = 0 ]; then
        java -classpath ${ruby_dir} Sample1 > ${ruby_dir}/ruby_result1.txt
    else
        cat ${ruby_dir}/javac_output.txt > ${ruby_dir}/ruby_result1.txt
    fi
else
    ${PROGRAMLANGUAGE} ${ruby_dir}/sample1 >& ${ruby_dir}/ruby_result1.txt
fi

sed 's/\/usr\/local\/tomcat\/webapps\/Programing_Study\/WEB-INF\/src\/Ruby\/sample1a.rb/sample1.rb/g' ${ruby_dir}/ruby_result1.txt > ${ruby_dir}/ruby_result2.txt
sed -z 's/\n/<br>/g' ${ruby_dir}/ruby_result2.txt > ${ruby_dir}/ruby_result3.txt

touch ${ruby_dir}/exists_flag.txt
