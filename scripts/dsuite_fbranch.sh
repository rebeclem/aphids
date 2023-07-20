#!/bin/bash
#SBATCH -J dsuite_fbranch
#SBATCH -o dsuiteFB_%A_%a.out
#SBATCH -e dsuiteFB_%A_%a.err
#SBATCH -N 1 -n 4
#SBATCH -t 2-00:00:00
#SBATCH -p short
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

# Load biopython environment
module load miniconda
source activate ml-env

# set variables
name1=myzus
treefile=~/90day_aphid/snp/$name1/dsuite/${name1}_pop_${name1}_tree_tree.txt
textfile=~/90day_aphid/snp/${name1}/dsuite/${name1}_pop.txt
vcffile=~/90day_aphid/snp/$name1/bam/${name1}_output_snps-only_max_missing_1_mac_3_minq_50.recode.vcf
tree=~/90day_aphid/snp/$name1/dsuite/${name1}_tree.nwk

echo "$treefile"
# run dsuite
~/90day_aphid/snp/Dsuite/Build/Dsuite Fbranch $tree $treefile > ${name1}_Fbranch.txt
# Dsuite Fbranch simulated_tree_with_geneflow.nwk species_sets_with_geneflow_tree.txt > species_sets_with_geneflow_Fbranch.txt
python3 ~/90day_aphid/snp/Dsuite/utils/dtools.py ${name1}_Fbranch.txt $tree

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

