#!/bin/bash
#SBATCH -J myzusbothVCF_array
#SBATCH -o variant_%A_%a.out
#SBATCH -e variant_%A_%a.err
#SBATCH --array=1-11
#SBATCH -N 1 -n 4
#SBATCH -t 2-00:00:00
#SBATCH -p short,mem-low,scavenger,scavenger-mem
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


base=$(sed -n "$SLURM_ARRAY_TASK_ID"p SampNames.txt)

#--- Start the timer
t1=$(date +"%s")

echo "Starting $base at ($(date))"
module load bwa/0.7.17
module load samtools/1.17
module load bcftools/1.16

genome=Phorodon_humuli_v2_scaffolds.braker.filtered.cds.LTPG.fa

fq1=~/90day_aphid/raw_data/aphid_shotgun_sequencing_trimmed/${base}*1.fastq.gz
    fq2=~/90day_aphid/raw_data/aphid_shotgun_sequencing_trimmed/${base}*2.fastq.gz
    sam=~/90day_aphid/snp/aphis/sam/${base}.aligned.sam
    bam=~/90day_aphid/snp/aphis/bam/${base}.aligned.bam
    sorted_bam=~/90day_aphid/snp/aphis/bam/${base}.aligned.sorted.bam
    raw_bcf=~/90day_aphid/snp/aphis/bcf/${base}_raw.bcf
    variants=~/90day_aphid/snp/aphis/vcf/${base}_variants.vcf
    final_variants=~/90day_aphid/snp/aphis/vcf/${base}_final_variants.vcf 

    bwa mem $genome $fq1 $fq2 > $sam
    samtools view -S -b $sam > $bam
    samtools sort -o $sorted_bam $bam
    samtools index $sorted_bam
    bcftools mpileup -O b -o $raw_bcf -f $genome $sorted_bam
    bcftools call --ploidy 1 -m -v -o $variants $raw_bcf 
    /software/7/apps/bcftools/1.14/bin/vcfutils.pl varFilter $variants > $final_variants


#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."


