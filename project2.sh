################
################

# filter data
plink --bfile GorgorWholeGenFID --chr 21 --hwe .001 --geno 0.02 --thin 0.15 --maf 0.15 --make-bed --out ../allsample/allsample21.clean
plink --bfile GorgorWholeGenFID --noweb --keep GorillaID.txt --chr 21 --hwe .001 --geno 0.02 --thin 0.15 --maf 0.15 --make-bed --out ../allsample/Gsample21.clean

# separate west and east Gorilla
plink --bfile ../Gsample21.clean --noweb --keep western_pop.txt --indep-pairwise 50 5 0.5 --recode --out west
plink --bfile ../Gsample21.clean --noweb --keep western_pop.txt --extract west.prune.in --make-bed --out westpurned21.clean
plink --bfile ../Gsample21.clean --noweb --keep eastern_pop.txt --indep-pairwise 50 5 0.5 --recode --out east
plink --bfile ../Gsample21.clean --noweb --keep eastern_pop.txt --extract east.prune.in --make-bed --out eastpurned21.clean


###PCA###
plink --bfile Gsample21.clean  --pca 10 --out ./PCA/Gsample21.pca10
plink --bfile eastpurned21.clean  --pca 10 --out ./esat.pca10
plink --bfile westpurned21.clean  --pca 10 --out ./west.pca10
Rscirpt do_PCA.r


###admixture###
for i in 2 3 4 5; do admixture --cv ../Gsample21.clean.bed $i; done > ./cvoutput
grep -i 'CV error' ./cvoutput
Rscirpt do_admixture.r


# Het
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
