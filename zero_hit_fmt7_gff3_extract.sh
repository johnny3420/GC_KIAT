#!/bin/bash

module load kentutils/308

grep -o "evg.*" ${1} | sed 's/::.*//g' > no_hits_temp.txt
grep -f no_hits_temp.txt ${2} > ${3}

rm no_hits_temp.txt

echo ${3} created
