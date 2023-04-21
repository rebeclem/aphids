#!/bin/bash
#SBATCH -J hybpiper_retrieve
#SBATCH -o hybpiper_retrieve.%A_%a.out
#SBATCH -e hybpiper_retrieve.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p short
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

module load miniconda
source activate hybpiper

#mkdir fasta_output
#hybpiper retrieve_sequences dna -t_dna targets_all_OG.fa --sample_names namelist.txt --fasta_dir fasta_output

#mkdir fasta_output_aa
hybpiper retrieve_sequences dna -t_dna targets_cds_OG.fa --sample_names namelist_aa.txt --fasta_dir fasta_output_aa
hybpiper retrieve_sequences aa -t_aa targets_aa_OG.fa --sample_names namelist_aa.txt --fasta_dir fasta_output_aa
#hybpiper retrieve_sequences intron -t_aa targets_aa_OG.fa --sample_names namelist_aa.txt --fasta_dir fasta_output_aa
#hybpiper retrieve_sequences supercontig -t_aa targets_aa_OG.fa --sample_names namelist_aa.txt --fasta_dir fasta_output_aa

conda deactivate

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
