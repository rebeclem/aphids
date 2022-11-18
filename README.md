# Aphid Introgression and Hybridization

=======
Aphids are important insects in the world of agriculture. They feed on the phloem of plants and can transmit plant viruses from plants to plants. They are extremely adept at reproducing in large numbers and adapting resistance to pesticides, perhaps because their **cyclical parthenogenesis** allows them to reproduce asexually during most of the year with females only followed by a period (usually the fall) where there are males and they reproduce sexually.

Aphids have been transported all over the globe due to agricultural imports and exports. Many species of aphids are **polyphagous**, meaning they feed on many different plant types. These two factors make it likely that **introgression** or **hybridization** are happening in aphids. Hybridization is the cross-breeding of individuals of different species. Introgression is a type of hybridization where the transfer of genes between species is also accompanied by back-crossing of hybrids with parent species resulting in a complex, highly variable mixture of genes. Evidence for introgression in aphids was found in [Owen and Miller 2022](https://resjournals.onlinelibrary.wiley.com/doi/10.1111/syen.12542?af=R) and [Mathers et al. 2022](https://www.biorxiv.org/content/10.1101/2022.09.27.509720v1)


Here, we are looking at introgression and hybridization in two genera of aphids: Aphis and Myzus. These two genera contain many aphid pests that are found across the globe.

## Steps to analysis

0) First, we need a set of genomes that have been assembled and annotated. The genomes from Mathers et al. 2022 are available on [zenodo](https://zenodo.org/record/5908005#.YzxkkuzMIeZ)
1) Next, we need to find a set of [orthologs](orthologs.md) with the amino acids
    * 1b. [Interpret Orthofinder Results](interpret_orthofinder.md)
2) Find the corresponding nucleotides to the amino acids to [set up for HybPiper](hybpiper_setup.md)
3) [Clean and trim raw reads](cleantrim.md)
3) Map genomes from this project to the nucleotide orthologs using [HybPiper](hybpiper.md)
4) [Build a tree](treebuilding.md) using the orthologs
5) Time the tree
6) Find synteny

