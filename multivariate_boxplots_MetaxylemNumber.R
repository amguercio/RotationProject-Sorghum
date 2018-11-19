#multivariate_boxplots_MetaxylemNumber.R

##Script to Plot number of Metaxylem Vessels of Sorghum Roots of various genotypes under various conditions

##modified script from Dr. Kawa in Dr Brady's lab modified by amguercio (Angelica Guercio) 2018



## load required libraries 
library(ggplot2)


##For 2-week data

setwd("~/Documents/BradyLab/Root_CrossSections_2W_Analyses/")
#Read in the data as a table
twoweekdata <- read.table("2W_ImagesData.csv", sep=",", header=T)
#take a look and check the data is read in correctly
twoweekdata
is(twoweekdata)


W2_metaxylemplot<-ggplot(twoweekdata, mapping=aes(Soil, Number_of_Metaxylem_vessels)) +
                      geom_boxplot(aes(fill=Striga)) +
                      geom_point(position=position_dodge(width=0.75),aes(group=Striga)) +
                      ggtitle("Number of Metaxylem Vessels 2 Weeks after Transfer") +
                      theme_gray() +
                      labs(x = "Soil Type", y= "Number of Metaxylem Vessels", fill = "") +
                      facet_grid(Root_Portion~Genotype, scales="fixed")



jpeg("2W_Metaxylemfigure.jpg")
W2_metaxylemplot
dev.off()




##For 3-week data

setwd("~/Documents/BradyLab/Root_CrossSections_3W_Analyses/")
#Read in the data as a table
threeweekdata <- read.table("3W_ImagesData.csv", sep=",", header=T)
#take a look and check the data is read in correctly
threeweekdata
is(threeweekdata)


W3_metaxylemplot<-ggplot(threeweekdata, mapping=aes(Soil, Number_of_Metaxylem_vessels)) +
  geom_boxplot(aes(fill=Striga)) +
  geom_point(position=position_dodge(width=0.75),aes(group=Striga)) +
  ggtitle("Number of Metaxylem Vessels 3 Weeks after Transfer") +
  theme_gray() +
  labs(x = "Soil Type", y= "Number of Metaxylem Vessels", fill = "") +
  facet_grid(Root_Portion~Genotype, scales="fixed")


jpeg("3W_Metaxylemfigure.jpg")
W3_metaxylemplot
dev.off()


