#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Da_Ae_Blast" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=50000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Da_Ae_Blast_03_28_2017.out # STDOUT
#SBATCH --error=Da_Ae_Blast_03_28_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
/bin/hostname

start=`date +%s`

# Load Blast Module

module load blast/2.6.0+
module load blast/2.6.0+

# Enter directory

cd /share/malooflab/John/KIAT/De_novo_Assembly/Blast_Da_Ae

# Run Blast

blastn -query Da_Ae.fasta -db /share/malooflab/John/KIAT/Reference/Brassica_napus.annotation_v5.cds.fa -perc_identity 90 -max_target_seqs 1 -outfmt 7 -num_threads 20 -out Da_Ae_blast.tab -evalue 1e-6

end=`date +%s`
runtime=$((end-start))
echo $runtime

echo Done
