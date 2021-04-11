test_that("version creation works", {

  nums <- new_version_number(list(c(1, 0, 1, 0), c(1, 0, 0)))

  expect_equal(version_number("1.0.1.0", "1.0.0")                , nums)
  expect_equal(version_number("1.0.1.0", version_number("1.0.0")), nums)
  expect_equal(version_number(c(1, 0, 1, 0), c(1, 0, 0))         , nums)
  expect_equal(version_number(c(1, 0, 1.0, 0), "1.0.0")          , nums)
  expect_equal(version_number(c("1.0.1.0", "1.0.0"))             , nums)
  expect_equal(version_number()                                  , new_version_number())
  expect_equal(version_number(version_number())                  , new_version_number())

})

test_that("version creation fails correctly", {

  expect_error(version_number("1.0.dog"), "Invalid character input '1.0.dog'")
  expect_error(version_number("1.0.0", c("1.1", "1.2")), "Non-numeric entries should all be length 1")
  expect_error(version_number(NA, 1, NA_character_), "Version number parts cannot be NA")
  expect_error(version_number(c(1, NA, 2)), "Version number parts cannot be NA")
  expect_error(version_number(c(1, -1, 2)), "Version number parts cannot be negative")

})
