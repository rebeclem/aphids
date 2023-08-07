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
    * Somehow get the mitochondrial genes from the mathers ones and add them to the fasta file. JK, the SRA from these are not available. 
    * Change the heading lines of fasta files. On an interactive node, load miniconda, then virtual environment `source ~/90day_aphid/conda_env/virt_test/bin/activate`. Run `python ~/90day_aphid/aphids_github/scripts/name_change_FNA.py`
    * Align the files with `module load mafft` and 
```
    for f in *final.fasta; do
mafft --auto --anysymbol ${f} > ${f}_align
done
```
    * Concatenate the files together into one giant fasta file using `module load phyx` then `pxcat -s *_final.fasta -p partitions.txt -o mito_concat.fasta`
    * Make a tree using iqtree. `module load iq_tree`, then `iqtree2 -s mito_concat.fasta -p partitions.txt -nt AUTO -m TESTMERGE -bb 1000 -pre mito_iqtree`

![mito tree 1](figs/mito_with_2AAUR.png)

    * Then I remembered that we got rid of the other AAUR bc we couldn't sort out which were parasitoids. Remove that sequence and run again: `iqtree2 -s mito_concat.fasta -p partitions.txt -nt AUTO -m TESTMERGE -bb 1000 -pre mito_iqtree_1AAUR`

Now the tree looks like:
![mito tree 3](figs/mito_iqtree.treefile)
