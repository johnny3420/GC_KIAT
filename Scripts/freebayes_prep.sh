#!/bin/bash

source /home/johndavis/.bash_profile

module load samtools/1.3

samtools view -b -@ 5 -q255 Aligned.sortedByCoord.out.bam > Unique.sorted.bam

samtools rmdup -s Unique.sorted.bam rmdup.bam

bamaddrg -b rmdup.bam -s Combined -r Combined > final.bam

samtools index final.bam

chmod 555 final.bam

chmod 555 final.bam.bai
