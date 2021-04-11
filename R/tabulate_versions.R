#' Tabulate version numbers
#'
#' This function expands the parts of a vector of version numbers into
#' a `data.frame` which may be useful, e.g. for moving version numbers
#' to a database.
#'
#' @param x The version numbers to tabulate
#' @param full_version Control how a column is added that contains the full
#' version numbers. Either "version_number" for a `version_number`-class column,
#' "character" for a `character`-class column or "none" to not add a column.
#'
#' @return A `data.frame`
#' @export
#'
#' @examples
#' tabulate_versions(version_number("1.0.0.0", "1.0.1.0"))
#'
#' tabulate_versions(version_number("1.0.0.0", "1.0.1.0"), "version_number")
#'
tabulate_versions <- function(x, full_version = c("none", "version_number", "character")) {

  full_version <- match.arg(full_version)

  max_parts <- max(vapply(x, length, numeric(1)))

  nums <- pad_version_number(x, max_parts, use_na = TRUE)

  parts <- getOption("versionr.parts")
  l <- length(parts)

  if (l < max_parts) {
    last_parts <- paste0(parts[l], "_", seq(l, max_parts) - l + 1)
    parts <- c(parts[seq(l - 1)], last_parts)
    warning(sprintf("Unnamed version parts - will name using '%s' etc", last_parts[1]))
  }

  cols <- seq_along(parts)
  names(cols) <- parts

  out <- lapply(cols, function(i) {
    vapply(nums, function(nums) nums[i], integer(1))
  })

  out <- as.data.frame(out)

  full_version <- switch(
    full_version,
    version_number = if (requireNamespace("tibble", quietly = TRUE)) "version_number" else "character",
    full_version
  )

  full_version_col <- switch(
    full_version,
    version_number = x,
    character = format(x),
    none = NULL
  )

  out$full_version <- full_version_col
  out <- out[,intersect(c("full_version", parts), colnames(out))]

  if (requireNamespace("tibble", quietly = TRUE)) {
    out <- tibble::as_tibble(out)
  }

  out

}

