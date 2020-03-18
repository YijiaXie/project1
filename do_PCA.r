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
	

#plot
plot_pca_basic <- function(pca_df, title, xlab, ylab){
    plot(pca_df$PC1 , pca_df$PC2, col = pca_df$Population, pch = 16, main = title,xlab=xlab,ylab=ylab)
    legend(x="topleft", legend = levels(pca_df$Population), fill = palette()[1:length(levels(pca_df$Population))],)
}

#All
pca_all = read.table('./test21_pca10.clean.eigenvec')
names(pca_all) = c('Population', 'Individual', 'PC1', 'PC2', 'PC3','PC4', 'PC5', 'PC6','PC7', 'PC8', 'PC9','PC10')
pca_all$Population <- factor(pca_all$Population , levels =c("Gbb","Gbg","Ggd","Ggg"))
pca_all = pca_all[order(pca_all$Population),]
png("./PCA.All.png")
plot_pca_basic(pca_all, title = 'All gorilla',
	xlab=paste0("PC1 (",first_pc("test21_pca10.clean.eigenval"),"% of variance)"),
	ylab=paste0("PC2 (",second_pc("test21_pca10.clean.eigenval"),"% of variance)"))


#eastern
pca_eastern = read.table('./test21_pca10.clean.east.eigenvec')
names(pca_eastern) = c('Population', 'Individual', 'PC1', 'PC2', 'PC3','PC4', 'PC5', 'PC6')
pca_eastern$Population <- factor(pca_eastern$Population , levels =c("Gbb","Gbg"))
pca_eastern = pca_eastern[order(pca_eastern$Population),]
png("./PCA.Eastern.png")
plot_pca_basic(pca_eastern, title = 'Eastern gorilla',
	xlab=paste0("PC1 (",first_pc("test21_pca10.clean.east.eigenval"),"% of variance)"),
	ylab=paste0("PC2 (",second_pc("test21_pca10.clean.east.eigenval"),"% of variance)"))

#western
pca_western = read.table('./test21_pca10.clean.west.eigenvec')
names(pca_western) = c('Population', 'Individual', 'PC1', 'PC2', 'PC3','PC4')
pca_western$Population <- factor(pca_western$Population , levels =c("Ggg","Ggd"))
pca_western = pca_western[order(pca_western$Population),]
png("./PCA.Western.png")
plot_pca_basic(pca_western, title = 'Western gorilla',
	xlab=paste0("PC1 (",first_pc("test21_pca10.clean.west.eigenval"),"% of variance)"),
	ylab=paste0("PC2 (",second_pc("test21_pca10.clean.west.eigenval"),"% of variance)"))


print("Done plotting PCAs")
