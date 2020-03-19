gbb<-read.table("Gbb_noNA.frq",h=T)
gbg<-read.table("Gbg_noNA.frq",h=T)
ggd<-read.table("Ggd_noNA.frq",h=T)
ggg<-read.table("Ggg_noNA.frq",h=T)

het<-function(x){2*x*(1-x)}

gbb <- gbb[gbb[,"MAF"]>0,]
gbg <- gbg[gbg[,"MAF"]>0,]
ggd <- ggd[ggd[,"MAF"]>0,]
ggg <- ggg[ggg[,"MAF"]>0,]

gbb <- cbind(gbb,position= as.numeric(gsub("21:",'',gbb[,"SNP"])))
gbb <- cbind(gbb, pi=het(gbb$MAF) *(length(gbb$MAF)/(gbb[length(gbb[,"position"]),"position"] - gbb[1,"position"])))

gbg <- cbind(gbg,position= as.numeric(gsub("21:",'',gbg[,"SNP"])))
gbg <- cbind(gbg, pi=het(gbg$MAF) *(length(gbg$MAF)/(gbg[length(gbg[,"position"]),"position"] - gbg[1,"position"])))

ggd <- cbind(ggd,position= as.numeric(gsub("21:",'',ggd[,"SNP"])))
ggd <- cbind(ggd, pi=het(ggd$MAF) *(length(ggd$MAF)/(ggd[length(ggd[,"position"]),"position"] - ggd[1,"position"])))

ggg <- cbind(ggg,position= as.numeric(gsub("21:",'',ggg[,"SNP"])))
ggg <- cbind(ggg, pi=het(ggg$MAF) *(length(ggg$MAF)/(ggg[length(ggg[,"position"]),"position"] - ggg[1,"position"])))


# Making a barplot with the nucleotide diversity
png('./piplot.png',width=800,height=800)
par(mfrow=c(1,1))
val = c(mean(gbb$pi), mean(gbg$pi), mean(ggd$pi), mean(ggg$pi)) 
barplot(val,ylim=c(0.000,0.00015), ylab="pi",  xlab="Population", names.arg=c("Gbb","Gbg","Ggd","Ggg"), main='Average heterozygosity')
# To shut down the plot window
print('Done Het')
