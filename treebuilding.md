# Building trees

## Building phylogeny using concatenation

To build a tree with concatenation, we need a fasta file.

1) We will align the fasta files using mafft. Run the mafft script in the fasta_output_aa directory `sbatch ../../../scripts/mafft.sh` or do the following on an interactive node in the fasta_output directory: `module load mafft`.
```
for f in *.FNA; do
mafft ${f} > ${f}_align
done
```
2) In the fasta_output_aa directory do the following:
```
for f in *; do
mafft ${f} > ${f}_align
done
```
3) We have enough sequences that it makes sense to use only those without missing data for our first concatenated alignment. Make two directories in the fasta_output_aa directory--one called "complete" and one called "incomplete". Run `python ../../../scripts/missing_data.py` in the fasta_output_aa directory to move the sequences with 12 sequences to the complete folder and those with fewer to the incomplete folder. For myzus DNA, there should be 4051 fasta files in the complete directory and 3013 in the incomplete. Myzus AA: 4109 complete 2188 incomplete. For Aphis DNA expect 3175 complete and 5456 incomplete. Aphis AA: 4607 complete, 4024 incomplete. 
4) Combine aligned fasta files into a concatenated file using phyx. On an interactive node, first, load the phyx module `module load phyx`, then in the fasta_output_aa directory, use the following command: .a text file of names of aligned files using `pxcat -s OG000503*.FNA_align -p partitions.txt -o myzus_trial.fasta`
5) 

## Building phylogeny using gene tree/species tree methods
