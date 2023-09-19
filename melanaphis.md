# Mitogenome for Melanaphis

There is a new record of *Melanaphis donacis* that we are going to publish the mitochondria for. 

## Try with [mitofinder](https://github.com/RemiAllio/MitoFinder)
    * On an interactive node, activate environment, load miniconda, and then `conda install mitofinder megahit python=2.7`.
    * We'll use [this reference](https://www.ncbi.nlm.nih.gov/nuccore/NC_050904.1) from *Hyalopterus pruni* (Note, [this one](https://www.ncbi.nlm.nih.gov/nuccore/MW811104.1) is Melanaphis sacchari, but is not a refseq one.)
    * This command: `mitofinder -j melanaphis -1 APHD00305MDON_R1.fastq.gz -2 APHD00305MDON_R2.fastq.gz -r Melanaphis_sacchari.gb -o 5 -p 20 -m 10`
    * The conda one isn't working so instead, load singularity module `module load singularityCE`, download the stuff `singularity pull --arch amd64 library://remiallio/default/mitofinder:v1.4.1`
    * Or use [mitofinder.sh](scripts/mitofinder.sh). 

Mitofinder with raw reads mapped to Hyalopterus pruni (MDON) gave me 5 different contigs. 14 genes. All assembled to draft.
- Contig 1 (17,753bp) aligns really well with the ND5 gene. Last ~7000 matches really well to Aphis gossypii chromosome 2. 
- Contig 2 (12,356bp) aligns well with rrnS, rrnL, nd1, cytB, nd6, nd4. Last bit matches to Aphis gossypii chromosome 2, 3, 4, and 1.
- Contig 3 (6,954bp) aligns well with nd2, cox1, cox2, ATP6, COX3, nd3
- Contig 4 (24,196bp) doesn't seem like it lines up with anything. Matches to Tuberolachnus chromosome 3, Melanaphis mitochondrion, Aphis gossypii chromosome 1
- Contig 5 (8,063bp) doesn't match well with anything. Matches to Hyalopterus pruni mitochondrion.

Raw reads mapped to Melanaphis sacchari (melanaphis) gave me 4 contigs. 15 genes. All assembled to draft. Contig 4 in part matches to Melanaphis sacchari endoribonuclease Dicer-like (LOC112590953), mRNA.

Tripp recommended I assemble contigs first using spades.
    To do this, first, I'll assemble contigs using spades.
* Load the spades module, then run `spades.py -1 APHD00305MDON_R1.fastq.gz -2 APHD00305MDON_R2.fastq.gz -s APHD00305MDON_A_BothSingle.fastq.gz -o spades_MDON`
* It assembled the reads into 115295 contigs. We'll use these as input for the next run of mitochondria.
   * Blast to see if you can find genes in it. On an interactive node, use `module load blast+`, then `makeblastdb -dbtype nucl -in ../spades_MDON/contigs.fasta`
   * Run blast with `blastn -db ../spades_MDON/contigs.fasta -query MDON_cox1.fasta -evalue 1e-5 -outfmt 7`
