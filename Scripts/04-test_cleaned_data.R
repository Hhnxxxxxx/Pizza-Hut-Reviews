#### Preamble ####
# Purpose: Test the cleaned data.
# Author: Chenyiteng Han
# Data: 1 April 2024
# Contact: chenyiteng.han@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have cleaned data saved.
# Any other information needed? None.

# Load the necessary library for testing
library(testthat)

# Begin tests

test_that("Dataset has correct dimensions", {
  # Ensure the dataset has exactly three columns and a positive number of rows
  expect_equal(ncol(clean_reviews), 4)
  expect_true(nrow(clean_reviews) > 0)
})

test_that("Stars rating is within 1 to 5", {
  # Star ratings should only be integers from 1 to 5
  expect_true(all(clean_reviews$stars >= 1 & clean_reviews$stars <= 5))
})

test_that("Text column contains only 0 or 1", {
  # The text column should only have binary values: 0 or 1
  expect_true(all(clean_reviews$text_indicator %in% c(0, 1)))
})

test_that("Words column is non-negative", {
  # The words column should not have negative values
  expect_true(all(clean_reviews$words >= 0))
})

test_that("No comment means zero words", {
  # If there is no comment (text_indicator = 0), then word count should be zero
  expect_equal(clean_reviews$words[clean_reviews$text_indicator == 0], 0)
})

test_that("Comments have words", {
  # If there is a comment (text_indicator = 1), then word count should be greater than zero
  comment_indices <- which(clean_reviews$text_indicator == 1)
  expect_true(all(clean_reviews$words[comment_indices] > 0))
})

test_that("Word counts are reasonable", {
  # Assuming no comment should exceed a certain limit, e.g., 100 words
  expect_true(all(clean_reviews$words <= 100))
})

test_that("All star ratings are represented", {
  # All star ratings from 1 to 5 should be present in the dataset
  expect_true(all(1:5 %in% unique(clean_reviews$stars)))
})

test_that("Proper handling of NA values", {
  # Ensure that there are no NA values in the dataset
  expect_true(!any(is.na(clean_reviews)))
})

test_that("Comments match words count", {
  # Ensure that the number of words reflects the content of comments
  with_comments <- clean_reviews[clean_reviews$text_indicator == 1, ]
  actual_word_counts <- sapply(with_comments$text, function(comment) str_count(comment, "\\S+"))
  expect_equal(with_comments$words, actual_word_counts)
})

# Execute all tests
test_dir("path/to/test/files") # Specify the path to your test files if they are in a separate directory
