library(rworldmap)
library(RColorBrewer)
# par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
# mapBubbles(dF=getMap() 
#            ,nameZSize="POP_EST" 
#            ,nameZColour="continent" 
#            ,colourPalette='rainbow' 
#            ,oceanCol='lightblue'
#            ,landCol='wheat' )
a<-read.csv("input",sep="\t",header = T)
a$set<-10
pdf(file = "worldmap.pdf",width = 4,height = 2.4)
par(mai=c(0,0,0.2,0),xaxs="i",yaxs="i")
mapBubbles(dF=a
           ,nameX = "LON"
           ,nameY = "LAT"
           ,nameZSize="set"
           ,mapRegion="NAME"
           ,nameZColour="continent"
           ,borderCol="dark grey"
           ,landCol="dark grey"
           ,mapTitle='Population'
           ,colourPalette=c(brewer.pal(n = 5, name = "Set1"))#"palette"
           ,symbolSize = 0.3
           ,addLegend=F
           ,addColourLegend=F) 
dev.off()