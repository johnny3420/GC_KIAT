#!/bin/bash
#SBATCH --partition=gc512 # partition to submit to
#SBATCH --job-name="Supernova" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=45 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=510000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=15-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=supernova_4_20_2017.out # STDOUT
#SBATCH --error=supernova_4_20_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL
# This will be run once for a single process

/bin/hostname

start=`date +%s`

# Load modules

source ~/.bash_profile

# Go to Directory

cd /share/malooflab/John/KIAT/Supernova

# Run Programs

sample=/share/malooflab/Fastqs/KIAT/10X/Data/3pm3dzuw7c/Unaligned10X/Project_RMRM_L1_Bnapus1_soni

supernova run \
	--sample Bnapus1_soni \
	--id Bnapus1_soni \
	--fastqs ${sample} \
	--localcores 45 \
	--localmem 500000

# Run Stats

end=`date +%s`
runtime=$((end-start))
echo Done after $runtime seconds
