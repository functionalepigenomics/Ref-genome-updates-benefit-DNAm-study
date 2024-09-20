dat <- read.table("data",header=T)
dat$value<-dat$value/1000000
dat$variable<-factor(dat$variable, levels=c("T2T-CHM13","Pangenome"))
dat$method<-factor(dat$method, levels=c("EUR","EAS"))

library(reshape2)
library(ggplot2)
library(scales)
g <- ggplot(dat,aes(experiment,value,fill=variable))+geom_bar(stat="identity",position = position_dodge())+
  facet_grid(~method, scales='free_x', space='free_x') +
  # facet_wrap(~method,nrow=1, scales = "free_x")+
  theme_classic()+
  labs(fill = "Ref genome")+
  scale_fill_manual(values = rev(c("#548235","#E64B35B2")))+ylab("CpG sites (million)")+
  xlab("Biosample")+ scale_y_continuous(breaks = function(x) unique(floor(pretty(seq(0, (max(x) + 1) * 1.1)))))
ggsave(g,file="pangenome_CpGs.pdf",width = 9,height = 3)