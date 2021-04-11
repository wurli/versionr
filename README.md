
<!-- README.md is generated from README.Rmd. Please edit that file -->

# {versionr} Package

<!-- badges: start -->
<!-- badges: end -->

{versionr} is a lightweight package designed to remove the friction of
working with version numbers in R. The main benefit of `versionr` is the
[vctrs](https://vctrs.r-lib.org/)-powered S3 class `version_number`.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("wurli/versionr")
```

## Create Version Numbers

Version numbers can be created using characters or numeric vectors, and
can have arbitrary numbers of parts

``` r
library(versionr)

version_number("1.0.0", "1.0.1")
#> <version_number[2]>
#> [1] 1.0.0 1.0.1
version_number(c(1, 0, 0, 0), c(1, 0, 0, 1))
#> <version_number[2]>
#> [1] 1.0.0.0 1.0.0.1
```

## Sorting

A main benefit of {versionr} is easy version comparison and sorting

``` r
nums <- version_number("1.0.0", "1.0.11", "1.0.2", "2.0.0.1")

# 1.0.11 should come after 1.0.2:
nums[2] > nums[3]
#> [1] TRUE

# Sorting is easy:
sort(nums)
#> <version_number[4]>
#> [1] 1.0.0   1.0.2   1.0.11  2.0.0.1
```

## Bumping

Version numbers can be easily ‘bumped’ using `bump_version()`:

``` r
bump_version(nums, "patch")
#> <version_number[4]>
#> [1] 1.0.1   1.0.12  1.0.3   2.0.1.0
bump_version(nums, "major")
#> <version_number[4]>
#> [1] 2.0.0   2.0.0   2.0.0   3.0.0.0
```

## Accessing Version Parts

Version numbers are vectors, and you can easily access particular parts
using `version_part()`:

``` r
version_part(nums, "minor")
#> [1] 0 0 0 0
version_part(nums, "dev")
#> [1] NA NA NA  1
```

## Implementation

Behind the scenes, version numbers are just vectors of integers wrapped
in a list:

``` r
unclass(nums)
#> [[1]]
#> [1] 1 0 0
#> 
#> [[2]]
#> [1]  1  0 11
#> 
#> [[3]]
#> [1] 1 0 2
#> 
#> [[4]]
#> [1] 2 0 0 1
#> 
#> attr(,"ptype")
#> integer(0)
```

…This makes intuitive subsetting possible:

``` r
nums[[3]][4]
#> [1] NA
```
