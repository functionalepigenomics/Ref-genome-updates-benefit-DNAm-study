# Pie Chart with Percentages
slices <- c(6878-4263, 4263)
lbls <- c("Both","DMCs")
pct <- round(slices/sum(slices)*100)
lbls <- paste(lbls, pct) # add percents to labels
lbls <- paste(lbls,"%",sep="") # ad % to labels
pdf("pie_cancer_t2t.pdf",width = 4.4,height = 4.4)
g<-pie(slices,labels = lbls, col=c("grey","#E64B35"))
dev.off()