#!/bin/bash
#SBATCH -J hybpiper_mito
#SBATCH -o hybpiper_mito.%A_%a.out
#SBATCH -e hybpiper_mito.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH --array=1-12
#SBATCH -p short,medium
#SBATCH -t 4-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

# SAMPLE_LIST=($(<namelist.txt))
SAMPLE=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt) # use this line for main files
#SAMPLE=$(sed -n "$SLURM_ARRAY_TASK_ID"p genomelist.txt) # use this line for other genomes
#SAMPLE=$(sed -n "$SLURM_ARRAY_TASK_ID"p scaffoldlist.txt) # use this line for scaffolds from mathers
module load miniconda
source activate hybpiper
echo ${SAMPLE}_mitochondria
hybpiper assemble -r ${SAMPLE}_*_trim.fastq.gz --unpaired ${SAMPLE}_*_BothSingle.fastq.gz -t_dna /home/rebecca.clement/90day_aphid/raw_data/mper_mito.fasta --cpu 20 --prefix ${SAMPLE}_mitochondria --bwa

# For other genomes
# SAMPLE=$(sed -n "$SLURM_ARRAY_TASK_ID"p genomelist.txt)
# hybpiper assemble -r ${SAMPLE}_*.fastq.gz -t_dna /home/rebecca.clement/90day_aphid/raw_data/agly_mito.fasta --cpu 20 --prefix ${SAMPLE}_mitochondria --bwa

# For Mathers fasta scaffolds
#hybpiper assemble -r ${SAMPLE}.scaffolds.fa -t_dna /home/rebecca.clement/90day_aphid/raw_data/agly_mito.fasta --cpu 20 --prefix ${SAMPLE}_mitochondria --bwa

#hybpiper assemble -r APHD00251_S41_*_trim.fastq --unpaired APHD00251_S41_R2_001_BothSingle.fastq -t_aa aphid_genome_scp_ortho_targets.fasta --cpu 20 --prefix Phylloxera_notabilis --run_intronerate --diamond
#hybpiper stats -t_aa targets_aa_OG.fa gene namelist_aa.txt
echo "finished running"
conda deactivate
