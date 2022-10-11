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

| --- | Raw | LPTG |
| Number of genes | 

