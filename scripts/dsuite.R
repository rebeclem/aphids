# Dsuite results analysis
# Rebecca Clement
# created July 5, 2023
# last modified:
# In this script, I will read in the output files from dsuite. 
#I will adjust the p values using FDR. then make a heatmap. Calculate range of d statistic values.
# What percent of trios have significant?
# What trios have the largest species pairs

# set working directory
setwd("~/Documents/aphis_myzus_hybridization/ABBABABA/dsuite/")

# load libraries
library(stats)

# Aphis first
aphis_trios<-read.table("aphis_pop_BBAA.txt",header=T)
summary(aphis_trios)
# D statistics range from 0.0002 to 0.199, pvalues range from 0 to .97. max f4 is .13
# how many significant?
table(aphis_trios$p.value<0.01) #324/455 71%
# adjust p values
aphis_trios$p_adj<-p.adjust(aphis_trios$p.value, method = 'fdr')
table(aphis_trios$p_adj<0.01) # now 321/455 70.5%

plot(aphis_trios$p.value,aphis_trios$Dstatistic)
aphis_trios[aphis_trios$Dstatistic>.15,]
plot(aphis_trios$p.value,aphis_trios$f4.ratio)
aphis_trios[aphis_trios$f4.ratio>.06,]

# Is there a difference if you use the dmin output file? Not really?
aphis_dmin<-read.table("aphis_pop_Dmin.txt",header=T)
summary(aphis_dmin)
table(aphis_dmin$p.value<0.01) #308/455 68%
aphis_dmin$p_adj<-p.adjust(aphis_dmin$p.value, method = 'fdr')
table(aphis_dmin$p_adj<0.01) #304
plot(aphis_dmin$p.value,aphis_dmin$Dstatistic)
aphis_dmin[aphis_dmin$Dstatistic>.15,]
plot(aphis_dmin$p.value,aphis_dmin$f4.ratio)
aphis_dmin[aphis_dmin$f4.ratio>.06,]

# For myzus
myzus_trios<-read.table("myzus_pop_BBAA.txt",header=T)
summary(myzus_trios)
# D statistics range from 0.002 to 0.24, pvalues range from 0 to .52, f4 ranges from 0.0002 to .225
# how many significant?
table(myzus_trios$p.value<0.01) #14/20 are significant 70%
# adjust p values
myzus_trios$p_adj<-p.adjust(myzus_trios$p.value, method = 'fdr')
table(myzus_trios$p_adj<0.01) # still 14/20
plot(myzus_trios$p_adj,myzus_trios$Dstatistic)
myzus_trios[myzus_trios$Dstatistic>.15,]
plot(myzus_trios$p_adj,myzus_trios$f4.ratio)
myzus_trios[myzus_trios$f4.ratio>.06,]
