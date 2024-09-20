a<-read.table("imr90_common_arrayvswgbs.txt")
a$type<-"Both"
b<-read.table("imr90_grch38_uniq_arrayvswgbs.txt")
b$type<-"GRCh38-unique"
c<-read.table("imr90_t2t_uniq_arrayvswgbs.txt")
c$type<-"T2T-unique"
d<-read.table("imr90_other_arrayvswgbs.txt")
d$type<-"Other"
data<-rbind(a,b,c,d)
names(data)[1:2]<-c("HM450K","WGBS")
data$type <- factor(data$type , levels =c("Both","T2T-unique" ,"GRCh38-unique","Other"))

data$change<-abs(data$HM450K-data$WGBS)

mean(data$change[data$type=="Both"]) # 0.1065734
mean(data$change[data$type=="GRCh38-unique"]) # 0.1103988
mean(data$change[data$type=="T2T-unique"]) # 0.1073786
mean(data$change[data$type=="Other"]) # 0.1687751
wilcox.test(data$change[data$type=="Both"],data$change[data$type=="GRCh38-unique"]) # 0.3352
wilcox.test(data$change[data$type=="Both"],data$change[data$type=="T2T-unique"]) # 0.6544
wilcox.test(data$change[data$type=="Both"],data$change[data$type=="Other"]) # < 2.2e-16

# 1000 permutations
n=0
for (i in 1:1000){
  random<-sample(data$change[data$type=="Both"], size=length(data$change[data$type=="GRCh38-unique"]), replace=F)
  if (mean(random,na.rm=T)>=mean(data$change[data$type=="GRCh38-unique"],na.rm=T)){n=n+1}
}
n/1000 # 0.112

# 1000 permutations
n=0
for (i in 1:1000){
  random<-sample(data$change[data$type=="Both"], size=length(data$change[data$type=="T2T-unique"]), replace=F)
  if (mean(random,na.rm=T)>=mean(data$change[data$type=="T2T-unique"],na.rm=T)){n=n+1}
}
n/1000 # 0.407

# 1000 permutations
n=0
for (i in 1:1000){
  random<-sample(data$change[data$type=="Both"], size=length(data$change[data$type=="Other"]), replace=F)
  if (mean(random,na.rm=T)>=mean(data$change[data$type=="Other"],na.rm=T)){n=n+1}
}
n/1000 # 0

library(ggplot2)
g<-ggplot(data, aes(x=type, y=change, color=type)) +
  geom_boxplot(outlier.shape = NA)+scale_y_continuous(limits = c(0, 0.5))+
  scale_color_manual(values=c("#999999","#E64B35","#4DBBD5", "#E69F00"))+
  theme_classic()+theme(legend.position="none",axis.title.x=element_blank(),
                        axis.text.x = element_text(angle=30))+
  stat_summary(fun="mean")+ylab("Methylation change (WGBS-HM450K)")
ggsave(g,file="arrayvsWGBS_HM450K_good_imr90.pdf",width = 4,height = 3)
