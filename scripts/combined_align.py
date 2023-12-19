#!/bin/bash
#SBATCH -J astral
#SBATCH -o astral_%A_%a.out
#SBATCH -e astral_%A_%a.err
#SBATCH -N 1 -n 40
#SBATCH -t 2-00:00:00
#SBATCH -p short
#SBATCH --mail-type=ALL
#SBATCH --mail-user=rebeclem@gmail.com


#--- Start the time
t1=$(date +"%s")

module load java

java -jar /home/rebecca.clement/90day_aphid/scripts/Astral/astral.5.7.8.jar -i aphis_gene.tre -o aphis_astral.tre 2> aphis_astral.log

#---Complete job
t2=$(date +"%s")
diff=$(($t2-$t1))
echo "[---$SN---] ($(date)) $(($diff / 60)) minutes and $(($diff % 60)) seconds elapsed."
echo "[---$SN---] ($(date)) $SN COMPLETE."

[rebecca.clement@ceres scripts]$ cat combined_align.py
# This script should read in alignments from ../hybridtree/alignments that end in "_final.fasta"
# It should read in a textfile from ../snaqboth called "removeTaxa.txt"
# It should remove the sequences from taxa listed in removeTaxa.txt from each alignment
# Then it should write the new alignments to ../snaqboth/alignments

import os
import glob
from Bio import AlignIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import IUPAC
from Bio.Align import MultipleSeqAlignment
import re

# First, read in the list of taxa to remove
# Make a list of the taxa to remove
removeTaxa = []
infile = open("../snaqboth/removeTaxa.txt", 'r')
for line in infile:
    line = line.strip()
    removeTaxa.append(line)
infile.close()

# Now, read in the alignments
for x in glob.glob('../hybridtree/alignments/*_final.fasta'):
    #print(x)
    # Get the name of the OG
    OG_name = x.split('/')[-1].split('_')[0]
    #print(OG_name)
    # Read in the alignment
    alignment = AlignIO.read(x, 'fasta')
    #print(alignment)
    # Make a list of the taxa in the alignment
    taxa = []
    for record in alignment:
        taxa.append(record.id)
    #print(taxa)
    # Make a new alignment that doesn't have the taxa in removeTaxa
    new_alignment = MultipleSeqAlignment([], alphabet=IUPAC.unambiguous_dna)
    for record in alignment:
        if record.id not in removeTaxa:
            new_alignment.append(record)
    #print(new_alignment)
    # Write the new alignment to a file
    outfile = open('../snaqboth/alignments/' + OG_name + '_final.fasta', 'w')
    AlignIO.write(new_alignment, outfile, 'fasta')
    outfile.close()
