#! /bin/bash

grep -v "Cluster: Bna" ${1} | grep -v "yourlist" | awk '{print $2}' > temp.1
grep -f temp.1 ${2} | awk '{print $1}' | sed 's/::m\..*$//' > temp.2
grep -f temp.2 ${3} > ${4}

rm temp.1 temp.2

echo Complete
