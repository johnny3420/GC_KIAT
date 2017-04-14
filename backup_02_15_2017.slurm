#!/bin/bash
#SBATCH --partition=gc # partition to submit to
#SBATCH --job-name=“Backup” # Job name
#SBATCH --nodes=1 # single node, anything more than 1 will not run
#SBATCH --ntasks=5 # equivalent to cpus, stick to around 20 max on gc64, or gc128 nodes
#SBATCH --mem=20000 # in MB, memory pool all cores, default is 2GB per cpu
#SBATCH --time=3-00:00:00  # expected time of completion in hours, minutes, seconds, default 1-day
#SBATCH --output=backup_02_15_2017.out # STDOUT
#SBATCH --error=backup_02_15_2017.err # STDERR
#SBATCH --mail-user=jtdavis@ucdavis.edu
#SBATCH --mail-type=ALL
# This will be run once for a single process

/bin/hostname
# transfer all Parent files to cabernet

cd /share/malooflab/Fastqs/KIAT/Parent &&
while read file
	do
	scp johndavis@coloma.plb.ucdavis.edu:/Network/Servers/avalanche.plb.ucdavis.edu/Volumes/Mammoth/Users/ruijuanli/2016_summer/raw_data/done_for_cufflinks/${file} ${file}
	done < batch_1.txt &&
while read file
	do
	scp johndavis@coloma.plb.ucdavis.edu:/Network/Servers/avalanche.plb.ucdavis.edu/Volumes/Mammoth/Users/ruijuanli/2016_summer/raw_data/${file} ${file}
	done < batch_2.txt &&
echo Parent Files Uploaded &&

# transfer all F1 files to cabernet

cd /share/malooflab/Fastqs/KIAT/F1 &&

while read file
	do
	scp johndavis@coloma.plb.ucdavis.edu:/Network/Servers/avalanche.plb.ucdavis.edu/Volumes/Mammoth/Users/ruijuanli/2016_summer/automate_transfer/F1/${file} ${file}
	done < batch_3.txt &&
echo F1 Files Uploaded &&

# transfer all F2 files to cabernet

cd /share/malooflab/Fastqs/KIAT/F2 &&

while read file
	do
	scp johndavis@coloma.plb.ucdavis.edu:/Network/Servers/avalanche.plb.ucdavis.edu/Volumes/Mammoth/Users/ruijuanli/2016_fall/F2/raw_data/bioftp.org/TBD160783_20161129/${file} ${file}
	done < batch_4.txt &&
echo F2 Files Uploaded &&

# transfer all 505 files to cabernet

cd /share/malooflab/Fastqs/KIAT/505 &&

while read file
	do
	scp johndavis@coloma.plb.ucdavis.edu:/Network/Servers/avalanche.plb.ucdavis.edu/Volumes/Mammoth/Users/ruijuanli/2017_winter/505/data/bioftp.org/TBD170001_1617/${file} ${file}
	done < batch_5.txt &&

while read file
	do
	scp johndavis@coloma.plb.ucdavis.edu:/Network/Servers/avalanche.plb.ucdavis.edu/Volumes/Mammoth/Users/ruijuanli/2017_winter/505/data/bioftp.org/TBD170026_20170202/${file} ${file}
	done < batch_6.txt &&
echo 505 Files Uploads &&

echo All Files Succesfully uploaded
