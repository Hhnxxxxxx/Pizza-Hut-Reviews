#### Preamble ####
# Purpose: Construct multilevel model.
# Author: Chenyiteng Han
# Data: 1 April 2024
# Contact: chenyiteng.han@mail.utoronto.ca
# License: MIT
# Pre-requisites: Need to know where to get the cleaned dataset.
# Any other information needed? None.

# Load necessary libraries
library(rstanarm)

# Assuming clean_reviews is a data frame already loaded into the environment
# Filtering rows where text_indicator is 1
data_for_model <- subset(clean_reviews, text_indicator == 1)

# Fit a negative binomial model using stan_glm
words_stan_glm <- stan_glm(
  words ~ factor(stars),
  data = data_for_model,
  family = neg_binomial_2(link = "log"),
  prior = normal(location = 0, scale = 3, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 3, autoscale = TRUE),
  seed = 853
)

# Save the model object to an RDS file
saveRDS(words_stan_glm, file = "../Models/words_stan_glm.rds")

# Fit a multilevel negative binomial model using stan_glmer
words_stan_glmer <- stan_glmer(
  words ~ (1 | stars),
  data = data_for_model,
  family = neg_binomial_2(link = "log"),
  prior = normal(location = 0, scale = 3, autoscale = TRUE),
  prior_intercept = normal(location = 0, scale = 3, autoscale = TRUE),
  seed = 853
)

# Save the multilevel model object to an RDS file
saveRDS(words_stan_glmer, file = "../Models/words_stan_glmer.rds")
