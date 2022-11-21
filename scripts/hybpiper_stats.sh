#!/bin/bash
#SBATCH -J hybpiper_stats
#SBATCH -o hybpiper_stats.%A_%a.out
#SBATCH -e hybpiper_stats.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p short
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

# SAMPLE_LIST=($(<namelist.txt))
#SAMPLE=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)

module load miniconda
source activate hybpiper
hybpiper stats -t_dna targets_all_OG.fa gene namelist.txt
hybpiper stats -t_aa targets_aa_OG.fa gene namelist_aa.txt --seq_lengths_filename seq_lengths_aa --stats_filename hybpiper_stats_aa

hybpiper recovery_heatmap seq_lengths.tsv
hybpiper recovery_heatmap seq_lengths_aa.tsv --heatmap_filename recovery_heatmap_aa
conda deactivate
