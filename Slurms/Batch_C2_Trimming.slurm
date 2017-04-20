#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Trimmomatic Array" # Job name
#SBATCH --array=1-26
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-05:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL

/bin/hostname

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" C2_samples.txt`

source ~/.bash_profile

cd /share/malooflab/John/KIAT/Fastqs/F2_Batch_C_Trimmed/Sample_${sample}

trimmomatic.sh PE -threads 10 /share/malooflab/Fastqs/KIAT/F2/Batch_C/Sample_${sample}/${sample}_1.fq.gz /share/malooflab/Fastqs/KIAT/F2/Batch_C/Sample_${sample}/${sample}_2.fq.gz ${sample}_1.paired.fq.gz ${sample}_1.unpaired.fq.gz ${sample}_2.paired.fq.gz ${sample}_2.unpaired.fq.gz ILLUMINACLIP:/share/malooflab/John/KIAT/Reference/Bradseq_adapter.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
