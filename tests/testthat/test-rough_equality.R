test_that("rough_equality works", {

  nums <- version_number("1.0", "1.0.1.1", "1.0.1.2", "1.1.0.0")

  expect_equal(nums %==% nums[1], c( TRUE,  TRUE,  TRUE, FALSE))
  expect_equal(nums %==%   "1.0", c( TRUE,  TRUE,  TRUE, FALSE))
  expect_equal(nums %==% nums[2], c( TRUE,  TRUE, FALSE, FALSE))
  expect_equal(nums %==% nums[3], c( TRUE, FALSE,  TRUE, FALSE))
  expect_equal(nums %==% nums[4], c(FALSE, FALSE, FALSE,  TRUE))
  expect_equal(nums %==% nums[c(1, 2, 4, 3)], c(TRUE, TRUE, FALSE, FALSE))

})

test_that("rough_equality fails correctly", {

  nums <- version_number("1.0", "1.0.1.1", "1.0.1.2", "1.1.0.0")

  expect_error(nums[1:2] %==% nums[1:3], "Can't recycle `x` and `y` to the same length")
  expect_error(nums %==% version_number(), "Can't recycle `x` and `y` to the same length")
  expect_error(nums %==% "pear", "Invalid character input")

})
