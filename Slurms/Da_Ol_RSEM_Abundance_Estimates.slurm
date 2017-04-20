#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Da_Ol_1_Abundance" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=1-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Da_Ol_1_Abundance_02_13_2017.out # STDOUT
#SBATCH --error=Da_Ol_1_Abundance_02_13_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
/bin/hostname

start=`date +%s`

cd /share/malooflab/John/KIAT/Trinity_Analysis/Abundance_Estimations/Da_Ol_1/RSEM

# Load Modules

module load trinity/2.3.2
module unload java/jdk1.7.0_75
module load java/jdk1.8
module load bowtie/1.1.2
module load rsem/1.2.28
module load samtools/1.3

# Run Contig Nx Stats

/software/trinityrnaseq/2.3.2/x86_64-linux-ubuntu14.04/util/TrinityStats.pl /share/malooflab/John/KIAT/Trinity_Analysis/Raw_Trinity/Da_Ol_1_Trinity.fasta > ../Da_Ol_1_Nx_Stats.txt

# Run Transcript abundance

/software/trinityrnaseq/2.3.2/x86_64-linux-ubuntu14.04/util/align_and_estimate_abundance.pl --transcripts /share/malooflab/John/KIAT/Trinity_Analysis/Raw_Trinity/Da_Ol_1_Trinity.fasta --seqType fq --samples_file /share/malooflab/John/KIAT/Trinity_Runs/Da_Ol_1_Samples.tab --est_method RSEM --aln_method bowtie --trinity_mode --prep_reference --SS_lib_type FR --output_dir Da_Ol_1_rsem_outdir

end=`date +%s`
runtime=$((end-start))

echo $runtime
