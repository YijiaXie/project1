#plot ADMIXTURE results
snpk2=read.table("./admixture/test21.clean.2.Q")
snpk3=read.table("./admixture/test21.clean.3.Q")
snpk4=read.table("./admixture/test21.clean.4.Q")
snpk5=read.table("./admixture/test21.clean.5.Q")
names=c("Gbb-Maisha", "Gbb-N010_Turimaso", "Gbb-Umurimo", "Gbg-A929_Kaisi",
        "Gbg-N011_Pinga", "Gbg-N012_Dunia", "Ggd-B646_Nyango", "Ggg-A932_Mimi",
        "Ggg-KB5792_Carolyn", "Ggg-X00108_Abe")
png('./admixture/admixture.png')
par(mfrow=c(4,1))
barplot(t(as.matrix(snpk2)),
        col= c("lightblue","Dark red"),
         border=NA, main="K=2",
         names.arg=(names), cex.names=0.8, las=2, ylab="ancestry")
barplot(t(as.matrix(snpk3)),
        col= c("lightgreen","Dark red","lightblue"),
        border=NA, main="K=3",
        names.arg=(names), cex.names=0.8, las=2, ylab="ancestry")
barplot(t(as.matrix(snpk4)),
        col= c("lightgreen","Dark red","lightblue","yellow"),
        border=NA, main="K=4", names.arg=(names), cex.names=0.8, las=2,
        ylab="ancestry")
barplot(t(as.matrix(snpk5)),
        col= c("lightgreen","Dark red","lightblue","yellow","pink"),
        border=NA, main="K=5", names.arg=(names), cex.names=0.8, las=2,
        ylab="ancestry")
