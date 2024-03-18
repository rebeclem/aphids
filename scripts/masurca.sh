#!/bin/bash
#SBATCH -J masurca
#SBATCH -o masurca_%A_%a.out
#SBATCH -e masurca_%A_%a.err
#SBATCH -N 1 -n 80 
#SBATCH -t 2-00:00:00
#SBATCH -p short,medium,long,scavenger
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --array=1-25

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)
filef=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelistf.txt)
filer=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelistr.txt)

#--- Start the timer
t1=$(date +"%s")

echo "Starting $name1"
module load masurca/4.1.0

#masurca ../config2.txt
# ./assemble.sh
rm -r $name1
mkdir $name1
cd $name1
masurca -i $filef,$filer -t 80   
cd ..

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

