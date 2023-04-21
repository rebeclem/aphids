#!/bin/bash
#SBATCH -J bpp0
#SBATCH -o bpp_%A_%a.out
#SBATCH -e bpp_%A_%a.err
#SBATCH -N 1 -n 40
#SBATCH -t 7-00:00:00
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

~/90day_aphid/software/bpp/src/bpp --resume ~/90day_aphid/bpp/myzus/A00/H0/out.txt.11.chk 

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

