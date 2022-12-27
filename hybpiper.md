# Running HybPiper

[HybPiper](https://github.com/mossmatters/HybPiper) is a pipeline of bioinformatics tools that can be used to extract target sequences from high-throughput DNA sequencing reads. It starts with sequencing reads and assigns them to target genes

1) First, since HybPiper is not one of the modules loaded on CERES, we will need to [install it using conda](https://scinet.usda.gov/guide/conda/). If you already have installed the bioconda channels, use the commmands `module load miniconda`, `conda create -n hybpiper -c chrisjackson-pellicle hybpiper` and `source activate hybpiper` to install on CERES. When you log back in later, you will only need to use `module load miniconda` and then `source activate hybpiper`
2) Next, transfer over reads from just the forward strands. Navigate to the `aphis_myzus` directory with all of the trimmed and single reads from trimmomatic, allocate a node using `salloc`, and run `python ../../scripts/move_files.py` script which reads in a file with the names and new names and puts them into a dictionary, then reads in the files that have R1 & trim and moves them to either the aphis or myzus analysis folder with changed names.
3) Move the single reads using 'python ../../scripts/move_singles.py`. Now you should have three files for each sample.
4) Combine singles. In the aphis/hybpiper_cds directory, use the command: `for file in *R1_BothSingle.fastq.gz*; do pref=${file%%_*}; cat ${pref}_A_R1_BothSingle.fastq.gz ${pref}_A_R2_BothSingle.fastq.gz > ${pref}_A_BothSingle.fastq.gz; done`. Then remove the files that have an R1 or R2 in them: `rm *R1_BothSingle*` and `rm *R2_BothSingle*
5) In the myzus/hybpiper directory, do the same thing: `for file in *R1_BothSingle.fastq.gz*; do pref=${file%%_*}; cat ${pref}_M_R1_BothSingle.fastq.gz ${pref}_M_R2_BothSingle.fastq.gz > ${pref}_M_BothSingle.fastq.gz; done`. Then remove the files that have an R1 or R2 in them: `rm *R1_BothSingle*` and `rm *R2_BothSingle*
6) Now we need to make a file that has a list of the prefixes to use for the run:
    ```
    for file in *BothSingle.fastq.gz; do 
    pref=${file%%_*}  
    echo ${pref} >> namelist.txt 
    done
    ```
7) Before you run, make sure you have 'namelist.txt': a list of prefixes for each sample, `targets_all_OG.fa`: a fasta file with sequences formatted like AFAB-OG0003568, two paired sequence files and one BothSingle sequence file for each prefix. Once these are complete, run `sbatch ../../scripts/hybpiper.sh` from within both the aphis and myzus directories.
8) Next, we will also run this on just the amino acid sequences. Make a list of the prefixes with "aa" after each one for the stats part of the commmand. `for file in *BothSingle.fastq.gz; do pref=${file%%_*}; echo "${pref}_aa" >> namelist_aa.txt; done`
9) Then, run `sbatch ../../scripts/hybpiper_aa.sh` in both the aphis and myzus directories.
10) On an interactive node, run `hybpiper stats -t_dna targets_all_OG.fa gene namelist.txt` in both the aphis/hybpiper and myzus/hybpiper directories. Or run (`hybpiper_stats.sh`)[scripts/hybpiper_stats.sh]
11) Next, to get the stats from the aa run, use `hybpiper stats -t_aa targets_aa_OG.fa gene namelist_aa.txt --seq_lengths_filename seq_lengths_aa --stats_filename hybpiper_stats_aa` to assign a different name for the seq lengths and stats files.
12) Make some recovery heatmaps using the commands: `hybpiper recovery_heatmap seq_lengths.tsv` and `hybpiper recovery_heatmap seq_lengths_aa.tsv --heatmap_filename recovery_heatmap_aa` 
13) Copy the files to a directory called heatmaps. then copy to my computer using `rsync -avh rebecca.clement@ceres.scinet.usda.gov:/90daydata/aphid_phylogenomics/becca/aphis/heatmaps/ .`


## HybPiper Output

