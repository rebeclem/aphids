# Haplotype phasing

To be able to test for ABBA BABA we need to first get the snps. [Here](http://data-science-sequencing.github.io/Win2018/lectures/lecture10/) is a good explanation of SNP calling.

The basic workflow is (referenceing [this](https://sateeshperi.github.io/nextflow_varcal/nextflow/nextflow_variant_calling) website):

1. Align reads to reference sequences using BWA or bowtie
2. This will output SAM format files. You need to convert them to BAM files and sort them
4. Then, use mpileup to convert it to VCFs and call and filter the snps.
5. To do this:
   * First make a directory called snp to run the analysis in with subdirectories for Aphis and Myzus
   * Then copy the reference file from [Mathers et al ](https://zenodo.org/record/5908005#.ZC885-zMIea) to that directory.
   * Next, make a list of names you want to get variant files for: `for fq1 in ~/90day_aphid/aphis/hybpiper/APHD*_R1_A_trim.fastq.gz;  do base=$(basename $fq1 _R1_A_trim.fastq.gz);  echo "$base"; done > SampNames.txt`
   * On an interactive node, load the bwa module and make index files for the reference file: `bwa index Aphis_fabae_JIC1_v2.scaffolds.braker.filtered.cds.fa`
   * Make output directories for the results `mkdir -p sam bam bcf vcf`
   * Run sbatch on the [make_vcf](scripts/make_vcf.sh) script --first change the number for the array to the number of files in SampNames.txt.
   * This will give you output files of a bunch of vcf files.
6. Next, we need to process these to convert them to a .geno file. See [here](https://github.com/gibert-Fab/ABBA-BABA). We want it too look like this:
```
#CHROM      POS      ind1      ind2      ind3
scaffold1  1        A/A       A/G       G|A
scaffold1  1        N/N       T/T       T|C
```
    * Use [this](scripts/parseVCFs.py) to put together multiple VCFs
