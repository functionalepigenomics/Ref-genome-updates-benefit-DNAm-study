pan<-read.table("probes_pan_450k.txt")
paneur<-read.table("EUR/probes_EUR_450k.txt")
t2t<-read.table("../T2T/Result/probes_human.txt")

length(pan$V1[pan$V1 %in% t2t$V1]) # 399967
length(pan$V1[-which(pan$V1 %in% t2t$V1)]) # 5858
length(t2t$V1[-which(t2t$V1 %in% pan$V1)]) # 30752
length(pan$V1[pan$V1 %in% t2t$V1])/length(t2t$V1) # 0.9286031
length(pan$V1[pan$V1 %in% t2t$V1])/length(pan$V1) # 0.9855652

length(paneur$V1[paneur$V1 %in% t2t$V1]) # 403323
length(paneur$V1[-which(paneur$V1 %in% t2t$V1)]) # 7756
length(t2t$V1[-which(t2t$V1 %in% paneur$V1)]) # 27396

# load Venn diagram package
library("VennDiagram")

# create pairwise Venn diagram
g<-draw.pairwise.venn(area1=length(t2t$V1), area2=length(pan$V1),cross.area=length(pan$V1[pan$V1 %in% t2t$V1]),
                      category=c("T2T","Pangenome"),fill=c("#4DBBD5B2","#E64B35B2"),
                      #cat.col = c("black", "black"),
                      #cat.cex = 1.5,
                      # cat.fontfamily = "sansserif",
                      euler.d = T, scaled = F,
                      cat.fontface = "bold",
                      cat.dist = c(0.08, 0.08) # Modified
)
## [1] "#E64B35B2" "#4DBBD5B2" "#00A087B2" "#3C5488B2" "#F39B7FB2" "#8491B4B2"
## [7] "#91D1C2B2" "#DC0000B2" "#7E6148B2"
ggsave(g,file="venn_450k_pan.pdf",width = 4,height = 3)

a<-read.table("overlapped.log")
a<-a[order(a$V1,decreasing = T),]
# V1     V2
# 37  22    CBS
# 97  16 LILRA1
# 91  13  KMT5A
# 187 13   TCN2
# 149 12 RCBTB2
# 206 11  U2AF1
