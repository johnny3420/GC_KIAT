#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“F2_Subset” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=10 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=50000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=0-10:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=F2_Subset_02_28_2017.out # STDOUT
#SBATCH --error=F2_Subset_02_28_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu # does not work yet
#SBATCH --mail-type=ALL # does not work yet
# This will be run once for a single process
/bin/hostname

# Gather Sample Names
cd /share/malooflab/Ruijuan/F2
Folder=`ls -d Sample* | sed 's/S.*-//'`
echo ${Folder}

pwd

for Sample in ${Folder}
	do
	gunzip -c Sample_138-${Sample}/138-${Sample}_paired_1.fq.gz > /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/138-${Sample}_1.fq
	gunzip -c Sample_138-${Sample}/138-${Sample}_paired_2.fq.gz > /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/138-${Sample}_2.fq
	paste /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/138-${Sample}_1.fq /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/138-${Sample}_2.fq | awk '{ printf("%s",$0); n++; if(n%4==0) { printf("\n");} else { printf("\t\t");} }' | shuf | head -n 1000000 | sed 's/\t\t/\n/g' | awk -F '\t' '{print $1 > "/share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/1.fq"; print $2 > "/share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/2.fq"}' &&
	mv /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/1.fq /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/small-138-${Sample}_1.fq &&
	mv /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/2.fq /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/small-138-${Sample}_2.fq &&
	rm /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/138-${Sample}_1.fq &&
	rm /share/malooflab/John/KIAT/F2_Star_Runs/Subset_Star/Fastqs/138-${Sample}_2.fq &&
	echo Sample-${Sample} is done
done

echo All samples complete
