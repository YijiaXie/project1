################
################

##filter data
plink --bfile GorgorWholeGenFID --chr 21 --hwe .001 --geno 0.02 --thin 0.15 --maf 0.15 --make-bed --out ../allsample/allsample21.clean
plink --bfile GorgorWholeGenFID --noweb --keep GorillaID.txt --chr 21 --hwe .001 --geno 0.02 --thin 0.15 --maf 0.15 --make-bed --out ../allsample/Gsample21.clean
#for LD
plink --bfile GorgorWholeGenFID --noweb --keep GorillaID.txt --chr 4 --hwe .001 --geno 0.02 --thin 0.15 --maf 0.15 --make-bed --out ../allsample/LD/Gsample4.clean

##separate west and east Gorilla
plink --bfile ../Gsample21.clean --noweb --keep western_pop.txt --indep-pairwise 50 5 0.5 --recode --out west
plink --bfile ../Gsample21.clean --noweb --keep western_pop.txt --extract west.prune.in --make-bed --out westpurned21.clean
plink --bfile ../Gsample21.clean --noweb --keep eastern_pop.txt --indep-pairwise 50 5 0.5 --recode --out east
plink --bfile ../Gsample21.clean --noweb --keep eastern_pop.txt --extract east.prune.in --make-bed --out eastpurned21.clean


###PCA###
plink --bfile Gsample21.clean  --pca 10 --out ./PCA/Gsample21.pca10
plink --bfile eastpurned21.clean  --pca 10 --out ./east.pca10
plink --bfile westpurned21.clean  --pca 10 --out ./west.pca10
Rscirpt do_PCA.r


###admixture###
for i in 2 3 4 5 6; do admixture --cv ../Gsample21.clean.bed $i; done > ./cvoutput
grep -i 'CV error' ./cvoutput
Rscirpt do_admixture.r


###Het###
plink --bfile ../Gsample21.clean --family --keep-cluster-names Gbb --recode --out Gbb
plink --bfile ../Gsample21.clean --family --keep-cluster-names Gbg --recode --out Gbg
plink --bfile ../Gsample21.clean --family --keep-cluster-names Ggd --recode --out Ggd
plink --bfile ../Gsample21.clean --family --keep-cluster-names Ggg --recode --out Ggg

plink --noweb --file Gbb --freq --out Gbb
plink --noweb --file Gbg --freq --out Gbg
plink --noweb --file Ggd --freq --out Ggd
plink --noweb --file Ggg --freq --out Ggg

cat Gbb.frq |grep -v NA > Gbb_noNA.frq
cat Gbg.frq |grep -v NA > Gbg_noNA.frq
cat Ggd.frq |grep -v NA > Ggd_noNA.frq
cat Ggg.frq |grep -v NA > Ggg_noNA.frq

###Inbreeding##
plink --file ../Het/Gbb --het --out Gbb
plink --file ../Het/Gbg --het --out Gbg
plink --file ../Het/Ggg --het --out Ggg

####LD####
plink --bfile ./Gsample4.clean --family --keep-cluster-names Gbb --recode --out Gbb_chr4
plink --bfile ./Gsample4.clean --family --keep-cluster-names Gbg --recode --out Gbg_chr4
plink --bfile ./Gsample4.clean --family --keep-cluster-names Ggg --recode --out Ggg_chr4

plink --file Gbb_chr4  --from 4:9029454 --to 4:14144296  --make-bed --out Gbb_chr4_Block
plink --file Gbg_chr4  --from 4:9029454 --to 4:14144296  --make-bed --out Gbg_chr4_Block
plink --file Ggg_chr4  --from 4:9029454 --to 4:14144296  --make-bed --out Ggg_chr4_Block

###LD_decay###
awk '{$2 = substr($2,3);print $0}' Gbb_chr4.map > Gbb2_chr4.map
rm Gbb_chr4.map
mv Gbb2_chr4.map Gbb_chr4.map
plink --file Gbb_chr4 --make-bed --out Gbb_chr4

awk '{$2 = substr($2,3);print $0}' Gbg_chr4.map > Gbg2_chr4.map
rm Gbg_chr4.map
mv Gbg2_chr4.map Gbg_chr4.map
plink --file Gbg_chr4 --make-bed --out Gbg_chr4

awk '{$2 = substr($2,3);print $0}' Ggg_chr4.map > Ggg2_chr4.map
rm Ggg_chr4.map
mv Ggg2_chr4.map Ggg_chr4.map
plink --file Ggg_chr4 --make-bed --out Ggg_chr4

####Ne####
plink --bfile GorgorWholeGenFID --noweb --keep GorillaID.txt --not-chr xy --hwe .001 --geno 0.02 --thin 0.02 --maf 0.15 --make-bed --out ../autosome/Gsample.clean
plink --bfile Gsample.clean --family --keep-cluster-names Gbb --make-bed --out Gbbauto
plink --bfile Gsample.clean --family --keep-cluster-names Gbg --make-bed --out Gbgauto
plink --bfile Gsample.clean --family --keep-cluster-names Ggg --make-bed --out Gggauto

plink --bfile Gbbauto --r2 square --out Gbbauto
plink --bfile Gbgauto --r2 square --out Gbgauto
plink --bfile Gggauto --r2 square --out Gggauto


