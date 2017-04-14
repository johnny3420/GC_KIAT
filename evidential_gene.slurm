#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Da_Ol_1_Trinity_Cleanup" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=51000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-01:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Da_Ol_1_Trinity_Cleanup_02_13_2017.out # STDOUT
#SBATCH --error=Da_Ol_1_Trinity_Cleanup_02_13_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL
# This will be run once for a single process

/bin/hostname

start=`date +%s`

cd /share/malooflab/John/KIAT/Trinity_Analysis/Trinity_Cleanup/Da_Ol_1/

source ~/.bash_profile
module load cdhit/4.6.1
module load blast/2.6.0+

~/Bioinformatic_Packages/evigene/scripts/rnaseq/trformat.pl -format=trinity -input /share/malooflab/John/KIAT/Trinity_Runs/trinity_out_unmapped_Da_Ol_1/Trinity.fasta > /share/malooflab/John/KIAT/Trinity_Analysis/Trinity_Cleanup/Da_Ol_1/R_Da_Ol_1_Trinity.fasta

~/Bioinformatic_Packages/evigene/scripts/prot/tr2aacds.pl -NCPU 10 -MAXMEM 50000 -logfile -tidyup -mrnaseq /share/malooflab/John/KIAT/Trinity_Analysis/Trinity_Cleanup/Da_Ol_1/R_Da_Ol_1_Trinity.fasta

end=`date +%s`
runtime=$((end-start))
echo Done after $runtime seconds
