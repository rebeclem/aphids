# Using Blobtools to check for contamination

Towards the beginning of this project, I discovered that APHD00272AAUR was not coming out in the right part of the tree bc it was parasitized. I want to use blobtools to see if I can separate the parasitized sequences from the aphid sequences. Thomas Mathers did something similar in this [G3 paper](https://academic.oup.com/g3journal/article/10/3/899/6026189).

I am also hoping I can use blobtools to see if there has been some contamination in the APHD00027ASPnl2 and APHD00270ASPlk specimens which were morphologically identified as *Myzus ascalonius* and *Myzus varians*, but the mitochondria shows up as Aphis.

To do this:
* First we need assemblies. Thomas Mathers recommended I do this with [discovar](https://github.com/broadinstitute/discovar_de_novo). He says this works well with aphids and illumina short reads.
* First I will transfer the raw reads over to ATLAS on GLOBUS bc CERES is down. I'll transfer first 272, 27, and 270, although I'm curious about doing it with all of them. I will also transfer Phorodons and another outgroup.

```
DiscovarDeNovo READS=M_lig_095_R1_val_1.fq,M_lig_095_R2_val_2.fq OUT_DIR=. NUM_THREADS=32 MAX_MEM_GB=100

### Generate blob plot of assembly (scaffs > 1Kb).
## Alternative run with megablast - can’t use diamond blast results as it does not output taxonomy. 
[matherst@TGAC-HPC kat_unfiltered_assembly]$ submit-slurm_v1.1.pl -q tgac-long -m 16000 -c 16 -t 3-00:00 -e -j M_var_vs_nt_megablast -i "source blast-2.2.31;blastn -task megablast -query a.lines.min_1kb.fasta -db /tgac/references/databases/blast/nt_28022016/nt -outfmt '6 qseqid staxids bitscore std sscinames sskingdoms stitle' -culling_limit 5 -num_threads 16 -evalue 1e-25 -out a.lines.min_1kb.megablast_nt"

# Generate blobDB
[matherst@TGAC-HPC kat_unfiltered_assembly]$ submit-slurm_v1.1.pl -q tgac-long -m 8000 -c 4 -t 2-00:00 -e -j M_var_blob_create_geablast_nt -i "source samtools-1.3;source blobtools-0.9.19;blobtools create -i a.lines.min_1kb.fasta -c M_var_232_to_a.lines.min_1kb.sorted.bam.cov -t a.lines.min_1kb.megablast_nt -o M_var_megablast_nt"
## Make output tables at genus, order and phylum level of taxonomy
[matherst@TGAC-HPC kat_unfiltered_assembly]$ submit-slurm_v1.1.pl -q tgac-long -m 8000 -c 4 -t 1-00:00 -e -j M_var_blob_view_megablast_nt -i "source samtools-1.3;source blobtools-0.9.19;blobtools view -i M_var_megablast_nt.blobDB.json -r genus -o genus"

[matherst@TGAC-HPC kat_unfiltered_assembly]$ submit-slurm_v1.1.pl -q tgac-long -m 8000 -c 4 -t 1-00:00 -e -j M_var_blob_view_megablast_nt -i "source samtools-1.3;source blobtools-0.9.19;blobtools view -i M_var_megablast_nt.blobDB.json -r order -o order"
[matherst@TGAC-HPC kat_unfiltered_assembly]$ submit-slurm_v1.1.pl -q tgac-long -m 8000 -c 4 -t 1-00:00 -e -j M_var_blob_view_megablast_nt -i "source samtools-1.3;source blobtools-0.9.19;blobtools view -i M_var_megablast_nt.blobDB.json -r phylum -o phylum"

# Make blob plots at genus, order and phylum level. Will run each with png and pdf output. 
[matherst@TGAC-HPC kat_unfiltered_assembly]$ blobtools blobplot -i M_var_megablast_nt.blobDB.json -r order -o blobPlot_order
# Phylum
[matherst@TGAC-HPC kat_unfiltered_assembly]$ blobtools blobplot -i M_var_megablast_nt.blobDB.json --format pdf -r phylum -o phylum
```
