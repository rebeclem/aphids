#!/usr/bin/env python

import os
from itertools import islice
# This script should read in the file "contig_stats.txt" that is the output from contig_stats.pl, then put it into a nice output table.
# The output looks like this:
#APHD00002_spades/contigs.fasta

#335939891 - total assembly length (bp)
#0 - N's (0.0%)
#287148 - number of contigs
#1169.9 - average contig size (bp)
#28788 - N50 length (bp)

# First open the output file
with open("contig_table.txt","w") as outfile:

        outfile.write('Sample \t AssemblyLength \t Ns \t n_contigs \t avgContigSize \t N50length\n')

# Read in contig text file
        infile = open('contig_stats.txt','r')
        count=0
        N=8
        with open('contig_stats.txt','r') as infile:
                while True:
                        next_n_lines = list(islice(infile,N))
                        if not next_n_lines:
                                break
                        sample=next_n_lines[0].split('_')[0]
                        alen=next_n_lines[2].split(' ')[0]
                        ns=next_n_lines[3].split(' ')[0]
                        ncontig=next_n_lines[4].split(' ')[0]
                        avgsize=next_n_lines[5].split(' ')[0]
                        n50=next_n_lines[6].split(' ')[0]
                        outline='%s \t %s \t %s \t %s \t %s \t %s \n' %(sample,alen,ns,ncontig,avgsize,n50)
                        outfile.write(outline)
outfile.close
