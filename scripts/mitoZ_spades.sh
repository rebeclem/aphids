#!/bin/bash
#SBATCH -J mitoZ
#SBATCH -o mitoZ.%A_%a.out
#SBATCH -e mitoZ.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p medium
#SBATCH -t 4-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com



#--- Start the timer
t1=$(date +"%s")

module load singularityCE


singularity run ../MitoZ_v3.6.sif mitoz all  --outprefix MDONspades_insert --thread_number 8 \
	--clade Arthropoda --genetic_code auto --species_name "Melanaphis donacis" \
	--fq1 ../clean_data/MDONspades.clean_R1.fq.gz --fq2 ../clean_data/MDONspades.clean_R2.fq.gz --insert_size 267 \
--data_size_for_mt_assembly 0,0 --assembler spades --kmers_spades 41 79 \
	--requiring_taxa Arthropoda \
	--skip_filter 
#        --slow_search \
#	--fq1 ../novoplasty/APHDOO305_S99_R1_001.fastq.gz --fq2 ../novoplasty/APHDOO305_S99_R2_001.fastq.gz --insert_size 150 \

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
