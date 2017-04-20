#!/bin/bash

module load transdecoder/3.0.0

TransDecoder.Predict -t Da_Ae_Zero_Hits.fasta --retain_blastp_hits Da_Ae_Pep_Blast.outfmt6
