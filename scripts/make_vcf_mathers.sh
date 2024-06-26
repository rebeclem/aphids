#!/bin/bash
#SBATCH -J variant_array
#SBATCH -o variant_Mathers_%A_%a.out
#SBATCH -e variant_Mathers_%A_%a.err
#SBATCH -N 1
#SBATCH -t 2-00:00:00
#SBATCH -p mem
#SBATCH --mail-type=ALL
#SBATCH --array=1-5
#SBATCH --mail-user=rebeclem@gmail.com

# #SBATCH --mem-per-cpu=3000

base=$(sed -n "$SLURM_ARRAY_TASK_ID"p SampMather.txt)
bamname=$(sed -n "$SLURM_ARRAY_TASK_ID"p SampMather_out.txt)
#--- Start the timer
t1=$(date +"%s")

echo "Starting $base at ($(date))"
module load bwa
module load samtools
module load bcftools

#genome=Phorodon_humuli_v2_scaffolds.braker.filtered.cds.LTPG.fa
genome=Aphis_gossypii_1033E_v1.scaffolds.braker.cds.LTPG.fa
#shortname= ${base//*\/}
# genome2=~/90day_aphid/snp/myzus/Myzus_varians_v1.1.scaffolds.braker.filtered.cds.LTPG.fa

# Editing this to include the scaffolds from Mathers
bwa mem -t 8 $genome $base | samtools sort -@8 -o $bamname
#bwa mem -t 8 $genome ~/90day_aphid/raw_data/Frozen_release/Aphis_rumicis/v1/Aphis_rumicis_v1.scaffolds.fa | samtools sort -@8 -o aphis/bam/Aphis_rumicis_v1.aligned.sorted.bam -
#bwa mem -t 8 $genome ~/90day_aphid/raw_data/Frozen_release/Aphis_gossypii/1033E_v1/Aphis_gossypii_1033E_v1.scaffolds.fa | samtools sort -@8 -o aphis/bam/Aphis_gossypii_1033E_v1.aligned.sorted.bam
#bwa mem -t 8 $genome2 ~/90day_aphid/raw_data/Frozen_release/Aphis_fabae/JIC1_v2/Aphis_fabae_JIC1_v2.scaffolds.fa | samtools sort -@8 -o aphis/bam/Aphis_fabae_JIC1_v2.aligned.sorted.bam
#bwa mem -t 8 $genome ~/90day_aphid/raw_data/Frozen_release/Aphis_thalictri/v1/Aphis_thalictri_v1.scaffolds.fa | samtools sort -@8 -o aphis/bam/Aphis_thalictri_v1.aligned.sorted.bam
#bwa mem -t 8 $genome ~/90day_aphid/raw_data/Frozen_release/Annotation_only/Aphis_glycines/Aphis_glycines_4.v2.1.scaffolds.fa | samtools sort -@8 -o aphis/bam/Aphis_glycines_4.v2.1.aligned.sorted.bam
#bwa mem -t 8 $genome2 ~/90day_aphid/raw_data/Frozen_release/Annotation_only/Myzus_cerasi/JHL1_v1.2/Myzus_cerasi_v1.2.scaffolds.fa | samtools sort -@8 -o myzus/bam/Myzus_cerasi_v1.2.aligned.sorted.bam
#bwa mem -t 8 $genome2 ~/90day_aphid/raw_data/Frozen_release/Myzus_ligustri/v1.1/Myzus_ligustri_v1.1.scaffolds.fa | samtools sort -@8 -o myzus/bam/Myzus_ligustri_v1.1.aligned.sorted.bam
#bwa mem -t 8 $genome2 ~/90day_aphid/raw_data/Frozen_release/Myzus_lythri/v1.1/Myzus_lythri_v1.1.scaffolds.fa | samtools sort -@8 -o myzus/bam/Myzus_lythri_v1.1.aligned.sorted.bam
#bwa mem -t 8 $genome2 ~/90day_aphid/raw_data/Frozen_release/Myzus_varians/v1.1/Myzus_varians_v1.1.scaffolds.fa | samtools sort -@8 -o myzus/bam/Myzus_varians_v1.1.aligned.sorted.bam


#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

