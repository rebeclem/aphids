#!/bin/bash
#SBATCH -J fastqc
#SBATCH -o fastqc_out_%A_%a.out
#SBATCH -e fastqc_err_%A_%a.err
#The next line tells slurm this is an array that will submit 149 garli jobs across the cluster
#SBATCH --array=1-124
#SBATCH --nodes=1
#SBATCH -t 1-00:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=rebeclem@gmail.com

# move to the directory where the data files locate
# cd /home/rebecca.clement/90day_aphid/raw_data/aphis_myzus

# the next line processes a text file with garli configs 1 per line and uses them as input
#name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p transcripts_hemip_files1.txt)

#/groups/cbi/garli-2.01/bin/Garli-2.01 $name1

module load fastqc
file=$(ls ./*.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p)

fastqc -o ./fastqc_out $file
