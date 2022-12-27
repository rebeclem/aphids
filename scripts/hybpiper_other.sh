#!/bin/bash
#SBATCH -J hybpiper_other
#SBATCH -o hybpiper_other.%A_%a.out
#SBATCH -e hybpiper_other.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH --array=1-11
#SBATCH -p medium
#SBATCH -t 4-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

# SAMPLE_LIST=($(<namelist.txt))
SAMPLE=$(sed -n "$SLURM_ARRAY_TASK_ID"p genomelist.txt)

module load miniconda
source activate hybpiper
echo ${SAMPLE}_aa
hybpiper assemble -r ${SAMPLE}* -t_aa targets_aa_OG.fa --cpu 20 --prefix ${SAMPLE}_aa --run_intronerate --diamond
#hybpiper assemble -r APHD00251_S41_*_trim.fastq --unpaired APHD00251_S41_R2_001_BothSingle.fastq -t_aa aphid_6genome_scp_ortho_targets.fasta --cpu 20 --prefix Phylloxera_notabilis --run_intronerate --diamond
#hybpiper stats -t_aa targets_aa_OG.fa gene namelist_aa.txt
echo "Finished running"

conda deactivate
