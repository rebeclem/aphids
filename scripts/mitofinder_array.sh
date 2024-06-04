#!/bin/bash
#SBATCH -J mitofinder
#SBATCH -o mitofinder.%A_%a.out
#SBATCH -e mitofinder.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p atlas
#SBATCH -A aphid_phylogenomics
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --array=1-36


name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)


#--- Start the timer
t1=$(date +"%s")
echo "starting $name1 "

module load singularity


singularity run mitofinder_v1.4.2.sif -j $name1 -a ../masurca_assemblies/${name1}_primary.genome.scf.fasta -r aphis_myzus_mito.gb -o 5 -p 20
#-m 10
# -o is for genetic code. 5 is invertebrate mitochondrial code, -p is threads, -m is memory

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
