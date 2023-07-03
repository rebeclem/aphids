#!/bin/bash
#SBATCH --job-name=filter
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

module load bcftools
module load htslib
module load bedtools


OUTDIR=../filtered_vcfs
mkdir -p $OUTDIR

# ls $INDIR/*mkdup.bam >$INDIR/list.bam

# set reference genome location
GEN=../Aphis_fabae_JIC1_v2.scaffolds.braker.filtered.cds.fa

TARGETS=../coverage_stats/targets.bed

bcftools view aphis.vcf.gz | bcftools filter -s LowQual -e '%QUAL<50' | bedtools intersect -header -wa -a stdin -b $TARGETS | bgzip -c > $OUTDIR/bcf_filter.vcf.gz

tabix -f -p vcf bcf_filter.vcf.gz



