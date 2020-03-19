#date=0317
awk '{print $1,$2}' GorgorWholeGen.ped   #check the subspecies information of griollas

# picked 9 individuals of each subspecies
nano sampleID.txt 

Gbb-Maisha Gbb-Maisha
Gbb-N010_Turimaso Gbb-N010_Turimaso
Gbb-Umurimo Gbb-Umurimo
Gbg-A929_Kaisi Gbg-A929_Kaisi
Gbg-N011_Pinga Gbg-N011_Pinga
Gbg-N012_Dunia Gbg-N012_Dunia
Ggd-B646_Nyango Ggd-B646_Nyango
Ggg-A932_Mimi Ggg-A932_Mimi
Ggg-KB5792_Carolyn Ggg-KB5792_Carolyn
Ggg-X00108_Abe Ggg-X00108_Abe


#make bed file for whole genome file of all individuals
plink --file GorgorWholeGen --make-bed --out GorgorWholeGen 
#pick the whole genomen of 9 individuals we want
plink --bfile GorgorWholeGen --noweb --keep sampleID.txt --recode --out ../datatest21/test10
#make bed file for whole genome file of 9 individuals we want 
plink --file test10 --make-bed --out test10
#pick chromosome 21 of 9 individuals and fiter data (先不用LD)
plink --bfile test10 --chr 21 --hwe .001 --geno 0.02 --thin 0.8 --maf 0.05 --make-bed --out test21

#########END###########

###date=0318####################################################################################################################
awk '{print $1,$2}' GorgorWholeGen.ped #check the subspecies information of griollas
   
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
plink --bfile test10 --chr 21 --hwe .001 --geno 0.02 --thin 0.2 --maf 0.05 --make-bed --out test21.clean

######PCA######
# do PCA (for all, for west ,for east)
plink --bfile test21.clean --noweb --keep sampleID_east.txt --recode --make-bed --out test21.clean.east
plink --bfile test21.clean --noweb --keep sampleID_west.txt --recode --make-bed --out test21.clean.west
plink --bfile test21.clean --pca 10 --out ./PCA_for_10/test21_pca10.clean
plink --bfile test21.clean.west --pca 10 --out ./PCA_for_10/test21_pca10.clean.west 
plink --bfile test21.clean.east --pca 10 --out ./PCA_for_10/test21_pca10.clean.east 
Rscript do_PCA.r

######admixture###### 
#find the K with the lowest number of errors
for i in 2 3 4 5; do admixture --cv test21.clean.bed $i; done > ./admixture/cvoutput
grep -i 'CV error' ./admixture/cvoutput
Rscript do_Admixture.r

#######LD######### use chr 4
#pick chromosome 4 of 10 individuals and fiter data
plink --bfile test10 --chr 4 --hwe .001 --geno 0.02 --thin 0.2 --maf 0.05 --make-bed --out test4.clean
#这一步暂时用不到makebed
#plink --bfile test4.clean --family --keep-cluster-names Gbb --make-bed --out Gbb  
#divide each subspecies (chr4)
plink --bfile test4.clean --family --keep-cluster-names Gbb --recode --out Gbb
plink --bfile test4.clean --family --keep-cluster-names Gbg --recode --out Gbg   
plink --bfile test4.clean --family --keep-cluster-names Ggd --recode --out Ggd   
plink --bfile test4.clean --family --keep-cluster-names Ggg --recode --out Ggg  
#LD anaysis 
plink --file Gbb --from 4:9029832 --to 4:14148683 --make-bed --out Gbb_block
plink --file Gbb --from 4:9029832 --to 4:14148683 --make-bed --out Gbg_block 
plink --file Gbb --from 4:9029832 --to 4:14148683 --make-bed --out Ggd_block #only one ? 要分析吗
plink --file Gbb --from 4:9029832 --to 4:14148683 --make-bed --out Ggg_block     


######heter#######
plink --noweb --file Gbb --freq --out ./het/Gbb
plink --noweb --file Gbg --freq --out ./het/Gbg
plink --noweb --file Ggd --freq --out ./het/Ggd
plink --noweb --file Ggg --freq --out ./het/Ggg
cat ./het/Gbb.frq |grep -v NA > ./het/Gbb_noNA.frq
cat ./het/Gbg.frq |grep -v NA > ./het/Gbg_noNA.frq
cat ./het/Ggd.frq |grep -v NA > ./het/Ggd_noNA.frq
cat ./het/Ggg.frq |grep -v NA > ./het/Ggg_noNA.frq
Rscript do_het.r


