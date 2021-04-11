#' Internal vctrs methods
#'
#' @import vctrs
#' @keywords internal
#' @name versionr-vctrs
NULL

#' Create a version number
#'
#' @param x A list
#'
#' @export
new_version_number <- function(x = list()) {
  new_list_of(x, ptype = integer(), class = "version_number")
}

#' Create a version number
#'
#' @param ... Can be either vectors of numbers, character strings or a single
#' character vector
#' @param .list Optionally supply the arguments as a list. Useful for
#' programming
#'
#' @examples
#' version_number("1.2.3.4", c(1, 2, 3, 4))
#' version_number(.list = list("1.0.0", c(1, 0, 0)))
#'
#' @export
version_number <- function(..., .list) {

  x <- if (missing(.list)) list(...) else .list

  if (length(x) == 1 && (is.character(x[[1]]) || is_version_number(x))) {
    x <- as.list(x[[1]])
  }

  if (length(x) > 1) {
    lapply(x, function(element) {
      if (!is.numeric(element) && length(element) > 1) {
        stop("Non-numeric entries should all be length 1. Alternatively, supply
             a single character vector of length >= 1.")
      }
    })
  }

  x <- x[vapply(x, length, integer(1)) > 0]

  new_version_number(vapply(x, as_version_number, new_version_number(list(1))))

}

# Ptypes -------------

#' @export
vec_ptype2.version_number.version_number <- function(x, y, ...) new_version_number()

#' @export
vec_ptype2.version_number.list <- function(x, y, ...) new_version_number()

# Coercion ----------

#' @export
vec_cast.version_number.version_number <- function(x, y, ...) x

#' @export
vec_cast.version_number.list <- function(x, y, ...) version_number(.list = x)

#' Test if an object is a version number
#'
#' @param x Object to test
#'
#' @return Logical
#' @examples
#' is_version_number(version_number("1.0.3.0"))
#' is_version_number("banana")
#'
#' @export
is_version_number <- function(x) {
  inherits(x, "version_number")
}

#' @export
vec_ptype_full.version_number <- function(x, ...) "version_number"

#' @export
vec_ptype_abbr.version_number <- function(x, ...) "vrsn"

#' @export
format.version_number <- function(x, ...) {
  vapply(x, function(x) paste(x, collapse = "."), character(1))
}

#' @export
obj_print_data.version_number <- function(x, ...) {
  if (length(x) == 0) {
    return()
  }
  print(format(x), quote = FALSE)
}

#' @export
as.character.version_number <- function(x, ...) {
  format(x)
}

#' @importFrom pillar pillar_shaft
#' @export
pillar_shaft.version_number <- function(x, ...) {
  pillar::new_pillar_shaft_simple(format(x), align = "left")
}

#' @export
vec_proxy_compare.version_number <- function(x, ...) {

  max_len <- getOption("versionr.max_parts", default = 6)
  max_parts <- max(vapply(x, length, numeric(1)))

  if (max_parts > max_len) {
    stop(sprintf(paste0("Can't compare version numbers with more than %d parts. ",
                        "Please set `options(versionr.max_parts = %d)` to do so."),
                 max_len, max_parts))
  }

  x <- pad_version_number(x, max_len)

  parts <- seq(max_len)
  names(parts) <- paste0("part_", parts)

  transposed <- lapply(parts, function(part) {
    vapply(x, function(vn) vn[part], integer(1))
  })

  as.data.frame(transposed)

}

#' @export
vec_proxy_order.version_number <- vec_proxy_compare.version_number
