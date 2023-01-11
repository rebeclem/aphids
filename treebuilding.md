# Building trees

## Building phylogeny using concatenation

To build a tree with concatenation, we need a fasta file. In the fasta_output_aa directory of hybpiper, we have 8631 (for *Aphis*) and 7064 (for *Myzus*) .FAA files and .FNA files. Each of these has sequences from each species of aphid, but we also need to align the original target files that we mapped to from the genomes online. The names of the sequences in the .FAA and .FNA files don't have the gene name and have descriptions like "APHD00002ASPI_aa multi_hit_stitched_contig_comprising_2_hits", while the names in the target files (targets_aa_OG.fa and targets_all_OG.fa) are formatted with the name and the gene "AFAB-OG0003568".

1) First, we need to rename the sequences in the .FAA and .FNA files. Allocate an active node with `salloc`. Load miniconda and a python environment then use the command: `python ../../../scripts/name_change_FAA.py` to run [name_change_FAA.py](scripts/name_change_FAA.py). This script renames the sequences in the .FAA and .FNA files to be in the format ">APHD00022MORN-OG0005271", then adds the matching sequences from each of the target files and results in files that end in "\_aafinal.fasta" for the amino acids and " \_nucfinal.fasta" for the nucleotide files. This takes a few hours.
2) Check to make sure all of the files are there using: `ls *_nucfinal.fasta | wc -l` and `ls *FAA | wc -l`
3) Also check how many of these have complete data (at least one sequence for every taxa) with `grep -c "^>" *FNA | grep -c "14"` for Myzus (Should be 6182) and `grep -c "^>" *FNA | grep -c "34"` for Aphis.
4) Make a directory called "Analysis" in both the *Aphis* and *Myzus* directories and transfer all the files from fasta_output_aa directory using `mv *.fasta ../../Analysis`. 
5) In the Analysis directory, align the amino acid files using the [mafft script](scripts/mafft.sh) and `sbatch ../../scripts/mafft.sh`.
6) Now we will use PAL2NAL and the amino acid alignments to align the DNA. In the Analysis directory, run the [pal.sh](scripts/pal.sh) script which uses the [pal2nal](https://github.com/nextgenusfs/funannotate/blob/master/funannotate/aux_scripts/pal2nal.pl) script. 
7) You should end up with **7064** files that end in pal.fasta for myzus and **8631** files for Aphis. Double check with `ls *pal.fasta | wc -l` to make sure they are all there.
8) Then we will trim using [GBLOCKS](https://anaconda.org/bioconda/gblocks). First make a virtual environment for gblocks. Load the miniconda module: `module load miniconda`. Activate it: `source activate gblocks`, then install gblocks using two commands: `conda install -c bioconda gblocks` and `conda install -c "bioconda/label/cf201901" gblocks`. If you need to run gblocks again, just use `source activate gblocks`
9) Now, in the Analysis directory, run the [gblocks.py](scripts/gblocks.py) using `python ../../scripts/gblocks.py`.
  * Make sure that you have **8631** files that end in \_mfgb using the command `ls *mfgb | wc -l` and make sure there are no empty files using `find * -empty`
10) We have enough sequences that it makes sense to use only those without missing data for our first concatenated alignment. Make two directories in the Analysis directory--one called "complete" and one called "incomplete". Run `python ../../scripts/missing_data_aphis.py` in the Analysis directory to move the sequences with 19 sequences (for myzus) and 23 ( for Aphis) to the complete folder and those with fewer to the incomplete folder. Change the missing data python script based on max # of reads found with `grep -c "^>" *mfgb`. For myzus DNA, there should be **4625** fasta files in the complete directory and 2437 in the incomplete. For Aphis expect **4607** complete and 4024 incomplete.
11) To clean things up, make a directory called "intermediate" and move all the files that begin with "OG" there. 
12) Combine aligned fasta files into a concatenated file using phyx. First we need to make sure all sequence names are the same in each file. This means changing the "APHD00002ASPI-OG0012537" to just "APHD00002ASPI". We also need to remove the spaces from the sequences before concatenating them. Run: `for f in *pal.fasta_mfgb; do prefix="${f%%_*}"; echo "$prefix"; sed 's/-OG.*//g; s/ //g' $f > "${prefix}_final.fasta"; done`.
13) In the "complete directory", use the following command: `sbatch ../../../scripts/pxcat.sh` to run the [pxcat](scripts/pxcat.sh) script to concatenate all sequences into one fasta file (takes about 5min to run).
14) You should probably [change the names](https://docs.google.com/spreadsheets/d/1lA_A7v1McQYVXbxUdtAB53EJPoQIcvBhJ5BX2rukXvc/edit#gid=1103610729) of the ones we changed here before you run the tree.

We now have our concatenated fasta file and a partition file!
### Running IQtree
1) To find the best model using modelfinder run `sbatch ../../../scripts/iqtree_modelfinder.sh` to run [iqtree modelfinder](scripts/iqtree_modelfinder.sh) in the "complete" directory (takes 5 hours).
2) Run IQtree with this best model with the [iqtree_tree.sh] script

### Viewing the trees
* In the Analysis directory, make a directory called "iqtree_aphis" or "iqtree_myzus", and copy all iqtree output files using `mv iqtree* ../iqtree_aphis`. 
* Make a folder called iqtree_output on your personal computer. Copy the resulting iqtree files to your computer by using the commands: rsync -avh rebecca.clement@ceres.scinet.usda.gov:/90daydata/aphid_phylogenomics/becca/aphis/Analysis/iqtree_aphis .
* Open the concensus file in [figtree](http://tree.bio.ed.ac.uk/software/figtree/).
* Compare to Mather 2022 and Rebijith et al. 2017 tree.

## Building phylogeny using gene tree/species tree methods

Although concatenation methods can give reliably tree inferences, especially with a large amount of genes, it is also a good idea to infer a species tree using individual gene trees. To do this, we will use [ASTRAL-III](https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-018-2129-y). 
* To run astral, we need to download the javascript from the [Astral III github page](https://github.com/smirarab/ASTRAL/raw/master/Astral.5.7.8.zip). Then, copy this to the cluster using the following: `rsync -avh Astral rebecca.clement@ceres.scinet.usda.gov:/90daydata/aphid_phylogenomics/becca/scripts`.
* The input of astral should be gene trees in the Newick format. 
* First, let's make partition files for each of the alignments of fasta files that we made in the last step using the file [get_iqtree_partitions_for_prot_coding_genes.py](scripts/get_iqtree_partitions_for_prot_coding_genes.py)
* Next, we need to split the names of the fasta files into groups of 999. so that we can run iqtree on them with the partition files.
* Finally, we will combine the trees into one file so we can run them through ASTRAL.
