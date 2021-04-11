#' Get a Version Number Part
#'
#' This is useful for checking the value of a certain part of a version
#' number, and is particularly useful when filtering datasets with a
#' version number column. If a part is not present, `NA` will be returned.
#'
#' @param x Version numbers
#' @param which The part to get - either as a string or a number
#'
#' @return An integer vector
#' @export
#'
#' @examples
#' nums <- version_number("1.0.0", "1.0.0.1", "1.0.0.2", "1.2.0", "2.0.0")
#'
#' # Specify the part to get using a string or a number
#' version_part(nums, "dev")
#' version_part(nums, 4)
#' version_part(nums, "major")
#'
#' # Filter datasets
#' if (require(dplyr, quietly = TRUE)) {
#'
#'   version_desc <- c("It's alive!", "Tweak to balancing", "Bug fix",
#'                     "Can do flips", "Complete rework")
#'
#'   # Get the numbers as a data.frame
#'   data <- tibble(versions = nums, version_desc = version_desc)
#'   data
#'
#'}
#'
#' # Filter for dev versions
#' if (require(dplyr, quietly = TRUE)) {
#'   data %>%
#'     filter(!is.na(version_part(versions, "dev")))
#' }
#'
#' # Filter for major version 1
#' if (require(dplyr, quietly = TRUE)) {
#'   data %>%
#'     filter(version_part(versions, "major") == 1)
#' }
version_part <- function(x, which = getOption("version.parts")) {

  which <- which_version_part(which)

  x <- pad_version_number(x, which, use_na = TRUE)

  vapply(x, function(x) as.integer(x[which]), integer(1))

}
