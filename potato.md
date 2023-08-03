# Potato aphid project

We will run orthofinder on aphids that have similar sequencing quality (ie long reads), and then do something to visualize the synteny.

    * First step: find the genomes we want to use listed [here](https://docs.google.com/spreadsheets/d/1YTeKEWSZg9Z5VIzDOeepkhvPFj-RW5Ua3oGiUnMjQRo/edit#gid=611073991). It should be a fasta file of a proteome (amino acid or peptide sequences) and preferably LTPG (longest transcript per gene). They need to be unzipped. 

    * One of the aphids, Therioaphis trifolii does not have amino acid sequences. Use [dna2proteins](https://github.com/prestevez/dna2proteins/tree/master) to convert the DNA to amino acid sequences. `python ~/90day_aphid/aphids_github/scripts/dna2proteins.py -i Therioaphis_trifolii_OMIX002673-01.fasta -o Therioaphis_trifolii_aa.fa`. (Note, I added parentheses to the prints in the [dna2proteins.py](scripts/dna2proteins.py) script.
    * Rename the fasta files to just be Genus_species.fa
    * Next step: Run orthofinder. `module load orthofinder; orthofinder -f Proteomes`
    * Sitobion has periods at the end of lines. Remove them `sed 's/\.$//g' Sitobion_miscanthi_Chr_genome_final_gene.gff3.pep > Proteomes/Sitobion_miscanthi.fa`


