#!/bin/bash
#SBATCH -J blast
#SBATCH -o blast.%A_%a.out
#SBATCH -e blast.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p short
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com



#--- Start the timer
t1=$(date +"%s")

module load blast+

makeblastdb -dbtype nucl -in ../spades_MDON/contigs.fasta

blastn -db ../spades_MDON/contigs.fasta -query MDON_cox1.fasta -out results.out -evalue 1e-5 -outfmt 7
#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
