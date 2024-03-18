#!/bin/bash
#SBATCH -J bowtie2
#SBATCH -o bowtie_%A_%a.out
#SBATCH -e bowtie_%A_%a.err
#SBATCH -N 1 -n 20 
#SBATCH -t 1:00:00
#SBATCH -p debug
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com
#SBATCH --array=1-34

name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist.txt)
filef=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelistf.txt)
filer=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelistr.txt)

#--- Start the timer
t1=$(date +"%s")

echo "Starting $name1"
module load bowtie2/2.5.2
module load samtools/1.17

# build the bowtie2 indexes
bowtie2-build $name1/a.final/a.lines.fasta $name1/a.final/a.lines.fasta

# now map the reads back
bowtie2 -p 8 -x $name1/a.final/a.lines.fasta -1 $filef -2 $filer -S $name1.map.sam

#convert to bam format
samtools view -bt $name1/a.final/a.lines.fasta.fai $name1.map.sam > $name1.map.bam
samtools sort $name1.map.bam -o $name1.map.sorted.bam
samtools index $name1.map.sorted.bam



#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

