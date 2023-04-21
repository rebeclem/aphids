#!/bin/bash
#SBATCH -J iqtree_myzus
#SBATCH -o iqtree.out
#SBATCH -e iqtree.err
#SBATCH -p medium
#SBATCH -n 40 -N 1
#SBATCH -t 7-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

module load iq_tree/2.0-rc1

iqtree -nt 40 -s myzus_concat.fasta -p myzus_iqtree_model.best_scheme.nex -bb 1000 -pre myzus_iqtree_tree
