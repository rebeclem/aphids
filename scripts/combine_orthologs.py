from Bio import SeqIO
from Bio.Seq import Seq
import glob
import os


# This script should read in the blast file that contains the first column of the OG name in Aphis and the second column is the OG name in myzus. Then, it should find the corresponding alignment file from each and concatenate them together in an Analysis directory.
# read in a line of the blast file
# 

# Disregard the following bc we can just use blast
# This script should read in two fasta files that have orthologs from APHD00270 (we use this because it has the most orthologs from both groups as opposed to APHD00014 or APHD00027) from both Aphis and Myzus analyses. It should build a dictionary of sequence names vs sequences. The output should be a file with one column is the orthogroup number from aphis and the other column is the orthogroup number from myzus. 
# read in the fasta files
# make a dictionary of the myzus sequences. There should be 6982 elements in dictionary
# read in 2 fasta files
# for file 1, make the key the sequence, and the value the ID for the sequence
# for file 2, look up each sequence in a dictionary. 
# If the two sequences match, print both to outfile

filename="blast.txt"
name1="APHD00270ASPlk"
name2="APHD00270MVAR"
path1='../aphis/Analysis/'
path2='../myzus/Analysis/'
with open(filename) as f:
    for line in f:
        aphisOG=line.split()[0].split("-")[1]
#		print('Moved:',outfile2)
        myzusOG=line.split()[1].split("-")[1]
        newfile=aphisOG+"_new.fasta"
        with open ('alignments/'+newfile,'w') as outfile:
            with open(path1+aphisOG+'_pal.fasta_mfgb') as infile:
                outfile.write(infile.read())
            with open(path2+myzusOG+'_pal.fasta_mfgb') as infile2:
                outfile.write(infile2.read())
#        print('%r \t %r \n' % (aphisOG,myzusOG))
#		print('Moved:',outfile2)


# make dictionary
#seq_dict = {rec.seq : rec.id for rec in SeqIO.parse(file1, "fasta")}
# make empty output file
#outfile=open("matches.txt","w")
#outfile.write('%r \t %r' % (AphisOG,MyzusOG))

# loop through the fasta file, put IDs of matching seqs in a text file
#with open(file2, "r") as handle:
#        for record in SeqIO.parse(handle, "fasta"):
#            if record.seq in seq_dict.key():
#                outfile.write('%r \t %r' % (record.id,seq_dict[record.seq]))

#outfile.close()
