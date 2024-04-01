#### Preamble ####
# Purpose: Test the simulated data
# Author: Chenyiteng Han
# Data: 1 April 2024
# Contact: chenyiteng.han@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have simulation done.
# Any other information needed? None.

# Load necessary library
library(testthat)

# Assuming 'dataset' is your dataframe created from the simulation function
# dataset <- simulate_pizza_hut_feedback(1000)

# Begin tests
test_that("Dataset has correct dimensions", {
  # Ensure the dataset has exactly three columns and a positive number of rows
  expect_equal(ncol(dataset), 3)
  expect_true(nrow(dataset) > 0)
})

test_that("Stars rating is within 1 to 5", {
  # Star ratings should only be integers from 1 to 5
  expect_true(all(dataset$stars >= 1 & dataset$stars <= 5))
})

test_that("Text column contains only 0 or 1", {
  # The text column should only have binary values: 0 or 1
  expect_true(all(dataset$text %in% c(0, 1)))
})

test_that("Words column is non-negative", {
  # The words column should not have negative values
  expect_true(all(dataset$words >= 0))
})

test_that("No comment means zero words", {
  # If there is no comment (text = 0), then word count should be zero
  no_comment_indices <- which(dataset$text == 0)
  expect_true(all(dataset$words[no_comment_indices] == 0))
})

test_that("Comments have words", {
  # If there is a comment (text = 1), then word count should be greater than zero
  comment_indices <- which(dataset$text == 1)
  expect_true(all(dataset$words[comment_indices] > 0))
})

test_that("Word counts are reasonable", {
  # Assuming no comment should exceed 100 words in this context
  expect_true(all(dataset$words <= 100))
})

test_that("All star ratings are represented", {
  # All star ratings from 1 to 5 should be present in the dataset
  expect_true(all(1:5 %in% unique(dataset$stars)))
})

test_that("Both 0s and 1s are present in text column", {
  # Ensure there is variability in the dataset with both comments and no comments
  expect_true(all(c(0, 1) %in% unique(dataset$text)))
})

test_that("Average word count differs between extreme and moderate ratings", {
  # Check if comments for extreme ratings (1 or 5 stars) are longer on average than those for moderate ratings (2-4 stars)
  extreme_ratings_avg_words <- mean(dataset$words[dataset$stars %in% c(1, 5)])
  moderate_ratings_avg_words <- mean(dataset$words[dataset$stars %in% 2:4])
  expect_true(extreme_ratings_avg_words > moderate_ratings_avg_words)
})

# Execute all tests
test_dir("path/to/test/files") # Specify the path to your test files if they are in a separate directory
