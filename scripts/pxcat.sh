#!/bin/bash
#SBATCH -J pxcat
#SBATCH -o pxcat_%A_%a.out
#SBATCH -e pxcat_%A_%a.err
#SBATCH --nodes=1
#SBATCH -N 1 -n 40
#SBATCH --partition=short    # standard node(s)
#SBATCH -t 24:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com
#--- Start the timer
t1=$(date +"%s")


module load phyx
pxcat -s OG*final.fasta -p ../trees/partitions.txt -o ../trees/concat.fasta
#pxcat -s OG*_final.fasta -p partitions.txt -o aphis_concat.fasta


#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
