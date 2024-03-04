from Bio import AlignIO
import glob

for fasta_file in glob.glob('OG*.fasta'):
    alignment = AlignIO.read(open(fasta_file), "fasta")
    outfile_name = fasta_file.replace('_final.fasta', '_parts.txt')
    outfile = open(outfile_name, 'w')
    aln_str = str(alignment.get_alignment_length())
    line1 = 'DNA, part1 = 1-%s\\3\n' % (aln_str)
    outfile.write(line1)
    line2 = 'DNA, part2 = 2-%s\\3\n' % (aln_str)
    outfile.write(line2)
    line3 = 'DNA, part3 = 3-%s\\3' % (aln_str)
    outfile.write(line3)
    outfile.close()
