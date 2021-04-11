
#' Check for rough equality between version numbers
#'
#' Returns a logical vector indicating whether all the present version
#' parts match for two sets of version numbers
#'
#' @param x,y Version numbers
#'
#' @return Logical
`%==%` <- function(x, y) {

  x <- as_version_number(x)
  y <- as_version_number(y)

  if (length(x) == 1 && length(y) > 1) {
    x <- rep(x, length(y))
  }

  if (length(y) == 1 && length(x) > 1) {
    y <- rep(y, length(x))
  }

  if (length(x) != length(y)) {
    stop("Can't recycle `x` and `y` to the same length")
  }

  vapply(
    seq(length(x)),
    function(i) {
      parts <- seq(min(length(x[[i]]), length(y[[i]])))
      all(x[[i]][parts] == y[[i]][parts])
    },
    logical(1)
  )

}
