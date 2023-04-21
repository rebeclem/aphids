from Bio import SeqIO
from Bio.Seq import Seq
import glob
import os

# This script is for changing the names of the fastq files that are probably a different species than we first thought they were. It should also move the myzus ones that are actually aphis to the aphis directory.
# Input: fixnames.txt, fastq files in the format APHD00101ANER_A_BothSingle.fastq.gz, APHD00101ANER_A_trim.fastq.gz, APHD00101ANER_R2_A_trim.fastq.gz
# Output: fastq files in the format APHD00101ASPsv_A_BothSingle.fastq.gz, APHD00101ASPsv_R1_A_trim.fastq.gz, APHD00101ASPsv_R2_A_trim.fastq.gz
# First, it should read in fixnames.txt. Then, for each line, it should read in the corresponding 3 fastq files and change the name. Finally, If it needs to be moved to another folder, it should do that as well.

MAchange=["APHD00014MORN", "APHD00027MASC", "APHD00270MVAR"]
with open('fixnames.txt') as f:
	for line in f:
		oldname=line.split("\t",2)[0]
		newname=line.split("\t",2)[1]
		genus=line.split("\t",2)[2].strip()
		if genus == "Aphis":
			old1=oldname+"_A_BothSingle.fastq.gz"
			new1=newname+ "_A_BothSingle.fastq.gz"
			old2=oldname+"_A_trim.fastq.gz"
			new2=newname+ "_R1_A_trim.fastq.gz"
			old3=oldname+"_R2_A_trim.fastq.gz"
			new3=newname+ "_R2_A_trim.fastq.gz"
			print(old1,new1)
			os.rename(old1, new1)
			print("Changed ", old1, " to ", new1, "/n")
			os.rename(old2, new2)
			print("Changed ", old2, " to ", new2, "/n")
			os.rename(old3, new3)
			print("Changed ", old3, " to ", new3, "/n")
		if genus == "Myzus":
			os.chdir("../../myzus/hybpiper")
			old1=oldname+"_M_BothSingle.fastq.gz"
			new1=newname+ "_BothSingle.fastq.gz"
			old2=oldname+"_M_trim.fastq.gz"
			new2=newname+ "_R1_trim.fastq.gz"
			old3=oldname+"_R2_M_trim.fastq.gz"
			new3=newname+ "_R2_trim.fastq.gz"
			print(old1,new1)
			os.rename(old1, new1)
			print("Changed ", old1, " to ", new1, "/n")
			os.rename(old2, new2)
			print("Changed ", old2, " to ", new2, "/n")
			os.rename(old3, new3)
			print("Changed ", old3, " to ", new3, "/n")
			if oldname in MAchange:
				os.rename(new1,"../../aphis/hybpiper/"+new1)
				os.rename(new2,"../../aphis/hybpiper/"+new2)
				os.rename(new3,"../../aphis/hybpiper/"+new3)
			os.chdir("../../aphis/hybpiper")
