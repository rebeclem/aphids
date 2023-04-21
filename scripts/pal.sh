#!/bin/bash
#SBATCH -J pal2nal
#SBATCH -o pal2nal_%A_%a.out
#SBATCH -e pal2nal_%A_%a.err
#SBATCH -p short
#SBATCH --mem=40G
#SBATCH --nodes=1
#SBATCH -t 1-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

for f in OG*aa_align.fasta; do 
	geneID="${f%%_*}"
../../scripts/pal2nal.pl ${geneID}_aa_align.fasta ${geneID}_nucfinal.fasta -output fasta -nomismatch > ${geneID}_pal.fasta
done

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

