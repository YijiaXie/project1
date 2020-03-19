# project1
gorilla

进度：

已经完成PCA（没有删除LD），admixture，fst，inbreedingcoefficient，het，

卡住的是 LD，Ne

正在进行treemix


##### 一些解释部分#####

关于PCA使用LD的解释:

Additionally, **individuals found to be very closely related to another on the basis of shared sequence analysis (Supplementary section 10) were also removed.** For the two within-species analyses, the resulting variant sites were pruned to remove all pairs in linkage disequilibrium (LD) with an R2 correlation coefficient of 0.5 or greater. In the eastern species PCA this stringent threshold left 21,921 sites, and in the western species 51,393 sites. 

**The LD pruning procedure was not carried out for the all-sample PCA across both species, to avoid excluding sites corresponding to fixed differences between the species**; as a result a much larger number of sites, 11,780,090, were included.


关于treemix的参考文献
在教程的最后：
http://gensoft.pasteur.fr/docs/treemix/1.12/treemix_manual_10_1_2012.pdf
其他参考文献：
https://www-tandfonline-com.ep.fjernadgang.kb.dk/doi/full/10.1080/14772000.2017.1359215  有类似图
https://airbugs.pixnet.net/blog/post/41859895
