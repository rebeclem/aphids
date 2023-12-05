#!/bin/bash
#SBATCH -J iqtree_combined
#SBATCH -o iqtree.out
#SBATCH -e iqtree.err
#SBATCH -p medium,scavenger-mem
#SBATCH -n 40 -N 1
#SBATCH -t 7-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

module load iq_tree/2.2.0
iqtree2 -nt 40 -s concat.fasta -spp partitions.txt -m TESTMERGEONLY -rclusterf 10 -rcluster-max 15000 -pre combined_iqtree_model

iqtree -nt 40 -s concat.fasta -p combined_iqtree_model.best_scheme.nex -bb 1000 -pre combined_iqtree_tree

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
