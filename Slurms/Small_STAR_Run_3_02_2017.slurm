#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“F2_Star_Run” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-06:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Small_Star_Run_3_01_2017.out # STDOUT
#SBATCH --error=Small_Star_Run_3_01_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL
# This will be run once for a single process
/bin/hostname

# Load STAR Module 2.5.2b

module load star/2.5.2b

cd /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star

pwd

STAR --genomeDir /share/malooflab/John/KIAT/Reference/star_genome --readFilesIn /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/Combined_1.fq.gz /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/Combined_2.fq.gz --sjdbGTFfile /share/malooflab/John/KIAT/Reference/Brassica_napus.annotation_v5_modified_modified.gff3 --quantMode TranscriptomeSAM GeneCounts --twopassMode Basic --alignIntronMax 15000 --outFilterIntronMotifs RemoveNoncanonical --runThreadN 20 --sjdbGTFtagExonParentTranscript Parent --sjdbGTFfeatureExon CDS --outReadsUnmapped Fastx --outSAMtype BAM SortedByCoordinate --readFilesCommand zcat
