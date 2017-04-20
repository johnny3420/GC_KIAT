#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="F2_Array_Freebayes" # Job name
#SBATCH --array=1-10
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=4-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules

module load freebayes/v1.0.2-33-gdbb6160
module load samtools/1.3
module load freebayes/v1.0.2-33-gdbb6160
module load samtools/1.3


## Identify each array run
cd /share/malooflab/John/KIAT/F2_Star_Runs/Star_Runs

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
chrom=`sed "${SLURM_ARRAY_TASK_ID}q;d" failed.chrom.list.txt`

bams=`ls *.paired.star.dir/Split_Bams/${chrom}.bam`

echo ${chrom}
echo ${bams}

module load freebayes/v1.0.2-33-gdbb6160

freebayes --genotype-qualities -f /share/malooflab/John/KIAT/Reference/Split_Chroms/${chrom}.fa ${bams} > /share/malooflab/John/KIAT/Freebayes/F2_Complete_With_GQ/${chrom}.vcf

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
