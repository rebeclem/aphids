#!/bin/bash
#SBATCH -J mitofinder
#SBATCH -o mitofinder_numt.%A_%a.out
#SBATCH -e mitofinder_numt.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p short
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com



#--- Start the timer
t1=$(date +"%s")

module load singularityCE



singularity run mitofinder_v1.4.1.sif --numt -j MDON_numt -a ~/90day_aphid/melanaphis/MDON2/MDON2_MitoFinder_mitfi_Final_Results/all_MDON2_contigs.fasta -r hemiptera_MSAC.gb -o 5 -p 20 -m 10
# -o is for genetic code. 5 is invertebrate mitochondrial code, -p is threads, -m is memory

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
