# Building trees

## Building phylogeny using concatenation

To build a tree with concatenation, we need a fasta file.

1) We will align the fasta files using mafft. Do the following on an interactive load in the fasta_output directory: `module load mafft`.
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
3) Combine aligned fasta files into a concatenated file using [this script](https://github.com/mossmatters/HybPiper/blob/master/hybpiper/fasta_merge.py). First, make a text file of names of aligned files using `ls *align > fasta_aln.txt`
4) 

## Building phylogeny using gene tree/species tree methods
