#!/bin/bash
#SBATCH -J masurca_stats
#SBATCH -o masurca_stats_%A_%a.out
#SBATCH -e masurca_stats_%A_%a.err
#SBATCH -N 1 -n 4 
#SBATCH -t 1:00:00
#SBATCH -p debug,brief-low,short,medium,long,scavenger
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --array=1-34

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)
filef=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelistf.txt)
filer=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelistr.txt)

#--- Start the timer
t1=$(date +"%s")

echo "Starting $name1"
module load perl/5.36.0

perl ~/scripts/new_Assemblathon.pl $name1/CA/primary.genome.scf.fasta > ${name1}_assemblathon_stats.txt


#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

