#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“F2_Star_Run” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-10:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=F2_Star_Run_01_19_2017.out # STDOUT
#SBATCH --error=F2_Star_Run_01_19_2017.err # STDERR
#SBATCH --mail-user=you@gmail.co # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
/bin/hostname

# Load STAR Module 2.5.2b

module load star/2.5.2b

# Change directory

cd /share/malooflab/John/KIAT/F2_Star_Runs/Single_End/

pwd

# Gather Sample Names
A="1 10 100 101 102"
echo ${A}
B="103 104 105 106 109"
echo ${B}

# Create A & B STAR Directories and run STAR

for i in $A
      do
      mkdir Batch_A/Sample_138-${i}.single.star.dir
      cd Batch_A/Sample_138-${i}.single.star.dir/
      STAR --genomeDir /share/malooflab/John/KIAT/Reference/star_genome --readFilesIn /share/malooflab/Ruijuan/F2/Sample_138-${i}/138-${i}_paired_1.fq.gz --sjdbGTFfile /share/malooflab/John/KIAT/Reference/Brassica_napus.annotation_v5_modified_modified.gff3  --quantMode TranscriptomeSAM GeneCounts --twopassMode Basic --alignIntronMax 15000 --outFilterIntronMotifs RemoveNoncanonical --runThreadN 20 --sjdbGTFtagExonParentTranscript Parent --sjdbGTFfeatureExon CDS --outReadsUnmapped Fastx --readFilesCommand zcat
      cd ../..
done

for i in $B
      do
      mkdir Batch_B/Sample_138-${i}.single.star.dir
      cd Batch_B/Sample_138-${i}.single.star.dir/
      STAR --genomeDir /share/malooflab/John/KIAT/Reference/star_genome --readFilesIn /share/malooflab/Ruijuan/F2/Sample_138-${i}/138-${i}_paired_1.fq.gz --sjdbGTFfile /share/malooflab/John/KIAT/Reference/Brassica_napus.annotation_v5_modified_modified.gff3 --quantMode TranscriptomeSAM GeneCounts --twopassMode Basic --alignIntronMax 15000 --outFilterIntronMotifs RemoveNoncanonical --runThreadN 20 --sjdbGTFtagExonParentTranscript Parent --sjdbGTFfeatureExon CDS --outReadsUnmapped Fastx --readFilesCommand zcat
      cd ../..
done
