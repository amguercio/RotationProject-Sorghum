#plotting_onmaps.R

##modified script from Chris Fiscus in Dr Koenig's lab modified by amguercio (Angelica Guercio) 2018


setwd("~/Downloads/")
locs<-read.delim("Sorghum_Geographic_Data.csv", sep=",", header=T)

need<-c("ggmap") # required packages
ins<-installed.packages()[,1] #find out which packages are installed
(Get<-need[which(is.na(match(need,ins)))]) # check if installed 
if(length(Get)>0){install.packages(Get)} #install if not installed previously
eval(parse(text=paste("library(",need,")")))#load the required packages

myMap<-get_map(location=c(-20,-25,120, 50), source="stamen", maptype="watercolor", zoom=3)

p<- ggmap(myMap) + geom_point(aes(x = locs$Long, y = locs$Lat), data=locs,
                              alpha = .7, color="black", size = 2)
p + labs(x = 'Longitude', y = 'Latitude') + ggtitle('Sorghum Accession Locations')
