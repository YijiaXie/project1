#PCA

#calculate
first_pc <- function(path){
        egivals=read.table(path)
        first=round((egivals[1,]/sum(egivals)*100),2)
        return(first)
}
second_pc <- function(path){
        egivals=read.table(path)
        second=round((egivals[2,]/sum(egivals)*100),2)
        return(second)
}

colors=c("darkred","lightgreen","palevioletred1","lightblue")
#plot
plot_pca_basic <- function(pca_df, title, xlab, ylab){
    plot(pca_df$PC1 , pca_df$PC2, col = pca_df$Population, pch = 16, main = title, xlab=xlab, ylab=ylab,
         cex.main=2, cex.lab=1.5, cex.axis=1.5, cex=2)
    legend(x="topleft", legend = levels(pca_df$Population), cex=2,pch=16,col = colors)
}
plot_pca_basic1 <- function(pca_df, title, xlab, ylab){
    plot(pca_df$PC1 , pca_df$PC2, col = pca_df$Population, pch = 16, main = title, xlab=xlab, ylab=ylab,
         cex.main=2, cex.lab=1.5, cex.axis=1.5, cex=2)
    legend(x="topleft", legend = levels(pca_df$Population), cex=2,
           fill = palette()[1:length(levels(pca_df$Population))],)
}

#All
pca_all = read.table('./Gsample21.pca10.eigenvec')
names(pca_all) = c('Population', 'Individual', 'PC1', 'PC2', 'PC3','PC4', 'PC5', 'PC6','PC7', 'PC8', 'PC9','PC10')
pca_all$Population <- factor(pca_all$Population , levels =c("Gbb","Gbg","Ggd","Ggg"))
pca_all = pca_all[order(pca_all$Population),]
png("./PCA.All.png", width=1500, height=500,res=100)
par(mfrow=c(1,3))
plot_pca_basic(pca_all, title = 'All gorilla',
        xlab=paste0("PC1 (",first_pc("Gsample21.pca10.eigenval"),"% of variance)"),
        ylab=paste0("PC2 (",second_pc("Gsample21.pca10.eigenval"),"% of variance)"))


#eastern
pca_eastern = read.table('./east.pca10.eigenvec')
names(pca_eastern) = c('Population', 'Individual', 'PC1', 'PC2', 'PC3','PC4', 'PC5', 'PC6')
pca_eastern$Population <- factor(pca_eastern$Population , levels =c("Gbb","Gbg"))
pca_eastern = pca_eastern[order(pca_eastern$Population),]
#png("./Eastern.png",width=800,height=800)
plot_pca_basic(pca_eastern, title = 'Eastern gorilla',
        xlab=paste0("PC1 (",first_pc("east.pca10.eigenval"),"% of variance)"),
        ylab=paste0("PC2 (",second_pc("east.pca10.eigenval"),"% of variance)"))

#western
pca_western = read.table('west.pca10.eigenvec')
names(pca_western) = c('Population', 'Individual', 'PC1', 'PC2', 'PC3','PC4')
pca_western$Population <- factor(pca_western$Population , levels =c("Ggg","Ggd"))
pca_western = pca_western[order(pca_western$Population),]
#png("./Western.png",width=800,height=800)
plot_pca_basic(pca_western, title = 'Western gorilla',
        xlab=paste0("PC1 (",first_pc("west.pca10.eigenval"),"% of variance)"),
        ylab=paste0("PC2 (",second_pc("west.pca10.eigenval"),"% of variance)"))


print("Done plotting PCAs")
