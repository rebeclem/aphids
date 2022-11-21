#!/bin/bash
#SBATCH -J hybpiper_cds
#SBATCH -o hybpiper_cds.%A_%a.out
#SBATCH -e hybpiper_cds.%A_%a.err
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
echo $SAMPLE
hybpiper assemble -r ${SAMPLE}_*_trim.fastq.gz --unpaired ${SAMPLE}_*_BothSingle.fastq.gz -t_dna targets_all_OG.fa --cpu 20 --prefix ${SAMPLE} --run_intronerate --bwa

conda deactivate
