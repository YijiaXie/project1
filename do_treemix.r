source("./treemix-1.13/src/plotting_funcs.R")
png("tree_allsample21.png",width=700,height=900)
plot_tree("tree_allsample21")
png("res_allsample21.png",width=600,height=600)
plot_resid("tree_allsample21", "indorder.txt")


png("tree_allfamily21.png",width=700,height=900)
plot_tree("tree_allfamily21")
png("res_allfamily21.png",width=600,height=600)
plot_resid("tree_allfamily21", "poporder.txt")
print("Done treemix")
