#!/bin/bash

cd /Network/Servers/avalanche.plb.ucdavis.edu/Volumes/Mammoth/Users/johndavis/KIAT/De_novo_Assembly/Trinity_Analysis/Da-Ol-1/Read_Content/transcript_abundance/kallisto

../align_and_estimate_abundance.pl --transcripts ../../../Fastas/Da-Ol-1.Unmapped.Trinity.fasta --seqType fq --samples_file ../samples_file.tab --est_method kallisto --trinity_mode

echo DONE
