
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
to add extra functionality and support cleaner code.

Here is a biref description of some functionality the wrappr package has
to offer:

-   set up functions that can be called later keeping a copy of the
    arguments. Flexibility to update or add arguments and change the
    function to call.  

-   set a temporary working directory to work with a function that deals
    with I/O to maintain the current working directory.

-   Get an existing variable from the environment or create a new
    variable if it does not exist. Great for loading large files once
    when re-running development code.

-   print a messages to the console before and after a function call.

-   Check for new packages to install and load in packages from a
    character vector.

## Installation

You can install the development version of wrappr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("John-Piper/wrappr")
```

## Usage

The examples below show how each function from wrappr could be used to
add functionality

``` r
library(wrappr)


#-----------------------------------------------------------------------------------------------------------

# To install and load in multipal packages

# Packages that are not on cran will not be installed
# Packages already on the host computer will skip installation

packages_to_use <- c("consolechoice", "readxl", "writexl")

wrappr::iter_library(packages_to_use)


#-----------------------------------------------------------------------------------------------------------

# Set up a function closure with a function and arguments set up to use later in the code

excel_file_loader <- wrappr::lazy_eval(
                                       path = "some/example/path/file_name.xlsx",
                                       sheet = "example_sheet",
                                       .f = read_excel
                                        )


# lots of code here

# even more code here

# a little extra code here


# call the function when it is needed in the code

df_example_sheet <- excel_file_loader()

# use the same function closure to load the same file but a different sheet

df_another_sheet <- excel_file_loader(sheet = "another_sheet")


#-----------------------------------------------------------------------------------------------------------

# assign to a variable using a value from an existing variable from the enviroment or create a new value

# This example code will be helpful to use when developing code
# and you require loading a big data file into the environment.

# The read_excel function will only load once if the variable is still in the enviroment scope

df_example_sheet <- wrappr::get_cache_or_create(
                                                var = "df_example_sheet",
                                                func = read_excel,
                                                path = "some/example/path/file_name.xlsx",
                                                sheet = "example_sheet"
                                                )


#-----------------------------------------------------------------------------------------------------------

# load and save a file using a temporary working directory to keep the existing working directory

df_example <- wrappr::set_temp_wd(
                    temp_cwd = "temp_wd/load/folder_one/",
                    func = read_excel,
                    path = "example_workbook.xlsx",
                    sheet = "example_sheet"
                    )


# code here to change the df

# saving the file

wrappr::set_temp_wd(
                    temp_cwd = "temp_wd/save/folder_one/",
                    func = write_xlsx,
                    x = df_example,
                    path = "df_example.xlsx"
                    )
                    

#-----------------------------------------------------------------------------------------------------------

# write a message to the console before and after a function call saving the output to a variable

output_df <- wrappr::msg_wrap(
                              func = read_excel,
                              path = "path/to/example_workbook.xlsx,
                              sheet = "example_sheet",
                              before_func_msg = "Loading the data.",
                              after_func_msg = "The data has loaded..",
                              )


#-----------------------------------------------------------------------------------------------------------

```
