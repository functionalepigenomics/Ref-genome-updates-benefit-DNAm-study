library(ggplot2) 
library(plyr)
df <-read.table("input",header=T)
# df_sorted <- arrange(df, Cancer, type)
df_cumsum <- ddply(df, "Cancer",
                   transform, 
                   label_ypos=cumsum(value) - 0.5*value)
p <- ggplot(data=df_cumsum, aes(x=Cancer, y=value,fill="white")) +
  geom_bar(stat="identity")+
  geom_text(aes(y=label_ypos, label=value), vjust=1.6, 
            color="white", size=3.5)+
  scale_fill_manual(values=c('#E64B35'))+
  theme_minimal()+ylim(0,1600)+
  labs(y="No. of cancer-associated T2T-unique unambiguous CpGs")+
  theme(axis.line.y=element_line(size = 0.6),
        axis.line.x=element_blank(),
        axis.text.x=element_text(size=12,face="plain",margin = margin(r = 0.1),angle = 30),
        axis.text.y=element_text(size=12,face="plain",margin = margin(r = 0.1)),
        axis.ticks.y=element_line(size = 1),
        #axis.ticks.length = unit(.001, "cm"),
        axis.ticks.x=element_blank(),
        axis.title.x=element_blank(),
        axis.title.y=element_text(size=12,face="plain",margin = margin(r = 0.1)),
        legend.position="none",
        legend.text = element_blank(),
        legend.title = element_blank(),
        panel.background=element_blank(),
        panel.border=element_blank(),
        panel.grid.major=element_blank(),
        panel.grid.minor=element_blank(),
        plot.background=element_blank())+
  geom_hline(yintercept=945, color = "gray",size=1) # 16.72 #ef8a62   17.70 #67a9cf
ggsave(p,width = 10, height = 3.4, dpi = 300, filename = "bar_cancer.pdf")