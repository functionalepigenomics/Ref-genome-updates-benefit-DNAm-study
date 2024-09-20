setwd("~/KoborLab/kobor_space/zdong/T2T/Sequence-based/Cancer/10X/Lineplot")
library(ggpubr)	
library(RColorBrewer)
library(ggplot2)
theme_set(theme_classic())	
mpg<-read.table("total.log",header=F,sep="\t")	
# # remove STES
# mpg1<-mpg[mpg$V4 != "STES",]
# mpg<-mpg1

colnames(mpg)<-c("ID","Methylation Variance","con","Cancer")	
mpg$`Methylation Variance`<-abs(mpg$`Methylation Variance`)	
yy<-mpg$`Methylation Variance`	
xx<-mpg$Cancer
zz<-mpg$con
mpg<-data.frame(xx,yy,zz)
mpg$zz[mpg$zz == 1]<-'Tumor'
mpg$zz[mpg$zz == 0]<-'Normal'

# Plot	
## chang the order of x-axis	
mpg$xx <- factor(mpg$xx, levels = unique(mpg$xx)[order(as.character(unique(mpg$xx)))])	#levels = rev(unique(mpg$xx)))	
mpg$zz <- factor(mpg$zz, levels = rev(c('Tumor','Normal')))
mpg<-mpg[!is.na(mpg$zz),]
# source('summarySE.R')
#tgc<-summarySE(mpg, measurevar="yy", groupvars=c("zz","xx"))
library(plyr)	
tgc <- ddply(mpg, c("zz","xx"), summarise,	
             # N    = length(yy),	
             mean = mean(yy),	
             # sd   = sd(yy),	
             # se   = sd / sqrt(N),	
             lower=quantile(yy, probs = 0.25),	
             upper=quantile(yy, probs = 0.75),	
             # median=median(yy)
             min=lower-1.5*(upper-lower),
             max=upper+1.5*(upper-lower)
)	
# tgc$M<-c(rep("***",nrow(tgc)*2/3),rep("",nrow(tgc)*1/3))
tgc$M<-c(rep("***",nrow(tgc)))	
pd <- position_dodge(1) # move them .05 to the left and right	
tp1<-rep(as.numeric(rownames(tgc))[1:(nrow(tgc)/2)],2)	
tp<-data.frame(tgc,rank=rank(tp1))	
tp$pos_neg <- ifelse((rank(tp1) %% 2) == 1, 0, 1)	
tp$pos_neg <- factor(tp$pos_neg)	
tgc$min[tgc$min<0]=0
# tgc$max[tgc$max>0.04]=0.04

g<-ggplot(mpg, aes(x=xx, y=yy, fill=zz,group=zz)) +	# ,shape=zz
  geom_rect(data = tp,aes(fill = "white"),color = NA,xmin = -Inf, xmax = Inf,inherit.aes=FALSE,show.legend=FALSE,	
            ymin = -Inf,ymax = Inf,alpha = 0.03)+#scale_fill_manual(values = alpha(c('gray53','white'), 0.2))+
  # geom_linerange(aes(ymin=min, ymax=max),colour="black",  width=1, position=pd) + #colour='black',
  # geom_crossbar(aes(ymin=lower, ymax=upper),colour="black",width=0.5, position=pd) + # colour='black',fill="white",
  # # geom_line(position=pd) +	
  # geom_point(position=pd,size=2, fill='white') + # 21 is filled circle
  geom_boxplot(fatten = 0.8,outlier.shape = NA,position=position_dodge(1.1))+
  stat_summary(fun.y = mean, geom = "point", shape=20, size=0.6, color="black", fill="black",
               position = position_dodge(1.1))+
  # geom_text(data = tp,aes(y=lower,label = tp$M),
  #           position=position_dodge(width = 1),
  #           hjust = -3, size = 3)+
  xlab("") +	
  ylab("Methylation level") +	
  # scale_colour_hue(name="CpG type",    # Legend label, use darker colors	
  #                  breaks=c('MSC-CpG','SC-CpG','NC-CpG'),	
  #                  labels=c('MSC-CpG','SC-CpG','NC-CpG'),	
  #                  l=40) +                    # Use darker colors, lightness=40	
  #ggtitle("The Effect of Vitamin C on\nTooth Growth in Guinea Pigs") +	
  expand_limits(y=0) +                     # Expand y range	
  #scale_y_continuous(breaks=0:0.01*1) +         # Set tick every 4	
  theme_classic() +	
  theme(#legend.justification=c(1,0),	
    legend.position='top',legend.title=element_blank(),	
    legend.text=element_text(size=12),panel.grid.minor.y=element_line(colour = "grey"),	
    axis.title = element_text(size = 12),	
    axis.text = element_text(size = 11))     + # Position legend in bottom right	
  # scale_color_brewer(palette="Dark2")+
  scale_fill_manual(values = c("#009E73","#E69F00","gray53"))+	
  # scale_shape_manual(values = c(15, 17, 16)) +	
  facet_grid(	
    rows = vars(xx),scales = "free", space = "free")+theme(	
      strip.background = element_blank(),strip.text =element_blank()	
      # strip.background = element_rect(color = brewer.pal(n = 8, name = "Dark2")[4],fill = brewer.pal(n = 8, name = "Dark2")[4]),	
      # strip.text = element_text(colour = brewer.pal(n = 8, name = "Dark2")[4], face = "bold")	
    )	+scale_x_discrete(labels=function(a) str_wrap(a,width = 20))+
  # geom_hline(yintercept = 0.4, linetype="dashed",
  #            color = "#A6761D", size=0.6)+
  coord_flip(ylim = c(0, 1))#+
  # geom_hline(yintercept = 0.03, linetype="dashed",
  #            color = "#A6761D", size=0.6)

# write.table(levels(tgc$xx),file="factor_name.log",sep="\t",quote=F,row.names = F,col.names = F)
ggsave(plot = g, width = 4.2, height = 6.2, dpi = 300, filename = "line.pdf")	