1) After you run hybpiper stats, you should have two summary statistics tsv files: `seq_lengths.tsv`, which lists the gene lengths recovered by HybPiper, and `hybpiper_stats.tsv`, which gives statistics about the run for all samples--see full explanation in the [tutorial](https://github.com/mossmatters/HybPiper/wiki/Tutorial). See [results](https://docs.google.com/spreadsheets/d/1lA_A7v1McQYVXbxUdtAB53EJPoQIcvBhJ5BX2rukXvc/edit#gid=1871184420).
2) Make a directory called "fasta_output", then retrieve the sequences using command: `hybpiper retrieve_sequences dna -t_dna targets_all_OG.fa --sample_names namelist.txt --fasta_dir fasta_output`, and `hybpiper retrieve_sequences dna -t_dna targets_aa_OG.fa --sample_names namelist_aa.txt --fasta_dir fasta_output_aa`. Or run the file ['hybpiper_retrieve.sh'](scripts/hybpiper_retrieve.sh)

## HybPiper to pull out symbionts and COI barcoding sequences
* We want to make sure that we have the correct sequence ID's. One way of doing this is mapping to aphid COIs. There is a file at `/90daydata/aphid_phylogenomics/chris/hybpiper_seqs_to_orthos/aphid_scp_orthos_mtdna_rbcl_endos.fasta` that has a list of endosymbionts and mitochondrial DNA for aphids. In the "hybpiper" directory, run [hybpiper_COI.sh] to pull out the mitochondrial and endosymbiont sequences. We will leave off the intronerate option for this one.
* When it finishes, make a file called namelist_COI.txt that has the names of the directories: `ls -d *COI > namelist_COI.txt`.
* Retrieve the samples. Run ['hybpiper_retrieve_COI.sh'](scripts/hybpiper_retrieve_COI.sh).
* [Blast](https://blast.ncbi.nlm.nih.gov/Blast.cgi) the samples in "COX1.FNA" in the fasta_output_COI directory to verify species ID and use the Canadian site Biodiversity of life database [BOLD](https://www.boldsystems.org/index.php/IDS_OpenIdEngine).
* Record best matches in the [hybpiper output](https://docs.google.com/spreadsheets/d/1lA_A7v1McQYVXbxUdtAB53EJPoQIcvBhJ5BX2rukXvc/edit#gid=1606515432) database.
* Make an alignment of COI sequences by uploading COX1.FNA or copy pasting file to [mafft](https://mafft.cbrc.jp/alignment/server/)
* Download the alignment and upload it to [iqtree](http://iqtree.cibiv.univie.ac.at/)
* Look at treefile using Figtree.

## Using Hybpiper to pull out sequences from other available genomes
* First, find sequences with SRA data on GenBank. I have a list [here](https://docs.google.com/spreadsheets/d/1YTeKEWSZg9Z5VIzDOeepkhvPFj-RW5Ua3oGiUnMjQRo/edit#gid=0).
* Put their names into a file called [sra_fetch_dump_array_list.txt](scripts/sra_fetch_dump_array_list.txt) with the SRR code and their name.
* Fetch the sequences from GenBank using SRA tools using [sra_fetch_array.sh](scripts/sra_fetch_array.sh). After this step you should have a bunch of files that end in ".sra".
* Use [sra_fastqdump.sh](scripts/sra_fastqdump.sh) to convert these .sra files to .fastq files.
* Rename the sequences to have a 4 digit species code and to include "other" in the name like "other_AGOS_ASM2018417v2.fasta.gz" using the python script [name_change4.py](scripts/name_change4.py).
* Move the genomes to either the aphis/hybpiper or myzus/hybpiper directories. `mv other_A* ../../aphis/hybpiper/` and `mv other_M* ../../myzus/hybpiper/`.
* In the hybpiper directory, put their names in a file called 'genomelist.txt'. `for file in other*1.fastq; do pref=${file%_*}; echo ${pref} >>genomelist.txt; done`
* Run [hybpiper_other.sh](scripts/hybpiper_other.sh) in the aphis and myzus hybpiper directories
* Run hybpiper_other_COI.sh to pull out COI sequences for these.
* Retrieve the sequences once they're finished.

Next step: [Build a tree](treebuilding.md)
