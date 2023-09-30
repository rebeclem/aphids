#!/bin/bash
#SBATCH -J spades
#SBATCH -o spades_%A_%a.out
#SBATCH -e spades_%A_%a.err
#SBATCH -N 1 
#SBATCH -t 2-00:00:00
#SBATCH -p scavenger-mem
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

module load spades

spades.py -1 APHDOO305_S99_R1_001.fastq.gz -2 APHDOO305_S99_R2_001.fastq.gz -t 80 -o spades_raw 

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

