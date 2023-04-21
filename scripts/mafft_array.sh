#!/bin/bash
#SBATCH -J mafft
#SBATCH -o mafft_%A_%a.out
#SBATCH -e mafft_%A_%a.err
#SBATCH --array=1-8631%500
#SBATCH -N 1 -n 4
#SBATCH -t 30:00
#SBATCH -p short,debug,brief-low
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p genelist.txt)

#--- Start the timer
t1=$(date +"%s")

module load mafft

# Add the anysymbol flag to make it so that it turns stop codons into X instead of removed

mafft --auto --anysymbol ${name1}_aafinal.fasta > ${name1}_aa_align.fasta


#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
