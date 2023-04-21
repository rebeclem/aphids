from ete3 import Tree
import os
import glob

# This script should read in the file "Aphis_bigdist.txt" and a bunch of alignment files (the ones that are part of this list) that end in _final.fasta. Then it should remove the APHD00272AAUR sequence from each alignment
# Output should be the new alignment

outfile=open("distances.txt",'w')
#branch_lengths = []
#distances = []

taxA="APHD00023AAUR"
taxB="APHD00272AAUR"

outfile.write('Gene \t AAURdistance \t treedist \t LongestBranch \n')

for x in glob.glob('OG*treefile'):
   t=Tree(x,format=0)
   OG_name = x.split('_')[0]
   leaf_names=t.get_leaf_names()
   total_dists=str(t.get_farthest_node())
# Now we want to split total_dists so that it only prints the name and the total distance
   lb=total_dists.split("'")[1]
   dist_node=total_dists.split(",")[1]
   dist_node=dist_node.strip(")")
   if taxA in leaf_names and taxB in leaf_names:
      pat_dist=t.get_distance(taxA,taxB)
   #OGs.append(OG_name)	
   #print(OG_name)
   #tree = Phylo.read(x, "newick")
   #print(tree)
   #bl=tree.total_branch_length()
   #branch_lengths.append(bl)
   #print("Total branch length:",bl)
   #pat_dist=tree.distance("APHD00023AAUR","APHD00272AAUR")
      outline='%s \t %s \t %s \t %s \n' %(OG_name,pat_dist,dist_node,lb)
      outfile.write(outline)
   else:
      outline='%s \t %s \t %s \t %s \n' %(OG_name,"NA",dist_node,lb)
      outfile.write(outline)
outfile.close
#distances.append(dist)
   #print("Distance between aurantiis: ",dist)
   #print(OG_name,bl,dist)
