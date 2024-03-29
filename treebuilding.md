# Building trees

## Building phylogeny using concatenation

To build a tree with concatenation, we need a fasta file. In the fasta_output_aa directory of hybpiper, we have 8631 (for *Aphis*) and 7064 (for *Myzus*) .FAA files and .FNA files. Each of these has sequences from each species of aphid, but we also need to align the original target files that we mapped to from the genomes online. The names of the sequences in the .FAA and .FNA files don't have the gene name and have descriptions like "APHD00002ASPI_aa multi_hit_stitched_contig_comprising_2_hits", while the names in the target files (targets_aa_OG.fa and targets_all_OG.fa) are formatted with the name and the gene "AFAB-OG0003568".

1) First, we need to rename the sequences in the .FAA and .FNA files. Allocate an active node with `salloc`. Load miniconda and a python environment then use the command: `python ../../../scripts/name_change_FAA.py` to run [name_change_FAA.py](scripts/name_change_FAA.py) in the fasta_output folder. This script renames the sequences in the .FAA and .FNA files to be in the format ">APHD00022MORN-OG0005271", then adds the matching sequences from each of the target files and results in files that end in "\_aafinal.fasta" for the amino acids and " \_nucfinal.fasta" for the nucleotide files. This takes a few hours.
2) Check to make sure all of the files are there using: `ls *_nucfinal.fasta | wc -l` and `ls *FAA | wc -l`
3) Also check how many of these have complete data (at least one sequence for every taxa) with `grep -c "^>" *FNA | grep -c "14"` for Myzus (Should be 6182) and `grep -c "^>" *FNA | grep -c "33"` for Aphis (there are only 46 of these. 7880 have at least 30 sequences).
4) Make a directory called "Analysis" in both the *Aphis* and *Myzus* directories and transfer all the files from fasta_output_aa directory using `mv *.fasta ../../Analysis`. 
5) Make a list of gene names using `for f in *aafinal.fasta; do pref="${f%%_*}"; echo "$pref" >> genelist.txt; done`. In the Analysis directory, align the amino acid files using the [mafft_array script](scripts/mafft_array.sh) and `sbatch ../../scripts/mafft_array.sh` (takes about 30min). Check for empty files using `find *align -empty`.
6) Now we will use PAL2NAL and the amino acid alignments to align the DNA. In the Analysis directory, run the [pal.sh](scripts/pal.sh) script which uses the [pal2nal](https://github.com/nextgenusfs/funannotate/blob/master/funannotate/aux_scripts/pal2nal.pl) script (takes ~10min). 
7) You should end up with **7064** files that end in pal.fasta for myzus and **8631** files for Aphis. Double check with `ls *pal.fasta | wc -l` to make sure they are all there.
8) Then we will trim using [GBLOCKS](https://anaconda.org/bioconda/gblocks). First make a virtual environment for gblocks. Load the miniconda module: `module load miniconda`. Activate it: `source activate gblocks`, then install gblocks using two commands: `conda install -c bioconda gblocks` and `conda install -c "bioconda/label/cf201901" gblocks`. If you need to run gblocks again, just use `source activate gblocks`
9) Now, in the Analysis directory, run the [gblocks.py](scripts/gblocks.py) using `python ../../scripts/gblocks.py`.
  * Make sure that you have **8631** files that end in \_mfgb using the command `ls *mfgb | wc -l` and make sure there are no empty files using `find * -empty`
