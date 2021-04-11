#' Bump a Version Number
#'
#' @param x Version numbers to bump
#' @param which Either a number indicating the part to bump or one of the
#' parts as specified in `getOption("versionr.parts")` - defaults are
#' "major", "minor", "patch" and "dev"
#' @param n The amount to increment the version number part by - will almost
#' always be 1
#'
#' @return A list of version numbers
#' @export
#' @examples
#' nums <- version_number("1.0.0.0", "2.0")
#' bump_version(nums)
#'
bump_version <- function(x, which = getOption("versionr.parts"), n = 1) {

  index <- which_version_part(which)

  x <- pad_version_number(
    x, index,
    "Part to bump not found in version number - missing parts will be added"
  )

  out <- lapply(x, function(vn) {

    n_parts <- length(unlist(vn))
    vn[index] <- vn[index] + n
    if (n_parts > index) {
      vn[seq(index + 1, n_parts)] <- 0
    }
    vn

  })

  version_number(.list = out)

}

