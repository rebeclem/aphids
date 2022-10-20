#!/bin/bash
#SBATCH -J trimmomatic
#SBATCH -o trimmomatic_%A_%a.out
#SBATCH -e trimmomatic_%A_%a.err
#SBATCH -p short
#SBATCH --array=1-31
#SBATCH --mem=40G
#SBATCH --nodes=1
#SBATCH -t 1-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

name=$(sed -n "$SLURM_ARRAY_TASK_ID"p filenames.txt)
# start timer
date 
echo $name

module load trimmomatic/0.38

java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE -threads 10 -phred33 ${name}*_R1_001.fastq.gz ${name}*_R2_001.fastq.gz ${name}_R1_001_trim.fastq.gz ${name}_R1_001_single.fastq.gz ${name}_R2_001_trim.fastq.gz ${name}_R2_001_single.fastq.gz ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 HEADCROP:12

#---Complete job

echo "[---$SN---] ($(date)) $SN COMPLETE."
