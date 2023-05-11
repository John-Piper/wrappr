
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wrappr <img src='man/figures/logo.png' align="right" height="138.5" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/John-Piper/wrappr/workflows/R-CMD-check/badge.svg)](https://github.com/John-Piper/wrappr/actions)
[![CRAN
status](https://www.r-pkg.org/badges/version/wrappr)](https://CRAN.R-project.org/package=wrappr)
[![Codecov test
coverage](https://codecov.io/gh/John-Piper/wrappr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/John-Piper/wrappr?branch=main)

<!-- badges: end -->

wrappr is a collection of wrapper functions to use on other R functions
to add extra functionality and maintain clean code.

Here is a biref description of some functionality wrappr has to offer:

-   set a temporary working directory to work with a function that deals
    with I/O and maintain the current working directory.

-   Get an existing variable from the enviroment or create a new
    variable if it does not exist. Great for loading big files once when
    re-running development code.

-   print a messages to the console before and after a function call.

## Installation

You can install the development version of wrappr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("John-Piper/wrappr")
```

## Usage
