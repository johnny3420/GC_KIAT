#!/bin/bash

echo Collecing names of all directories which end in .star.dir

files=`ls -d *.star.dir`
#echo $files
echo `wc -w <<< $files` Directories found
set -- $files
awk '{print $1}' $1/ReadsPerGene.out.tab | sed '1i\\'  > Star_Gene_Counts.tab

for i in $files
    do
    echo Extracting mapping stats from ReadsPerGene.out.tab file in ${i}
    if [ -f ${i}/ReadsPerGene.out.tab ]
        then
		echo ${i} | sed 's/\.star\.dir//' > gene.temp
		awk '{print $2}' ${i}/ReadsPerGene.out.tab >> gene.temp
		paste Star_Gene_Counts.tab gene.temp > total.temp
		mv total.temp Star_Gene_Counts.tab
    else
        echo Error, ReadsPerGene.out.tab not found in ${i}
    fi
done

rm gene.temp
echo Star_Gene_Counts.tab has been created
