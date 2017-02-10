#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“File_Conversion” # Job name
#SBATCH --array=1-120
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=50000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-00:11:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
# This will be run once for a single process

/bin/hostname

module load samtools/1.3

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples.txt`

echo ${sample}

cd ${sample}

samtools view -b -@ 10 Aligned.out.sam | samtools sort -m 4G -@ 10 > Sorted.aligned.out.bam && rm Aligned.out.sam && echo sorted bam file created and sam file removed
