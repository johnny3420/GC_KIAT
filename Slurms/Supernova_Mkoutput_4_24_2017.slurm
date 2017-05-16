#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Supernova" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=50000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-01:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=supernova_mkoutput_4_24_2017.out # STDOUT
#SBATCH --error=supernova_mkoutput_4_24_2017.err # STDERR
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


supernova mkoutput \
	--asmdir=/share/malooflab/John/KIAT/Supernova/Bnapus1_soni/outs/assembly \
	--outprefix=Bnapus1_soni \
	--style=pseudohap2

# Run Stats

end=`date +%s`
runtime=$((end-start))
echo Done after $runtime seconds
