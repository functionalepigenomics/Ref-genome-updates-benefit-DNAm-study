library(tidyr)
library(ggplot2)
require(RColorBrewer)
df<-read.table("input",sep="\t",header=T)

df$Group <- factor(df$Group, levels = c("Other","SD unique","Both SD & RepeatMasker","RepeatMasker unique"))
g <- ggplot(df, aes(x = Sample, y = Value)) +
  geom_bar(aes(fill=Group),stat="identity") +
  facet_grid(. ~ Method,scales = "free_x")+scale_fill_manual(values = brewer.pal(4, "Pastel2") )+
  theme_classic()+ylab("Proportion")+labs(fill = "Genomic feature")+xlab("Biosample")
ggsave(g,file="Proportion.pdf",width = 11,height = 3)
