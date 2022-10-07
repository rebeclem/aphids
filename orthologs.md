# Finding orthologs

To build a tree using genome data, first we need to find a set of orthologous genes that will make an informative tree. It is fairly easy to find genes that are homologous, or being derived from a single gene. But it is more difficult to know if two segments of DNA have shared ancestry because of a speciation event (ortholog) or a duplication event (paralogs).

To find orthologs, we will use a software called Orthofinder.

![Figure from Orthofinder ms](figs/orthologs.png)

First, let's set up our sequences:

0) First, let's transfer over the genome data from from Mathers et al. 2022 long term storage. Using globus, transfer the zipped directory `Frozen_release.zip` to the directory `/90daydata/aphid_phylogenomics/becca'. 
1) Next, unzip using the command `unzip Frozen_release.zip`
2) Now, move amino acid and nucleotide sequences into directories aa and cds:  5 *Aphis* files (*Aphis fabae, Aphis glycines, Aphis gossypii, Aphis thalictri* and *Aphis rumicis*) and four *Myzus* files (*Myzus cerasi, Myzus ligustri, Myzus lythri* and *Myzus varians*) using the following commands from the becca directory:
    * `mv Frozen_release/Aphis*/*/*.aa.fa aphis/aa`
    * `mv Frozen_release/Aphis*/*/*.cds.fa aphis/cds`
    * `mv Frozen_release/Myzus*/*/*.cds.fa myzus/cds`
    * `mv Frozen_release/Myzus*/*/*.aa.fa myzus/aa`
    * `mv Frozen_release/Annotation_only/Aphis*/*.aa.fa aphis/aa/`
    * `mv Frozen_release/Annotation_only/Aphis*/*.cds.fa aphis/cds/`
    * `mv Frozen_release/Annotation_only/Myzus*/*/*.aa.fa myzus/aa/`
    * `mv Frozen_release/Annotation_only/Myzus*/*/*.cds.fa myzus/cds/`

Hmm.. missing *Aphis rumicis*. There's only scaffolds. There are other genomes for [Myzus persicae](https://bipaa.genouest.org/sp/myzus_persicae/download/annotation/OGS2.0/). Transfer this one to the Myzus folder as well.
4) 
