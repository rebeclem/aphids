# This script should read in a distances file and plot the distances between the two species of aphis aurantii to see if there's a pattern
# Rebecca Clement
# Jan 19, 2022
library(ggplot2)
library(dplyr)
library(stringr)
library(forcats) #for collapsing factors

dist<-read.table("distances.txt", header=T,sep="\t")
dist %>%
  mutate_if(is.character, str_trim)
dist$AAURdistance=as.numeric(dist$AAURdistance)
dist$longestBranch<-as.factor(str_trim(dist$longestBranch))
dist$Gene<-str_trim(dist$Gene)
head(dist)
dim(dist)
summary(dist)

#Remove distances with NAs
dist2<-dist[!is.na(dist$AAURdistance),]
dim(dist2) # There's 4900 that have both Aurantiis
hist(dist2$AAURdistance,breaks=100,ylim=c(0,1200))
hist(dist$treedist,breaks=100,ylim=c(0,3000),angle=90)
plot(dist$treedist)
table(dist$longestBranch) #3583 for 272AAUR, 2864 for 270ASPlk,27ASPnl has 603
which(table(dist$longestBranch)/8630>.1)
long_names<-which(table(dist$longestBranch)>100)
#Make new categories that have anything less than 100 as other
dist$longestBranch2<-fct_lump_min(dist$longestBranch,100)
levels(dist$longestBranch2)

# remove APHD00272AAUR
dist_noAAUR<-dist[dist$longestBranch!="APHD00272AAUR",]
dim(dist_noAAUR)

# make a plot that shows number of each type of furthest taxa
ggplot(dist,aes(x=longestBranch2)) + geom_bar()+theme_classic() + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
table()
# I'd love to have a plot of distances for each of the longest taxa.
ggplot(data=dist,aes(x=treedist,fill=longestBranch2))+geom_histogram()#+ylim(0,300)+xlim(0,12)

# Just based on the distance between the two AAURs
ggplot(data=dist,aes(x=AAURdistance,fill=longestBranch2))+geom_histogram()+ylim(0,300)+xlim(0,12)
# Which branches are greater than 10?
table(dist[dist$treedist>10,"longestBranch"])
# How many?
dist_sub<-dist[dist$treedist>2.5,]
length(dist_sub$Gene)/nrow(dist)
# It seems like about 10% of the trees have branch lengths longer than 2.5
new_OG<-dist[dist$treedist<2.5,"Gene"]
write.table(new_OG,"Aphis_90pct.txt",quote=F,row.names=F,col.names=F)

# Myzus now

dist_myzus<-read.table("distances_myzus.txt", header=T,sep="\t")
dist_myzus %>%
  mutate_if(is.character, str_trim) %>%
  mutate_if(is.numeric, str_trim)
summary(dist_myzus)
dist_myzus$LongestBranch<-as.factor(dist_myzus$LongestBranch)
levels(dist_myzus$LongestBranch)
dist_myzus$longestBranch2<-fct_lump_min(dist_myzus$LongestBranch,100)
levels(dist_myzus$longestBranch2)
ggplot(data=dist_myzus,aes(x=treedist,fill=longestBranch2))+geom_histogram()
ggplot(dist_myzus,aes(x=LongestBranch2)) + geom_bar()+theme_classic() + theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
table()
#looks great