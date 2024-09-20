# load Venn diagram package
library("VennDiagram")

# create pairwise Venn diagram
g<-draw.pairwise.venn(area1=1245858, area2=1165567,cross.area=1143869,
                      category=c("GRCh38","T2T"),fill=c("#4DBBD5B2","#E64B35B2"),
                      #cat.col = c("black", "black"),
                      #cat.cex = 1.5,
                      # cat.fontfamily = "sansserif",
                      euler.d = T, scaled = F,
                      cat.fontface = "bold",
                      cat.dist = c(0.08, 0.08) # Modified
)
## [1] "#E64B35B2" "#4DBBD5B2" "#00A087B2" "#3C5488B2" "#F39B7FB2" "#8491B4B2"
## [7] "#91D1C2B2" "#DC0000B2" "#7E6148B2"
ggsave(g,file="venn_rrbs.pdf",width = 4,height = 3)
