# Comparing assembly quality from spades, masurca and DiscovarDenovo
# Rebecca Clement
# Mar 13, 2024

setwd("~/Documents/aphis_myzus_hybridization/discovar/")

library(ggplot2)
library(tidyverse)

# read in files
spades=read_csv("spades_stats.csv")
masurca=read_csv("masurca_stats.csv")
discovar=read_csv("discovar_stats.csv")
head(masurca)

# I'd like to make a figure to compare the assembly length, number of contigs, average contig size, and n50 length

# First I need to rename the column names from discovar
head(discovar)
colnames(discovar)
#discovar2<-discovar[,c(1,6,8,2,3,4)]
#colnames(discovar2)<-c("Sample","AssemblyLength","Ns","n_contigs","avgContigSize","N50length")

# Add a column called assembly method
spades$method<-"spades"
masurca$method<-"masurca"
discovar$method<-"discovar"

# now put them into a combined dataset
assemblies<-rbind(spades,masurca,discovar)
dim(assemblies)
assemblies$AssemblyLength<-as.numeric(assemblies$AssemblyLength)
assemblies$n_contigs<-as.numeric(assemblies$n_contigs)
assemblies$avgContigSize<-as.numeric(assemblies$avgContigSize)
assemblies$N50length<-as.numeric(assemblies$N50length)

## A basic scatterplot with color depending on Species
ggplot(assemblies, aes(x=n_contigs, y=avgContigSize, color=method)) + 
  geom_point(size=1) +
  theme_classic()

#assembly length
ggplot(assemblies, aes(x = method, y = AssemblyLength)) + 
  geom_boxplot(aes(fill = method), alpha = .2) +
  geom_line(aes(group = Sample)) + 
  geom_point(size = 1) 

#n_contigs
ggplot(assemblies, aes(x = method, y = n_contigs)) + 
  geom_boxplot(aes(fill = method), alpha = .2) +
  geom_line(aes(group = Sample)) + 
  geom_point(size = 1) 
#avgContigSize
ggplot(assemblies, aes(x = method, y = avgContigSize)) + 
  geom_boxplot(aes(fill = method), alpha = .2) +
  geom_line(aes(group = Sample)) + 
  geom_point(size = 1) 
#N50 length
ggplot(assemblies, aes(x = method, y = N50length)) + 
  geom_boxplot(aes(fill = method), alpha = .2) +
  geom_line(aes(group = Sample)) + 
  geom_point(size = 1) 
