#!/bin/bash

module load transdecoder/3.0.0

TransDecoder.Predict -t Da_Ol_1_Zero_Hits.fasta --retain_blastp_hits Da_Ol_1_Pep_Blast.outfmt6
