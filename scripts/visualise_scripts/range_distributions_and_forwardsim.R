
library(ggplot2)
library(ggthemes)
library(ggpubr)

values <- structure(list(value = c(0.272, 0.283, 0.274, 0.313, 0.282, 0.347, 
                                   0.173, 0.141, 0.157, 0.294, 0.062, 0.038), type = c("he", "he", 
                                                                                       "he", "he", "he", "he", "ho", "ho", "ho", "ho", "ho", "ho"), 
                         group = c("pimelea_outgroup", "p_venosa1", "p_venosa2", "zieria_outgroup", 
                                   "z_obco1", "z_obco2", "pimelea_outgroup", "p_venosa1", "p_venosa2", 
                                   "zieria_outgroup", "z_obco1", "z_obco2")), class = "data.frame", row.names = c(NA, 
                                                                                                                  -12L))

He_specified <- values[values$type %in% "he" & values$group %in% "zieria_outgroup", "value"]
Ho_specified <- values[values$type %in% "ho" & values$group %in% "zieria_outgroup", "value"]

He_group1 <- values[values$type %in% "he" & values$group %in% "z_obco1", "value"]
He_group2 <- values[values$type %in% "he" & values$group %in% "z_obco2", "value"]
Ho_group1 <- values[values$type %in% "ho" & values$group %in% "z_obco1", "value"]
Ho_group2 <- values[values$type %in% "ho" & values$group %in% "z_obco2", "value"]

setwd('/Users/eilishmcmaster/Documents/forward_simulations_March23/outputs/zieria_pop_style')
# read in the he values for given ho extracted using the scrape script 
df <- read.csv("rdata/farout_0/Z_distributions_farout_0.csv")

# # create a ggplot object with the data
ggplot(data = df, aes(x = He_value)) +
  # add a histogram layer
  geom_histogram(binwidth = 0.01) +
  # facet by popsize and outcross
  facet_grid(popsize ~ outcross) +
  # add x-axis and y-axis labels
  xlab("Expected heterozygosity (He)") +
  ylab("Count")+ theme_few()+ geom_vline(xintercept=c(He_group1, He_group2), color="red", linetype="dotted")+
  # scale_y_continuous(limits=c(0,1000), expand = c(0, 0))+
  scale_x_continuous(limits=c(0,0.39), expand = c(0, 0))#+
  # theme(axis.text.x = element_text(hjust=0))
  


# read in the combined average scripts 

He_df <- read.csv("dataframes/farout_0/He_combined_df.csv")
Ho_df <- read.csv("dataframes/farout_0/Ho_combined_df.csv")



Ho_plot <- ggplot(Ho_df, aes(x=generations, y=Ho, groups=factor(popsize_outcrossrate),color=factor(outcross)))+
  geom_point(size=0.5)+
  geom_line()+
  theme_few()+
  geom_hline(yintercept = c(Ho_group1, Ho_group2), linetype="dotted")+ # z obco
  geom_text(aes(y = Ho_group1, x=85, label= 'Z.O. 1 Ho'), hjust= 0.15, vjust = -0.7, size= 3, color= "black", family="sans", check_overlap=TRUE) +
  geom_text(aes(y = Ho_group2, x=85, label= 'Z.O. 2 Ho'), hjust= 0.15, vjust = -0.7, size= 3, color= "black", family="sans", check_overlap=TRUE) +
  geom_hline(yintercept = Ho_specified, color="blue", linetype='dotted')+
  geom_text(aes(y = Ho_specified, x=85, label= 'Starting pop. Ho'), hjust= 0.15, vjust = -0.7, size= 3, color= "blue", family="sans", check_overlap=TRUE) +
  geom_hline(yintercept = He_specified, color="red", linetype='dotted')+
  geom_text(aes(y = He_specified, x=85, label= 'Starting pop. He'), hjust= 0.15, vjust = -0.7, size= 3, color= "red", family="sans", check_overlap=TRUE) +
  facet_wrap(popsize~., drop=FALSE)+
  scale_color_brewer(palette="Set2")+
  labs(x="Generation", color="Outcross rate")+
  expand_limits(y=c(0, He_specified+0.02))
  # geom_smooth(se=FALSE)




He_plot <- ggplot(He_df, aes(x=generations, y=He, groups=factor(popsize_outcrossrate),color=factor(outcross)))+
  geom_point(size=0.5)+
  geom_line()+
  theme_few()+
  geom_hline(yintercept = c(He_group1, He_group2), linetype="dotted")+ # z obco
  geom_text(aes(y = He_group1, x=85, label= "Z.O. 1 He"), hjust= 0.15, vjust = 1, size= 3, color= "black", family="sans", check_overlap=TRUE) +
  geom_text(aes(y = He_group2, x=85, label= "Z.O. 2 He"), hjust= 0.15, vjust = 1, size= 3, color= "black", family="sans", check_overlap=TRUE) +
  geom_hline(yintercept = He_specified, color="red", linetype='dotted')+
  geom_text(aes(y = He_specified, x=85, label= 'Starting pop. He'), hjust= 0.15, vjust = 1, size= 3, color= "red", family="sans", check_overlap=TRUE) +
  facet_wrap(popsize~., drop=FALSE)+
  scale_color_brewer(palette="Set2")+
  labs(x="Generation", color="Outcross rate")+
  expand_limits(y=c(0, He_specified+0.02))
  # geom_smooth(se=FALSE)

# library(ggpubr)
ggarrange(Ho_plot, He_plot, align='hv', nrow=2, common.legend = TRUE, legend='bottom')