#####inbreeding coefficient#######
plink --file Gbb --het --out ./inbreed/Gbb
plink --file Ggg --het --out ./inbreed/Ggg
plink --file Gbg --het --out ./inbreed/Gbg
plink --file Gbg --het --out ./inbreed/Gbg

#########END###########



###date=0319#####################################################################################################################
awk '{print $1,$2}' GorgorWholeGen.ped #check the subspecies information of griollas
   
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
plink --bfile test10 --chr 21 --hwe .001 --geno 0.02 --thin 0.2 --maf 0.05 --make-bed --out test21.clean

######PCA######
# do PCA (for all, for west ,for east)
plink --bfile test21.clean --noweb --keep sampleID_east.txt --recode --make-bed --out test21.clean.east
plink --bfile test21.clean --noweb --keep sampleID_west.txt --recode --make-bed --out test21.clean.west
plink --bfile test21.clean --pca 10 --out ./PCA_for_10/test21_pca10.clean
plink --bfile test21.clean.west --pca 10 --out ./PCA_for_10/test21_pca10.clean.west 
plink --bfile test21.clean.east --pca 10 --out ./PCA_for_10/test21_pca10.clean.east 
Rscript do_PCA.r

######admixture###### 
#find the K with the lowest number of errors
for i in 2 3 4 5; do admixture --cv test21.clean.bed $i; done > ./admixture/cvoutput
grep -i 'CV error' ./admixture/cvoutput
Rscript do_Admixture.r

#######LD######### use chr 4
#pick chromosome 4 of 10 individuals and fiter data
plink --bfile test10 --chr 4 --hwe .001 --geno 0.02 --thin 0.2 --maf 0.05 --make-bed --out test4.clean
#这一步暂时用不到makebed
#plink --bfile test4.clean --family --keep-cluster-names Gbb --make-bed --out Gbb  
#divide each subspecies (chr4)
plink --bfile test4.clean --family --keep-cluster-names Gbb --recode --out Gbb
plink --bfile test4.clean --family --keep-cluster-names Gbg --recode --out Gbg   
plink --bfile test4.clean --family --keep-cluster-names Ggd --recode --out Ggd   
plink --bfile test4.clean --family --keep-cluster-names Ggg --recode --out Ggg  
#LD anaysis 
plink --file Gbb --from 4:9029832 --to 4:14148683 --make-bed --out Gbb_block
plink --file Gbb --from 4:9029832 --to 4:14148683 --make-bed --out Gbg_block 
plink --file Gbb --from 4:9029832 --to 4:14148683 --make-bed --out Ggd_block #only one ? 要分析吗
plink --file Gbb --from 4:9029832 --to 4:14148683 --make-bed --out Ggg_block     


######heter#######
plink --noweb --file Gbb --freq --out ./het/Gbb
plink --noweb --file Gbg --freq --out ./het/Gbg
plink --noweb --file Ggd --freq --out ./het/Ggd
plink --noweb --file Ggg --freq --out ./het/Ggg
cat ./het/Gbb.frq |grep -v NA > ./het/Gbb_noNA.frq
cat ./het/Gbg.frq |grep -v NA > ./het/Gbg_noNA.frq
cat ./het/Ggd.frq |grep -v NA > ./het/Ggd_noNA.frq
cat ./het/Ggg.frq |grep -v NA > ./het/Ggg_noNA.frq
Rscript do_het.r


#####inbreeding coefficient#######
plink --file Gbb --het --out ./inbreed/Gbb
plink --file Ggg --het --out ./inbreed/Ggg
plink --file Gbg --het --out ./inbreed/Gbg
plink --file Gbg --het --out ./inbreed/Gbg


##choose chr21 for all individuals
plink --bfile GorgorWholeGenFID --chr 21 --hwe .001 --geno 0.02 --thin 0.15 --maf 0.15 --make-bed --out ../allsample/allsample21.clean
