#### Preamble ####
# Purpose: Construct logistic regression model.
# Author: Chenyiteng Han
# Data: 1 April 2024
# Contact: chenyiteng.han@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to know where to get the cleaned dataset.
# Any other information needed? None.

# Load necessary libraries
library(rstanarm)

# Setting seed for reproducibility, if random processes are involved later
set.seed(853)

# Assuming data is loaded into a dataframe called 'clean_reviews'
# Building the logistic regression model using the entire dataset
# The model will study the relationship between 'text_indicator' and 'stars'
# 'stars' is considered as a numeric predictor in this case

text_stars_model <-
  stan_glm(
    text_indicator ~ factor(stars),
    data = clean_reviews,
    family = binomial(link = "logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

# Saving the model to an RDS file
saveRDS(text_stars_model, file = "../Models/text_stars_model.rds")
