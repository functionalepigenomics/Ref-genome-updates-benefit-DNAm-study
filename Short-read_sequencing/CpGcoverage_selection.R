setwd("~/KoborLab/kobor_space/zdong/T2T/Sequence-based/Cancer")
### ======= DMR =================
suppressPackageStartupMessages(library(bsseq))
cov_files_16 <- list.files(path = ".",
                           pattern = glob2rx("*CpG_report.merged_CpG_evidence.cov.gz"),full.names = TRUE)
bsseq_16 <- read.bismark(files = cov_files_16,
                         #sampleNames = gsub(".CpG_report.merged_CpG_evidence.cov.uncovered.txt.filtered.cov", "", cov_files_16),
                         rmZeroCov = TRUE,
                         strandCollapse = FALSE)
bsseq_16[[1]] <- c("cancer","normal","cancer","normal","cancer","normal","cancer","normal","normal","cancer",
                   "normal","cancer","cancer","normal","cancer","normal","cancer","normal","cancer","normal")
bsseq_16[[2]] <- c("pair1","pair1","pair2","pair2","pair3","pair3","pair4","pair4","pair5","pair5",
                   "pair6","pair6","pair7","pair7","pair8","pair8","pair9","pair9","pair10","pair10")
pData(bsseq_16) <- setNames(pData(bsseq_16),c("Type","pair"))
myBS.cov <- getCoverage(bsseq_16)
myLoci1 <- which(rowSums(myBS.cov[, bsseq_16$Type == "cancer"] >= 10) > 9 &
                   rowSums(myBS.cov[, bsseq_16$Type == "normal"] >= 10) > 9)
bsseq.data.smooth1 <- bsseq_16[myLoci1,]
cpg<-as.data.frame(granges(bsseq.data.smooth1))
write.table(cpg,file="~/KoborLab/kobor_space/zdong/T2T/Sequence-based/Cancer/10X/pos_t2t.bed",sep="\t",quote = F,row.names = F,col.names = F)
