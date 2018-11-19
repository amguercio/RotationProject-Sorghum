##interaction_boxplots.R

##Script to Plot Metaxylem Vessels of Sorghum Roots of various genotypes under various conditions

##Script modified from Dr. Kawa under PI Dr. Brady by amguercio  (Angelica Guercio) 2018


#install.packages("ggplot2")
#install.packages("ggsignif") 
#install.packages("cowplot")
#install.packages("ggpubr")

## load required libraries 
library(ggplot2)


##For 2-week data

setwd("~/Documents/BradyLab/2WeeksFolder/")
#Read in the data as a table
twoweekdata <- read.table("Metaxylem_2W_Data.csv", sep=",", header=T)
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


setwd("~/Documents/BradyLab")

pdf("2Wfigure.pdf", width=7, height=5)
W2_metaxylemplot
dev.off()




##For 3-week data

setwd("~/Documents/BradyLab/3WeeksFolder/")
#Read in the data as a table
threeweekdata <- read.table("Metaxylem_3W_Data.csv", sep=",", header=T)
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


setwd("~/Documents/BradyLab/")

pdf("3Wfigure.pdf", width=7, height=5)
W3_metaxylemplot
dev.off()
