data<-read.table("~/KoborLab/kobor_space/zdong/Child-cancer/Childhood/AML/Result/var1.txt.gz",header=T)
crosst2t<-read.table("../../450K/T2T/Result/probes_human.txt")
crosshg38<-read.table("../../450K/GRCh38/Result/Withoutalter/probes_human.txt")

t2t<-data[data$TargetID %in% crosst2t$V1,]
hg38<-data[data$TargetID %in% crosshg38$V1,]

t2t$fdr<-p.adjust(t2t$pvalues,method="fdr")
t2t<-t2t[abs(t2t$diff1) > 0.1 & t2t$fdr<0.05,] 
nrow(t2t) # 36955

hg38$fdr<-p.adjust(hg38$pvalues,method="fdr")
hg38<-hg38[abs(hg38$diff1) > 0.1 & hg38$fdr<0.05,] 
nrow(hg38) # 37089

overlap<-intersect(t2t$TargetID,hg38$TargetID)
length(overlap) # 36354
write.table(overlap,"overlap.txt",sep="\t",quote=F,row.names = F)

t2t_uniq<-t2t[-which(t2t$TargetID %in% overlap),]
nrow(t2t_uniq) # 601

nrow(t2t_uniq)/nrow(t2t) # 0.01626302
write.table(t2t_uniq,"t2t_unique.txt",sep="\t",quote=F,row.names = F)

nrow(t2t_uniq[t2t_uniq$TargetID %in% crosshg38$V1,]) # 0

nrow(t2t_uniq)/length(crosst2t$V1[-which(crosst2t$V1 %in% intersect(crosst2t$V1,crosshg38$V1))])
# 0.08738005
nrow(t2t)/nrow(data[data$TargetID %in% crosst2t$V1,])
# 0.0981134
a<-c(nrow(t2t_uniq),
     length(crosst2t$V1[-which(crosst2t$V1 %in% intersect(crosst2t$V1,crosshg38$V1))]),
     nrow(t2t),
     nrow(data[data$TargetID %in% crosst2t$V1,])
)
dim(a)<-c(2,2)
fisher.test(a) # 0.890593 0.006476

nrow(t2t_uniq[t2t_uniq$diff1<0,])/length(crosst2t$V1[-which(crosst2t$V1 %in% intersect(crosst2t$V1,crosshg38$V1))])
# 0.04041873
nrow(t2t[t2t$diff1<0,])/nrow(data[data$TargetID %in% crosst2t$V1,])
# 0.03940466
a<-c(nrow(t2t_uniq[t2t_uniq$diff1<0,]),
     length(crosst2t$V1[-which(crosst2t$V1 %in% intersect(crosst2t$V1,crosshg38$V1))]),
     nrow(t2t[t2t$diff1<0,]),
     nrow(data[data$TargetID %in% crosst2t$V1,])
)
dim(a)<-c(2,2)
fisher.test(a) #  1.025741  0.6621

nrow(t2t_uniq[t2t_uniq$diff1>0,])/length(crosst2t$V1[-which(crosst2t$V1 %in% intersect(crosst2t$V1,crosshg38$V1))])
# 0.04696133
nrow(t2t[t2t$diff1>0,])/nrow(data[data$TargetID %in% crosst2t$V1,])
# 0.05870874
a<-c(nrow(t2t_uniq[t2t_uniq$diff1>0,]),
     length(crosst2t$V1[-which(crosst2t$V1 %in% intersect(crosst2t$V1,crosshg38$V1))]),
     nrow(t2t[t2t$diff1>0,]),
     nrow(data[data$TargetID %in% crosst2t$V1,])
)
dim(a)<-c(2,2)
fisher.test(a) #  0.7998957  6.78e-05