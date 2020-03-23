data <- read.table('inbreeding.txt', sep = '', header = T)
newdata <- data[data$F > 0, ]
newdata$FID <- factor(newdata$FID)
newdata <- newdata[order(newdata$FID, newdata$F), ]
png('ieboxplot.png', width = 500, height = 700,res=100)
boxplot(F ~ FID, newdata, ylab = 'Inbreeding coefficient', border = c("darkred","chartreuse3", "dodgerblue2"))
#dev.off()

png('iescatterplot.png',  width = 800, height = 600,res=100)
par(mar=c(3,6,2,2))
plot(seq(1,34), newdata$F, ylim = c(0,0.5), xaxt = "n", xlab = '', ylab = '', 
     col = c(rep('darkred', 4), rep('chartreuse3', 6), rep('dodgerblue2', 24)), pch = 16, las = 1, cex.lab = 1.5)
axis(1,at = c(1, 6, 23),labels=c('Gbb','Gbg','Ggg'))
mtext("Inbreeding coefficient", side = 2, line = 4)
axis(2,at = c(0.0625, 0.125, 0.25), las = 1)
abline(h=0.0625, col='grey', lty = 2)
abline(h=0.125, col='grey', lty = 2)
abline(h=0.25, col='grey', lty =2)
legend("top",legend=c("Gbb","Gbg","Ggg"),
       col=c("darkred","chartreuse3", "dodgerblue2"), pch = 16)

print("Done Inbreeding plotting")


######################################

 FID                            IID       O(HOM)       E(HOM)        N(NM)            F
 Gbb                     Gbb-Maisha        21615    2.375e+04        36524      -0.1672
 Gbb              Gbb-N010_Turimaso        27215    2.375e+04        36524       0.2712
 Gbb   Gbb-SC_EGWGS5386356_Zirikana        26748    2.375e+04        36524       0.2347
 Gbb     Gbb-SC_EGWGS5389138_Imfura        22879    2.375e+04        36524     -0.06822
 Gbb       Gbb-SC_EGWGS5389140_Tuck        14673    2.375e+04        36524      -0.7106
 Gbb     Gbb-SC_EGWGS5389618_Kaboko        29587    2.375e+04        36524       0.4569
 Gbb                    Gbb-Umurimo        26114    2.374e+04        36507        0.186
 Gbg               Gbg-9732_Mkubwa        33154    2.984e+04        45660       0.2096
 Gbg                Gbg-A929_Kaisi        35218    2.984e+04        45660       0.3401
 Gbg             Gbg-A967_Victoria        31713    2.984e+04        45661       0.1185
 Gbg                Gbg-N011_Pinga        27656    2.984e+04        45658      -0.1378
 Gbg                Gbg-N012_Dunia        29945    2.984e+04        45661     0.006775
 Gbg   Gbg-SC_EGWGS5389141_Itebero        34359    2.984e+04        45661       0.2857
 Gbg  Gbg-SC_EGWGS5389142_Ntabwoba        36973    2.984e+04        45661       0.4509
 Gbg                  Gbg-Serufuli        29432    2.984e+04        45661     -0.02565
 Gbg                    Gbg-Tumani        24067    2.984e+04        45661      -0.3647
 Ggd   Ggd-B646_Nyango            0    1.411e+04        28221           -1
 Ggg       Ggg-9749_Kowali       107628     1.07e+05       144949      0.01541
 Ggg        Ggg-9750_Azizi       109046     1.07e+05       144950       0.0528
 Ggg       Ggg-9751_Bulera       107960     1.07e+05       144949      0.02417
 Ggg        Ggg-9752_Suzie       106332     1.07e+05       144949     -0.01878
 Ggg       Ggg-9753_Kokomo       106668     1.07e+05       144949    -0.009912
 Ggg       Ggg-A930_Sandra       108666     1.07e+05       144950      0.04278
 Ggg        Ggg-A931_Banjo       108168     1.07e+05       144950      0.02964
 Ggg         Ggg-A932_Mimi       109336     1.07e+05       144950      0.06045
 Ggg         Ggg-A933_Dian       112793     1.07e+05       144949       0.1517
 Ggg       Ggg-A934_Delphi       109665     1.07e+05       144949      0.06916
 Ggg         Ggg-A936_Coco       107941     1.07e+05       144950      0.02365
 Ggg         Ggg-A937_Kolo       108640     1.07e+05       144949      0.04211
 Ggg        Ggg-A962_Amani       106430     1.07e+05       144950     -0.01621
 Ggg   Ggg-B642_Akiba_Beri       113587     1.07e+05       144949       0.1726
 Ggg      Ggg-B643_Choomba       112411     1.07e+05       144950       0.1416
 Ggg         Ggg-B644_Paki       108157     1.07e+05       144950      0.02935
 Ggg       Ggg-B647_Anthal       109568     1.07e+05       144950      0.06657
 Ggg        Ggg-B650_Katie       123406     1.07e+05       144950       0.4316
 Ggg       Ggg-KB3782_Vila       110889     1.07e+05       144947       0.1015
 Ggg      Ggg-KB3784_Dolly       113260     1.07e+05       144949        0.164
 Ggg      Ggg-KB4986_Katie       117773     1.07e+05       144949       0.2831
 Ggg    Ggg-KB5792_Carolyn       110990     1.07e+05       144946       0.1042
 Ggg      Ggg-KB5852_Helen       109086     1.07e+05       144948       0.0539
 Ggg        Ggg-KB6039_Oko       109887     1.07e+05       144950      0.07499
 Ggg      Ggg-KB7973_Porta       112056     1.07e+05       144947       0.1323
 Ggg        Ggg-X00108_Abe       110463     1.07e+05       144950      0.09018
 Ggg     Ggg-X00109_Tzambo       110566     1.07e+05       144950       0.0929
