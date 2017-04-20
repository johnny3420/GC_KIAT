#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Blastx_Array" # Job name
#SBATCH --array=1-14
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL
# This will be run once for a single process

/bin/hostname

module load blast/2.6.0+

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" names.txt`

echo ${sample}
cd ${sample}

files=`ls *_0*`

for file in ${files}
	do
	blastx -max_target_seqs 1 -evalue 1e-6 -db /share/malooflab/nr/nr -query ${file} -outfmt 6 -num_threads 20 >> ${sample}.BLAST
	done
