#### Preamble ####
# Purpose: Simulate the desired data.
# Author: Chenyiteng Han
# Data: 1 April 2024
# Contact: chenyiteng.han@mail.utoronto.ca
# License: MIT
# Pre-requisites: None.
# Any other information needed? None.

set.seed(123) # Setting seed for reproducibility

# Function to simulate dataset
simulate_pizza_hut_feedback <- function(n = 1000) {
  # Generate random star ratings
  stars <- sample(1:5, size = n, replace = TRUE)
  
  # Initialize text and words columns
  text <- numeric(n)
  words <- numeric(n)
  
  for (i in 1:n) {
    # Assume comments are more likely for ratings of 1 or 5
    if (stars[i] %in% c(1, 5)) {
      text[i] <- rbinom(1, 1, 0.7) # 70% chance of having a comment
    } else {
      text[i] <- rbinom(1, 1, 0.3) # 30% chance of having a comment
    }
    
    # If there is a comment, determine the word count
    if (text[i] == 1) {
      # Assuming longer comments for very positive or negative experiences
      if (stars[i] %in% c(1, 5)) {
        words[i] <- sample(10:100, 1) # Longer comments for 1 or 5 stars
      } else {
        words[i] <- sample(5:50, 1) # Shorter comments for 2-4 stars
      }
    } else {
      words[i] <- 0 # No words if there is no comment
    }
  }
  
  return(data.frame(stars, text, words))
}

# Generate the dataset
dataset <- simulate_pizza_hut_feedback(1000)

# Preview the first few rows of the dataset
head(dataset)
