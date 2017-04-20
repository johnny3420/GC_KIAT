#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“Compression” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=5 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-6:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Small.Compression.out # STDOUT
#SBATCH --error=Small.Compression.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL

cd /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs

gzip small*
