#!/bin/bash
#SBATCH -J astral_myzus
#SBATCH -o astral_%A_%a.out
#SBATCH -e astral_%A_%a.err
#SBATCH -N 1 -n 40
#SBATCH -t 2-00:00:00
#SBATCH -p short
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the timer
t1=$(date +"%s")

module load java

java -jar /home/rebecca.clement/90day_aphid/scripts/Astral/astral.5.7.8.jar -i myzus_7052genes.tre -o myzus_7052genes_astral.tre 2> myzus_astral.log

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

