#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Compression" # Job name
#SBATCH --array=1-42
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=2 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=5000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-01:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=compression.out # File to which STDOUT will be written
#SBATCH --error=compression.err # File to which STDERR will be written
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL

# This will be run once for a single process

/bin/hostname

start=`date +%s`

## Load required modules

cd /share/malooflab/John/KIAT/Freebayes/F2_Complete_With_GQ

## Identify each array run

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
variable=`sed "${SLURM_ARRAY_TASK_ID}q;d" names.txt`

# Run program

gzip ${variable}

# Run stats

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
