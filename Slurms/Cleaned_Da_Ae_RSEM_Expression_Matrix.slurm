#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Cleaned_Da_Ae_Expression_Matrix" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-00:01:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Cleaned_Da_Ae_Exp_Matrix_02_13_2017.out # STDOUT
#SBATCH --error=Cleaned_Da_Ae_Exp_Matrix_02_13_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
/bin/hostname

start=`date +%s`

cd /share/malooflab/John/KIAT/Trinity_Analysis/Abundance_Estimations/Da_Ae_Cleaned/RSEM

# Load Modules

module load R/latest
module load trinity/2.3.2
module unload java/jdk1.7.0_75
module load java/jdk1.8
module load bowtie/1.1.2
module load rsem/1.2.28
module load samtools/1.3

# Build Matrix

/software/trinityrnaseq/2.3.2/x86_64-linux-ubuntu14.04/util/abundance_estimates_to_matrix.pl --est_method RSEM --name_sample_by_basedir --out_prefix trans_counts Bolting_Ae_Chu_2/RSEM.isoforms.results Flowering_Ae_Gae_2/RSEM.isoforms.results Early-Silique_05-11-Final-8ul/RSEM.isoforms.results Early-Silique_Ae_Cho_2/RSEM.isoforms.results Early-Silique_Ae_Cho_3/RSEM.isoforms.results Flowering_6/RSEM.isoforms.results Flowering_Ae_Gae_3/RSEM.isoforms.results Late-Silique_8/RSEM.isoforms.results Late-Silique_Ae_Hu_2/RSEM.isoforms.results Late-Silique_Ae_Hu_3/RSEM.isoforms.results Young_5/RSEM.isoforms.results Young_Ae_Yeong_2/RSEM.isoforms.results Young_Ae_Yeong_3/RSEM.isoforms.results
