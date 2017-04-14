#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=51000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-08:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=your.out # STDOUT
#SBATCH --error=you.err # STDERR
#SBATCH --mail-user=yourname@ucdavis.edu
#SBATCH --mail-type=ALL
# This will be run once for a single process

/bin/hostname

start=`date +%s`

# Load modules

# Run Programs

# Run Stats

end=`date +%s`
runtime=$((end-start))
echo Done after $runtime seconds
