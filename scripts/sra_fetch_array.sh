#!/bin/bash
#SBATCH -J sra_prefetch
#SBATCH -o sra_prefetch_%A_%a.out
#SBATCH -e sra_prefetch_%A_%a.err
#SBATCH --array=1-16
#SBATCH -n 6 -N 1
#SBATCH -p short
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

## Load conda and activate environment ##
module load miniconda
module load sratoolkit/3.0.1
#source activate /90daydata/aphid_phylogenomics/chris/aphid_subfam_genomics

# Bash variables ##
line=$(sed -n "$SLURM_ARRAY_TASK_ID"p sra_fetch_dump_array_list.txt)
sra_id=`echo "${line}"|cut -f1`
#paired_wildcard=$(echo "$leftpair" | sed "s/R1/*/g")
#identifier=$(echo "$leftpair" | cut -d '_' -f1)
#rightpair=`echo "${line}"|cut -f2`
#leftsingle=`echo "${line}"|cut -f3`
#rightsingle=`echo "${line}"|cut -f4`
taxon=`echo "${line}"|cut -f2`
#both_singles=$(echo "$leftpair" | sed "s/R1_001_trim.fastq/bothsingles.fastq/g")
#cat $leftsingle $rightsingle > $both_singles
echo $sra_id
echo $taxon
prefetch -X 9999999999999 $sra_id
#fastq-dump $sra_id/${sra_id}.sra --threads 6 --split-3 --skip-technical -O $sra_id


