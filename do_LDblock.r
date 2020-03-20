library(snpMatrix)


data_Gbb <- read.plink("Gbb_chr4_Block")
ld_Gbb <- ld.snp(data_Gbb, dep=930)
plot.snp.dprime(ld_Gbb, filename="Gbb_chr4.eps", res=100)

data_Ggg <- read.plink("Ggg_chr4_Block")
ld_Ggg <- ld.snp(data_Ggg, dep=2268)
plot.snp.dprime(ld_Ggg, filename="Ggg_chr4.eps", res=100)

data_Gbg <- read.plink("Gbg_chr4_Block")
ld_Gbg <- ld.snp(data_Gbg, dep=930)
plot.snp.dprime(ld_Gbg, filename="Gbg_chr4.eps", res=100)

print("Done LDblock plotting")
