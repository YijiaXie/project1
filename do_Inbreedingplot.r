data <- read.table('inbreeding.txt', sep = '', header = T)
data$FID <- factor(data$FID)
data$IID <- factor(data$IID)
newdata <- data[which(data$F >= 0),]

colors = c(rep('lightblue', 4), rep('darkred', 6), rep('yellow',20))
png('./inbreeding.png', width = 1000, height = 800)
barplot(newdata[,6], col=colors, ylab = 'Inbreeding coefficient',
        ylim = c(0,0.6), xlab = '')
legend("topright",legend=c("Gbb","Gbg","Ggg"),
       fill=c("lightblue","darkred","yellow"))
mtext("Subspecies", side = 1, line = 1)

gbbmean <- mean(newdata[newdata$FID=='Gbb',]$F)
gbgmean <- mean(newdata[newdata$FID=='Gbg',]$F)
gggmean <- mean(newdata[newdata$FID=='Ggg',]$F)
inbreedmean <- data.frame('Inbreeding mean'
                          = c(gbbmean, gbgmean, gggmean),
                          row.names = c('Gbb', 'Ggd', 'Ggg'))
print(inbreedmean)
print('Done Inbreedng coefficient plotting')
