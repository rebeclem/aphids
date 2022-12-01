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

for f in OG*.FAA; do
	geneID="${f%%.*}"
	../../../scripts/pal2nal.pl ${geneID}.FAA_align ${geneID}.FNA -output fasta -nomismatch > ${geneID}pal.fasta
done
