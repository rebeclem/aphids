# Using BPP

BPP is a program to analyze sequence data with and without introgresion. It can estimate population size and species divergence times as well as species tree estimation and cross-species introgression intensity.

We will follow [this tutorial](https://github.com/bpp/bpp-tutorial/wiki)

1) First we need to make an Imap file-- two columns with one column of sample names and the second column of species names.
    * To do this, navigate to the myzus/Analysis folder. There, you should have the concatenated fasta file we used for the concatenated tree called "myzus_concat.fasta".
    * Find a fasta file that has all the fasta sequences, then do grep "^>" OG0005037_final.fasta > myzus_imap.txt (For aphis, do this with one that ends in New_final.fasta, and doesn't contain 272AAUR)
    * Manually remove the > and add what their species codes should be
3) Next, we need to get a sequence file with alignments one after the other.
    * Use the [alignToLoci.py](scripts/alignToLoci.py) script to put the alignments into the bpp loci format. (For aphis, change the script to read in New_final.fasta)
    * On an interactive node, run this file in the myzus/Analysis folder. It will read in files that end in "_final.fasta".
    * Move this file to the bpp/myzus folder.
5) Finally we need a control file that points to the imap and sequence files.
    * Start here
7) To run, first you need to copy the program from github. Then use `export PATH=$PATH:~/mybpp`
8) There are four ways to run BPP:
    * A00: Within-model inference. Used to estimate parameters in MSC or MSC with introgression models such as species divergence times, population size and introgression probability.
    * A01: Species tree inference with species provided by user
    * A10: Species delimitation using user-specified guide tree
    * A11: joint species delimitation and species tree inference
9) 
