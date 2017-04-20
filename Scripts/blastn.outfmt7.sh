#!/bin/bash

module load blast/2.6.0+

blastn -query /share/malooflab/John/KIAT/De_novo_Assembly/Custom_Reference/Raw_Reference/Da_Ae_New.cds -db /share/malooflab/John/KIAT/Reference/Brassica_napus_v4.1.chromosomes.fa -perc_identity 99 -max_target_seqs 1 -outfmt 7 -num_threads 5 -out Da_Ae_blastn.outfmt7.tab -evalue 1e-6

blastn -query /share/malooflab/John/KIAT/De_novo_Assembly/Custom_Reference/Raw_Reference/Da_Ol_1_New.cds -db /share/malooflab/John/KIAT/Reference/Brassica_napus_v4.1.chromosomes.fa -perc_identity 99 -max_target_seqs 1 -outfmt 7 -num_threads 5 -out Da_Ol_1_blastn.outfmt7.tab -evalue 1e-6

echo Complete