12) Combine aligned fasta files into a concatenated file using phyx. First we need to make sure all sequence names are the same in each file. This means changing the "APHD00002ASPI-OG0012537" to just "APHD00002ASPI". We also need to remove the spaces from the sequences before concatenating them. Run: `for f in *pal.fasta_mfgb; do prefix="${f%%_*}"; echo "$prefix"; sed 's/-OG.*//g; s/ //g' $f > "${prefix}_final.fasta"; done`.
13) In the "Analysis" directory, use the following command: `sbatch ../../scripts/pxcat.sh` to run the [pxcat](scripts/pxcat.sh) script to concatenate all sequences into one fasta file (takes about 5min to run) and generate a partition file called partitions.txt.
14) You should probably [change the names](https://docs.google.com/spreadsheets/d/1lA_A7v1McQYVXbxUdtAB53EJPoQIcvBhJ5BX2rukXvc/edit#gid=1103610729) of the ones we changed here before you run the tree. For example:
   * sed -i 's/APHD00036DSP/APHD00036BBRA/; s/APHD00071MCER/APHD00071MSPgt/; s/>MCER/>other_MCER_JHI1/; s/>MLIG/>other_MLIG_v1/; s/>MLYT/>other_MLYT_v1/; s/>MPER/>other_MPER_O/; s/>MVAR/>other_MVAR_v1/' myzus_concat.fasta
   * sed -i 's/>APHD00079AGOS/>APHD00079ANAS/; s/>APHD00101ANER/>APHD00101ASPsv/; s/>APHD00122ASPI/>APHD00122ASPva/; s/>APHD00232ASP/>APHD00232AVIB/; s/>APHD00265ANA/>APHD00265ACORN/; s/>AFAB/>other_AFAB_JIC1/; s/>AGLY/>other_AGLY_4v2/; s/>AGOS/>other_AGOS_1033E/; s/>ATHA/>other_ATHA_LTPG/' aphis_concat.fasta

11) We have enough sequences that it makes sense to use only those without missing data for our first concatenated alignment. Make two directories in the Analysis directory--one called "complete" and one called "incomplete". Run `python ../../scripts/missing_data_aphis.py` in the Analysis directory to move the sequences with 19 sequences (for myzus) and 23 ( for Aphis) to the complete folder and those with fewer to the incomplete folder. Change the missing data python script based on max # of reads found with `grep -c "^>" *mfgb`. For myzus DNA, there should be **6154** fasta files in the complete directory and 910 in the incomplete. For Aphis expect **4607** complete and 4024 incomplete.

We now have our concatenated fasta file and a partition file!
### Running IQtree
1) To find the best model using modelfinder run `sbatch ../../../scripts/iqtree_modelfinder.sh` to run [iqtree modelfinder](scripts/iqtree_modelfinder.sh) in the "complete" directory (takes 5 hours).
2) Run IQtree with this best model with the [iqtree_tree.sh](scripts/iqtree_tree.sh) script.

