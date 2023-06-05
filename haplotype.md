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

7. Use these R functions to convert your VCF files to geno:
```
vcf_to_geno <- function(outname,filenames) {
  genodf=data.frame(matrix(ncol = 3, nrow = 0))
  for (i in 1:length(filenames)){
    APH_temp<-read.table(filenames[i])
    colnames(APH_temp)<-c("#CHROM", "POS", "ID", "REF", "ALT", "QUAL", "FILTER", "INFO",
                           "FORMAT", "SAMPLE0")
    # Combine the REF and ALT columns with a "/"
    APH_temp$nucs<-paste0(APH_temp$REF,"/",APH_temp$ALT)
    
    # Split columns that might say INDEL
    APH_temp<-APH_temp %>% separate(INFO,";",into=c("INDEl","INFO"),extra="merge")
    newdf<-APH_temp[APH_temp$INDEl!="INDEL",c("#CHROM","POS","nucs")]
    colnames(newdf)[3]<-substr(filenames[i],1,15)
    #if genodf exists, leftmerge based on chromosome and pos, otherwise, create genodf
    if (nrow(genodf)==0){
      genodf<-newdf
    }else{
      genodf<-merge(x=genodf,y=newdf,by=c('#CHROM','POS'),all=T)
    }
  }
  # Next we need to replace NAs with N/N
  #genodf[is.na(genodf)]<-"N/N"
  write.table(genodf,outname,quote=F,row.names=F)
  return(genodf)
}
outname<-"aphis_NA.geno"
filenames=dir(pattern="*_final_variants.vcf")
aphis_genodf<-vcf_to_geno(outname,filenames)
```
Next, filter to only include SNPs present in at least 75% of samples and replace the NAs with the reference seqs:
```
NAtoNuc <- function(genodf,outnew) {
  for (i in 1:nrow(genodf)){
    # if there are any non-na values, set them to temp
    #temp_nuc<-strsplit(as.character(genodf[i,which(!is.na(genodf[i,]))][3]),"/")[[1]][1]
    temp_nuc<-genodf[i,which(!is.na(genodf[i,]))][3]
    # str_split temp by / and keep just the first part of it
    temp_nuc<-strsplit(as.character(temp_nuc),"/")[[1]][1]
    #temp_nuc<-paste0(temp_nuc,"/",temp_nuc)
    # make temp temp/temp
    # set any NA values to temp
    genodf[i,is.na(genodf[i,])]<- paste0(temp_nuc,"/",temp_nuc)
    #print(i)
  }
  write.table(genodf,outnew,quote=F,row.names=F)
  return(genodf)
}
aphis_inf<-aphis_genodf[which(rowSums(is.na(aphis_genodf))<((ncol(aphis_genodf)-2)*.25)),] #informative snps? SNPs that have NA in fewer than .25 samples 
dim(aphis_inf) #85835    36
aphis_genoNew<-NAtoNuc(aphis_inf,outnew)
```
8. Make a text file called "aphis_pop.txt" with the first column the names in aphis_genoNew and the second column the species names. `ls *final_variants.vcf | cut -c1-15 > aphis_pop.txt` then add a column with species names
9. Using the python files from [here](https://github.com/simonhmartin/tutorials/tree/master/ABBA_BABA_whole_genome), run the following `python ../genomics_general-master/freq.py -g myzus_new.geno -p ornatus -p antirhinii -p varians -p fataunae -p cerasi -p persicae --popsFile  myzus_pop.txt --target derived -o myzus75.derFreq.tsv` and for myzus do `python ../genomics_general-master/freq.py -g aphis_new.geno -p spiraecola -p craccivora -p ASPnl -p aurantii -p ruborum -p ASPnl2 -p coreopsidis -p nasturtii -p fabae -p sedi -p ASPsv -p ASPva -p nerii -p Melanaphis -p viburniphila -p affinis -p cornifoliae -p ASPlk -p Hyalopterus -p glycines -p gossypii -p urticata --popsFile  aphis_pop.txt --target derived -o aphis75.derFreq.tsv`.
10. 
Maybe we need to merge the vcf files using an actual thing. Trying with bcftools -merge. First need to pip install bgzip in a virtual environment.

