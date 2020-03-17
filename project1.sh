#date=0317
awk '{print $1,$2}' GorgorWholeGen.ped   #check the subspecies information of griollas

nano sampleID.txt # picked 4 individuals of each subspecies

Gbb-N010_Turimaso Gbb-N010_Turimaso
Gbg-9732_Mkubwa Gbg-9732_Mkubwa
Ggd-B646_Nyango Ggd-B646_Nyango
Ggg-B647_Anthal Ggg-B647_Anthal


#make bed file for whole genome file of all individuals
plink --file GorgorWholeGen --make-bed --out GorgorWholeGen 
#pick the whole genomen of 4 individuals we want
plink --bfile GorgorWholeGen --noweb --keep sampleID.txt --recode --out ../datatest21/test10
#make bed file for whole genome file of 4 individuals we want 
plink --file testdata --make-bed --out test10
#pick chromosome 21 of 4 individuals 
plink --bfile testdata --chr 21 --out test21

#########END###########
