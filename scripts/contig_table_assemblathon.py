#!/usr/bin/env python

import os
import sys
import glob
from itertools import islice
# This script reads in an assemblathon stats file and then adds it to a line of an output file I'll call aphid_masurca_stats.txt


# First open the output file
with open("aphid_masurca_stats.txt","w") as outfile:
#only run this outfile.write line once
        outfile.write('Sample \t AssemblyLength \t Ns \t n_contigs \t avgContigSize \t N50length\n')

# loop through the fasta files, 
        for file1 in glob.glob('*_assemblathon_stats.txt'):
        #with open(sys.argv[1],'r') as infile:
                with open(file1,'r') as infile: # read in alignment 
                        lines=infile.readlines()
                        sample=file1.split('_')[0]
                        #sample=next_n_lines[0].split()[0]
                        print(sample)
                        alen=lines[5].split()[4] # assembly length
                        ns=lines[23].split()[2] # Number of Ns (percent) 
                        ncontig=lines[4].split()[3]
                        avgsize=lines[13].split()[3]
                        n50=lines[45].split()[3]
                        outline='%s \t %s \t %s \t %s \t %s \t %s \n' %(sample,alen,ns,ncontig,avgsize,n50)
                        outfile.write(outline)
outfile.close
