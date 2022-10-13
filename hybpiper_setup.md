# Setting up files for HybPiper

1) We now have a file with the amino acid sequences that are single-species orthologs. Make a directory in the myzus and aphis directories and call it `hybpiper_aa`. Transfer these files to that directory.
2) Now we need to get a file with the corresponding nucleotide sequences.
3) Next, we need to gather the unannotated genomes for *Aphis* and *Myzus* as well as outgroups and put them in a directory called `unannotated_genomes`. For *Myzus*, we will use outgroups *Dysaphis* and *Brachychotis*. For *Aphis*, we will use outgroups *Melanaphis* and *Hyalopterus*.
4) Now, since HypPiper is not one of the modules loaded on CERES, we will need to [install it using conda](https://scinet.usda.gov/guide/conda/). If you already have installed the bioconda channels, use the commmands `module load miniconda`, `conda create -n hybpiper -c chrisjackson-pellicle hybpiper` and `conda activate hybpiper` to install on CERES.
5) 
