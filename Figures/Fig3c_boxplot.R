require(matrixStats)
grch38_uniq<-read.table("../good_grch38_uniq.txt")
t2t_uniq<-read.table("../good_t2t_uniq.txt")
common<-read.table("../good_common.txt")

array<-read.table("GSE103502_series_matrix.txt",sep="\t",header = T,row.names = 1)
### ==== Array QC chec ==============
library(rtracklayer)
## remove the probes which contain snp in cpg site
snpcpg<-read.table("~/KoborLab/kobor_space/zdong/450kwithSNPCpG.txt",sep="\t",header = T)
rownames(snpcpg)<-snpcpg$TargetID
Methy_annoslect2 <- snpcpg[rownames(array),]
Methy_annoslect2 <- data.frame(array,Methy_annoslect2)
data<-Methy_annoslect2[is.na(Methy_annoslect2$n_SNPCpG),]
data<-data[,1:(length(colnames(data))-2)]

datanew<-data
row_NA <- as.numeric(rowSums(is.na(datanew)))
col_NA <- as.numeric(colSums(is.na(datanew)))
datanew$row_NA_ratio <- row_NA/(length(colnames(datanew))) *100

## Set the cut-off value for each methylation site (now NA portion fewer than 5% are selected) ##56943:10%;56721:5%
datanew_2<-datanew[datanew$row_NA_ratio < 5,]
datanew_2<-datanew_2[1:length(colnames(datanew_2))-1]

## Set the cut-off value for each sample (now NA portion fewer than 1% are selected)
datanew_3 <-rbind(datanew_2,col_NA/length(datanew_2[,1]) *100)
TargetID<-rownames(datanew_3)
datanew_3<-datanew_3[,1:ncol(datanew_3)]
datanew_4<-datanew_3[,datanew_3[length(rownames(datanew_3)),1:(length(colnames(datanew_3)))] < 1]
datanew_4<-data.frame(TargetID,datanew_4)
datanew_5<-datanew_4[1:length(rownames(datanew_4))-1,2:ncol(datanew_4)]
array<-datanew_5
array[] <- lapply(array, as.numeric)
IMR_90<-array[,c(1,3,5,7)]
#### ===== Between duplications =======####
sd1<-rowSds(as.matrix(IMR_90), na.rm=TRUE)
sd2<-sd1

re<-data.frame(sd1,sd2)
rownames(re)<-rownames(IMR_90)
mean(re$sd1[rownames(re) %in% as.character(grch38_uniq$V1)],na.rm=T) # 0.01779519
mean(re$sd1[rownames(re) %in% as.character(t2t_uniq$V1)],na.rm=T) # 0.01682943
mean(re$sd1[rownames(re) %in% as.character(common$V1)],na.rm=T) # 0.01634498
mean(re$sd1[-which(rownames(re) %in% c(as.character(common$V1),as.character(t2t_uniq$V1),as.character(grch38_uniq$V1)))],na.rm=T) # 0.01966279
bad<-re$sd1[-which(rownames(re) %in% c(as.character(common$V1),as.character(t2t_uniq$V1),as.character(grch38_uniq$V1)))]
com<-re$sd1[rownames(re) %in% as.character(common$V1)]
wilcox.test(com,re$sd1[rownames(re) %in% as.character(grch38_uniq$V1)]) # 0.03395
wilcox.test(com,re$sd1[rownames(re) %in% as.character(t2t_uniq$V1)]) #  0.9978
wilcox.test(com,bad) #  < 2.2e-16
# 1000 permutations
n=0
for (i in 1:1000){
  random<-sample(com, size=length(re$sd1[rownames(re) %in% as.character(grch38_uniq$V1)]), replace=F)
  if (mean(random,na.rm=T)>=mean(re$sd1[rownames(re) %in% as.character(grch38_uniq$V1)],na.rm=T)){n=n+1}
}
n/1000 # 0

# 1000 permutations
n=0
for (i in 1:1000){
  random<-sample(com, size=length(re$sd1[rownames(re) %in% as.character(t2t_uniq$V1)]), replace=F)
  if (mean(random,na.rm=T)>=mean(re$sd1[rownames(re) %in% as.character(t2t_uniq$V1)],na.rm=T)){n=n+1}
}
n/1000 # 0.005

