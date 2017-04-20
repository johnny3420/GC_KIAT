#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="CAP3" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=50000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-10:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=CAP3_2_28_2017.out # File to which STDOUT will be written
#SBATCH --error=CAP3_2_28_2017.err # File to which STDERR will be written
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL
# This will be run once for a single process

/bin/hostname

source /home/johndavis/.bash_profile

cap3 /share/malooflab/John/KIAT/CAP3/Da_Ae_Trinity.fasta

cap3 /share/malooflab/John/KIAT/CAP3/Da_Ol_1_Trinity.fasta
