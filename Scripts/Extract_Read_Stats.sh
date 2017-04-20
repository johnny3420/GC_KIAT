#!/bin/bash

samples=`ls -d Sample* | sed 's/Sample_//'`

echo "Sample Before After" > Trimmomatic_Summary.txt

for sample in ${samples}
	do
	Before=`grep -o "Pairs: [0-9]*" Sample_${sample}/stats | sed 's/Pairs:\s//'`
	After=`grep -o "Both Surviving: [0-9]*" Sample_${sample}/stats | sed 's/Both\sSurviving:\s//'`
	echo ${sample} ${Before} ${After} >> Trimmomatic_Summary.txt
	done
