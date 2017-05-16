#!/bin/bash
#SBATCH --partition=gc512 # partition to submit to
#SBATCH --job-name="Supernova" # Job name
#SBATCH --array=1-2
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=45 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=510000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=4-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=supernova_%a_5_04_2017.out # STDOUT
#SBATCH --error=supernova_%a_5_04_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL
# This will be run once for a single process

/bin/hostname

start=`date +%s`

# Load modules

source ~/.bash_profile

# Go to Directory

cd /share/malooflab/John/KIAT/Supernova/Bnapus1_2_soni


# Identify array

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

# Run Programs

sample=/share/malooflab/Fastqs/KIAT/10X/Davis_Sonic/Supernova_mkfastq

supernova run \
	--sample Split_Bnapus1-$SLURM_ARRAY_TASK_ID \
	--id Split_Bnapus1-$SLURM_ARRAY_TASK_ID \
	--fastqs ${sample} \
	--localcores 45 \
	--localmem 500000

# Run Stats

end=`date +%s`
runtime=$((end-start))
echo Done after $runtime seconds
