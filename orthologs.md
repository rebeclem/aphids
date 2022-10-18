# Finding orthologs

To build a tree using genome data, first we need to find a set of orthologous genes that will make an informative tree. It is fairly easy to find genes that are homologous, or being derived from a single gene. But it is more difficult to know if two segments of DNA have shared ancestry because of a speciation event (ortholog) or a duplication event (paralogs).

To find orthologs, we will use a software called Orthofinder.

![Figure from Orthofinder ms](figs/orthologs.png)

First, let's set up our sequences:

0) First, let's transfer over the genome data from from Mathers et al. 2022 long term storage. Using globus, transfer the zipped directory `Frozen_release.zip` to the directory `/90daydata/aphid_phylogenomics/becca'. 
1) Next, unzip using the command `unzip Frozen_release.zip`
2) Now, move amino acid and nucleotide sequences into directories aa and cds:  5 *Aphis* files (*Aphis fabae, Aphis glycines, Aphis gossypii, Aphis thalictri* and *Aphis rumicis*) and four *Myzus* files (*Myzus cerasi, Myzus ligustri, Myzus lythri* and *Myzus varians*) using the following commands from the becca directory:
    * `scp Frozen_release/Aphis*/*/*.aa.fa aphis/aa`
    * `scp Frozen_release/Aphis*/*/*.cds.fa aphis/cds`
    * `scp Frozen_release/Myzus*/*/*.cds.fa myzus/cds`
    * `scp Frozen_release/Myzus*/*/*.aa.fa myzus/aa`
    * `scp Frozen_release/Annotation_only/Aphis*/*.aa.fa aphis/aa/`
    * `scp Frozen_release/Annotation_only/Aphis*/*.cds.fa aphis/cds/`
    * `scp Frozen_release/Annotation_only/Myzus*/*/*.aa.fa myzus/aa/`
    * `scp Frozen_release/Annotation_only/Myzus*/*/*.cds.fa myzus/cds/`
    * Note, for  *Aphis rumicis*, There's only scaffolds, so we won't use it at this stage.
    * There are other genomes for [Myzus persicae](https://bipaa.genouest.org/sp/myzus_persicae/download/annotation/OGS2.0/). Transfer this one to the Myzus folder as well.
3) At the end of this, using the commands `ls aphis/*` and `ls myzus/*` you should see that both your cds and aa directories should have four fasta files in them in aphis, and five files in myzus.
4) Make a directories in aphis and myzus called aaLTPG and cdsLTPG and transfer files to these, so we can test and see if using the longest transcript per gene makes a difference.
6) Allocate an interactive node to run the analysis on CERES using `alloc`
7) Rename the files--add four letter code and identifier to the beginning. I'll do this manually since there's only a few. Then, in the aaLTPG directory, load the python module `module load python_3` and run the python script [name_change.py](scripts/name_change.py) to change the names of the fasta sequences to include the names using the command `python3 ../../scripts/name_change.py`. Do the same thing in the cdsLTPG directory for both *Aphis* and *Myzus*.
8) Make a directory for the raw files and move original files there `mv *G.fa raw_files`
9) Load the orthofinder module (`module load orthofinder`) and run the command `orthofinder -f aphis/aa`. This may take up to an hour.
10) Orthofinder recommends using only the longest transcript variant per gene. To extract these from the myzus genomes we uploaded, use the command: `for f in *fa ; do python scripts/primary_transcript.py $f ; done
    * Alternatively, use the script [orthofinder.sh](scripts/orthofinder.sh), and run using `sbatch scripts/orthofinder.sh` from the becca directory.


Next: [Interpret Orthofinder Results](interpret_orthofinder.md)
