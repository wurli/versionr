% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/vctrs.R
\name{is_version_number}
\alias{is_version_number}
\title{Test if an object is a version number}
\usage{
is_version_number(x)
}
\arguments{
\item{x}{Object to test}
}
\value{
Logical
}
\description{
Test if an object is a version number
}
\examples{
is_version_number(version_number("1.0.3.0"))
is_version_number("banana")

}
