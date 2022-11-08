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
10) On an interactive node, run `hybpiper stats -t_dna targets_all_OG.fa gene namelist.txt` in both the aphis/hybpiper and myzus/hybpiper directories.
11) Next, to get the stats from the aa run, use `hybpiper stats -t_aa targets_aa_OG.fa gene namelist_aa.txt --seq_lengths_filename seq_lengths_aa.tsv --stats_filename hybpiper_stats_aa.tsv` to assign a different name for the seq lengths and stats files.

## HybPiper Output

1) After you run hybpiper stats, you should have two summary statistics tsv files: `seq_lengths.tsv`, which lists the gene lengths recovered by HybPiper, and `hybpiper_stats.tsv`, which gives statistics about the run for all samples--see full explanation in the [tutorial](https://github.com/mossmatters/HybPiper/wiki/Tutorial).