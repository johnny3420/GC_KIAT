#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“Rmdup” # Job name
#SBATCH --array=1-120
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=5 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-00:15:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
# This will be run once for a single process

/bin/hostname

module load samtools/1.3

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples.txt`

echo ${sample}

cd ${sample}

samtools rmdup -s Unique.sorted.bam rmdup.bam
