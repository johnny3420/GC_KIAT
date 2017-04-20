#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Cleaned_Da_Ol_1_Abundance" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-01:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Cleaned_Da_Ae_Abundance_02_10_2017.out # STDOUT
#SBATCH --error=Cleaned_Da_Ae_Abundance_02_10_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
/bin/hostname

start=`date +%s`

cd /share/malooflab/John/KIAT/Trinity_Analysis/Abundance_Estimations/Da_Ol_1_Cleaned/Kallisto

# Load Modules

module load trinity/2.3.2
module unload java/jdk1.7.0_75
module load java/jdk1.8
module load kallisto/0.42.2.1
module load samtools/1.3

# Run Transcript abundance

/software/trinityrnaseq/2.3.2/x86_64-linux-ubuntu14.04/util/align_and_estimate_abundance.pl --transcripts /share/malooflab/John/KIAT/Trinity_Analysis/Trinity_Cleanup/Da_Ol_1/Cleaned_Da_Ol_1_Trinity.fasta --seqType fq --samples_file /share/malooflab/John/KIAT/Trinity_Runs/Da_Ol_1_Samples.tab --est_method kallisto --trinity_mode --prep_reference --thread_count 20 --output_dir Cleaned_Da_Ol_1_kallisto_outdir

end=`date +%s`
runtime=$((end-start))

echo $runtime
