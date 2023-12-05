#!/bin/bash
#SBATCH -J iqtree_array
#SBATCH -o iq_array_%A_%a.out
#SBATCH -e iq_array_%A_%a.err
#SBATCH --array=1-5589%500
#SBATCH -N 1 -n 4
#SBATCH -t 1:00:00
#SBATCH -p short,debug,brief-low,scavenger
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p filelist.txt)

#--- Start the timer
t1=$(date +"%s")

echo "Starting $name1"
module load iq_tree/2.0-rc1

iqtree2 -nt AUTO -s ${name1}_align.fasta -spp ${name1}_parts.txt -m TESTMERGE -bb 1000 -pre ${name1}_nucs_ml_1000ufbs 

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

