# Load in the Ne and Nc estimates
Ne = read.table("./Ne_estimates.txt",sep = '\t', header = TRUE)
Nc = read.table("./Nc_estimates.txt",sep = '\t', header = TRUE)

## Use the merge command to join them
estimates = merge(Ne, Nc)
estimates$ratio = estimates$Ne_est / estimates$Nc_est

# reorder to match input order
estimates$Pop <- factor(estimates$Pop , levels =c('Gbb', 'Gbg', 'Ggg'))
estimates = estimates[order(estimates$Pop),]
estimates

for_barplot = data.matrix(t(estimates[,c('Ne_est', 'Nc_est')]))
colnames(for_barplot) = estimates$Pop

for_ratio_barplot = data.matrix(t(estimates[,'ratio']))
colnames(for_ratio_barplot) = estimates$Pop


png('./Ne_and_Nc.png', width=1000,height =1000,res=100)
par(mfrow=c(2,2),mar=c(7.5,5.5,3,3))
barplot(for_barplot['Ne_est',], col = "white", beside = TRUE, las=2,width=0.8,
       main = "Ne estimates for each population",ylab = '',cex.main=1.4)
mtext('Ne', side=2, line=4.2)

barplot(for_ratio_barplot, col = "gray", beside = TRUE, las=2, #axes = FALSE,
       main = "Ne/Nc ratios for each population",ylab = '',cex.main=1.4)
mtext('Ne/Nc ratio', side=2, line=4.2)

#png('./Ne_and_Nc_estimates.png',  width=650,height =650,res=100)
#par(mar=c(10,6,4,2))
barplot(for_barplot, col =c("white","grey12"), beside = TRUE, las=2,
       main = "Ne and Nc estimates for each population",ylab = '',cex.main=1.4)
mtext('Size', side=2, line=4.2)
legend("top",
  c("Ne_est","Nc_est"),
  fill = c("white","grey12")
)

# same plot with a log y axis
barplot(for_barplot, col = c("white","grey12"), beside = TRUE, las=2,
        log = 'y',
       main = "Ne and Nc estimates for each population",ylab = '',cex.main=1.4)
mtext('Size (log scaled)', side=2, line=4.2)
legend("top",
  c("Ne_est","Nc_est"),
  fill =  c("white","grey12")
)
print("Done Ne_Nc_plot")

