#' Search a Set of Version Numbers
#'
#' This function makes it easy to find a version number by indexing from another
#' version number. This is particularly useful when you want to know, e.g. what
#' the last dev version was before a certain patch version, or what the last
#' minor version was before a certain major version.
#'
#' @param data Existing version numbers to search
#' @param reference The version number to index from - can be given as a
#' character for convenience.
#' @param which The version number part to be cycled through - can either
#' be supplied as a number or one of the part-names as set in
#' `getOption("versionr.parts")`. By default this will be the same as the
#' last version number part of `reference`, giving a more convenient interface.
#' See examples for details.
#' @param increment The number iterations to look forwards/backwards - in most
#' cases this will be -1 to look for the previous version.
#'
#' @return A version number
#' @export
#'
#' @examples
#' data <- version_number("1.0.0", "1.2.0", "1.2.0.1", "2.0.0")
#'
#' # Find the previous dev version
#' search_versions(data, "2.0.0", "dev")
#'
#' # Find the previous patch version
#' search_versions(data, "2.0.0", "patch")
#'
#' # In some cases these will be the same:
#' search_versions(data, "1.2.0", "dev")
#' search_versions(data, "1.2.0", "patch")
#'
#' # If not supplied, the part that gets incremented will be chosen based on
#' # the specificity of the reference number:
#' search_versions(data, "2.0.0.0")
#' search_versions(data, "2.0.0")
#'
#' # You can use different increments, but usually this isn't needed
#' search_versions(data, "2.0.0.0", increment = -2)
#' search_versions(data, "1.0.0", increment = 1)
search_versions <- function(data, reference, which = length(reference[[1]]), increment = -1) {

  if (!all(is_version_number(data))) {
    stop("`data` should have class `'version_number'`")
  }

  if (is.character(reference)) {
    reference <- version_number(reference)
  }

  if (!is_version_number(reference) || length(reference) != 1) {
    stop("`reference` should be a single version number")
  }

  part <- which_version_part(which)
  data <- sort(data)
  data_padded <- pad_version_number(data, part)
  abbr_data <- version_number(.list = lapply(data_padded, function(vn) vn[seq(part)]))
  indices <- vapply(
    seq_along(data),
    function(i) which(sort(unique(abbr_data)) == abbr_data[i]),
    integer(1)
  )

  matches <- data_padded %==% reference

  if (!any(matches)) {
    stop("`reference` has no similar version numbers in `data`")
  }

  reference_index <- indices[matches][1]

  get_index <- which(indices == (reference_index + increment))[1]

  if (length(get_index) == 0 || is.na(get_index)) {
    stop("No such version number exists in search data")
  }

  # Uncomment for checks
  # print(data.frame(
  #   data = data,
  #   abbr_data = abbr_data,
  #   abbr_indices = indices,
  #   return = seq_along(data) == get_index
  # ))

  data[get_index]

}
