# Possible *Aphis/Myzus* hybrids

In our analyses, a few specimens have given me trouble. 

APHD00027ASPnl2 was first identified as Myzus ascalonicus, and APHD00270ASPlk was first identified as Myzus varians. In the mitochondrial tree, these come out in the Aphis gossyppii clade, but in the nuclear tree, they come out as outgroups to Myzus.

![Figure of phylogenies](figs/aphis_myzus3trees.png)

Thomas Mathers didn't believe they would hybridize. He thinks it's more likely we sequenced more than one species together. He recommended I use IGV to look at the SNP files. 

This is what it looked like with Aphis:

![Figure of IGV with Aphis](figs/IGV_aphis.png)

The two mystery ones are suspiciously heterozygous. But what if we look at them when compared to other Myzus species?

I'm not sure where these files are right now, so instead I'm going to look at the vcf files to see if I can see cases where there are more then 2 options. VCF files have options that look like this: 0/1:108,0,77. In this case, the 0 indicates the reference allele, the 1 indicates the alternative allele. The PL is the likelihood of the sample being either 0/0,0/1 or 1/1.

Thomas mentioned something about concordance factors. 
