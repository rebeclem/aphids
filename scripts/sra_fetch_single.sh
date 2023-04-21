#!/bin/bash
#SBATCH -J sra_prefectch_dump_single
#SBATCH -o sra_prefectch_dump_single.out
#SBATCH -e sra_prefectch_dump_single.err
#SBATCH -n 6 -N 1
#SBATCH -p medium
#SBATCH -t 4-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com

/90daydata/aphid_phylogenomics/chris/public_genomes_transcriptomes/sratoolkit.3.0.0-centos_linux64/bin/prefetch -X 60000000 SRR3466613
/90daydata/aphid_phylogenomics/chris/public_genomes_transcriptomes/sratoolkit.3.0.0-centos_linux64/bin/fastq-dump SRR3466613/SRR3466613.sra --split-3 --skip-technical -O /90daydata/aphid_phylogenomics/chris/public_genomes_transcriptomes/ncbi_fastqs

./sratoolkit.3.0.0-centos_linux64/bin/prefetch -X 60000000 SRR18085628
./sratoolkit.3.0.0-centos_linux64/bin/fastq-dump SRR18085628/SRR18085628.sra --split-3 --skip-technical -O /90daydata/aphid_phylogenomics/chris/public_genomes_transcriptomes/ncbi_fastqs
