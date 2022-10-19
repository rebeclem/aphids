# Running HybPiper

[HybPiper](https://github.com/mossmatters/HybPiper) is a pipeline of bioinformatics tools that can be used to extract target sequences from high-throughput DNA sequencing reads. It starts with sequencing reads and assigns them to target genes

1) First, since HybPiper is not one of the modules loaded on CERES, we will need to [install it using conda](https://scinet.usda.gov/guide/conda/). If you already have installed the bioconda channels, use the commmands `module load miniconda`, `conda create -n hybpiper -c chrisjackson-pellicle hybpiper` and `source activate hybpiper` to install on CERES. When you log back in later, you will only need to use `module load miniconda` and then `source activate hybpiper`
2) Next, transfer over reads from just the forward strands and combine single reads.
