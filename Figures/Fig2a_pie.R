# Pie Chart with Percentages
slices <- c(517-88, 88)
lbls <- c("Both","T2T-unique")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels
lbls <- paste(lbls,"%",sep="") # ad % to labels
pdf("pie_colon_new.pdf",width = 5,height = 5)
g<-pie(slices,labels = lbls, col=c("grey","#E64B35"))
dev.off()