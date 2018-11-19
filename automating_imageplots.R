##automating_imageplots.R

##Script for automating putting images into a table

##amiriamguercio  (Angelica Guercio) 2018

##A function to plot your images, given a prefixes for the filenames you wish to plot
##default plots all files with the same prefix as one row (in order within that row left to right), you can change the row/col layout
##output is a pdf file named prefix.pdf of this plot with a left label of "prefix"
##the end of the script provides a way to plot multiple prefix plots into one larger table-like figure
##default input is .tiff format files but .jpeg and others can be used as well with minor modifications



##### Installing/Loading Required Libraries #####
if (!require("pacman")) install.packages("pacman")
#pacman is a package manager, this will load (or install) it 
pacman::p_load(ggplot2, gridExtra, grid, cowplot, magick, tiff, jpeg, stringr, pdftools)
#this will load (or install if necessary) all of these packages


######  User Inputs ######

#Define the path of where your images are located
path = "~/Documents/Images"
#fill the quotes in with the path to your images

##Define the prefixes of the filenames of the images you would like to plot.
#No need to put the entire file name, just the prefix, all images with this prefix will be plotted (regex will search for prefix*)
#Outfiles will be named prefix.pdf and be located in the image folder
prefixlist<-c("SQR_2N_CTR", "SQR_2N_Striga", "SQR_2S_CTR", "SQR_2S_Striga", "SRN39_2N_CTR", "SRN39_2N_Striga", "SRN39_2S_CTR", "SRN39_2S_Striga")
#make your list and save it as prefixlist (enter all prefixes in quote separated by commas)

##### OPTIONAL  #####
##If you want to utilize the final functionality of the script under ######  Getting these plots into a larger table plot  #####
##Here there are indicators of 
######     vvvvvUSER NEEDS TO EDITvvvvvv     #####

#allmyimages<-c(allmyimages[[1]], allmyimages[[2]], allmyimages[[3]], allmyimages[[4]], allmyimages[[5]], allmyimages[[6]], allmyimages[[7]], allmyimages[[8]])

######     ^^^^^USER NEEDS TO EDIT^^^^^     #####

#this allmyimages definition depends on the length of your prefixlist, which you can find with 
length(prefixlist)
#if length(prefixlist) is i:
#You will need to edit this **IN THE SCRIPT** such that you are calling on allmyimages<-c(allmyimages[[1]], ...., allmyimages[[i]])



###### Defining the Function plotmyimages  ###### 

#define the function 'plotmyimages'
#the only input is a prefix of a filename to search for and plot
plotmyimages<-function(prefix){
  #let's make sure the prefix you give the function is read in as characters
  name<-as.character(prefix)
  #let's define a variable called 'searchpattern' that looks with regex for prefix*
  searchpattern<- paste0(prefix, "*", sep="")
  #now let's use the searchpattern to search our path for files with the searchpattern
  prefixmatches<-dir(path, pattern = searchpattern)
  #we want to exclude any file containing'.pdf'
  #you can copy this line below to exclude more patterns from your prefixmatches list
  prefixmatches<-prefixmatches[!str_detect(prefixmatches, pattern="pdf")]
  #below is a small nested function to take each prefix match and read and draw the image 
  #into a list called imagelist
  imagelist<-lapply(prefixmatches, function(file) {
    image<-readTIFF(file, native=TRUE)
    #if your image is a jpeg file you can use <<image<-readJPEG(file)>> instead
    drawimage<-(ggdraw() + draw_image(image, scale = 0.9))
  }
  )
  #with our list of images we want to combine them in a plot 
  #the name of the final plot will be exported as a .pdf file using the 
  #original prefix name specified
  pdfname<-paste0(name, ".pdf", sep="")
  pdf(pdfname, width=30,height=3)
  #now that we've opened a .pdf file we need to print the imagelist into it
  #grid.arrange allows us to choose the rows columns and title placement
  print(do.call(grid.arrange, c(imagelist, nrow=1, ncol=8, left=name)))
  #in this print line above you can change the location of the title (currently its left)
  #you can also change the nrow and ncol
  dev.off()
}
#end of plotmyimages function! 



##### Running plotmyimages Function ######

#Before running the function we should make sure our working directory is the path we defined as where the images are contained
setwd(path)
#let's set our wd to this path 


##Now let's run the plotmyimages function over all prefixes in the prefix list you have given 
for (prefix in prefixlist){
  #this is a loop, that applies the plotmyimages function over each prefix in your provided prefixlist
  plotmyimages(prefix)
}

#Now you have a plot for each prefix in prefix list in your image folder





######  Getting these plots into a larger table plot  #####

######  OPTIONAL  + REQUIRES USER INPUT ######


##Each prefix in this list has saved as an individual file
##If you want to arrange these into one table-like pdf file:

allmyimages<-sapply(prefixlist, function(prefix) {
  #let's make a list of each plot we just made so we can combine them
  filename<-paste0(prefix, ".pdf", sep="")
  #first we have to locate each prefix.pdf file
  new<-image_read_pdf(filename)
  #then we can read in the file
  image_append(image_scale(new, "x1500"), stack=TRUE)
  #and then we can add each of these pdf plots to our list called allmyimages
}
)



##for some reason sapply will only save this as a list of lists
##magick won't work with these objects so we have to force it to a normal list
##to do this make sure you get

#once you have the length just force allmyimages to be a literal list 
#to do call on each element of the list 1-i of length i 


######     vvvvvUSER NEEDS TO EDITvvvvvv     #####

allmyimages<-c(allmyimages[[1]], allmyimages[[2]], allmyimages[[3]], allmyimages[[4]], allmyimages[[5]], allmyimages[[6]], allmyimages[[7]], allmyimages[[8]])

######     ^^^^^USER NEEDS TO EDIT^^^^^     #####



#You can take a look--now it's a list so R studio viewer will plot one image after another
allmyimages
#let's make it look like a real table

final_plot<-image_append(image_scale(allmyimages), stack=TRUE)
#if you want the images side by side, stack = F, if you want them vertically stacked stack = T

#You can take a look at the finished product
plot(final_plot)


#great! now let's save it to a pdf (or your file of choice)

pdf("finalplot.pdf")
plot(final_plot)
dev.off()
