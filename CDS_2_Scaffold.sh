#! /bin/bash

file=${1}
name=${2}

echo ">${name}" > ${name}.fa

grep -v "^>" ${file} | tr -d '\n' | sed 's/\([A-Z]\{60\}\)/\1\n/g' >> ${name}.fa
