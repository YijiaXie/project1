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
LD decay 
plink --bfile ../Gsample21.clean --family --keep-cluster-names Gbb --recode --out Gbb
plink --bfile ../Gsample21.clean --family --keep-cluster-names Gbg --recode --out Gbg
plink --bfile ../Gsample21.clean --family --keep-cluster-names Ggg --recode --out Ggg
逸心改21：后makebed
