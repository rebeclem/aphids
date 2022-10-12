# Interpretting Orthofinder results

The first thing to do is get some idea of how your run went. In the Orthofinder folder, use the commmand `cat Comparative_Genomics_Statistics/Statistics_Overall.tsv` to take a look at some of the statistics for the run. For *Aphis*, it looks something like this:

```
Number of species	4
Number of genes	92101
Number of genes in orthogroups	87530
Number of unassigned genes	4571
Percentage of genes in orthogroups	95.0
Percentage of unassigned genes	5.0
Number of orthogroups	16961
Number of species-specific orthogroups	1242
Number of genes in species-specific orthogroups	4534
Percentage of genes in species-specific orthogroups	4.9
Mean orthogroup size	5.2
Median orthogroup size	4.0
G50 (assigned genes)	5
G50 (all genes)	5
O50 (assigned genes)	4839
O50 (all genes)	5296
Number of orthogroups with all species present	10799
Number of single-copy orthogroups	6893
Date	2022-10-11
Orthogroups file	Orthogroups.tsv
Unassigned genes file	Orthogroups_UnassignedGenes.tsv
Per-species statistics	Statistics_PerSpecies.tsv
Overall statistics	Statistics_Overall.tsv
Orthogroups shared between species	Orthogroups_SpeciesOverlaps.tsv
```

95% of our 92101 genes were assigned to orthogroups! (Fewer than 80% is problematic)

## Difference between raw and LPTG files

| --- | Aphis_all | Aphis_LPTG | Myzus_all | Myzus_LPTG |
| --- | --- | --- | --- | --- | 
| Number of taxa | 4 | 4 | 5 | 5 |
| Number of genes | 92101 | 83379 | 119918 | 110955 |
| Percent of genes in orthogroups | 95.0 | 94.6 | 94.0 | 93.2 |
| Number of orthogroups | 16961 | 16265 | 18629 | 17481 |
| Number of orthogroups with all species present | 10799 | 10560 | 10553 | 10176 |
| Number of single-copy orthogroups | 6893 | 8631 | 6203 | 7064 |

Genomes that include only the LTPG (longest transcript per gene) have fewer total genes, and a slightly smaller percent added to orthogroups, fewer orthgroups and fewer orthogroups with all species present. However, there are more single-copy orthogroups.
