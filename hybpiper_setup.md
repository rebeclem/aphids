# Setting up files for HybPiper

1) We now have a file with the amino acid sequences that are single-species orthologs. Make a directory in the myzus and aphis directories and call it `hybpiper_aa`. Transfer these files to that directory.
    * `Orthogroups/Orthogroups_SingleCopyOrthologues.txt` has a list of all the orthogroups that are single copy.
    * All these sequences (there are 8631 for *Aphis*, 7064 for *Myzus*) are in the Single_Copy_Orthologue_Sequences folder, but each of these fasta files has 4 sequences in it. I guess we can concatenate all of these into a single file.
    * First, let's add the name of the orthogroup to each of the sequences. Allocate an interactive node `salloc`, load the python module and virtual environment, then add the names of the OG to the descriptions of each sequence using the command `python ~/90day_aphid/scripts/name_change2.py` in the Single_copy_Orthologue_Sequences directory.
    * In the `hybpiper_aa` directory, type the command: `cat ../aaLTPG/OrthoFinder/Results_Oct14/Single_Copy_Orthologue_Sequences/*final.fasta > single_copy_all_targets.fa`
    * You should have a file with 8631 orthogroups. Check the number of sequences in this file with `grep ">" single_copy_all_targets.fa | wc -l`. There should be 34,524 sequences for *Aphis* (4 different species with 8631 orthogroups) and 35,320 sequences for *Myzus* (5 species with 7064 orthologs).
3) Now we need to get a file with the corresponding nucleotide sequences. Make a file called hybpiper_cds and navigate into it. 
    * Let's make a file of the list of names from the amino acid sequence: `grep ">" ../hybpiper_aa/single_copy_all_targets.fa > genes_list.txt`
    * Now remove the karots from this file using `sed 's/>//' genes_list.txt > genes_list2.txt`. This command substitutes the carot for nothing.
    * Remove the OG sequence from the file as well `sed 's/[^_]*_//' genes_list2.txt > genes_names.txt`
    * Now use seqtk to extract matching sequences. `module load seqtk`, then for each species, make a different file
    * `seqtk subseq ../cdsLTPG/AFAB_final.fasta genes_names.txt > targets_AFAB_cds.fa`
    - `seqtk subseq ../cdsLTPG/AGLY_final.fasta genes_names.txt > targets_AGLY_cds.fa`
    -  `seqtk subseq ../cdsLTPG/AGOS_final.fasta genes_names.txt > targets_AGOS_cds.fa`
    -  `seqtk subseq ../cdsLTPG/ATHA_final.fasta genes_names.txt > targets_ATHA_cds.fa`
    * Put them all together using `cat targets_* > targets_all_cds.fa`
4) Repeat steps 1 and 2 but for *Myzus*
    * `seqtk subseq ../cdsLTPG/MCER_final.fasta genes_names.txt > targets_MCER_cds.fa`
    * `seqtk subseq ../cdsLTPG/MLIG_final.fasta genes_names.txt > targets_MLIG_cds.fa`
    * `seqtk subseq ../cdsLTPG/MLYT_final.fasta genes_names.txt > targets_MLYT_cds.fa`
    * `seqtk subseq ../cdsLTPG/MPER_final.fasta genes_names.txt > targets_MPER_cds.fa`
    * `seqtk subseq ../cdsLTPG/MVAR_final.fasta genes_names.txt > targets_MVAR_cds.fa`
    * Put them all together using `cat targets_* > targets_all_cds.fa`
    * Count the number of sequences. `grep ">" targets_all_cds.fa | wc -l`. You should have the same number as in the single_copy_all_targets.fa amino acid file.
6) Next, we need to gather the unannotated genomes for *Aphis* and *Myzus* as well as outgroups and put them in a directory called `unannotated_genomes`. For *Myzus*, we will use outgroups *Dysaphis* and *Brachycaudus*. For *Aphis*, we will use outgroups *Melanaphis* and *Hyalopterus*.
    * Upload the tissue bank csv to the raw data file `rsync -avh aphid_tissues.csv rebecca.clement@ceres.scinet.usda.gov:/90daydata/aphid_phylogenomics/becca/raw_data`.
    * Put the *Aphis* and *Myzus* into different cvs files with `grep "Aphis," aphid_tissues.csv > aphis_accessions.csv`, and `grep "Myzus," aphid_tissues.csv > myzus_accessions.csv`.
    * Put the outgroups into their own files using `grep -E "Brachycaudus|Dysaphis" aphid_tissues.csv > myzus_outgroup.csv` and `grep -E "Melanaphis,|Hyalopterus" aphid_tissues.csv > aphis_outgroup.csv`
7) Now, since HybPiper is not one of the modules loaded on CERES, we will need to [install it using conda](https://scinet.usda.gov/guide/conda/). If you already have installed the bioconda channels, use the commmands `module load miniconda`, `conda create -n hybpiper -c chrisjackson-pellicle hybpiper` and `conda activate hybpiper` to install on CERES. When you log back in later, you will only need to use `module load miniconda` and then `conda activate hybpiper`

Next step: [Set up, clean and trim raw reads](cleantrim.md)
