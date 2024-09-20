dat <- read.table("data",header=T)
library(reshape2)
library(ggplot2)
library(scales)
g <- ggplot(dat,aes(experiment,value,fill=variable))+geom_bar(stat="identity", width=0.7,position = position_dodge())+
  #facet_wrap(~method,nrow=1, scales = "free")+
  theme_classic()+labs(fill = "Ref genome")+
  scale_fill_manual(values = c("#4DBBD5B2","#E64B35B2"))+ylab("CpG sites (million)")+
  xlab("Biosample")
#+ scale_y_continuous(breaks = function(x) unique(floor(pretty(seq(0, (max(x) + 1) * 1.1)))))
ggsave(g,file="short_CpGs_RRBS.pdf",width = 4,height = 3)