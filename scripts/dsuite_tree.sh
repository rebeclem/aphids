#!/bin/bash
#SBATCH -J dsuite_tree
#SBATCH -o dsuite_%A_%a.out
#SBATCH -e dsuite_%A_%a.err
#SBATCH -N 1 -n 4
#SBATCH -t 2-00:00:00
#SBATCH -p short
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")
# set variables

textfile=~/90day_aphid/snp/aphis/dsuite/aphis_pop.txt
vcffile=~/90day_aphid/snp/aphis/bam/aphis_output_snps-only_max_missing_1_mac_3_minq_50.recode.vcf
tree=~/90day_aphid/snp/aphis/dsuite/aphis_tree.nwk 

# run dsuite
~/90day_aphid/snp/Dsuite/Build/Dsuite Dtrios -c -t $tree $vcffile $textfile -n aphis_tree

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

