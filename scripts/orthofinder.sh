#!/bin/bash


#SBATCH --time=10:00:00   # walltime limit (HH:MM:SS)
#SBATCH --nodes=1   # number of nodes
#SBATCH --ntasks-per-node=2   # 1 processor core(s) per node X 2 threads per core
#SBATCH --partition=short    # standard node(s)
#SBATCH --job-name="orthofinder"
#SBATCH --mail-user=rebeclem@gmail.com   # email address
#SBATCH --mail-type=BEGIN,END,FAIL

date
module load orthofinder
orthofinder -f aa
orthofinder -f aa_LTPG
date
