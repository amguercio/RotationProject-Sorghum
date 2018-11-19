#simple_boxplots.R

## Germination Analyses Boxplot

## amguercio (Angelica Guercio) 2018


setwd("~/Documents/BradyLab/")
getwd()

##Installing packages
#install.packages("ggplot2")
install.packages("forcats")

##Loading packages
library(ggplot2)
library(ggsignif)
library(forcats)
library(ggpubr)


germdata <- read.table("Sorghum_Germination_Scoring_R_Plotting_Data.csv", sep=",", header=T)

germdata$Genotype <- as.character(germdata$Genotype)


rootlenplot<-ggplot(germdata, aes(x = fct_reorder(germdata$Genotype, germdata$Root_Length, fun = median, .desc =FALSE), y = germdata$Root_Length)) + 
  geom_boxplot(aes(fill = fct_reorder(germdata$Genotype, germdata$Root_Length, fun = median, .desc =FALSE))) + 
  theme_bw(base_size = 14) +
  theme(legend.position = "none", axis.text.x=element_text(angle = 50, size = 7)) +
  xlab("Genotype") +
  ylab("Root Length (cm)") +
  ggtitle("Root Length at 5 Days by Genotype")


jpeg("Germination_rootlength.jpg")
plot(rootlenplot)
dev.off()

#rootlenplot + stat_compare_means(method="anova")

#my_comparisons <- list( c("0.5", "1"), c("1", "2"), c("0.5", "2") )
#ggboxplot(ToothGrowth, x = "dose", y = "len",
#          color = "dose", palette = "jco")+ 
#  stat_compare_means(comparisons = my_comparisons)+ # Add pairwise comparisons p-value
#  stat_compare_means(label.y = 50)

rootangleplot<-ggplot(germdata, aes(x = fct_reorder(germdata$Genotype, germdata$Root_Angle, fun = median, .desc =FALSE), y = germdata$Root_Angle)) + 
  geom_boxplot(aes(fill = fct_reorder(germdata$Genotype, germdata$Root_Angle, fun = median, .desc =FALSE))) + 
  theme_bw(base_size = 14) +
  theme(legend.position = "none", axis.text.x=element_text(angle = 50, size = 7)) +
  xlab("Genotype") +
  ylab("Root Angle (degrees from 180)") +
  ggtitle("Root Angle at 5 Days by Genotype")


jpeg("Germination_rootangle.jpg")
plot(rootangleplot)
dev.off()




#seed germination

germ <- read.table("Sorghum_Germination_Scoring.csv", sep=",", header=T)

germ$Genotype<-as.character(germ$Genotype)

germ<-read.table("Jiregna_Germ.csv", sep=",", header=T)

seedgerm<-ggplot(germ, aes(x = germ$Genotype, y = germ$Percentage_Germinated, fill=germ$Genotype)) + 
  geom_bar(stat="identity") +
  xlab("Genotype") +
  ylab("Percentage Germination") +
  theme_bw(base_size = 14) +
  ylim(0,100) +
  theme(legend.position = "none", axis.text.x=element_text(angle = 50, size = 7)) +
  ggtitle("Seedling Germination Percentage by Genotype")

jpeg("Germinationplot.jpg")
plot(seedgerm)
dev.off()

jpeg("Jiregna_Germinationplot.jpg")
plot(seedgerm)
dev.off()



contamination<-ggplot(germ, aes(x = germ$Genotype, y = germ$Percentage_Contaminated, fill=germ$Genotype)) + 
  geom_bar(stat="identity") +
  theme_bw(base_size = 14) +
  theme(legend.position = "none", axis.text.x=element_text(angle = 50, size = 7)) +
  xlab("Genotype") +
  ylab("Percentage of Seed Contaminated") +
  ylim(0,100) +
  ggtitle("Seedling Contamination Percentage by Genotype")

jpeg("Germination_Contamination.jpg")
plot(contamination)
dev.off()


