# Building trees

## Building phylogeny using concatenation

To build a tree with concatenation, we need a fasta file. In the fasta_output_aa directory of hybpiper, we have 8631 (for *Aphis*) and 7064 (for *Myzus*) .FAA files and .FNA files. Each of these has sequences from each species of aphid, but we also need to align the original target files that we mapped to from the genomes online. The names of the sequences in the .FAA and .FNA files don't have the gene name and have descriptions like "APHD00002ASPI_aa multi_hit_stitched_contig_comprising_2_hits", while the names in the target files (targets_aa_OG.fa and targets_all_OG.fa) are formatted with the name and the gene "AFAB-OG0003568".

1) First, we need to rename the sequences in the .FAA and .FNA files. Allocate an active node with `salloc`. Load miniconda and a python environment then use the command: `python ../../../scripts/name_change_FAA.py` to run [name_change_FAA.py](name_change_FAA.py)
2) Use seqtk to pull out matching sequences.
3) In the fasta_output_aa directory do the following:
```
for f in *.FAA; do
mafft ${f} > ${f}_align
done
```
3) Now we will use PAL2NAL and the amino acid alignments to align the DNA. In the fasta_output_aa directory, run the [pal.sh](scripts/pal.sh) script which uses the [pal2nal](https://github.com/nextgenusfs/funannotate/blob/master/funannotate/aux_scripts/pal2nal.pl) script. 
4) You should end up with 7064 files that end in pal.fasta for myzus and 8631 files for Aphis. Double check with `ls *pal.fasta | wc -l` to make sure they are all there.
5) Then we will trim using [GBLOCKS](https://anaconda.org/bioconda/gblocks). First make a virtual environment for gblocks. Load the miniconda module: `module load miniconda`. Activate it: `source activate gblocks`, then install gblocks using two commands: `conda install -c bioconda gblocks` and `conda install -c "bioconda/label/cf201901" gblocks`. If you need to run gblocks again, just use `source activate gblocks`
6) Now, in the fasta_output_aa directory, run the [gblocks.py](scripts/gblocks.py) using `python ../../../scripts/gblocks.py`.
7) We have enough sequences that it makes sense to use only those without missing data for our first concatenated alignment. Make two directories in the fasta_output_aa directory--one called "complete" and one called "incomplete". Run `python ../../../scripts/missing_data.py` in the fasta_output_aa directory to move the sequences with 12 sequences to the complete folder and those with fewer to the incomplete folder. For myzus DNA, there should be 4051 fasta files in the complete directory and 3013 in the incomplete. Myzus AA: 4109 complete 2188 incomplete. For Aphis DNA expect 3175 complete and 5456 incomplete. Aphis AA: 4607 complete, 4024 incomplete. 
8) Combine aligned fasta files into a concatenated file using phyx. On an interactive node, first, load the phyx module `module load phyx`, then in the fasta_output_aa directory, use the following command: .a text file of names of aligned files using `pxcat -s OG000503*.FNA_align -p partitions.txt -o myzus_trial.fasta`
9) 

## Building phylogeny using gene tree/species tree methods
