#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="ChrCnn_Freebayes" # Job name
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=200000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=6-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=chrCnn_Freebayes.out # File to which STDOUT will be written
#SBATCH --error=chrCnn_Freebayes.err # File to which STDERR will be written
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

bams=`ls *.paired.star.dir/Split_Bams/chrCnn_random.bam`

echo ${bams}

module load freebayes/v1.0.2-33-gdbb6160

freebayes --genotype-qualities -f /share/malooflab/John/KIAT/Reference/Split_Chroms/chrCnn_random.fa ${bams} > /share/malooflab/John/KIAT/Freebayes/F2_Complete_With_GQ/chrCnn_random.vcf

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
