#!/bin/bash
#SBATCH -J discovar_array
#SBATCH -o discovar_%A_%a.out
#SBATCH -e discovar_%A_%a.err
#SBATCH -N 1 -n 20
#SBATCH -t 2-00:00:00
#SBATCH -p atlas
#SBATCH -A aphid_phylogenomics
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --array=1-34

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)
file1=${name1}_*_R1_001.fastq
file2=${name1}_*_R2_001.fastq
#--- Starrt timer
t1=$(date +"%s")

echo "Starting $name1"
#module load discovar/52488
module load miniconda
source activate discovarenv
DiscovarDeNovo READS=$file1,$file2 OUT_DIR=./$name1 NUM_THREADS=32 MAX_MEM_GB=100
#DiscovarDeNovo READS=../raw_data/shotgunseqs/APHD00002_S10_R1_001.fastq,../raw_data/shotgunseqs/APHD00002_S10_R2_001.fastq OUT_DIR=. NUM_THREADS=32 MAX_MEM_GB=100

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
