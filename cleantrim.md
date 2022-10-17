# Cleaning and trimming raw reads

Each file has an R1 and an R2. We need to assess the quality of these sequences, and then clean them using trimmomatic.

However, we only want to do this for the sequences we will be using, so the *Aphis*, *Myzus*, and outgroups. Let's combine these into one file. In the raw_data directory, use `cat aphis_accessions.csv aphis_outgroup.csv myzus_accessions.csv myzus_outgroup.csv > project_aphis_myzus.csv`. This file should have 32 lines in it. (Use `wc -l project_aphis_myzus.csv` to check). This includes, 17 *Aphis* species, 8 *Myzus* species, 3 *Aphis* outgroups and 4 *Myzus* outgroups. 