* Also it looks like you can use more than one reference database. In [NCBI](https://www.ncbi.nlm.nih.gov/nuccore) use the search term "hemiptera mitochondrion complete genome", then narrow to RefSeq for source databases. This gives 703 matches. Download these as a .gb file. 
* Concatenate this with the Melanaphis sacchari genbank file (which is not refseq quality). `cat Melanaphis_sacchari.gb hemiptera_refseq.gb > hemiptera_MSAC.gb`
* Run mitofinder with the contigs.fasta output file from spades.
* Problem: -orf114 and a bunch of other genes aren't recognized. Solution: delete the genbank from that weird fungus.
-GIY-YIGendonuclease: NC_049089
 -intron-encodedendonucleaseaI1: NC_049089
 -ribosomalproteinS3
 -ATPsynthaseF0subunita
 -endonuclease
 -LAGLIDADGendonuclease
 -reversetranscriptase
 -ATPsynthaseF0subunitc
 -alpha-beta-hydrolase
 -ATPasesubunit8
 -hypotheticalprotein
 -ATPasesubunit6

This (MDON2--spades contigs as input, hemiptera as reference) resulted in 15 contigs. Most of these don't align well with the CLC output. One is 17K bp, the rest are shorter than 8K. The 17K one blasts to Adineta vaga chromosome 3-- a rotifer? or Aphis gossypii chromosome 3. 14 genes found -- 11 map to draft, 3 dont: COX1 (Cladosporium), ND4L (Cladosporium), ND5 (Cladosporium).

Try: 
* mitofinder with hemiptera reference and raw reads (MDON_hemip_ref): Found 17 contigs. A few are big. 15 genes--14 match draft, but COX1 blasts to Cladosporium.
* I'll also try running mitofinder with spades contigs with only 1 reference (MDON_contig_HPRU): Found 5 contigs. Only found 11 genes--all align to draft mitochondria. 
* I'll also try running mitofinder with the numt setting--see if that does anything (MDON_numt). Concatenate all the files generated with `cat MDON2_mtDNA_contig_[0-9].fasta MDON2_mtDNA_contig_[0-9][0-9].fasta > all_MDON2_contigs.fasta`. Then run `singularity run mitofinder_v1.4.1.sif --numt -j MDON_numt -a 90day_aphid/melanaphis/MDON2/MDON2_MitoFinder_mitfi_Final_Results -r hemiptera_MSAC.gb -o 5 -p 20 -m 10`: This didn't really seem to work.

| Runs | melanaphis | MDON | MDON_contig_HPRU | MDON2 | MDON_hemipRef_raw |MDON_aphid_ref | MDON_contig_aphididae |
|---|---|---|---|---|---|---|---|
|Reference|M.sacchari|H.pruni|H.pruni|703 Hemiptera | 703 Hemiptera | 43 Aphididae | 43 Aphididae
|Input | Raw fastq | Raw fastq | Contigs from SPAdes | Contigs from SPAdes | Raw Fastq | Raw Fastq | Contigs from SPAdes |
|Contigs found | 4 | 5 | 5 | 15 | 17 | 5 | 6 |
|Longest contig |24,196 |24,196|8055 | 17,251 | 24,196 | 5403 | 8055 |
|Genes found | 15 | 14 | 11 | 14 | 15 | 15 | 12 |
|Non-matching genes | 0| 0 | 0 | 3 (Cladosporium) | 1 (Cladosporium)| 0 | unknown |

The contig that is 24,196 seems to only have a small portion matching mitochondrial reads (COX3)--the rest maps to A. gossypii chromosome 1. 

### From CLC:
* I assembled all the paired reads into contigs. Of these 53,223 contigs, I filtered to contigs that were between 12000 and 20000 in consensus length, then sorted by coverage. One of them, contig 209, was 15,382bp and had 94991 coverage--the rest had <12K coverage. 

# mitos to circularize.
* I'm using the fasta file generated by CLC.
* Differences between Geneious transfer of MSAC annotations vs MITOS annotations:
    * MITOS has an OH_1, 16S/rrnL starts 566 later and ends 17 later (is smaller)
    * nad1 starts 18 later, ends 18 earlier, doesn't end on a stop codon.
    * nad2 starts 51 later, ends 81 earlier, not on a stop codon.
    * cox1 starts 33 later (not on an M), ends 24 early.
    * Cox2 starts 21 later, ends 15 early.
    * ATP8 starts the same, but ends 15 early.
    * ATP6 starts 96 later, ends 12 early
    * COX3 starts the same, ends 3 early
    * nad3 starts 3 later, ends same.
    * nad5 ends 516 earlier, starts 108 later
    * ND4 ends 25-26 earlier, starts 141 later
    * ND4L ends 3 early, starts 45 later
    * ND6 starts 45 later, ends 9 early
    * Cytb starts 33 alter, ends 45 early,
    * ND1 ends 18 early, starts 18 late
    * 

# BWA
* `bwa index -p CLCref CLCref.fa` Index the reference from CLC
* `bwa mem CLCref APHD00305MDON_R1.fastq APHD00305MDON_R2.fastq 2> bwa.err >MDonBWA.sam`
* 505,721 reads mapped to the CLCref
* mapped to the MSAC reference

# MitoZ
* on an interactive node: `module load singularityCE`
* `singularity pull MitoZ_v3.6.sif docker://guanliangmeng/mitoz:3.6`
* `singularity run MitoZ_v3.6.sif mitoz all  --outprefix MDON_mitosz --thread_number 4 --clade Arthropoda --genetic_code auto --species_name "Melanaphis donacis" --fq1 ../APHD00305MDON_R1.fastq.gz --fq2 ../APHD00305MDON_R1.fastq.gz --insert_size 139 --data_size_for_mt_assembly 8,0 --assembler megahit --kmers_megahit 71 99 --memory 50 --requiring_taxa Arthropoda --skip_filter`
* Or use [mitoZ.sh](scripts/mitoZ.sh)
* First run through with only 8Gb of data and megahit found only 6 protein coding genes
* Second runthrough with all data and megahit found all 13 protein coding genes, but in 2 different contigs--linear, not circular.
* Third runthrough with spades: Circular mitochondria! Found 36 genes. only missin gtRNA-Glu. 
* Fourth runthrough with mitoassemble: annotation finished with no result. l

# Novoplasty
* Upload perl script from [here](https://github.com/ndierckx/NOVOPlasty)
* Run [novoplasty.sh](scripts/novoplasty.sh). Use COX1 as a seed.
* It found 1 contig with 22022 bp from 75680 assembled reads with average organelle coverage of 579.
* Part of this has ~7K bp reversed.
* Try with raw reads--this worked! 16848 bp for a circularized contig!
* Increasing kmer length to 63 didn't make a difference
* Increasing kmer length to 43 and insert size to 262 made contig 16172 long.
* Trying with a longer seed than just cox1: gave 15974bp
```
Project:
-----------------------
Project name          = MDON
Type                  = mito
Genome Range          = 12000-22000
K-mer                 = 33
Max memory            =
Extended log          = 0
Save assembled reads  = no
Seed Input            = ../MDON_cox1.fasta
Extend seed directly  = no
Reference sequence    = ../MSAC_mito.fasta
Variance detection    =
Chloroplast sequence  =

Dataset 1:
-----------------------
Read Length           = 150
Insert size           = 262
Platform              = illumina
Single/Paired         = PE
Combined reads        =
Forward reads         = APHDOO305_S99_R1_001.fastq.gz
Reverse reads         = APHDOO305_S99_R2_001.fastq.gz
Store Hash            =

Heteroplasmy:
-----------------------
MAF                   =
HP exclude list       =
PCR-free              =

Optional:
-----------------------
Insert size auto      = yes
Use Quality Scores    = no
Reduce ambigious N's  =
Output path           =
```
* 
