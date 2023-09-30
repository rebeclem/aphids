#!/bin/bash
#SBATCH -J mitoZ
#SBATCH -o mitoZ.%A_%a.out
#SBATCH -e mitoZ.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p short
#SBATCH -t 2-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com



#--- Start the timer
t1=$(date +"%s")

module load singularityCE


singularity run MitoZ_v3.6.sif mitoz all  --outprefix MDON_mitosz --thread_number 4 --clade Arthropoda --genetic_code auto --species_name "Melanaphis donacis" --fq1 ../APHD00305MDON_R1.fastq.gz --fq2 ../APHD00305MDON_R1.fastq.gz --insert_size 139 --data_size_for_mt_assembly 0,0 --assembler megahit --kmers_megahit 43 71 99 --memory 50 --requiring_taxa Arthropoda 

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
