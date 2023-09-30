#!/bin/bash
#SBATCH --job-name=bcf_mpileup
#SBATCH -n 1
#SBATCH -N 1
#SBATCH -t 2-00:00:00
#SBATCH -p short
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --mail-type=ALL
#SBATCH -o %x_%j.out
#SBATCH -e %x_%j.err

hostname
date
# Run this file in the folder with the bam files
module load bcftools

# Set output name
#outname="myzus2"
outname=aphis2
# Put list of bam files into a file
ls *sorted.bam >list.bam

# set reference genome location
GEN=../Aphis_fabae_JIC1_v2.scaffolds.braker.filtered.cds.fa
#GEN=../Myzus_varians_v1.1.scaffolds.braker.filtered.cds.LTPG.fa

bcftools mpileup \
        -f $GEN \
        -b list.bam \
        -q 20 \
        -Q 30 \
         >${outname}.pileup

bcftools call -m -v -Oz -o ${outname}.vcf.gz ${outname}.pileup
