import glob, os

# This script goes through all of the files that have been aligned with pal2nal and trims some of the spaces?

gblocks_options = "-t=c -b4=5 -b5=h -e=_mfgb"

for fasta_file in glob.glob("*.fasta"):

    fasta = open(fasta_file, 'r').read()

    halfseqsplus1 = fasta.count('>')//2 + 1

    command = "./Gblocks %s %s -b2=%s" % (fasta_file,gblocks_options,halfseqsplus1)

    print ("executing: " + command)

    os.system(command)



#    gblocks_output = fasta_file[:-15] + "mafft_gblocks.fa"



#mafft --localpair --maxiterate 1000 input [> output]



#-t=c = codon, to preserve the triplets

#-b1 = (default)Minimum Number Of Sequences For A Conserved Position: 163

#-b2 = Minimum Number Of Sequences For A Flanking Position: 163 # have to count '>' divide by two and add 1

#-b3= (default)Maximum Number Of Contiguous Nonconserved Positions: 8

#-b4=5 Minimum Length Of A Block: 5

#-b5=h Allowed Gap Positions: With Half

#Gblocks nad3.pir -t=p -e=-gb1 -b4=5 -d=y
