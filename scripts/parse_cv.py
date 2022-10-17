from Bio import SeqIO
from Bio.Seq import Seq
import csv
import glob
import os
import gzip

# I want this file to read in a CSV file with a list of IDs and taxonomic info, and a directory of sequences. I want it to a) output text file with a list of new names, b) make a dictionary of aphid names and the new names c) rename the sequences according to their new names.
row_ids = []
new_names = []
with open('project_aphis_myzus.csv','r') as csvfile:
        data = csv.reader(csvfile,delimiter=',')
        f = open("new_aphid_names.txt","w")
        for row in data:
                #print ID, first letter of genus, first 3 letters of species name
                row_ID = row[0]
                row_ids.append(row_ID)
                # We should also replace the 'APHDOO' with 'APHD00'
                new_ID = row[0].replace("O","0")
                new_name = new_ID+row[4][0]+row[5][0:3].upper()
                new_names.append(new_name)
                f.write(row_ID + " " + new_name + " " +row[4]+" " + row[5]+"\n")
f.close()