# 1000 permutations
n=0
for (i in 1:1000){
  random<-sample(com, size=length(bad), replace=F)
  if (mean(random,na.rm=T)>=mean(bad,na.rm=T)){n=n+1}
}
n/1000 # 0

mean(re$sd2[rownames(re) %in% as.character(grch38_uniq$V1)],na.rm=T) # 0.01852826
mean(re$sd2[rownames(re) %in% as.character(t2t_uniq$V1)],na.rm=T) # 0.01718523
mean(re$sd2[rownames(re) %in% as.character(common$V1)],na.rm=T) # 0.01752695
mean(re$sd2[-which(rownames(re) %in% c(as.character(common$V1),as.character(t2t_uniq$V1),as.character(grch38_uniq$V1)))],na.rm=T) # 0.02083737

bad<-re$sd2[-which(rownames(re) %in% c(as.character(common$V1),as.character(t2t_uniq$V1),as.character(grch38_uniq$V1)))]
com<-re$sd2[rownames(re) %in% as.character(common$V1)]
wilcox.test(com,re$sd2[rownames(re) %in% as.character(grch38_uniq$V1)]) # 0.007873
wilcox.test(com,re$sd2[rownames(re) %in% as.character(t2t_uniq$V1)]) #  0.06206
wilcox.test(com,bad) #  p-value < 2.2e-16
# 1000 permutations
n=0
for (i in 1:1000){
  random<-sample(com, size=length(re$sd2[rownames(re) %in% as.character(grch38_uniq$V1)]), replace=F)
  if (mean(random,na.rm=T)>=mean(re$sd2[rownames(re) %in% as.character(grch38_uniq$V1)],na.rm=T)){n=n+1}
}
n/1000 # 0

# 1000 permutations
n=0
for (i in 1:1000){
  random<-sample(com, size=length(re$sd2[rownames(re) %in% as.character(t2t_uniq$V1)]), replace=F)
  if (mean(random,na.rm=T)<=mean(re$sd2[rownames(re) %in% as.character(t2t_uniq$V1)],na.rm=T)){n=n+1}
}
n/1000 # 0.031

# 1000 permutations
n=0
for (i in 1:1000){
  random<-sample(com, size=length(bad), replace=F)
  if (mean(random,na.rm=T)>=mean(bad,na.rm=T)){n=n+1}
}
n/1000 # 0

### ========= Boxplot ==================
dose1<-cbind(re$sd1[rownames(re) %in% as.character(grch38_uniq$V1)],"GRCh38-unique")
dose2<-cbind(re$sd1[rownames(re) %in% as.character(t2t_uniq$V1)],"T2T-unique")
dose3<-cbind(re$sd1[rownames(re) %in% as.character(common$V1)],"Both")
dose4<-cbind(re$sd1[-which(rownames(re) %in% c(as.character(common$V1),as.character(t2t_uniq$V1),as.character(grch38_uniq$V1)))],"Other")
ToothGrowth<-rbind(dose1,dose2,dose3,dose4)
ToothGrowth<-as.data.frame(ToothGrowth)
names(ToothGrowth)<-c("Methylation variability","dose")
ToothGrowth$`Methylation variability`<-as.numeric(ToothGrowth$`Methylation variability`)
ToothGrowth$dose <- factor(ToothGrowth$dose , levels = c("Both","T2T-unique" ,"GRCh38-unique","Other"))

library(ggplot2)
g<-ggplot(ToothGrowth, aes(x=dose, y=`Methylation variability`, color=dose)) +
  geom_boxplot(outlier.shape = NA)+scale_y_continuous(limits = c(0, 0.05))+
  scale_color_manual(values=c("#999999","#E64B35","#4DBBD5", "#E69F00"))+
  theme_classic()+theme(legend.position="none",axis.title.x=element_blank(),
                        axis.text.x = element_text(angle=30))+
  stat_summary(fun="mean")
ggsave(g,file="arraysamples_450k_good.pdf",width = 4,height = 3)
