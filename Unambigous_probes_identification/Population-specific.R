afr<-read.table("AFR/probes_AFR_450k.txt")
amr<-read.table("AMR/probes_AMR_450k.txt")
eas<-read.table("EAS/probes_EAS_450k.txt")
eur<-read.table("EUR/probes_EUR_450k.txt")
sas<-read.table("SAS/probes_SAS_450k.txt")
x<-unique(c(afr$V1,amr$V1,eur$V1,sas$V1))
ueas<-eas$V1[-which(eas$V1 %in% x)]
length(ueas) # 484

x<-unique(c(eas$V1,amr$V1,eur$V1,sas$V1))
uafr<-afr$V1[-which(afr$V1 %in% x)]
length(uafr) # 128

x<-unique(c(eas$V1,afr$V1,eur$V1,sas$V1))
uamr<-amr$V1[-which(amr$V1 %in% x)]
length(uamr) # 20

x<-unique(c(eas$V1,afr$V1,amr$V1,sas$V1))
ueur<-eur$V1[-which(eur$V1 %in% x)]
length(ueur) # 2174

x<-unique(c(eas$V1,afr$V1,amr$V1,eur$V1))
usas<-sas$V1[-which(sas$V1 %in% x)]
length(usas) # 1962