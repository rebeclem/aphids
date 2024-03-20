#!/bin/bash
#SBATCH -J cov_array
#SBATCH -o cov_%A_%a.out
#SBATCH -e cov_%A_%a.err
#SBATCH -N 1 -n 20
#SBATCH -t 2-00:00:00
#SBATCH -p atlas
#SBATCH -A aphid_phylogenomics
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --array=1-36

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)

#--- Starrt timer
t1=$(date +"%s")

echo "Starting $name1"
module load singularity/ce-3.11.0
module load minimap2/2.17
module load samtools

# from https://blobtoolkit.genomehubs.org/blobtools2/blobtools2-tutorials/adding-data-to-a-dataset/adding-coverage/

minimap2 -ax sr \
        -t 20 ../masurca_assemblies/${name1}_primary.genome.scf.fasta \
        ../rawdata/${name1}*R1*.fastq ../rawdata/${name1}*R2*.fastq \
| samtools sort -@16 -O BAM -o ${name1}_masurca.bam -



#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
