#!/bin/bash
#SBATCH -J hybpiper_AAUR
#SBATCH -o hybpiper_AAUR.%A_%a.out
#SBATCH -e hybpiper_AAUR.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p medium
#SBATCH -t 4-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


module load miniconda
source activate hybpiper
echo APHD00023AAUR_aa
hybpiper assemble -r APHD00023AAUR_*_trim.fastq.gz --unpaired APHD00023AAUR_*_BothSingle.fastq.gz -t_aa targets_aa_OG.fa --cpu 20 --prefix APHD00023AAUR_aa --run_intronerate --diamond
#hybpiper assemble -r APHD00251_S41_*_trim.fastq --unpaired APHD00251_S41_R2_001_BothSingle.fastq -t_aa aphid_6genome_scp_ortho_targets.fasta --cpu 20 --prefix Phylloxera_notabilis --run_intronerate --diamond
#hybpiper stats -t_aa targets_aa_OG.fa gene namelist_aa.txt
echo "finished running"
conda deactivate
