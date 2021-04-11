#' Pad version number(s) with zeros
#'
#' @param x Version numbers
#' @param places The number of parts each number should have
#' @param use_na Whether to pad with NA instead of zeros
#' @param warning Warning to use - NULL for no warning
pad_version_number <- function(x, places, warning = NULL, use_na = FALSE) {

  out <- lapply(x, function(vn) {
    if (length(vn) < places) {
      if (!is.null(warning)) warning(warning)
      vn[seq(length(vn) + 1, places)] <- if (use_na) NA_integer_ else 0L
    }
    vn
  })

  if (use_na) out else version_number(.list = out)

}

#' Get the index of a version number part
#'
#' @param which Either an option in `getOption("versionr.parts")` or a number
which_version_part <- function(which) {
  if (is.numeric(which)) {
    stopifnot("`which` must be length 1" = length(which) == 1,
              "`which` must not be NA" = !is.na(which),
              "`which` must be >= 1" = which > 0)
    index <- as.integer(which)
  } else {
    opts <- getOption("versionr.parts")
    which <- match.arg(which, opts)
    index <- which(opts == which)
  }
  index
}
