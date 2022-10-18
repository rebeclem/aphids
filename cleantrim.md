# Cleaning and trimming raw reads

Each file has an R1 and an R2. We need to assess the quality of these sequences, and then clean them using trimmomatic.

However, we only want to do this for the sequences we will be using, so the *Aphis*, *Myzus*, and outgroups. 

1) Let's combine these into one file. In the raw_data directory, use `cat aphis_accessions.csv aphis_outgroup.csv myzus_accessions.csv myzus_outgroup.csv > project_aphis_myzus.csv`. This file should have 32 lines in it. (Use `wc -l project_aphis_myzus.csv` to check). This includes, 17 *Aphis* species, 8 *Myzus* species, 3 *Aphis* outgroups and 4 *Myzus* outgroups. Vim the `project_aphis_myzus.csv` file and change line 20 to read `APHDOO305,,,,Melanaphis,donacis,,,,,,` at the beginning.
2) Use the [parse_csv.py](scripts/parse_csv.py] file to make this csv file into a text file "new_aphid_names.txt" that includes old names, new names, and taxonoimc info. In the raw_data directory, after loading the python_3 module and activating the virtual environment, use `python ../scripts/parse_csv.py`.
3) Next, make a directory called aphis_myzus in the raw_data directory to move the matching files to: `mkdir aphis_myzus`.
4) Navigate to the "aphid_raw_shotgun_sequencing" file and do the following
  ```
  for f in *.gz; do fprefix="${f%%_*}"; if grep "$fprefix" ../new_aphid_names.txt; then mv $f ../aphis_myzus/; else echo "$fprefix"; echo "not present"; fi; done
  ```
  
    *This command loops through all the files that end in gz, takes just the prefix before the first underscore, searches for the prefix in the file we just made, then moves the matching files to the aphis_myzus directory.
5) This should have copied over 62 files. Check to make sure there are 62 files with `ls aphis_myzus | wc -l`. (Note: we expected 64 files from the 32 taxa in new_aphid_names.txt, but APHD00102 is missing because the qubit was too low)
6) Next, run fastqc on the files. In the aphis_myzus directory, make a directory called fastqc_out. Load the fastqc module (`module load fastqc`), then run the command: `fastqc -l fastqc_out/ -f fastq *.gz`. Or, run the samples all at once using an array and [fastqc.sh](scripts/fastqc.sh) with the command `sbatch ../../scripts/fastqc.sh` from the aphis_myzus directory.
7) This will produce a list of html files in the fastqc_out directory. Download them to your computer to look at them. Open a new terminal window and use the command: `rsync -avh rebecca.clement@ceres.scinet.usda.gov:/home/rebecca.clement/90day_aphid/raw_data/aphis_myzus/fastqc_out/*.html /Downloads`. In a finder window, single click on one of the html files and then press the space bar. Use the arrow keys to go through the fastq files. Check that the per base sequence quality stays in the green zone.
8) Now run trimmomatic using the [trimmomatic.sh](scripts/trimmomatic.sh) script.
    * First make a list of filenames using `aphis_myzus]$ for f in *R1_001.fastq.gz; do filename=${f%%_*}; echo $filename >> filenames.txt; done`
    * Then we'll use this command to run the files from the text file.
    ```
    java -jar /software/7/apps/trimmomatic/0.38/trimmomatic-0.38.jar PE -threads 10 -phred33 R1.fq R2.fq ILLUMINACLIP:/software/7/apps/trimmomatic/0.38/adapters/TruSeq3-PE-2.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36
    ```
    * This script removes illumina adapters, removes low quality or N bases below 3 from both leading or trailing, scans the read with a 4-base sliding window and cut when the quality per base drops below 15, and drop reads below 36 bases long.


