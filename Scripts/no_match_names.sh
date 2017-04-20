#!/bin/bash

names=`ls *Blast`

for name in ${names}
do
grep -B 3 "# 0 hits found" ${name} | grep "# Query" | sed 's/#\sQuery:\s//' > No_Match_Contigs/Zero_Hit_${name}
done
