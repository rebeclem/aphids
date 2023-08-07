# Potato aphid project

We will run orthofinder on aphids that have similar sequencing quality (ie long reads), and then do something to visualize the synteny.

    * First step: find the genomes we want to use listed [here](https://docs.google.com/spreadsheets/d/1YTeKEWSZg9Z5VIzDOeepkhvPFj-RW5Ua3oGiUnMjQRo/edit#gid=611073991). It should be a fasta file of a proteome (amino acid or peptide sequences) and preferably LTPG (longest transcript per gene). They need to be unzipped. 

    * One of the aphids, Therioaphis trifolii does not have amino acid sequences. Use [dna2proteins](https://github.com/prestevez/dna2proteins/tree/master) to convert the DNA to amino acid sequences. `python ~/90day_aphid/aphids_github/scripts/dna2proteins.py -i Therioaphis_trifolii_OMIX002673-01.fasta -o Therioaphis_trifolii_aa.fa`. (Note, I added parentheses to the prints in the [dna2proteins.py](scripts/dna2proteins.py) script.
    * Rename the fasta files to just be Genus_species.fa
    * Sitobion has periods at the end of lines. Remove them `sed 's/\.$//g' Sitobion_miscanthi_Chr_genome_final_gene.gff3.pep > Proteomes/Sitobion_miscanthi.fa`
    * Run orthofinder. `module load orthofinder; orthofinder -f Proteomes`
    * Next step: Summarize orthofinder findings--how many single copy?

Results: OrthoFinder assigned 210222 genes (90.2% of total) to 19253 orthogroups. Fifty percent of all genes were in orthogroups with 12 or more genes (G50 was 12) and were contained in the largest 5255 orthogroups (O50 was 5255). There were 5068 orthogroups with all species present and 1655 of these consisted entirely of single-copy genes. Here is the species tree.
![Figure from potato orthofinder](figs/Orthofinder_species_tree.png)


    * Then: Synteny


