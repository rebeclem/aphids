#!/bin/bash
#SBATCH -J bpp0
#SBATCH -o bpp_%A_%a.out
#SBATCH -e bpp_%A_%a.err
#SBATCH -N 2 -n 40
#SBATCH -t 2-00:00:00
#SBATCH -p short
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

~/90day_aphid/software/bpp/src/bpp --cfile ~/90day_aphid/bpp/myzus/myzus.bpp.H0.A00.ctl 

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

