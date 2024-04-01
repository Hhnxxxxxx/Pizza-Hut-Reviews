#### Preamble ####
# Purpose: Clean the raw data.
# Author: Chenyiteng Han
# Data: 1 April 2024
# Contact: chenyiteng.han@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have raw data downloaded.
# Any other information needed? None.

# Load necessary libraries
library(tidyverse)
library(arrow)

# Read the dataset
reviews <- read_csv("../Data/pizza_hut_reviews.csv")

# Clean the data
clean_reviews <- reviews %>%
  mutate(
    # Add a review_id column as a sequence number
    review_id = row_number(),
    # Replace NA in text column with empty string
    text = replace_na(text, ""),
    # Create a binary column 'text_indicator' based on the presence of comments
    text_indicator = as.integer(text != ""),
    # Count the number of words in the comment
    words = if_else(text_indicator == 1, str_count(text, "\\S+"), 0L)
  ) %>%
  # Rearrange columns to place review_id first
  select(review_id, stars, text_indicator, words)

# Save the cleaned data to a Parquet file
write_parquet(clean_reviews, "../Data/clean_pizza_hut_reviews.parquet")

