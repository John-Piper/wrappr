
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wrappr <img src='man/figures/logo.png' align="right" height="138.5" /></a>

<!-- badges: start -->

[![R-CMD-check](https://github.com/John-Piper/wrappr/workflows/R-CMD-check/badge.svg)](https://github.com/John-Piper/wrappr/actions)
[![Codecov test
coverage](https://codecov.io/gh/John-Piper/wrappr/branch/main/graph/badge.svg)](https://app.codecov.io/gh/John-Piper/wrappr?branch=main)

<!-- badges: end -->

wrappr is a collection of wrapper and helper functions that can add
extra functionality to other functions and support cleaner dry code.

Here is a brief description of some functionality the wrappr package has
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


# Set up a function closure with a function and arguments set up to use later in the code

csv_file_loader <- wrappr::lazy_eval(
                                     file = "some/example/path/file_name_one.csv",
                                     sep = "|,
                                     .f = read.csv
                                     )


# lots of code here

# even more code here

# a little extra code here


# call the function when it is needed in the code

df_one <- excel_file_loader()

# use the same function closure to load the same file but a different sheet

df_two <- csv_file_loader(file = file = "some/example/path/file_name_two.csv")


#-----------------------------------------------------------------------------------------------------


# assign to a variable using a value from an existing variable from the enviroment or create a new value

# This example code will be helpful to use when developing code
# and you require loading a big data file into the environment.

# The read_excel function will only load once if the variable is still in the enviroment scope

df_big_file <- wrappr::get_cache_or_create(
                                           var = "df_big_file",
                                           func = read.csv,
                                           file = "some/example/path/file_name.csv"
                                          )


#-----------------------------------------------------------------------------------------------------


# load and save a file using a temporary working directory to keep the existing working directory

df_example <- wrappr::set_temp_wd(
                    temp_cwd = "temp_wd/load/folder_one/",
                    func = read.csv,
                    file = "example_file.csv"
                    )


# code here to change the df

# saving the file

wrappr::set_temp_wd(
                    temp_cwd = "temp_wd/save/folder_one/",
                    func = write.csv,
                    df_example,
                    file = "df_example.csv"
                    )
                    

#-----------------------------------------------------------------------------------------------------


# write a message to the console before and after a function call saving the output to a variable

output_df <- wrappr::msg_wrap(
                              func = read.csv,
                              path = "path/to/example_workbook.csv",
                              before_func_msg = "Loading the data.",
                              after_func_msg = "The data has loaded..",
                              )
                              

#-----------------------------------------------------------------------------------------------------

```
