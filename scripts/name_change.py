from Bio import SeqIO
from Bio.Seq import Seq
import glob
import os

# get the fasta files from my working directory
# wanted_fastas = []
# for root, dirs, files in os.walk('/project/aphid_phylogenomics/SGRA_trinity.Trinity.fasta.transdecoder_dir'):
#     for file in files:
#         if file.endswith('.faa'):
#              wanted_fastas.append(os.path.join(root, file))

# loop through the fasta files, clean them, and write the new file to the same dir
for x in glob.glob('*.fa'):
    taxon = x.split('_')[0]
    outfile = taxon + '_final.fasta'
    recs = []
    with open(x, "r") as handle:
        for record in SeqIO.parse(handle, "fasta"):
            record.id = record.id.replace('.', '_').replace(' ', '')
            record.id = taxon + '_' + record.id
            record.description = ''
            record.seq = Seq(str(record.seq).replace('*', ''))
            record.seq = Seq(str(record.seq).replace('.', ''))
            recs.append(record)
    SeqIO.write(recs, outfile, 'fasta')

## record.id = taxon.uppercase()
