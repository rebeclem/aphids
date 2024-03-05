#!/bin/bash
#SBATCH -J blob_array
#SBATCH -o blob_%A_%a.out
#SBATCH -e blob_%A_%a.err
#SBATCH -N 1 -n 20
#SBATCH -t 1:00:00
#SBATCH -p debug
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --array=1-34

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)

#--- Starrt timer
t1=$(date +"%s")

echo "Starting $name1"
#module load blast+/2.13.0
module load samtools/1.17
module load miniconda
source activate discovarenv

#blastparams="6 qseqid staxids bitscore std sscinames sskingdoms stitle"

#blastn -task megablast -query $name1/a.final/a.lines.fasta -db /reference/data/NCBI/blast/2023-08-31/nt -outfmt "6 qseqid staxids bitscore std sscinames sskingdoms stitle" -culling_limit 5 -num_threads 16 -evalue 1e-25 -out ${name1}_a.lines.megablast_nt
#culling limit sets the number of hits returned per subject sequence

# Generate blobdb
blobtools create -i $name1/a.final/a.lines.fasta -c $name1/a.final/a.covs -t ${name1}_a.lines.megablast_nt -o ${name1}_megablast_nt
# This command takes in the fasta from discovar and a coverage file and the --hits file from blast and outputs something as the prefix

# Make output tables at genus, order and phylum level
blobtools view -i ${name1}_megablast_nt.blobDB.json -r genus -o genus
blobtools view -i ${name1}_megablast_nt.blobDB.json -r order -o order
blobtools view -i ${name1}_megablast_nt.blobDB.json -r phylum -o phylum

#Make blob plots at genus, order and phylum level
blobtools blobplot -i ${name1}_megablast_nt.blobDB.json --format pdf -r genus -o genus
blobtools blobplot -i ${name1}_megablast_nt.blobDB.json --format pdf -r order -o order
blobtools blobplot -i ${name1}_megablast_nt.blobDB.json --format pdf -r phylum -o phylum

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
