from Bio import SeqIO
from Bio.Seq import Seq
import glob
import os

# This file is to specifically add the OG sequence name to the end of each sequence in the target file
# First, it should read in the genes_list3.txt and make a dictionary based on the split of the underscore? Then it should read in targets_all_cds.fa, and rename the sequences

newdict={}
with open('genes_list3.txt') as f:
	for line in f:
		OG=line.split("_",1)[0]
		seq="_".join(line.split("_",4)[1:4])
		tax=line.split("_")[1]
		newname=tax+"-"+OG
		newdict[seq.strip()]=newname
#print (newdict)

#for x in glob.glob('*.fa'):
#    taxon = x.split('.')[0]
#    outfile = taxon + '_final.fasta'
recs = []
with open("targets_all_cds.fa", "r") as handle:
	for record in SeqIO.parse(handle, "fasta"):
	#	record.id="_".join(record.name.split("_",3)[0:2])
		record.id=newdict[record.id]
		record.description = ''
		recs.append(record)
SeqIO.write(recs, "targets_cds_OG.fa",'fasta')
recs_aa=[]
# Now do the same for the amino acids file.
with open("single_copy_all_targets.fa","r") as handle:
	for record in SeqIO.parse(handle, "fasta"):
		seq=record.name.split("_",3)[1]+"-"+record.name.split("_",3)[0]
		record.id=seq
		record.description=''
		recs_aa.append(record)

SeqIO.write(recs_aa, "targets_aa_OG.fa",'fasta')

#record.id = record.id.replace('.', '_').replace(' ', '')
#            record.id = taxon + '_' + record.id
#            record.description = ''
#            record.seq = Seq(str(record.seq).replace('*', ''))
#            record.seq = Seq(str(record.seq).replace('.', ''))
#            recs.append(record)
#    SeqIO.write(recs, outfile, 'fasta')
#
# record.id = taxon.uppercase()
