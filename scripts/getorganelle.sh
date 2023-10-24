#!/bin/bash
#SBATCH -J getorganelle
#SBATCH -o getorganelle.%A_%a.out
#SBATCH -e getorganelle.%A_%a.err
#SBATCH -n 20 -N 1
#SBATCH -p medium
#SBATCH -t 5-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com



#--- Start the timer
t1=$(date +"%s")

module load miniconda
source ~/.conda/envs/getorganelle/bin/activate 


get_organelle_from_reads.py -1 ../APHD00305MDON_4.2M_start_19.2M1.fastq -2 ../APHD00305MDON_4.2M_start_19.2M2.fastq -u ../APHD00305MDON_4.2M_start_19.2MUnpaired.fastq -F animal_mt -o MDON-mitogenome_4.2 -R 10 --reduce-reads-for-coverage inf --max-reads inf



#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
