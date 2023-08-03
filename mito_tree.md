# Mitochondrial tree

We have most of the mitochondrial genes in two folders fasta_output_COI. I want to make one mitochondrial tree for all the mitochondrial genes. 
    * Make a list of mitochondrial genes called mtgenes.txt
```
COX1
COX2
COX3
ATP6
ATP8
ND1
ND2
ND3
ND4
ND4L
ND5
ND6
CYTB
```
    * Copy aphis mitochondrial genes to mito folder: `while read p; do cp ../aphis/hybpiper/fasta_output_COI/${p}.FNA .; done <mtgenes.txt`
    * Add myzus mitochondrial genes to ends of aphis ones: `while read p; do cat ../myzus/hybpiper/fasta_output_COI/${p}.FNA>>${p}.FNA; done <mtgenes.txt`
    * Somehow get the mitochondrial genes from the mathers ones and add them to the fasta file
    * Change the heading lines of fasta files 
    * Merge the files together into one giant fasta file
