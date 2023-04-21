from Bio import SeqIO, bgzf
from Bio.Seq import Seq
from io import StringIO
from gzip import open as gzopen
import os
import glob
import shutil

# Use this file to read in `new_aphid_names.txt` and make a dictionary of input prefix, output and other thing.
# Make a variable aphis_seqs: includes Aphis, Melanaphis and Hyalopterus
# Read in  a filename from the aphis_myzus directory. If it has an R1 or single in it, find the prefix in the new_aphid_names text file and change it to the second column. Then, if the third column is in aphis_seqs, add an A to it, otherwise, add an M to it

aphis_seqs = ["Aphis","Melanaphis","Hyalopterus"]
mydict = {}
with open('new_aphid_names.txt') as f:
	for line in f:
		(prefix, newname, genus, species)=line.split()
		mydict[prefix]=[newname,genus,species]
#print(mydict)

#for filename in os.listdir("."):
#	taxon=filename.split('_')[0]
#	taxon2=mydict[taxon][0]
#	if mydict[taxon][1] in aphis_seqs:
#                outfile1=taxon2+'_A_trim.fastq.gz'
#	else:
#		outfile1=taxon2+'_M_trim.fastq.gz'
	#print (filename, taxon, outfile1)
dst_folder1=r"/home/rebecca.clement/90day_aphid/aphis/hybpiper_cds/"
dst_folder2=r"/home/rebecca.clement/90day_aphid/myzus/hybpiper_cds/"

files=glob.glob('*R1*trim.fastq.gz')
#for x in glob.glob('*R1*trim.fastq.gz'): # just take the forward sequences that are trimmed
for x in files:
	taxon=x.split('_')[0]
	taxon2=mydict[taxon][0]
#	print(taxon,taxon2)
#	outfile1=taxon2+'_trim.fastq.gz'
	#print(mydict[taxon][2])
#	recs = []
	if mydict[taxon][1] in aphis_seqs:
		outfile1=taxon2+'_R1_A_trim.fastq.gz'
		shutil.move(x,dst_folder1+outfile1)
		print('Moved:',outfile1)	
	else:
		outfile2=taxon2+'_R1_M_trim.fastq.gz'
		shutil.move(x,dst_folder2+outfile2)
		print('Moved:',outfile2)
# Now do the same for the R2 files
filesR2=glob.glob("*R2*trim.fastq.gz")
for x in filesR2:
        taxon=x.split('_')[0]
        taxon2=mydict[taxon][0]
#       print(taxon,taxon2)
#       outfile1=taxon2+'_trim.fastq.gz'
        #print(mydict[taxon][2])
#       recs = []
        if mydict[taxon][1] in aphis_seqs:
                outfile1=taxon2+'_R2_A_trim.fastq.gz'
                shutil.move(x,dst_folder1+outfile1)
                print('Moved:',outfile1)
        else:
                outfile2=taxon2+'_R2_M_trim.fastq.gz'
                shutil.move(x,dst_folder2+outfile2)
                print('Moved:',outfile2)
#	print(x, taxon, outfile1)
#	os.rename(x,os.path.join("../",outfile1)
#	records = SeqIO.parse(gzopen(x,"rt"),format="fastq")
#	with bgzf.BgzfWriter(outfile1,"wb") as outgz:
#		SeqIO.write(sequences=records, handle=outgz, format="fastq")
#with open(x,"r") as handle:
#		for reco	
		
