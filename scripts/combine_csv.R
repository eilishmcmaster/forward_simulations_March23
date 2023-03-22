

# This script takes the csv outputs from the simulations and combines them. The csvs are the average values per generation for that scenario.
# This script returns a Ho and a He CSV which can then be used to plot average heterozygosity over n generations.  


# set the directory where your csv files are stored
setwd("/home/eilish/projects/forward_simulations_March23/outputs/zieria_pop_style/dataframes")

# get a list of all csv files in the directory
filenames <- list.files(pattern = "^Z.*\\.csv$")

datatypes <- c("He","Ho")

for(i in 1:length(datatypes)){
  # filter the filenames to only include those that contain "He" in their name
  filenames_filtered <- grep(datatypes[i], filenames, value = TRUE)
  # use lapply to read each csv file into a list of data frames
  data_list <- lapply(filenames_filtered, read.csv)
  # combine all the data frames into a single data frame using rbind
  combined_data <- do.call(rbind, data_list)
  write.csv(combined_data, paste0(datatypes[i],"_combined_df.csv"))
}
