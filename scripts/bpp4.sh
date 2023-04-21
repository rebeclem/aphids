#!/bin/bash
#SBATCH -J bpp4
#SBATCH -o bpp_%A_%a.out
#SBATCH -e bpp_%A_%a.err
#SBATCH -N 1 
#SBATCH --exclusive
#SBATCH -t 7-00:00:00
#SBATCH -p medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

~/90day_aphid/software/bpp/src/bpp --cfile ~/90day_aphid/bpp/myzus/myzus.bpp.H4.A00.ctl 
#~/90day_aphid/software/bpp/src/bpp --resume ~/90day_aphid/bpp/myzus/A00/H4/out.txt.32.chk

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

