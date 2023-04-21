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
#hybpiper assemble -r APHD00251_S41_*_trim.fastq --unpaired APHD00251_S41_R2_001_BothSingle.fastq -t_aa aphid_6genome_scp_ortho_targets.fasta --cpu 20 --prefix Phylloxera_notabilis --run_intronerate --diamond
#hybpiper stats -t_dna targets_all_OG.fa gene namelist.txt

conda deactivate
