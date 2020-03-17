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
#pick chromosome 21 of 9 individuals 
plink --bfile test10 --chr 21 --out 待定

#########END###########

