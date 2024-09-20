dat <- read.table("data",header=T,sep="\t")
library(reshape2)
library(ggplot2)
library(scales)
g <- ggplot(dat,aes(experiment,value,fill=variable))+geom_bar(stat="identity", width=0.7,position = position_dodge())+
  #facet_wrap(~method,nrow=1, scales = "free")+
  theme_classic()+labs(fill = "Ref genome")+
  scale_fill_manual(values = c("#fce7e4","#E64B35B2"))+ylab("Proportion of cancer drive genes")+
  theme(legend.position="none",axis.title.x=element_blank())
#+ scale_y_continuous(breaks = function(x) unique(floor(pretty(seq(0, (max(x) + 1) * 1.1)))))
ggsave(g,file="bar_cancer-driver.pdf",width = 3.2,height = 2.6)