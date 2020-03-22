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
png('./piplot.png',width=400,height=800, res=100)
#par(mfrow=c(1,1))
val = c(mean(gbb$pi), mean(gbg$pi), mean(ggd$pi), mean(ggg$pi)) 
barplot(val,ylim=c(0.000,0.0013), ylab="pi",  xlab="Population", names.arg=c("Gbb","Gbg","Ggd","Ggg"), main='Average heterozygosity')

#######n
slidingwindowplot <- function(mainv, xlabv, ylabv, ylimv, window.size, step.size,input_x_data,input_y_data)
{
	if (window.size > step.size)
		step.positions  <- seq(window.size/2 + 1, length(input_x_data)- window.size/2, by=step.size) 
	else
		step.positions  <- seq(step.size/2 + 1, length(input_x_data)- step.size, by=step.size)
	n <- length(step.positions)
	means_x <- numeric(n) 
	means_y <- numeric(n) 
	for (i in 1:n) {
		chunk_x <- input_x_data[(step.positions[i]-window.size/2):(step.positions[i]+window.size-1)]
        		means_x[i] <-  mean(chunk_x,na.rem=TRUE)
		chunk_y <- input_y_data[(step.positions[i]-window.size/2):(step.positions[i]+window.size-1)]
        		means_y[i] <-  mean(chunk_y,na.rem=TRUE)
		}
	

	plot(means_x,means_y,type="b",main=mainv,xlab=xlabv,ylab=ylabv,ylim=ylimv,cex=0.25,
		pch=20,cex.main=0.8)
	vec <- c(0.025,0.5,0.975)
	zz <- means_y[!is.na(means_y)]
	abline(h=quantile(zz,0.025,na.rem=TRUE),col="blue")
	abline(h=quantile(zz,0.925,na.rem=TRUE),col="blue")
	abline(h=mean(input_y_data))
}

## Plotting the nucleotide diversity in sliding windows across the chromosome.
 ## R is doing strange things on the graphics window; therefore, we plot it on
## a pdf file. You can view it with evince afterwards
pdf ("nucleotide_diversity_in_4_subspecies.pdf")
par(mfrow=c(2,2))
windowsize<- 3000
steps<- 100
# Gbb
mainvv = paste("gbb pi = ",format(mean(gbb$pi,na.rem=TRUE), digits=3), "SNPs =", length(gbb$pi), "Win: ", windowsize, "Step: ", steps)	
slidingwindowplot(mainv=mainvv, xlab=expression(paste("Position (x ", 10^6,")")), ylab=expression(paste("pi")),ylimv=c(0.00,0.0015), window.size=windowsize/4, step.size=steps, input_x_data=gbb$position/1000000,input_y_data=gbb$pi)
# Gbg
mainvv = paste("gbg pi = ",format(mean(gbg$pi,na.rem=TRUE), digits=3),"SNPs =", length(gbg$pi),"Win: ", windowsize, "Step: ", steps )	
slidingwindowplot(mainv=mainvv, xlab=expression(paste("Position (x ", 10^6,")")), ylab=expression(paste("pi")),ylimv=c(0.000,0.0015), window.size=windowsize/3, step.size=steps, input_x_data=gbg$position/1000000,input_y_data=gbg$pi)
# Ggg
mainvv = paste("ggg pi = ",format(mean(ggg$pi,na.rem=TRUE), digits=3),"SNPs =", length(ggg$pi),"Win: ", windowsize, "Step: ", steps )	
slidingwindowplot(mainv=mainvv, xlab=expression(paste("Position (x ", 10^6,")")), ylab=expression(paste("pi")),ylimv=c(0.000,0.0015), window.size=windowsize, step.size=steps, input_x_data=ggg$position/1000000,input_y_data=ggg$pi)
# Ggd only one
mainvv = paste("ggd pi =  ",format(mean(ggd$pi,na.rem=TRUE), digits=3),"SNPs =", length(ggd$pi),"Win: ", windowsize, "Step: ", steps )	
slidingwindowplot(mainv=mainvv, xlab=expression(paste("Position (x ", 10^6,")")), ylab=expression(paste("pi")),ylimv=c(0.000,0.0015), window.size=windowsize, step.size=steps, input_x_data=ggd$position/1000000,input_y_data=ggd$pi)

print("Done het")
