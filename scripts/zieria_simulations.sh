#!/bin/bash

input_values=(1 0.25 0.5 0.75 0) #outcross rates
other_values=(5 10) # pop sizes
num_cores=25 # set the number of cores to use here

for i in "${input_values[@]}"
do
for j in "${other_values[@]}"
do
Rscript /home/eilish/projects/forward_simulations_March23/scripts/zieria_simulation.R $i $j &
  done
done

wait
