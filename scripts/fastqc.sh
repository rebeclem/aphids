#!/bin/bash
#SBATCH -J fastqc
#SBATCH -o fastqc_out_%A_%a.out
#SBATCH -e fastqc_err_%A_%a.err
#The next line tells slurm this is an array that will submit 149 garli jobs across the cluster
#SBATCH --array=1-62
#SBATCH --nodes=1
#SBATCH -t 1-00:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=rebeclem@gmail.com

# move to the directory where the data files locate
cd /home/rebecca.clement/90day_aphid/raw_data/aphis_myzus

module load fastqc
file=$(ls ./*.fastq.gz | sed -n ${SLURM_ARRAY_TASK_ID}p)

fastqc -o ./fastqc_out $file
