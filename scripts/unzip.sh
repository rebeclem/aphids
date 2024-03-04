#!/bin/bash
#SBATCH -J unzip_array
#SBATCH -o unzip_%A_%a.out
#SBATCH -e unzip_%A_%a.err
#SBATCH --array=1-34
#SBATCH -N 1 -n 20
#SBATCH -t 2:00:00
#SBATCH -p short,brief-low
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)

#--- Starrt timer
t1=$(date +"%s")

echo "Starting $name1"

pigz -d ${name1}*fastq.gz

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

