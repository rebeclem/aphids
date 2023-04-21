#!/bin/bash
#SBATCH -J mafft
#SBATCH -o mafft_%A_%a.out
#SBATCH -e mafft_%A_%a.err
#SBATCH -p short
#SBATCH --mem=40G
#SBATCH --nodes=1
#SBATCH -t 1-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

#--- Start the timer
t1=$(date +"%s")

module load mafft

# Add the anysymbol flag to make it so that it turns stop codons into X instead of removed
for f in *aafinal.fasta; do
mafft --auto --anysymbol ${f} > ${f}_align
done

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
