#先分类再filter

plink --bfile ../../Gorgorstudent/GorgorWholeGenFID --chr 21 --family --keep-cluster-names Gbb --recode --out Gbb_LD
plink --bfile ../../Gorgorstudent/GorgorWholeGenFID --chr 21 --family --keep-cluster-names Gbg --recode --out Gbg_LD
plink --bfile ../../Gorgorstudent/GorgorWholeGenFID --chr 21 --family --keep-cluster-names Ggd --recode --out Ggd_LD
plink --bfile ../../Gorgorstudent/GorgorWholeGenFID --chr 21 --family --keep-cluster-names Ggg --recode --out Ggg_LD
plink --file Gbb_LD --maf 0.15 --geno 0 --thin 0.20 --from 21:3016639 --to 21:8024075 --make-bed --out Gbb_block
plink --file Gbg_LD --maf 0.15 --geno 0 --thin 0.20 --from 21:3016639 --to 21:8024075 --make-bed --out Gbg_block
plink --file Ggd_LD --maf 0.15 --geno 0 --thin 0.20 --from 21:3016639 --to 21:8024075 --make-bed --out Ggd_block
plink --file Ggg_LD --maf 0.15 --geno 0 --thin 0.20 --from 21:3016639 --to 21:8024075 --make-bed --out Ggg_block

###LD decay### 
plink --bfile ../Gsample21.clean --family --keep-cluster-names Gbb --recode --out Gbb
plink --bfile ../Gsample21.clean --family --keep-cluster-names Gbg --recode --out Gbg
plink --bfile ../Gsample21.clean --family --keep-cluster-names Ggg --recode --out Ggg

awk '{$2 = substr($2,4);print $0}' Gbb.map > Gbb2.map
rm Gbb.map 
mv Gbb2.map Gbb.map 
plink --file Gbb --make-bed --out Gbb
awk '{$2 = substr($2,4);print $0}' Gbg.map > Gbg2.map
rm Gbg.map 
mv Gbg2.map Gbg.map 
plink --file Gbg --make-bed --out Gbg
awk '{$2 = substr($2,4);print $0}' Ggg.map > Ggg2.map
rm Ggg.map 
plink --file Ggg --make-bed --out Ggg

####Ne##  (在autosome文件夹)
plink --file gorilla --make-bed --out gorilla
plink --bfile gorilla --not-chr xy --make-bed --out gorilla.clean

plink --bfile gorilla.clean --family --keep-cluster-names Gbg --keep GbgsampleID.txt -hwe 0.001 --geno 0.02 --maf 0.05 --make-bed --out Gbg
plink --bfile gorilla.clean --family --keep-cluster-names Ggg --keep GggsampleID.txt -hwe 0.001 --geno 0.02 --maf 0.05 --make-bed --out Ggg

plink --bfile Ggg --thin 0.001 --make-bed --out Ggg.clean
plink --bfile Gbg --thin 0.002 --make-bed --out Gbg.clean
plink --bfile Gbb --thin 0.002 --make-bed --out Gbb.clean
plink --bfile Gbb.clean --r2 square --out Gbb.clean
plink --bfile Gbg.clean --r2 square --out Gbg.clean
plink --bfile Ggg.clean --r2 square --out Ggg.clean


####treemix#####
awk '{print $1,$2,$2}' ../GorgorStudent/GorgorWholeGenFID.ped > allsample21.clean.clust
awk '{print $1,$2,$1}' ../GorgorStudent/GorgorWholeGenFID.ped > allfamily21.clean.clust

cd treemix
#individual
plink --bfile ../allsample21.clean --freq --missing --within ./allsample21.clean.clust --out allsample21
gzip allsample21.frq.strat 
python ./treemix-1.13/plink2treemix.py  allsample21.frq.strat.gz  tree_allsample21.gz
treemix -i tree_allsample21.gz  -o tree_allsample21
#subpopulation
plink --bfile ../Gsample21.clean --freq --missing --within ./allfamily21.clean.clust --out allfamily21
gzip allfamily21.frq.strat 
python ./treemix-1.13/plink2treemix.py  allfamily21.frq.strat.gz  tree_allsample21.gz
treemix -i tree_allfamily21.gz -o tree_allfamily21


