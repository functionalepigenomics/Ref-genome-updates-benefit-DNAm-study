library("gplots")
#library("heatmap.plus")
library("RColorBrewer")
# zz=gzfile('~/KoborLab/kobor_space/zdong/Monkey/Probes3/Mdata/Disorder/Cancer_figure/heatmap_P/total.log.gz','rt')  
test<-read.table("input.log",row.names=1,header=T,sep="\t")
navalues<-which(is.na(test), arr.ind=TRUE)
test[navalues]<-1

# colnames(test)<-c("AML","BLCA","BRCA","CESC","CHOL","COAD",
#                   "ESCA","GBM","HNSC","JPA","KIRC","KIRP","LIHC","LUAD",
#                   "LUSC","NBL","NPC","OV","PAAD","PRAD","Rb","READ","SBA","STES","THCA","UCEC","WT")
length(test[is.na(test)]) ## 0
#test<-test[1:2497,] ## 4357 for P<0.01 in wilcox.test
#test<-test[,1:16] ##only for MHBmap data

## Imputation
# row_average <- as.numeric(rowMeans(test[,1:10], na.rm=TRUE))
# for (i in 1:length(row.names(test))) {
#   test[i,][is.na(test[i,])] <- 0
# }
# row_average <- as.numeric(rowMeans(test[,11:16], na.rm=TRUE))
# for (i in 1:length(row.names(test))) {
#   test[i,11:16][is.na(test[i,11:16])] <- row_average[i]
# }
# http://www.rapidtables.com/web/color/RGB_Color.htm
#colnames(test)[11:16]<-c("ceu.SRR4453293","ceu.SRR568016","ceu.SRR948847","ceu.SRR948848","ceu.SRR948849","ceu.SRR948855")
condition_colors <- unlist(lapply(colnames(test),function(x){
  if(grepl('fileID',x)) '#CC0066' #pink
  else if(grepl('ceu',x)) '#00994C' #grey
  #else if(grepl('ceu',x)) '#008000'
  #else if(grepl('H.s',x)) '#0000FF'
  # else '#FF0000'
}))
input<-as.matrix(test)
myCol <- colorRampPalette(c("white","red"))(100)
myBreaks <- c(1,2,3,4,5,6)
pdf("test.pdf",width=8, height=6)
heatmap.2(input,na.rm=T,#Colv=NA,
          lhei = c(1,5),key.title=NA,key.ylab=NA,sepwidth=c(0.05,0.05),
          #colCol=c("#CC0066","#00994C"),
          # na.color="white",
          # labRow=NA,#colCol=rainbow(27),
          #labCol=NA,
          trace="none", density.info="none", col=myCol,symbreaks = F,cexRow=0.1,srtCol=45,adjCol = c(1,1),cexCol=1, #margins = c(1,1),
          #Euclidean distance with Ward's linkage
          distfun=function(x) dist(x, method="euclidean"), hclustfun=function(x) hclust(x, method="ward.D2"),
          #1 minus Pearson correlation distance with average linkage
          #distfun=function(x) as.dist(1-cor(t(x))), hclustfun=function(x) hclust(x, method="average"),
          keysize=1.1,key.xlab="Fold enrichment",#ColSideColors=rainbow(27), 
          scale="none")#,hclust=function(x) hclust(x,method="average"),distfun=function(x) as.dist((1-cor(x))/2))
#legend(0.086,0.93,bty = "n",text.width=c(0.00,0.017,0.017,0.017,0.017,0.017,0.017),legend=colnames(test),inset=c(-0.05,-0.1),lty=0,xpd=T,horiz=T,cex=0.66)
#legend("topright",xpd = TRUE,bty = "n",legend = colnames(test),col = rainbow(18), 
#       lty= 1.5,   lwd = 2,           
#       cex=.6)
dev.off()

pdf("test.pdf",width=8, height=6)
heatmap.2(input,col=myCol,colsep=c(1:62),rowsep=(1:62), 
          sepwidth=c(0.05,0.05), sepcolor="white", trace="none",
          Rowv=F,Colv=F, scale="none", dendrogram="none",key=F, 
          lhei = c(0.05,5))#,margins=c(8,8))
dev.off()