# Running snaq to test for hybridization between all taxa including aphis and myzus

In the [SNaQ manuscript](https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1005896), they are able to successfully run the snaq network analysis with 24 taxa. In total, we have ~56 taxa, from about 34 different species. I think if we subset to include one taxa from each species, this might be manageable.

1. Make a directory called "snaqboth", get on an interactive node and load the julia module
2. Read in the list of gene trees
3. Run a python script to prune trees.
4. 
