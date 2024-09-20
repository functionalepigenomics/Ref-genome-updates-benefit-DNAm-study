library(ggprism)

df<-read.table("all.log")
names(df)<-c("diff1","con","cancer")
df$diff1[df$diff1>=1]<-0.9999
df$diff1[df$diff1<=0]<-0.0001
require(ggplot2)
df$con[df$con==1]<-"Tumor"
df$con[df$con==0]<-"Normal"
df$con <- factor(df$con, levels = c('Tumor','Normal'))

p<-ggplot(data = df, aes(x=cancer, y=diff1,fill=con)) + 
  geom_boxplot(fatten = 2,outlier.shape = NA) +
  stat_summary(fun.y = mean, geom = "point", shape=20, size=3, color="black", 
               position = position_dodge(0.75))+
  theme_classic()+
  theme(axis.title.x = element_blank(),axis.text.y = element_text(size = 12),
        axis.title.y=element_text(size=12,face="plain",margin = margin(r = 0.1)),
        legend.text = element_text(size=12,face="plain",margin = margin(r = 0.1)),
        axis.text.x = element_text(size = 12),
        legend.position = "top",
        axis.line.y=element_line(size = 0.6),
        axis.ticks.y=element_line(size = 1),
        #axis.ticks.length = unit(.001, "cm"),
        axis.ticks.x=element_blank(),
        axis.line.x=element_blank())+
  scale_fill_manual(values=c("#E69F00","#009E73"))+
  labs(y="Methylation level")+scale_color_discrete(name="")+
  coord_cartesian(ylim = c(0, 1))

ggsave(p,file="Cancer_cpg.pdf",width = 13.2, height = 3, dpi = 300)

