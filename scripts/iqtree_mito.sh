#!/bin/bash
#SBATCH -J iqtree_mito
#SBATCH -o iqtree.out
#SBATCH -e iqtree.err
#SBATCH -p short
#SBATCH -n 40 -N 1
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

module load iq_tree/2.2.0
iqtree2 -s mito_concat_1AAUR.fasta -p partitions.txt -nt AUTO -m TESTMERGE -bb 1000 -pre mito_iqtree_1AAUR

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
