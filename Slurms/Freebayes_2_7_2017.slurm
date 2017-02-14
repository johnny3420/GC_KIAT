#!/bin/bash
#SBATCH --partition=gc256 # partition to submit to
#SBATCH --job-name="F2_Freebayes" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=30 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=220000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=7-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Freebayes_2_7_2017.out # STDOUT
#SBATCH --error=Freebayes_2_7_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu
# This will be run once for a single process

/bin/hostname

start=`date +%s`

module load freebayes/v1.0.2-33-gdbb6160

bams=`ls */final.bam`

echo $bams

freebayes -f /share/malooflab/John/KIAT/Reference/Brassica_napus_v4.1.chromosomes.fa ${bams} > /share/malooflab/John/KIAT/Freebayes/F2/F2_Freebayes.vcf

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
