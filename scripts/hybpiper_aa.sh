#!/bin/bash
#SBATCH -J hybpiper_aa
#SBATCH -o hybpiper_aa.%A_%a.out
#SBATCH -e hybpiper_aa.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH --array=1-19
#SBATCH -p medium
#SBATCH -t 4-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

# SAMPLE_LIST=($(<namelist.txt))
SAMPLE=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)

module load miniconda
source activate hybpiper
echo ${SAMPLE}_aa
hybpiper assemble -r ${SAMPLE}_*_trim.fastq.gz --unpaired ${SAMPLE}_*_BothSingle.fastq.gz -t_aa targets_aa_OG.fa --cpu 20 --prefix ${SAMPLE}_aa --run_intronerate --diamond

conda deactivate
