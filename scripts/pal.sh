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

for f in OG*aafinal.fasta_align; do
	geneID="${f%%_*}"
	../../scripts/pal2nal.pl ${geneID}aafinal.fasta_align ${geneID}nucfinal.fasta -output fasta -nomismatch > ${geneID}_pal.fasta
done
