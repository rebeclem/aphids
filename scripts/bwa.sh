#!/bin/bash
#SBATCH -J bwa
#SBATCH -o bwa.%A_%a.out
#SBATCH -e bwa.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p short
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com



#--- Start the timer
t1=$(date +"%s")

module load bwa


bwa index -p MSAC_mito MSAC_mito.fasta

bwa mem MSAC_mito APHD00305MDON_R1.fastq APHD00305MDON_R2.fastq 2> bwa.err >MDonBWA_msac.sam

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
