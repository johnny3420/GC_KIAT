#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Bamaddrg" # Job name
#SBATCH --array=1-120
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=5 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-00:25:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
# This will be run once for a single process

/bin/hostname

source /home/johndavis/.bash_profile

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples.txt`

name=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples.txt | sed 's/\.paired\.star\.dir//' | sed 's/Sample_//'`

echo ${sample}
echo ${name}

cd ${sample}

Bamaddrg -b rmdup.bam -s ${name} -r ${name} > final.bam
