
# This script runs the forward simulations given specified outcross and pop sizes supplied by the bash script


# # for bash 
# #!/bin/bash
# 
# input_values=(1 0.25 0.5 0.75 0) #outcross rates
# other_values=(5 10) # pop sizes
# num_cores=4 # set the number of cores to use here
# 
# for i in "${input_values[@]}"
# do
# for j in "${other_values[@]}"
# do
# Rscript my_simulation_script.R $i $j &
#   done
# done
# 
# wait


#to run: 
# chmod +x my_bash_script.sh
# ./my_bash_script.sh



#library('ggplot2')
#library('ggthemes')
library('dplyr')
#library('reshape2')
library('stringr')
library('tidyr')

devtools::source_url("https://github.com/eilishmcmaster/SoS_functions/blob/main/simulate_bottleneck.R?raw=TRUE")

values <- structure(list(value = c(0.272, 0.283, 0.274, 0.313, 0.062, 0.038, 
                                   0.173, 0.141, 0.157, 0.294, 0.062, 0.038), type = c("he", "he", 
                                                                                       "he", "he", "he", "he", "ho", "ho", "ho", "ho", "ho", "ho"), 
                         group = c("pimelea_outgroup", "p_venosa1", "p_venosa2", "zieria_outgroup", 
                                   "z_obco1", "z_obco2", "pimelea_outgroup", "p_venosa1", "p_venosa2", 
                                   "zieria_outgroup", "z_obco1", "z_obco2")), class = "data.frame", row.names = c(NA, 
                                                                                                                  -12L))

# Retrieve the input values from the command line arguments
args <- commandArgs(trailingOnly = TRUE)
outcross <- as.numeric(args[1])
pop_size1 <- as.numeric(args[2])
print(outcross)

generations <- 100
reps <- 1000
pop_size <- rep(pop_size1, reps)
far_out_rate <- 0.0
num_loci <- 1000

# #zieria
He_specified <- values[values$type %in% "he" & values$group %in% "zieria_outgroup", "value"]
Ho_specified <- values[values$type %in% "ho" & values$group %in% "zieria_outgroup", "value"]

He_group1 <- values[values$type %in% "he" & values$group %in% "z_obco1", "value"]
He_group2 <- values[values$type %in% "he" & values$group %in% "z_obco2", "value"]
Ho_group1 <- values[values$type %in% "ho" & values$group %in% "z_obco1", "value"]
Ho_group2 <- values[values$type %in% "ho" & values$group %in% "z_obco2", "value"]


out_list <- simulate_populations(pop_size, outcross,far_out_rate, generations, num_loci, He_specified, Ho_specified)

He_df <- get_generation_df(out_list, 'He')
Ho_df <- get_generation_df(out_list, 'Ho')


write.csv(He_df, file=paste0("/home/eilish/projects/forward_simulations_March23/outputs/zieria_pop_style/dataframes/Z_He_popsize",pop_size1, "_outcross", outcross,"_farout",far_out_rate, "_rep", reps,".csv"))
write.csv(Ho_df, file=paste0("/home/eilish/projects/forward_simulations_March23/outputs/zieria_pop_style/dataframes/Z_Ho_popsize",pop_size1, "_outcross", outcross,"_farout",far_out_rate, "_rep", reps,".csv"))

save(out_list,
     file=paste0("/home/eilish/projects/forward_simulations_March23/outputs/zieria_pop_style/rdata/z_popsize_",pop_size1, "_outcross", outcross,"_farout",far_out_rate, "_rep", reps,".RData"))

