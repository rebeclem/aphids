from Bio import SeqIO
from Bio.Seq import Seq
import glob
import os

# This file should read in the files that end in .FAA or .FNA. The sequences for these have headers like "APHD00002ASPI_aa multi_hit_stitched_contig_comprising_2_hits"
# For each of the sequences, take off the _aa and delete the description
# Then, add the gene name to the end of the record ID 
# Then, I would like to add any lines from targets_aa_OG.fa and targets_all_OG.fa that have the suffix is the OG sequence like "AFAB-OG0003568"
# Finally print out each of the files


# loop through the fasta files, clean them, and write the new file to the same dir
for x in glob.glob('*.FAA'):
	gene_OG = x.split('.')[0]
	outfile = gene_OG + '_aafinal.fasta'
	recs = []
	with open(x, "r") as handle:
		for record in SeqIO.parse(handle, "fasta"):
			record.id = record.id.replace('_aa', '').replace(' ', '')
			record.id = record.id + "-" + gene_OG
			record.description = ''
			recs.append(record)
	with open("../targets_aa_OG.fa") as f:
		for record2 in SeqIO.parse(f, "fasta"):
			genename = record2.id.split('-')[1]
			if genename == gene_OG:
				recs.append(record2)
	SeqIO.write(recs, outfile, 'fasta')

## Now do the same but with the nucleotide sequences

for y in glob.glob('*.FNA'):
        gene_OG = y.split('.')[0]
        outfile = gene_OG + '_nucfinal.fasta'
        recs = []
        with open(y, "r") as handle:
                for record in SeqIO.parse(handle, "fasta"):
                        record.id = record.id.replace('_aa', '').replace(' ', '')
                        record.id = record.id + "-" + gene_OG
                        record.description = ''
                        recs.append(record)
        with open("../targets_cds_OG.fa") as f:
                for record2 in SeqIO.parse(f, "fasta"):
                        genename = record2.id.split('-')[1]
                        if genename == gene_OG:
                                recs.append(record2)
        SeqIO.write(recs, outfile, 'fasta')