### Viewing the trees
* In the Analysis directory, make a directory called "iqtree_aphis" or "iqtree_myzus", and copy all iqtree output files using `mv iqtree* ../iqtree_aphis`. 
* Make a folder called iqtree_output on your personal computer. Copy the resulting iqtree files to your computer by using the commands: rsync -avh rebecca.clement@ceres.scinet.usda.gov:/90daydata/aphid_phylogenomics/becca/aphis/Analysis/iqtree_aphis .
* Open the concensus file in [figtree](http://tree.bio.ed.ac.uk/software/figtree/).
* Compare to Mather 2022 and Rebijith et al. 2017 tree.

## Building phylogeny using gene tree/species tree methods

Although concatenation methods can give reliably tree inferences, especially with a large amount of genes, it is also a good idea to infer a species tree using individual gene trees. To do this, we will use [ASTRAL-III](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-018-2129-y). 
* To run astral, we need to download the javascript from the [Astral III github page](https://github.com/smirarab/ASTRAL/raw/master/Astral.5.7.8.zip). Then, copy this to the cluster using the following: `rsync -avh Astral rebecca.clement@ceres.scinet.usda.gov:/90daydata/aphid_phylogenomics/becca/scripts`.
* The input of astral should be gene trees in the Newick format. 
* First, let's make partition files for each of the alignments of fasta files that we made in the last step using the file [iqtree_getpartitions.py](scripts/iqtree_getpartitions.py)
* Next, run IQtree on each of the nucleotide alignements using the generated partition files. [This script](scripts/iqtree_array.sh) runs 500 at a time.  Change the iqtree_array script array number to the number of genes you will be doing then run it using `sbatch ../../../scripts/iqtree_array.sh`
* Finally, we will combine the trees into one file so we can run them through ASTRAL. `cat OG*treefile > aphis_gene.tre`. (Or myzus_gene.tre)
* Run [astral.sh](scripts/astral.sh) with the command `java -jar ../../../scripts/Astral/astral.5.5.1.jar -i myzus.gene.tre -o myzus.astral.tre 2> myzus_astral.log`. This should just take a few minutes.
* Change the names in the tree as in step 14. 
  * sed -i 's/APHD00079AGOS/APHD00079ANAS/; s/APHD00101ANER/APHD00101ASPsv/; s/APHD00122ASPI/APHD00122ASPva/; s/APHD00232ASP/APHD00232AVIB/; s/APHD00265ANA/APHD00265ACORN/; s/(AFAB/(other_AFAB_JIC1/; s/,AGLY/,other_AGLY_4v2/; s/(AGOS/(other_AGOS_1033E/; s/(ATHA/(other_ATHA_LTPG/' aphis_astral.tre
* Download the log file and astral tree 

## Building mitochondrial tree
The script we used to pull out COI also included the other of the 13 mitochondrial genes. We will concatenate them and make a [mitochondrial tree](mito_tree.md)

## Dealing with long branches
For *Aphis*, APHD00272AAUR has a very long branch. This is probably because we also sequenced a parasitoid (Lipolexis oregmae (parasitoid)). We need to remove APHD00272AAUR from the alignments where it has too long of a branch. First, we will produce a list of genes and associated distances between the two Aphis aurantii species. Then we will graph the distances to look for separation between the ones that are close and far. Finally, we will remove the APHD00272AAUR from the alignments that it has a long branch for and then re-estimate gene trees and concatenation tree.
* Do something about the long branches. APHD00272AAUR has a parasitoid in it. Run [long_branch.py](scripts/long_branch.py) after you `source activate ete3` to get a list of distances between the two A. aurantii species as well as total tree lengths and longest branches.
* Copy the file called distances.txt to your computer and [use R](AAUR_distance.R) to figure out which branches are the longest and which taxa are responsible for these long branches. This will output a file of the OG genes that have branch lengths longer than 2.5 and the longest branch is AAUR called "Aphis_bigdist.txt".
* Remove APHD00272AAUR from the nucleotide alignments where it is the outgroup and the branch length is longer than 2.5 with [this AAUR_cut script](AAUR_cut.py). `while read p; do seqkit grep -rvip "APHD00272AAUR" ${p}_final.fasta > ${p}New_final.fasta; done < Aphis_bigdist.txt`. Then move the old files to a different place a new directory, oldfastas: `while read p; do mv ${p}_final.fasta oldfastas; done <Aphis_bigdist.txt`.
* Also remove the old trees: `while read p; do rm ${p}_nucs_ml*; done <Aphis_bigdist.txt`
* Make a concatenated tree and an astral tree of these genes without the things.
* This didn't really help so now I'm just going to remove AAUR00272AAUR from all the trees.
* Move the old trees and stuff to a directory calld oldfiles2
* `while read p; do seqkit grep -rvip "APHD00272AAUR" ${p}_final.fasta > ${p}New_final.fasta; done < Aphis_bigdist.txt` (-r for recursive, -v for inversion/select non matches, -i for ignore case)

## Building a combined tree
signs are pointing to possible introgression between aphis gossypii and Myzus persicae. That would be wild. To find this out we need to build a combined tree that includes both the aphis and myzus samples. 
- First, we'll find the orthologs that are shared between aphis and myzus. We'll use APHD00270ASPlk because it has 8415 instead of 8388 for APHD00014ASPnl. 
      - First make 2 files with all sequences for APHD00014MORN/APHD00014ASPnl. APHD00014ASPnl.fa:8388, APHD00014MORN.fa:6606, APHD00270ASPlk.fa:8415, APHD00270MVAR.fa:6982. Use this [name change script](scripts/name_change_FNA2.py).
```
cat ../aphis/hybpiper/APHD00014ASPnl_aa/*/APHD00014ASPnl_aa/sequences/FNA/OG*.FNA > APHD00014ASPnl.fa
cat ../myzus/hybpiper/APHD00014MORN_aa/*/APHD00014MORN_aa/sequences/FNA/OG*.FNA > APHD00014MORN.fa
```

- Next, blast one to the other. `module load blast+` then `blastn -query APHD00270ASPlk.fa -subject APHD00270MVAR.fa -outfmt 6 -evalue 1e-10 -max_target_seqs 1 -max_hsps 1 -perc_identity 99 > blast.txt`. This gives 5589 lines.
- Use [combine orthologs script](scripts/combine_orthologs.py) to combine the alignments with the matching sequences
- Then I'll make a bunch of gene alignments and trees. Align using [mafft script](scripts/mafft_array.sh). change taxa names using `for f in *align.fasta; do prefix="${f%%_*}"; echo "$prefix"; sed 's/-OG.*//g; s/ //g' $f > "${prefix}_final.fasta"; done`. Concatenate using [pxcat](scripts/pxcat.sh). Then use iqtree_concat_combined.sh to run iqtree.
- Gene trees using iqtree_getpartitions then `cat OG*treefile > ../trees/combined_gene.tre`.  Remove OG #s with `sed 's/-OG[0-9]*//g; s/ //g' combined_gene.tre > combined_gene2.tre`
- Then I'll look at the gene trees to see where weird taxa show up (APHD00014, APHD00027, APHD00270)
- Next, we'll make an astral and ML tree
- Then do it again after we delete the duplicated ones
- Then, I'll use toytree to make one of those cool tree clouds
- Then, I'll trim the tree down to a reasonable number of taxa.
- good luck

Next: do [snaq](snaq.md)
