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
infile = open("../snaqboth/removeMoreTaxa.txt", 'r')
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
