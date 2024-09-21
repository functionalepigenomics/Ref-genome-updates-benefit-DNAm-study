datanew_5<-read.table("datanew_5.txt.gz",row.names = 1,sep="\t")

readme<-read.csv("README.txt.gz",sep="\t",header=T,row.names = 1)
case<-datanew_5[which(names(datanew_5) %in% as.character(readme$geo_accession[readme$group.ch1 == "tumor"]))]
control<-datanew_5[which(names(datanew_5) %in% as.character(readme$geo_accession[readme$group.ch1 == "normal"]))]

control[control>=1]<-0.9999
control[control<=0]<-0.0001
case[case>=1]<-0.9999
case[case<=0]<-0.0001
datanew_5<-data.frame(case,control)
test<-datanew_5
## Calcualte the methylation difference
case1<-c(1,1);control1<-c(1,1); pvalues<-c(1,1);
diff1<-c(1,1);
for (i in 1:length(rownames(test))) {
  case1[i]<-mean(as.numeric(case[i,1:(length(colnames(case)))][!is.na(case[i,1:(length(colnames(case)))])]));
  control1[i]<-mean(as.numeric(control[i,1:(length(colnames(control)))][!is.na(control[i,1:(length(colnames(control)))])]));
  diff1[i]<-(case1[i]-control1[i])
  n0<-as.numeric(case[i,])
  n0<-log2(n0/(1-n0))
  n1<-as.numeric(control[i,])
  n1<-log2(n1/(1-n1))
  pvalues[i]<-wilcox.test(n0,n1,na.rm=TRUE)$p.value
}

var1<-data.frame(rownames(datanew_5),diff1,pvalues)
colnames(var1)<-c("TargetID","diff1","pvalues")
## Save those data
write.table(var1,file="Result/var1.txt",sep="\t",row.names =F,quote=F)