# Running snaq to test for hybridization between all taxa including aphis and myzus

In the [SNaQ manuscript](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1005896), they are able to successfully run the snaq network analysis with 24 taxa. In total, we have ~56 taxa, from about 34 different species. I think if we subset to include one taxa from each species, this might be manageable.

1. Make a directory called "snaqboth",
2. First we need to make some new gene trees with just the taxa we want to include. Use this [combined_align script](scripts/combined_align.py) to remove the samples in the removeTaxa.txt file from each of the alignments.
3. Make a list of genes. `for f in *_final.fasta; do pref="${f%%_*}"; echo "$pref" >> genelist.txt; done`
4. Run [iqtree_getpartitions.py](scripts/iqtree_getpartitions.py) to get partition files
5. Next make a tree from each of them using iqtree_array_AAUR.sh but change the number of arrays to 5589
6. `cat OG*treefile > ../trees/combined_gene.tre`. Remove OG #s with `sed 's/-OG[0-9]*//g; s/ //g' combined_gene.tre > combined_gene2.tre`
7. get on an interactive node and load the julia module
8. 
9. 
