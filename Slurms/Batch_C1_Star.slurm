#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="STAR_Array" # Job name
#SBATCH --array=1-20
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-05:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=arrayJob_%A_%a.out # File to which STDOUT will be written
#SBATCH --error=arrayJob_%A_%a.err # File to which STDERR will be written
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL


/bin/hostname

# Load STAR Module 2.5.2b

module load star/2.5.2b

echo "My SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID

sample=`sed "${SLURM_ARRAY_TASK_ID}q;d" samples.txt`

cd /share/malooflab/John/KIAT/F2_Star_Runs/Batch_C

mkdir Sample_${sample}

cd Sample_${sample}

STAR \
	--genomeDir /share/malooflab/John/KIAT/Reference/star_genome \
	--readFilesIn /share/malooflab/John/KIAT/Fastqs/F2_Batch_C_Trimmed/Sample_${sample}/${sample}_1.paired.fq.gz /share/malooflab/John/KIAT/Fastqs/F2_Batch_C_Trimmed/Sample_${sample}/${sample}_2.paired.fq.gz \
	--sjdbGTFfile /share/malooflab/John/KIAT/Reference/Brassica_napus.annotation_v5_modified_modified.gff3 \
	--quantMode TranscriptomeSAM GeneCounts \
	--twopassMode Basic \
	--alignIntronMax 15000 \
	--outFilterIntronMotifs RemoveNoncanonical \
	--runThreadN 10 \
	--sjdbGTFtagExonParentTranscript Parent \
	--sjdbGTFfeatureExon CDS \
	--outReadsUnmapped Fastx \
	--readFilesCommand zcat \
	--outSAMtype BAM SortedByCoordinate

