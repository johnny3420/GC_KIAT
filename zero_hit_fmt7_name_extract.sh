#! /bin/bash

file=${1}

grep -B 2 "# 0 hits found" ${file} | grep "# Query" | sed 's/# Query:\s//' > Zero_Hit_Names.txt
