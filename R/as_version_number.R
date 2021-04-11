
#' Coerce to a version number
#'
#' By default this just calls `version_number(x)`
#'
#' @param x The object to coerce
#'
#' @return A version number
#' @export
#'
#' @examples
#'
#' as_version_number("1.0.3.1")
as_version_number <- function(x) {
  UseMethod("as_version_number")
}

#' @export
as_version_number.default <- function(x) {
  new_version_number(list(x))
}

#' @export
as_version_number.version_number <- function(x) {
  x
}

#' @export
as_version_number.list <- function(x) {
  version_number(.list = x)
}

#' @export
as_version_number.character <- function(x) {
  out <- tryCatch(
    as.integer(strsplit(x, "\\.")[[1]]),
    warning = function(w) {
      stop("Invalid character input '", x, "'",
           ". Strings should be point-separated integers, e.g. '1.0.3.1'")
    }
  )
  as_version_number(out)
}

#' @export
as_version_number.integer <- function(x) {

  if (any(is.na(x))) {
    stop("Version number parts cannot be NA")
  }
  if (any(x < 0)) {
    stop("Version number parts cannot be negative")
  }

  new_version_number(list(x))
}

#' @export
as_version_number.double <- function(x) {
  as_version_number(as.integer(x))
}
