setwd("~/KoborLab/kobor_space/zdong/T2T/Sequence-based/Cancer/10X/Genomic_features")
## After get all the values then generate the plot
require(ggpubr)
require(stringr)
dfm<-read.csv("enrichment_GWASdb.csv",header=T,sep='\t')
dfm$mpg=log2(dfm$mpg)
dfm$group <- factor(dfm$group, levels = c(1,0))
dfm$name <- factor(dfm$name, levels =sort(dfm$name))
p<-ggdotchart(dfm, x = "name", y = "mpg",
              shape ="group",color = "#E64B35",
              dot.size = 4,
              #palette = "Set1",
              rotate = TRUE,ylab="Log2(Fold enrichment)",
              sorting = "descending",
              ggtheme = theme_bw()
)+
  # geom_point(aes(shape=factor(group)))+
  scale_shape_manual(values=c(19,1) , guide = "none")+
  theme(legend.position = "top",axis.title.x = element_text(size=12),
        axis.title.y=element_blank(),axis.text = element_text(size=12),
        legend.title =element_blank(),legend.text = element_text(size=12)
  )+
  #scale_y_continuous(breaks = sort(c(seq(0, 20,length.out=5), 1)))+
  scale_x_discrete(labels=function(dfm) str_wrap(dfm,width = 39))+
  scale_colour_manual(values=c("#E64B35"))
ggsave("Enrichmen_colon-cancer.pdf",p, width=2.8, height=2.4)