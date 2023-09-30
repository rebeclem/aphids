#!/bin/bash
#SBATCH -J mitofinder
#SBATCH -o mitofinder.%A_%a.out
#SBATCH -e mitofinder.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p short
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com



#--- Start the timer
t1=$(date +"%s")

module load singularityCE



singularity run mitofinder_v1.4.1.sif -j MDON_52K -r HPRU_MSAC.gb -1 APHD00305MDON_52Kreads_CLC_contig_209_1.fastq -2 APHD00305MDON_52Kreads_CLC_contig_209_2.fastq -s APHD00305MDON_52Kreads_CLC_contig_209_Unpaired.fastq -o 5 -p 20 -m 10
# -o is for genetic code. 5 is invertebrate mitochondrial code, -p is threads, -m is memory

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
