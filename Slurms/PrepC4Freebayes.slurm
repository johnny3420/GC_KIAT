#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Prep4FreeBayes" # Job name
#SBATCH --array=1-46
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=5 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-01:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob.%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob.%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

source /home/johndavis/.bash_profile
source /home/johndavis/.bash_profile

module load samtools/1.3
module load samtools/1.3

cd /share/malooflab/John/KIAT/F2_Star_Runs/Star_Runs

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" batch_C_samples.txt`

echo ${sample}

cd Sample_138-${sample}.paired.star.dir

samtools view -b -@ 5 -q255 Aligned.sortedByCoord.out.bam > Unique.sorted.bam &&
samtools rmdup -s Unique.sorted.bam rmdup.bam &&
bamaddrg -b rmdup.bam -s 138-${sample} -r 138-${sample} > final.bam &&
samtools index final.bam &&
chmod 555 final.bam &&
chmod 555 final.bam.bai &&

echo ${sample} is complete
