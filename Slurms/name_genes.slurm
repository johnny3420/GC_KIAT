#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name="Name_Genes" # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=20 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=51000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=10-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=Name_Genes.out # STDOUT
#SBATCH --error=Name_Genes.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL
# This will be run once for a single process

/bin/hostname

start=`date +%s`

cd /share/malooflab/John/KIAT/Evidential_Gene_Test

source ~/.bash_profile
module load cdhit/4.6.1
module load blast/2.6.0+

deltablast -show_domain_hits -outfmt 7 -db /share/malooflab/Uniprot/uniref90.fasta -query Da_Ae.allok.aa -out Da_Ae.deblastp

end=`date +%s`
runtime=$((end-start))
echo Done after $runtime seconds
