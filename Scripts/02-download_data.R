#### Preamble ####
# Purpose: Download the raw data.
# Author: Chenyiteng Han
# Data: 1 April 2024
# Contact: chenyiteng.han@mail.utoronto.ca
# License: MIT
# Pre-requisites: None.
# Any other information needed? None.

# Set the command as a string
command <- "kaggle datasets download -d kanchana1990/pizza-hut-ratings-and-reviews"

# Use the system() function to run the command
system(command, intern = TRUE)
