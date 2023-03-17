# Using BPP

BPP is a program to analyze sequence data with and without introgresion. It can estimate population size and species divergence times as well as species tree estimation and cross-species introgression intensity.

We will follow [this tutorial](https://github.com/bpp/bpp-tutorial/wiki)

1) There are four ways to run BPP:
    * A00: Within-model inference. Used to estimate parameters in MSC or MSC with introgression models such as species divergence times, population size and introgression probability. This is the one we want. With the MSCi model, the user has to specify the number of introgression events, their directions, and the populations involved.
    * A01: Species tree inference with species provided by user
    * A10: Species delimitation using user-specified guide tree
    * A11: joint species delimitation and species tree inference
2) First we need to make an Imap file-- two columns with one column of sample names and the second column of species names.
    * To do this, navigate to the myzus/Analysis folder. There, you should have the concatenated fasta file we used for the concatenated tree called "myzus_concat.fasta".
    * Find a fasta file that has all the fasta sequences, then do grep "^>" OG0005037_final.fasta > myzus_imap.txt (For aphis, do this with one that ends in New_final.fasta, and doesn't contain 272AAUR)
    * Manually remove the > and add what their species codes should be
3) Next, we need to get a sequence file with alignments one after the other.
    * Use the [alignToLoci.py](scripts/alignToLoci.py) script to put the alignments into the bpp loci format. (For aphis, change the script to read in New_final.fasta)
    * On an interactive node, run this file in the myzus/Analysis folder. It will read in files that end in "_final.fasta".
    * Move this file to the bpp/myzus folder.
5) Finally we need a control file that points to the imap and sequence files.
    * Change the seqfile and imapfile names to the names of the above sequences
    * Set speciesdelimitation = 0. This means that we are estimating parameters of species divergence times and population sizes under the MSC and MSci models when the species tree model is given
    * Set "species&tree =" with the total nuber of species, a list of the species abreviations, and on the next line, the maximum number of sequences at any locus. 
    * Next, you need the tree. Use the tree from snaq. Run the following: `while read p1 p2; do sed -i "s/$p1/$p2/g" myzus_snaq1.txt; echo "replacing $p1 with $p2"; done < myzus_imap.txt` to change the names from the snaq tree to the names in the imap file. Then do `sed -i "s/[0-9:\.]*//g" myzus_snaq1.txt` to remove numbers, colons and periods.
    * Remove any duplicate species from the tree and rearrange it how you want it.
    * Put the tree into a file called msci.txt as follows:
```
tree ((BHEL,BAMY),((MORN,(((MFAT,MCER),MLYT),(MVAR,(MLIG,(MPER,MANT)T)S))),(DFOE,((BBRA,MSPgt),(ASPlk,(ASPnl,ASPnl2))))))R;
define B as ASPnl,ASPnl2
define C as ASPnl,ASPlk
hybridization C B, S T as Q H tau=yes, yes phi=.0348
```
6) To run, first you need to copy the program from github. Then use `export PATH=$PATH:~/mybpp`
    * Run `bpp ‐‐msci‐create msci.txt` and paste the outputted tree into the control file.
    * Change nloci to number of datasets in sequence file. ( use `grep -cvP '\S' aphid_bpp_loci.txt` to count blank lines in loci file)
    * Put the control file name in the bpp.sh file and run
7) Make a new tree for each of your hybridization events.
8) 
9) 
