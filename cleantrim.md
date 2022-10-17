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
  This command loops through all the files that end in gz, takes just the prefix before the first underscore, searches for the prefix in the file we just made, then moves the matching files to the aphis_myzus directory.
5) 


