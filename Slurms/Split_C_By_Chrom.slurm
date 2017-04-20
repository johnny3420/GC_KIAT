#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Bam_Split" # Job name
#SBATCH --array=1-41
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=2 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=10000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-00:02:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules

module load samtools/1.3
module load samtools/1.3

## Identify each array run

cd /share/malooflab/John/KIAT/F2_Star_Runs/Star_Runs

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
chrom=`sed "${SLURM_ARRAY_TASK_ID}q;d" chrom_list`

bams=`cat batch_C_samples.txt`

echo ${chrom}
echo ${bams}

## Extract reads from bam files for specific chromosome

for sample in ${bams}
	do
	mkdir Sample_138-${sample}.paired.star.dir/Split_Bams
	samtools view -@ 2 -b Sample_138-${sample}.paired.star.dir/final.bam ${chrom} > Sample_138-${sample}.paired.star.dir/Split_Bams/${chrom}.bam
	samtools index Sample_138-${sample}.paired.star.dir/Split_Bams/${chrom}.bam
	done

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
