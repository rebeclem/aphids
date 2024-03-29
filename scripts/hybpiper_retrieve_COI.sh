#!/bin/bash
#SBATCH -J hybpiper_retrieve_COI
#SBATCH -o hybpiper_retrieve.%A_%a.out
#SBATCH -e hybpiper_retrieve.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p short
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

module load miniconda
source activate hybpiper

#mkdir fasta_output
#hybpiper retrieve_sequences dna -t_dna targets_all_OG.fa --sample_names namelist.txt --fasta_dir fasta_output

#mkdir fasta_output_aa
hybpiper retrieve_sequences dna -t_dna /home/rebecca.clement/90day_aphid/raw_data/cox1_mtdna_endos.fasta --sample_names namelist_COI.txt --fasta_dir fasta_output_COI
#hybpiper retrieve_sequences intron -t_aa targets_aa_OG.fa --sample_names namelist_aa.txt --fasta_dir fasta_output_aa
#hybpiper retrieve_sequences supercontig -t_aa targets_aa_OG.fa --sample_names namelist_aa.txt --fasta_dir fasta_output_aa
echo "finished running"
conda deactivate
