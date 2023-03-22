library(data.table)
library(stringr)

# set the directory where your rdata files are stored
setwd("/home/eilish/projects/forward_simulations_March23/outputs/zieria_pop_style/rdata")

# create an empty data table to store the results
results <- data.table(name = character(),
                      col_num = numeric(),
                      row_num = numeric(),
                      He_value = numeric())



filenames <- list.files(pattern = "rep1000\\.RData$")

# loop through each rdata file in the directory
for (file_name in 1:length(filenames)){
  
  # load the rdata file
  load(filenames[file_name])
  
  # loop through each column in Ho
  for (replicate in 1:length(out_list$Ho)) {
    
    # get the row numbers where Ho is between 0.062 and 0.038
    valid_generations <- which(out_list$Ho[[replicate]] > 0.038 & out_list$Ho[[replicate]] < 0.062)
    
    # check if any valid rows were found
    if (length(valid_generations) > 0) {
      
      # loop through each valid row
      for (generation in valid_generations) {
        
        # get the corresponding value from He
        He_value <- out_list$He[[replicate]][[generation]]
        
        # get the value from out_list$name
        name <- out_list$name[[replicate]]
        
        # add the results to the data table
       # results <- rbind(results, data.table(name = name, replicate = replicate, generation = generation, He_value = He_value))
      new_row <- data.table(name = name, replicate = replicate, generation = generation, He_value = He_value)
      results <- rbindlist(list(results, new_row), fill = TRUE)
      }
      
    }
    
  }
  rm(out_list)
}

results <- as.data.frame(results)
results[,c("popsize","outcross")] <- str_split_fixed(results$name,"_",2)

# print the results
write.csv(results, "Z_data_for_distributions2.csv")
