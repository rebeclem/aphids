#!/bin/bash
#SBATCH -J blob_array
#SBATCH -o blob_%A_%a.out
#SBATCH -e blob_%A_%a.err
#SBATCH -N 1 -n 10
#SBATCH -t 1:00:00
#SBATCH -p debug,mem-low,brief-low
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --array=1-36

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)

#--- Starrt timer
t1=$(date +"%s")

echo "Starting $name1"
#module load blast+/2.13.0
#module load samtools/1.17
#module load miniconda
#source activate discovarenv
module load blobtools/4.3.6

#blastparams="6 qseqid staxids bitscore std sscinames sskingdoms stitle"

#blastn -task megablast -query $name1/a.final/a.lines.fasta -db /reference/data/NCBI/blast/2023-08-31/nt -outfmt "6 qseqid staxids bitscore std sscinames sskingdoms stitle" -culling_limit 5 -num_threads 16 -evalue 1e-25 -out ${name1}_a.lines.megablast_nt
#culling limit sets the number of hits returned per subject sequence

# Generate blobdb
blobtools create --fasta /90daydata/aphid_phylogenomics/becca/masurca/masurca_assemblies/${name1}_primary.genome.scf.fasta.gz $name1

# add coverage
blobtools add --cov ../masurca/coverage/${name1}_masurca.bam $name1

# add taxonomic info
blobtools add --hits ../masurca/megablast/${name1}_masurca.megablast_nt --taxrule bestsumorder --taxdump ./taxdump $name1

# plot
blobtools view --plot $name1
# snail plot
blobtools view --plot --view snail  $name1
# plot colored at a different rank
blobtools view --plot --param catField=bestsumorder_genus $name1 --out $name1 # this outputs the genus level one into the individual folder.

# This command takes in the fasta from discovar and a coverage file and the --hits file from blast and outputs something as the prefix

# Make output tables at genus, order and phylum level
#blobtools view -i ${name1}_masurca.megablast_nt.blobDB.json -r genus -o genus
#blobtools view -i ${name1}_masurca.megablast_nt.blobDB.json -r order -o order
#blobtools view -i ${name1}_masurca.megablast_nt.blobDB.json -r phylum -o phylum

#Make blob plots at genus, order and phylum level
#blobtools blobplot -i ${name1}_masurca.megablast_nt.blobDB.json --format pdf -r genus -o genus
#blobtools blobplot -i ${name1}_masurca.megablast_nt.blobDB.json --format pdf -r order -o order
#blobtools blobplot -i ${name1}_masurca.megablast_nt.blobDB.json --format pdf -r phylum -o phylum

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
