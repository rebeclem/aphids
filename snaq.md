# Phylogenetic Networks

We now have both a species tree and a concatenated tree for these aphid groups. Now we can start looking for hybridization events using a network approach. One method of doing this is a software called [SNaQ](http://crsl4.github.io/PhyloNetworks.jl/latest/man/inputdata/).
* Make a directory called snaq in the aphis and myzus folder and transfer the gene tree and species tree files from the Analysis folder.
*  On an interactive node, load the julia module. Type julia to start running julia. Then press the "]" key to start the [package manager.](https://researchcomputing.princeton.edu/support/knowledge-base/julia)
```
activate "/home/<YourNetID>/.julia/project1"
add PhyloNetworks
add CSV
add DataFrames
```
* I ran into this issue when my package didn't load but [this fixes it? ](https://discourse.julialang.org/t/help-with-registry-toml-missing/49304)
* To make sure it's working, type `using PhyloNetworks;`
* Following [this tutorial](http://crsl4.github.io/PhyloNetworks.jl/latest/man/inputdata/), read in the file of gene trees with `genetrees = readMultiTopology("myzus_gene.tre");` Verify you can see one of the gene trees with `genetrees[3]`.
* Calculate the quartets in your gene trees `q,t = countquartetsintrees(genetrees);` and put it in a data frame `df = writeTableCF(q,t)`
* Write it to a CSV: `using CSV; CSV.write("myzus_tableCF.csv", df);` and then read it in as a DataCF object: `iqtreeCF = readTableCF("myzus_tableCF.csv")`
* Read in your astral consensus tree: `astraltree = readMultiTopology("myzus_astral.tre")[1]`
* To leave the environment use the package manager then "activate". 
* To access the environment again, start julia, then type:
```
using Pkg
Pkg.activate("/home/rebecca.clement/.julia/project1")
Pkg.instantiate()
```
* Use Pkg.status() to see what packages you have loaded.
* Update the [runSNaQ.jl](scripts/runSNaQ.jl) to have the correct csv and tree file names, as well as the correct pathway to your julia project. Then run `sbatch ../../scripts/snaq.sh`.
