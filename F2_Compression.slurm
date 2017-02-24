#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="File_Compression" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=40000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=File_Compression.out # STDOUT
#SBATCH --error=File_Compression.err # STDERR
# This will be run once for a single process

/bin/hostname

cd /share/malooflab/John/KIAT/F2_Star_Runs/Paired_End

names=`ls -d *.paired.star.dir`

for i in $names; do gzip -v ${i}/Unmapped.out.mate1; gzip -v ${i}/Unmapped.out.mate2; done
