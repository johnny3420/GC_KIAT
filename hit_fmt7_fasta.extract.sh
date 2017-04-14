#!/bin/bash

module load kentutils/308

grep -B 3 "# [1-9][0-9]* hits found" ${1} | grep "# Query" | sed 's/# Query:\s//' | sed 's/\s.*//' > no_hits_temp.txt

faSomeRecords ${2} no_hits_temp.txt ${3}

rm no_hits_temp.txt

echo "Zero hit fasta file created"
