#!/bin/bash
#SBATCH -J iqtree_concat_modelfinder
#SBATCH -o iqtree_concat_modelfinder.out
#SBATCH -e iqtree_concat_modelfinder.err
#SBATCH -p medium
#SBATCH -n 40 -N 1
#SBATCH -t 7-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

module load iq_tree/2.0-rc1

iqtree -nt 40 -s aphis_concat.fasta -spp partitions.txt -m TESTMERGEONLY -rclusterf 10 -rcluster-max 15000 -pre aphis_iqtree

# TESTMERGEONLY doesn't do tree reconstruction yet.
