#!/bin/bash
#SBATCH --partition=gc256 # partition to submit to
#SBATCH --job-name="Da_Ae_Trinity" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=30 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=220000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=10-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Da_Ae_Trinity_02_02_2017.out # STDOUT
#SBATCH --error=Da_Ae_Trinity_02_02_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
/bin/hostname

start=`date +%s`

# Load Trinity Module

module load trinity/2.3.2
module unload java/jdk1.7.0_75
module load java/jdk1.8
module load bowtie2/2.2.8

# Run Trinity

Trinity --seqType fq --samples_file /share/malooflab/John/KIAT/Trinity_Runs/Da_Ae_Samples.tab --SS_lib_type FR --max_memory 200G --CPU 30 --output /share/malooflab/John/KIAT/Trinity_Runs/trinity_out_unmapped_Da_Ae

end=`date +%s`
runtime=$((end-start))
echo $runtime

echo Done
