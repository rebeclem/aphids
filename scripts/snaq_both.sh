#!/bin/bash
#SBATCH -J snaq
#SBATCH -o snaq_%A_%a.out
#SBATCH -e snaq_%A_%a.err
#SBATCH -p long,scavenger
#SBATCH --array=0-10
#SBATCH -c 31
# #SBATCH --mem-per-cpu=10
#SBATCH -t 21-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

module load julia/1.9.3 
echo "slurm task ID = $SLURM_ARRAY_TASK_ID used as hmax"
echo "start of SNaQ parallel runs on $(hostname)"
# finally: launch the julia script, using Julia executable appropriate for slurm, with full paths:
julia --project="/project/aphid_phylogenomics/becca/.julia/project0/" ~/scripts/snaq_both.jl $SLURM_ARRAY_TASK_ID 10 > net${SLURM_ARRAY_TASK_ID}_10runs.screenlog 2>&1
echo "end of SNaQ run ..."

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."
