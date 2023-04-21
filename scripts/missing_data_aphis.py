from Bio import SeqIO
from Bio.Seq import Seq
from io import StringIO
from gzip import open as gzopen
import os
import glob
import shutil

# This code should iterate through files that end in .FNA. If there are 12 sequences in the file, it should move the file to a file called 'complete' otherwise move it to a file called incomplete.



files=glob.glob('*mfgb')
for x in files:
	n = 0
	with open(x) as seqfile:
		for line in seqfile:
			if line.startswith(">"):
				n += 1
		if n==23:
			shutil.move(x,r"complete/")
			print('Moved:',x,'to complete')
		else:
			shutil.move(x,r"incomplete/")
			print('Moved:',x,'to incomplete')	
