from Bio import SeqIO
from Bio.Seq import Seq
from Bio import AlignIO
import glob
import os

# This file is for making an IMAP and sequences files from fasta files.
# The Imap file has two columns. The first column should be numbers 1-ntaxa, the second column should be the species name/code
# The sequence file has all the sequences from all loci. 
# The first line of each sequence block should have # of sequences and # of sites in the alignment
# Then there should be a space followed by sequence name (OG number)^its corresponding name
# Then we need a control file, which has the names of the seqfile and Imapfile. 

# First, read in a file that has all sequences and number them 1-n
# it should read in fasta files ending in _final.fasta
# For each fasta file, it should count how many sequences and sites and print it to the file
# Then, it should print the name and the number on the line 
# Then it will print the sequence name and the sequence in the sequence format.


# First open the output file
with open("aphid_bpp_loci.txt","w") as f:

# loop through the fasta files, 
    for fasta_file in glob.glob('*_final.fasta'):
        OGnum = fasta_file.split('_')[0] # Set the OGnumber
        alignment = AlignIO.read(open(fasta_file), "fasta") # read in alignment 
        aln_str = str(alignment.get_alignment_length()) # Get length of alignment
        aln_n = len(alignment)# Get number of sequences
        print("\n",aln_n,"\t",aln_str,file=f) # print n seqs and alignment length to file
        for record in alignment:
            print("%s^%s\t%s" % (OGnum,record.id,record.seq),file=f) # print OG number, ^,sample name and sequence


#with open(x, "r") as handle:
#        for record in SeqIO.parse(handle, "fasta"):
#            record.id = record.id.replace('.', '_').replace(' ', '')
#            record.id = taxon + '_' + record.id
#            record.description = ''
##            record.seq = Seq(str(record.seq).replace('*', ''))
#            record.seq = Seq(str(record.seq).replace('.', ''))
#            recs.append(record)
#    SeqIO.write(recs, outfile, 'fasta')

## record.id = taxon.uppercase()
