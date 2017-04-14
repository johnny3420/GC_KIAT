#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“F2_Star_Run” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=100000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=3-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=F2_Star_Run_01_10_2017.out # STDOUT
#SBATCH --error=F2_Star_Run_01_10_2017.err # STDERR
#SBATCH --mail-user=you@gmail.co # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
/bin/hostname

# Load STAR Module 2.5.2b

module load star/2.5.2b

# Gather Sample Names
cd /share/malooflab/Ruijuan/F2
Folder=`ls -d Sample* | sed 's/S.*-//'`
echo ${Folder}

# Enter Directory which will hold STAR runs

cd /share/malooflab/John/KIAT/F2_Star_Runs

pwd

# Create STAR Directories

for i in $Folder
      do
      echo $i
      if [[ -d Sample_138-${i}.paired.star.dir ]]
             then
                     echo OK
      else
             mkdir Sample_138-${i}.paired.star.dir
      fi

      # Enter Directory and run STAR

      cd Sample_138-${i}.paired.star.dir
      STAR --genomeDir /share/malooflab/John/KIAT/Reference/star_genome --readFilesIn /share/malooflab/Ruijuan/F2/Sample_138-${i}/138-${i}_paired_1.fq.gz /share/malooflab/Ruijuan/F2/Sample_138-${i}/138-${i}_paired_2.fq.gz --sjdbGTFfile /share/malooflab/John/KIAT/Reference/Brassica_napus.annotation_v5_modified_modified.gff3 --quantMode TranscriptomeSAM GeneCounts --twopassMode Basic --alignIntronMax 15000 --outFilterIntronMotifs RemoveNoncanonical --runThreadN 20 --sjdbGTFtagExonParentTranscript Parent --sjdbGTFfeatureExon CDS --outReadsUnmapped Fastx --readFilesCommand zcat
      cd ..
      echo Sample_138-${i} is done

done
