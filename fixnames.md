# Fixing the names and rerunning samples

We have to be wary of trusting the names that come up when you blast sequences, but if there is a high enough percent match, and it agrees with the BOLD database, we can change the names. The most important thing is there are some myzus specimens that are probably actually aphis. They need to have hybpiper ran on them with the aphis orthologs.

* Make a text file called "fixnames.txt"
```
APHD00014MORN	APHD00014ASPnl Myzus
APHD00027MASC	APHD00027ASPnl Myzus
APHD00036DSP	APHD00036BBRA Myzus
APHD00071MCER	APHD00071MSPgt Myzus
APHD00079AGOS	APHD00079ANAS Aphis
APHD00101ANER	APHD00101ASPsv Aphis
APHD00122ASPI	APHD00122ASPva Aphis
APHD00232ASP	APHD00232AVIB Aphis
APHD00265ANA	APHD00265ACOR Aphis
APHD00270MVAR	APHD00270ASPlk Myzus
```
* Make a python file to read in the text file, change names of fastq files in the text file and move myzus files that should be aphis to the myzus directory.
* 
