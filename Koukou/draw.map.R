#load the county data
load("C:\\Users\\Kou Kou\\Dropbox\\A life with IF49-Cancer Epidemiology\\R learning\\R mapping code\\SD_shp_by_county")
load("C:\\Users\\Kou Kou\\Dropbox\\A life with IF49-Cancer Epidemiology\\R learning\\R mapping code\\provincial_mapdata")
load("C:\\Users\\Kou Kou\\Dropbox\\A life with IF49-Cancer Epidemiology\\R learning\\R mapping code\\prefecture_mapdata")

#read the values for filling the colours
library(xlsx)
values <- read.xlsx("C:\\Users\\Kou Kou\\Dropbox\\A life with IF49-Cancer Epidemiology\\Data sets\\Mortality data\\Esopageal cancer data 1970 & 2010s_for satscan analysis.xlsx",1)
values <- values[-841, ]

index1<-which(values$sex=='both', arr.ind=T)
both.values<-values[index1, ]

index2<-which(both.values$year=='2010s', arr.ind=T)
both.2010s.values<-both.values[index2, ]

adj.rate <- both.2010s.values$adj.rate

id <- as.character(both.2010s.values$XQDM)

filling.data <- data.frame(id,adj.rate)

my.data <- merge(MapDf, filling.data, by='id')

#create colour palette
# myColor <- colorRampPalette(brewer.pal(9,'Blues'))(length(breaks) - 1)

#draw the map
library(ggplot2)
library(RColorBrewer)
# prefect.boundary<-ggplot(prefectDf,aes(long,lat,group=group))+geom_path(colour="black",size=1.05)
# province.boundary<-geom_path(mapping=aes(long,lat,group=group),data=provinceDf ,colour="black",size=1.05)
# 
# prefect.boundary+province.boundary+geom_polygon(aes(long,lat,group=group,fill=adj.rate),data=my.data,alpha=0.95)+scale_fill_gradientn(limits=c(0,60), name='Deaths per 100,000 persons',colours=brewer.pal(8,"Reds"))+theme(axis.line = element_blank(), axis.text.y = element_blank(),axis.ticks.y = element_blank(),axis.title.y = element_blank(),axis.title.x = element_blank(),axis.text.x = element_blank(), axis.ticks.x = element_blank(),panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.border = element_blank(),panel.background = element_blank())+coord_equal()+theme(legend.position = 'bottom')
windows()
prefect.name<-aggregate(prefectDf[,c(1,2)], by=list(prefectDf$id),FUN="mean")

prefect.name[1,2]<-prefect.name[1,2]+15
prefect.name[2,3]<-prefect.name[2,3]+15
prefect.name[5,3]<-prefect.name[5,3]-12
prefect.name[14,3]<-prefect.name[14,3]-20
prefect.name[15,2]<-prefect.name[15,2]+10
ggplot()+geom_polygon(aes(long,lat,group=group,fill=adj.rate),data=my.data,alpha=0.95)+scale_fill_gradientn(limits=c(0,60), name='Deaths per 100,000 persons',colours=brewer.pal(8,"Reds"))+theme(axis.line = element_blank(), axis.text.y = element_blank(),axis.ticks.y = element_blank(),axis.title.y = element_blank(),axis.title.x = element_blank(),axis.text.x = element_blank(), axis.ticks.x = element_blank(),panel.grid.major = element_blank(), panel.grid.minor = element_blank(), panel.border = element_blank(),panel.background = element_blank())+coord_equal()+theme(legend.position = 'bottom')+geom_text(mapping=aes(long,lat+8,label=Group.1),data=prefect.name,colour="black")+geom_path(mapping=aes(long,lat,group=group),data=prefectDf,colour="grey")+geom_path(mapping=aes(long,lat,group=group),data=provinceDf ,colour="black")      