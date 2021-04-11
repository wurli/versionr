test_that("search_versions works", {

  data <- version_number("1.0.0", "1.2.0", "1.2.0.1", "2.0.0")

  expect_equal(search_versions(data, "2.0.0.0"), version_number("1.2.0.1"))
  expect_equal(search_versions(data, "2.0.0"), version_number("1.2.0"))
  expect_equal(search_versions(data, "2.0.0", increment = -2), version_number("1.0.0"))
  expect_equal(search_versions(data, "2.0.0.0", increment =  -2), version_number("1.2.0"))
  expect_equal(search_versions(data, "1.0", "dev", 1), version_number("1.2.0"))

})

test_that("search_versions fails correctly", {

  data <- version_number("1.0.0", "1.2.0", "1.2.0.1", "2.0.0")

  expect_error(search_versions(data, "1.0.0.1"), "`reference` has no similar")
  expect_error(search_versions(data, "1.0.0"), "No such version number exists")
  expect_error(search_versions(data, "1.2.0", increment = 2), "No such version number exists")

})
