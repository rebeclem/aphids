#!/bin/bash
#SBATCH -J novoplasty
#SBATCH -o novoplasty.%A_%a.out
#SBATCH -e novoplasty.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p brief-low
#SBATCH -t 2:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com



#--- Start the timer
t1=$(date +"%s")



perl NOVOPlasty4.3.4.pl -c config.txt


#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
