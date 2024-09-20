# load Venn diagram package
library("VennDiagram")

# create pairwise Venn diagram
g<-draw.pairwise.venn(area1=423841+10792, area2=423841+6878,cross.area=423841,
                      category=c("GRCh38","T2T"),fill=c("#4DBBD5B2","#E64B35B2"),
                      #cat.col = c("black", "black"),
                      #cat.cex = 1.5,
                      # cat.fontfamily = "sansserif",
                      euler.d = T, scaled = F,
                      cat.fontface = "bold",
                      cat.dist = c(0.08, 0.08) # Modified
)
ggsave(g,file="venn_450k_good.pdf",width = 4,height = 3)

