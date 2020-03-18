#date=0317
awk '{print $1,$2}' GorgorWholeGen.ped   #check the subspecies information of griollas
# change Family ID as subspecies name, and rename other files
awk '{$1 = substr($1,1,3);print $0}' GorgorWholeGen.ped > GorgorWholeGenFID.ped
cp GorgorWholeGen.map > GorgorWholeGenFID.map
cp GorgorWholeGen.log > GorgorWholeGenFID.log
# picked 9 individuals of each subspecies
nano sampleID.txt 

Gbb Gbb-Maisha
Gbb Gbb-N010_Turimaso
Gbb Gbb-Umurimo
Gbg Gbg-A929_Kaisi
Gbg Gbg-N011_Pinga
Gbg Gbg-N012_Dunia
Ggd Ggd-B646_Nyango
Ggg Ggg-A932_Mimi
Ggg Ggg-KB5792_Carolyn
Ggg Ggg-X00108_Abe


#make bed file for whole genome file of all individuals
plink --file GorgorWholeGenFID --make-bed --out GorgorWholeGenFID 
#pick the whole genomen of 9 individuals we want
plink --bfile GorgorWholeGenFID --noweb --keep sampleID.txt --recode --out ../FIDchr21/test10
#make bed file for whole genome file of 9 individuals we want 
plink --file test10 --make-bed --out test10
#pick chromosome 21 of 9 individuals and fiter data (先不用LD)
plink --bfile test10 --chr 21 --hwe .001 --geno 0.02 --thin 0.8 --maf 0.05 --make-bed --out test21.clean

# divide each subspecies
plink --bfile test21.clean --family --keep-cluster-names Gbb --make-bed --out Gbb
plink --bfile test21.clean --family --keep-cluster-names Gbg --make-bed --out Gbg
plink --bfile test21.clean --family --keep-cluster-names Ggg --make-bed --out Ggg
plink --bfile test21.clean --family --keep-cluster-names Ggd --make-bed --out Ggd

# do PCA
plink --bfile test21.clean --pca 3 --out test21_pca3.clean


#########END###########

