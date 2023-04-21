#!/bin/bash
#SBATCH -J pxcat
#SBATCH -o pxcat_%A_%a.out
#SBATCH -e pxcat_%A_%a.err
#SBATCH --nodes=1
#SBATCH -t 1-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


module load phyx
pxcat -s OG*New_final.fasta -p partitions.txt -o aphis_concat.fasta
