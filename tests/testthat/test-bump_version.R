test_that("bumping works", {
  nums <- version_number("1.0.0.0.0.0", "2.3.4")

  expect_equal(bump_version(nums[1],       1, 1), version_number("2.0.0.0.0.0"))
  expect_equal(bump_version(nums[1], "minor", 2), version_number("1.2.0.0.0.0"))

  expect_equal(suppressWarnings(bump_version(nums[2], 5, 0)), version_number("2.3.4.0.0"))
  expect_equal(bump_version(nums[2], 2, -2), version_number("2.1.0"))

})

test_that("bumping fails correctly", {
  nums <- version_number("1.0.0.0.0.0", "2.3.4")

  expect_error(bump_version(nums[1],       1, -2), "Version number parts cannot be negative")
  expect_error(bump_version(nums[1], "minor", -1), "Version number parts cannot be negative")

})
