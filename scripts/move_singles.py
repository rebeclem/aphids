from Bio import SeqIO
from Bio.Seq import Seq
from io import StringIO
from gzip import open as gzopen
import os
import glob
import shutil

# This file should read in new_aphid_names and make a dictionary for changing names etc.
# Then, for files that end in single.fastq.gz, it should concatenate the two files together into one.

aphis_seqs = ["Aphis","Melanaphis","Hyalopterus"]
mydict = {}
with open('new_aphid_names.txt') as f:
	for line in f:
		(prefix, newname, genus, species)=line.split()
		mydict[prefix]=[newname,genus,species]

dst_folder1=r"/home/rebecca.clement/90day_aphid/aphis/hybpiper_cds/"
dst_folder2=r"/home/rebecca.clement/90day_aphid/myzus/hybpiper_cds/"

files=glob.glob('*R1*single.fastq.gz')
for x in files:
	taxon=x.split('_')[0]
	taxon2=mydict[taxon][0]

	if mydict[taxon][1] in aphis_seqs:
		outfile1=taxon2+'_A_R1_BothSingle.fastq.gz'
		shutil.move(x,dst_folder1+outfile1)
		print('Moved:',outfile1)
	else:
		outfile2=taxon2+'_M_R1_BothSingle.fastq.gz'
		shutil.move(x,dst_folder2+outfile2)
		print('Moved:',outfile2)
# Same but for R2
files2=glob.glob('*R2*single.fastq.gz')
for x2 in files2:
	taxon=x2.split('_')[0]
	taxon2=mydict[taxon][0]
	if mydict[taxon][1] in aphis_seqs:
		outfile1=taxon2+'_A_R2_BothSingle.fastq.gz'
		shutil.move(x2,dst_folder1+outfile1)
		print('Moved:',outfile1)
	else:
		outfile2=taxon2+'_M_R2_BothSingle.fastq.gz'
		shutil.move(x2,dst_folder2+outfile2)
		print('Moved:',outfile2)
