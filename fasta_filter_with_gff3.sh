#!/bin/bash

module load kentutils/308

grep "mRNA" ${1} | awk '{print $9}' | sed 's/ID=//' | sed 's/;.*//' | sort | uniq > temp.1

faSomeRecords ${2} temp.1 ${3}

rm temp.1

echo Process Complete
