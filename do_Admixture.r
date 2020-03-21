#plot ADMIXTURE results
snpk2=read.table("./Gsample21.clean.2.Q")
snpk3=read.table("./Gsample21.clean.3.Q")
snpk4=read.table("./Gsample21.clean.4.Q")
snpk5=read.table("./Gsample21.clean.5.Q")
names=c('Gbb-Maisha', 'Gbb-N010_Turimaso', 'Gbb-SC_EGWGS5386356_Zirikana',
'Gbb-SC_EGWGS5389138_Imfura', 'Gbb-SC_EGWGS5389140_Tuck', 
'Gbb-SC_EGWGS5389618_Kaboko', 'Gbb-Umurimo', 'Gbg-9732_Mkubwa',
'Gbg-A929_Kaisi', 'Gbg-A967_Victoria', 'Gbg-N011_Pinga', 'Gbg-N012_Dunia',
'Gbg-SC_EGWGS5389141_Itebero', 'Gbg-SC_EGWGS5389142_Ntabwoba',
'Gbg-Serufuli', 'Gbg-Tumani', 'Ggd-B646_Nyango', 'Ggg-9749_Kowali',
'Ggg-9750_Azizi', 'Ggg-9751_Bulera', 'Ggg-9752_Suzie', 'Ggg-9753_Kokomo',
'Ggg-A930_Sandra', 'Ggg-A931_Banjo', 'Ggg-A932_Mimi', 'Ggg-A933_Dian',
'Ggg-A934_Delphi', 'Ggg-A936_Coco', 'Ggg-A937_Kolo', 'Ggg-A962_Amani',
'Ggg-B642_Akiba_Beri', 'Ggg-B643_Choomba', 'Ggg-B644_Paki', 'Ggg-B647_Anthal',
'Ggg-B650_Katie', 'Ggg-KB3782_Vila', 'Ggg-KB3784_Dolly', 'Ggg-KB4986_Katie',
'Ggg-KB5792_Carolyn', 'Ggg-KB5852_Helen', 'Ggg-KB6039_Oko', 'Ggg-KB7973_Porta',
'Ggg-X00108_Abe', 'Ggg-X00109_Tzambo')
png('./admixture.png', width=1200, height=800)
par(mfrow=c(4,1))
barplot(t(as.matrix(snpk2)),
        col= c("lightblue","Dark red"),
         border=NA, main="K=2",
         cex.names=0.55, las=2, ylab="ancestry")
barplot(t(as.matrix(snpk3)),
        col= c("lightgreen","Dark red","lightblue"),
        border=NA, main="K=3",
        cex.names=0.55, las=2, ylab="ancestry")
barplot(t(as.matrix(snpk4)),
        col= c("lightgreen","Dark red","lightblue","yellow"),
        border=NA, main="K=4",cex.names=0.55, las=2,
        ylab="ancestry")
barplot(t(as.matrix(snpk5)),
        col= c("lightgreen","Dark red","lightblue","yellow","pink"),
        border=NA, main="K=5", names.arg=(names), cex.names=0.55, las=2,
        ylab="ancestry")
