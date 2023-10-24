#!/bin/bash
#SBATCH -J masurca
#SBATCH -o masurca_%A_%a.out
#SBATCH -e masurca_%A_%a.err
#SBATCH -N 1 -n 80 
#SBATCH -t 2-00:00:00
#SBATCH -p mem
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

module load masurca/4.1.0

masurca ../config2.txt
 ./assemble.sh
#masurca -i ../APHDOO305_S99_R1_001.fastq.gz,../APHDOO305_S99_R2_001.fastq.gz -t 80  

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

