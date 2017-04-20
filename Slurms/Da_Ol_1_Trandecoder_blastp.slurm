#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Da_Ol_1_Blast" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=50000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Da_Ol_1_Blast_03_28_2017.out # STDOUT
#SBATCH --error=Da_Ol_1_Blast_03_28_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
/bin/hostname

start=`date +%s`

# Load Blast Module

module load blast/2.6.0+
module load blast/2.6.0+

cd /share/malooflab/John/KIAT/De_novo_Assembly/Transdecoder_Da_Ol_1

#Run Blast

blastp  -query Da_Ol_1_Zero_Hits.fasta.transdecoder_dir/longest_orfs.pep \
	-db /share/malooflab/Uniprot/uniref90.fasta \
	-max_target_seqs 1 \
	-outfmt 6 \
	-evalue 1e-6 \
	-num_threads 20 \
	> Da_Ol_1_Pep_Blast.outfmt6

end=`date +%s`
runtime=$((end-start))
echo $runtime

echo Done

