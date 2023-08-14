# Mitogenome for Melanaphis

## Try with [mitofinder](https://github.com/RemiAllio/MitoFinder)
    * On an interactive node, activate environment, load miniconda, and then `conda install mitofinder megahit python=2.7`.
    * We'll use [this reference](https://www.ncbi.nlm.nih.gov/nuccore/NC_050904.1) from *Hyalopterus pruni* (Note, [this one](https://www.ncbi.nlm.nih.gov/nuccore/MW811104.1) is Melanaphis sacchari, but is not a refseq one.)
    * This command: `mitofinder -j melanaphis -1 APHD00305MDON_R1.fastq.gz -2 APHD00305MDON_R2.fastq.gz -r Melanaphis_sacchari.gb -o 5 -p 20 -m 10`
    * The conda one isn't working so instead, load singularity module `module load singularityCE`, download the stuff `singularity pull --arch amd64 library://remiallio/default/mitofinder:v1.4.1`
    * Or use [mitofinder.sh](scripts/mitofinder.sh). 
    
