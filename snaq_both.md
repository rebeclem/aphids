# Running snaq to test for hybridization between all taxa including aphis and myzus

In the [SNaQ manuscript](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1005896), they are able to successfully run the snaq network analysis with 24 taxa. In total, we have ~56 taxa, from about 34 different species. I think if we subset to include one taxa from each species, this might be manageable.

1. Make a directory called "snaqboth",
2. First we need to make some new gene trees with just the taxa we want to include. Use this [combined_align script](scripts/combined_align.py) to remove the samples in the removeTaxa.txt file from each of the alignments.
3. Make a list of genes. `for f in *_final.fasta; do pref="${f%%_*}"; echo "$pref" >> genelist.txt; done`
4. Run [iqtree_getpartitions.py](scripts/iqtree_getpartitions.py) to get partition files
5. Next make a tree from each of them using iqtree_array_AAUR.sh but change the number of arrays to 5589
6. Make sure you have all the trees: `ls *treefile | wc -l` 
7. `cat OG*treefile > ../trees/combined_gene.tre`. Remove OG #s with `sed 's/-OG[0-9]*//g; s/ //g' combined_gene.tre > combined_gene2.tre`
8. Run [astral](scripts/astral_both.sh)
9. get on an interactive node and load the julia module, press "]" to load packages, `activate "/project/aphid_phylogenomics/becca/.julia/project0"`, `add PhyloNetworks`, `add CSV`, `add DataFrames`
10. Read in gene trees `using PhyloNetworks; genetrees = readMultiTopology("../trees/combined_gene2.tre");`
11. Calculate the quartets in your gene trees `q,t = countquartetsintrees(genetrees);` and put it in a data frame `df = writeTableCF(q,t)`
6) Write it to a CSV: `using CSV; CSV.write("both_tableCF.csv", df);` and then read it in as a DataCF object: `iqtreeCF = readTableCF("both_tableCF.csv")`
11. Edit [snaq_both.jl](scripts/snaq_both.jl) to have the correct environment and astral tree (I rooted it this time to see if it'd work better), and tableCF.csv file
12. Run snaq_both.sh in the analysis folder.



## Next, run DSUITE
* In snp, make a directory called "both".
* We should use [this genome](https://www.ncbi.nlm.nih.gov/datasets/genome/GCF_001856785.1/) for Aphis gossypii since it's certified and has chromosome level. use wget with the curl, then unzip and the file will be a .fna file.
* Transfer the Aphis gossypii references here. Make index files on an interactive node (load bwa first) with `bwa index GCF_020184175.1_ASM2018417v2_genomic.fna`. After this, you should see six files in the directory.
* Make output files: `mkdir -p sam bam bcf vcf`
* Use globus to transfer the cleaned fastq files to a directory ../cleanedFiles
* Make a list of sample names called SampNames.txt
* run [make_vcf_both.sh](scripts/make_vcf_both.sh).
* Also run [make_vcf_mathers_both.sh](scripts/make_vcf_mathers_both.sh)
* 
