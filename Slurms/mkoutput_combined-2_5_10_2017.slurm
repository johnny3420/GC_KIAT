#!/bin/bash
#
#SBATCH --job-name=mkoutput_supernova # Job name
#SBATCH --nodes=1
#SBATCH --time=3-0
#SBATCH --ntasks=8 # Number of cores
#SBATCH --mem=120000 # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --partition=gc128 # Partition to submit to
#SBATCH --output=Combined-2_mkoutput_supernova3.out # File to which STDOUT will be written
#SBATCH --error=Combined-2_mkoutput_supernova3.err # File to which STDERR will be written
#SBATCH --mail-type=ALL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=jtdavis@ucdavis.edu # Email to which notifications will be sent

hostname

echo "My SLURM_JOB_ID"
echo $SLURM__JOB_ID

start=`date +%s`

THREADS=${SLURM_NTASKS}
MEM=$(expr ${SLURM_MEM_PER_NODE} / 1000)

source ~/.bash_profile
basepath="/share/malooflab/John/KIAT/Supernova/Bnapus1_Novogene"

out_prefix="Combined-2"
amsdir="${basepath}/Combined_B_napus-2/outs/assembly"

## output style options are raw|megabubbles|pseudohap|pseudohap2
## minsize default is 1000bp
## headers default is short
#call="supernova mkoutput \
#--asmdir=${amsdir} \
#--outprefix=${out_prefix}.raw \
#--style=raw \
#--minsize=1000 \
#--headers=full"

#echo $call
#eval $call

#call="supernova mkoutput \
#--asmdir=${amsdir} \
#--outprefix=${out_prefix}.megabubbles \
#--style=megabubbles \
#--minsize=1000 \
#--headers=full"

#echo $call
#eval $call

call="supernova mkoutput \
--asmdir=${amsdir} \
--outprefix=${out_prefix}.pseudohap \
--style=pseudohap \
--minsize=1000 \
--headers=full"

echo $call
eval $call

call="supernova mkoutput \
--asmdir=${amsdir} \
--outprefix=${out_prefix}.pseudohap2 \
--style=pseudohap2 \
--minsize=1000 \
--headers=full"

echo $call
eval $call

end=`date +%s`

runtime=$((end-start))

echo $runtime

