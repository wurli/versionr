test_that("version comparison works", {

  nums   <- version_number("1.0.2.3", "1.0.0", "2.0.3", "1.0.11.2")
  sorted <- version_number("1.0.0", "1.0.2.3", "1.0.11.2", "2.0.3")

  expect_equal(sort(nums), sorted)

})

test_that("version comparison fails correctly", {

  nums <- version_number("1.0.2.3",  "1.0.0.0.0.0.0")

  expect_error(nums[1] < nums[2], "Can't compare version numbers with more than 6 parts")

})
