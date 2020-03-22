source('./R_functions.r')

# Make an empty data frame to store the results
DF <- data.frame(Pop=rep(NA, 3), Ne_est=rep(NA, 3))

# Calculate
Pops = c('Gbb','Gbg', 'Ggg')

for (index in 1:3){
    POP = Pops[index]
    res = get_Ne(base_path = paste("./", POP,".clean", sep = ''))
    DF[index, ] = c(POP, res$Ne_est)
}
DF
write.table(DF, "./Ne_estimates.txt", sep = '\t', quote = FALSE, row.names = FALSE)
print("Done Ne-estimate")
