#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Test3_Freebayes" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Test3_Freebayes.out # STDOUT
#SBATCH --error=Test3_Freebayes.err # STDERR
# This will be run once for a single process

/bin/hostname

start=`date +%s`

module load freebayes/v1.0.2-33-gdbb6160

bams=`ls */final.bam`

echo $bams

freebayes -f /share/malooflab/John/KIAT/Reference/Split_Chroms/chrA01.fa ${bams} > /share/malooflab/John/KIAT/Freebayes/F2/test3_chr1.vcf

end=`date +%s`
runtime=$((end-start))
echo $runtime seconds to completion
