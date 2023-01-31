#!/bin/bash
#SBATCH -J compress
#SBATCH -o compress_%A_%a.out
#SBATCH -e compress_%A_%a.err
#The next line tells slurm this is an array that will submit 149 garli jobs across the cluster
#SBATCH --array=1-33
#SBATCH --nodes=1
#SBATCH -t 1-00:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=rebeclem@gmail.com

module load pigz
name1=$(sed -n "$SLURM_ARRAY_TASK_ID"p namelist_compress.txt)

#otherlist=["other_ACRA_empraba_SRR5651507","other_ACRA_LBME_SRR9901306","other_AFAB_empraba_SRR5651508","other_AGLY_bt1_SRR10158900","other_AGLY_bt2_SRR10355383","other_AGLY_bt3_SRR10355382","other_AGLY_bt4_SRR3190086","other_AGOS_Hap1_SRR14552454","other_AGOS_Hap3_SRR14552459","other_AGOS_hic_ERR6928994","other_AURT_QM_SRR11037232"]

tar --use-compress-program=pigz -cf ${name1}_COI.tar.gz ${name1}_COI

tar --use-compress-program=pigz -cf ${name1}_aa.tar.gz ${name1}_aa
