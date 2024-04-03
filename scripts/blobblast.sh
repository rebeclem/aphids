#!/bin/bash
#SBATCH -J blob_array
#SBATCH -o blob_%A_%a.out
#SBATCH -e blob_%A_%a.err
#SBATCH -N 1 -n 20
#SBATCH -t 2-00:00:00
#SBATCH -p short,scavenger,scavenger-gpu,scavenger-mem768,medium
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --array=1-34

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)

#--- Starrt timer
t1=$(date +"%s")

echo "Starting $name1"
module load blast+/2.13.0

blastparams="6 qseqid staxids bitscore std sscinames sskingdoms"

blastn -task megablast -query $name1/CA/primary.genome.scf.fasta -db /reference/data/NCBI/blast/2023-08-31/nt -outfmt "6 qseqid staxids bitscore std sscinames sskingdoms stitle" -culling_limit 5 -num_threads 16 -evalue 1e-25 -out ${name1}_masurca.megablast_nt
#culling limit sets the number of hits returned per subject sequence


#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
