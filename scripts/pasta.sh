#!/bin/bash
#SBATCH -J pasta
#SBATCH -o pasta_%A_%a.out
#SBATCH -e pasta_%A_%a.err
#SBATCH -p medium
#SBATCH --mem=40G
#SBATCH --nodes=1
#SBATCH -t 4-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

module load java
source ~/90day_aphid/conda_env/virt_test/bin/activate

# Add the anysymbol flag to make it so that it turns stop codons into X instead of removed
for f in *final.fasta; do
run_pasta.py -i $f --temporaries tempfiles
done
