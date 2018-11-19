#another_imageplotter.R

##Script for automating putting images into a table

##amguercio  (Angelica Guercio) 2018



#Libraries to install/load
library(ggplot2)
library(gridExtra)
library(grid)
library(cowplot)
library(magick)
library(pdftools)
library(jpeg)
library(stringr)
library(pdftools)


##A function to plot your images, given a prefix for the filenames you wish to plot
##default plots these as one row (in order within that row left to right)
##output is a pdf file with the name prefix.pdf and the left label of the prefix
##default input is .jpeg format files

plotmyimages<-function(prefix){
  name<-as.character(prefix)
  searchpattern<- paste0(prefix, "*", sep="")
  prefix<-dir(path, pattern = searchpattern)
  prefix<-prefix[!str_detect(prefix, pattern="pdf")]
  imagelist<-lapply(prefix, function(file) {
    image<-readJPEG(file)
    drawimage<-(ggdraw() + draw_image(image, scale = 0.9))
  }
  )
  pdfname<-paste0(name, ".pdf", sep="")
  pdf(pdfname, width=16,height=3)
  print(do.call(grid.arrange, c(imagelist, nrow=1, ncol=4, left=name)))
  dev.off()
}



##First set your path to the directory where your images are held, this can be a master folder
##  we will use regular expressions to direct to the specific images we want in the table

##For Germination Plates from 09.17.18
path = "~/Documents/BradyLab/Germination_Assays/SorghumPlates_9.17.18/"
setwd(path)

##For Germination Plates from 09.18.18
path = "~/Documents/BradyLab/Germination_Assays/SorghumPlates_9.18.18/"
setwd(path)


##When calling the function, you need to give it the prefix you wish to look for to plot these images
##To make it easy, you can make a list of these prefixes--each will save as an individual file
prefixlist<-c("SQR_RT_St", "SQR_30_St", "SQR_30_Nst")
              
##Now let's run the plotmyimages function over all prefixes in our prefix list
for (prefix in prefixlist){
  plotmyimages(prefix)
}


##Each prefix in this list has saved as an individual file
##If you want to arrange these into one table-like pdf file:


allmyimages<-sapply(prefixlist, function(prefix) {
  filename<-paste0(prefix, ".pdf", sep="")
  new<-image_read_pdf(filename)
  newer<-image_rotate(new, 90)
  image_append(image_scale(newer, "x1500"), stack=TRUE)
}
)


##for some reason sapply will only save this as a list of lists
##magick won't work with these objects so we have to force it to a normal list
##to do this make sure you get
length(prefixlist)
##and then do this below for the full length
allmyimages<-c(allmyimages[[1]], allmyimages[[2]], allmyimages[[3]])
allmyimages

final_plot<-image_append(image_scale(allmyimages))
plot(final_plot)

##For Germination Plates from 09.17.18
germ_9.17.18<-final_plot
germ_9.17.18
pdf("Germination_9.17.18.pdf")
plot(germ_9.17.18)
dev.off()

##For Germination Plates from 09.18.18
germ_9.18.18<-final_plot
germ_9.18.18
pdf("Germination_9.18.18.pdf")
plot(germ_9.18.18)
dev.off()

germ_9.17<-(ggdraw() + draw_image(germ_9.17.18, scale = 0.9))
germ_9.18<-(ggdraw() + draw_image(germ_9.18.18, scale = 0.9))

germination_plot<-plot_grid(germ_9.17, germ_9.18, labels=c("09.17.18", "09.18.18"), label_size = 10)

setwd("~/Documents/BradyLab/Germination_Assays/")
pdf("Germination_Plot.pdf")
germination_plot
dev.off()

