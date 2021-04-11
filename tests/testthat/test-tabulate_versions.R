test_that("tabulate_versions works", {

  nums <- version_number("1.0.0.0", "2.3.4")
  data <- data.frame(major = c(1L, 2L), minor = c(0L, 3L),
                     patch = c(0L, 4L), dev = c(0L, NA_integer_))

  add_col <- function(d, col) {
    d$full_version <- col
    d[,c("full_version", colnames(data))]
  }

  expect_equal(tabulate_versions(nums), data, ignore_attr = TRUE)
  expect_equal(tabulate_versions(nums, "version_number"), add_col(data, nums), ignore_attr = TRUE)
  expect_equal(tabulate_versions(nums, "character"), add_col(data, format(nums)), ignore_attr = TRUE)

})

test_that("tabulate_versions warns correctly", {

  nums <- version_number("1.0.0.0.0", "2.3.4")
  data <- data.frame(major = c(1L, 2L), minor = c(0L, 3L),
                     patch = c(0L, 4L), dev_1 = c(0L, NA_integer_),
                     dev_2 = c(0L, NA_integer_))

  expect_equal(suppressWarnings(tabulate_versions(nums)), data, ignore_attr = TRUE)
  expect_warning(tabulate_versions(nums), "Unnamed version parts - will name using 'dev_1' etc")

})
