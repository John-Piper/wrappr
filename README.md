
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

-   Set up functions that can be called later keeping a copy of the
    arguments. Flexibility to update or add arguments and change the
    function to call.  

-   Set a temporary working directory to work with a function that deals
    with I/O to maintain the current working directory.

-   Get an existing variable from the environment or create a new
    variable if it does not exist. Great for loading large files once
    when re-running development code.

-   Print a messages to the console before and after a function call.

-   Combine functions into a single function.

## Installation

You can install the development version of wrappr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("John-Piper/wrappr")
```

## Usage

The examples below show how each function from wrappr could be used to
add functionality to other functions.

``` r
library(wrappr)


# Set up a function closure with a function and arguments set up to use later in the code.

csv_file_loader <- wrappr::lazy_eval(
                                     file = "some/example/path/file_name_one.csv",
                                     sep = "|,
                                     .f = read.csv
                                     )


# lots of code here.

# even more code here.

# a little extra code here.


# call the function when it is needed in the code.

df_one <- csv_file_loader()

# use the same function closure to load a different file with the same arguments used previously.

df_two <- csv_file_loader(file = "some/example/path/file_name_two.csv")


#-----------------------------------------------------------------------------------------------------


# Assign to a variable using a value from an existing variable from the environment or create a new value.

# This example code will be helpful to use when developing code
# and you require loading a big data file into the environment.

# The read.csv function in the example below will not load if the variable in the param `var` is still in the environment scope.

df_big_file <- wrappr::get_cache_or_create(
                                           var = "df_big_file",
                                           func = read.csv,
                                           file = "some/example/path/file_name.csv"
                                          )


#-----------------------------------------------------------------------------------------------------


# load and save a file using a temporary working directory to keep the existing working directory.

df_example <- wrappr::set_temp_wd(
                    temp_cwd = "temp_wd/load/folder_one/",
                    func = read.csv,
                    file = "example_file.csv"
                    )


# code here to change the df.

# saving the file.

wrappr::set_temp_wd(
                    temp_cwd = "temp_wd/save/folder_one/",
                    func = write.csv,
                    df_example,
                    file = "df_example.csv"
                    )
                    

#-----------------------------------------------------------------------------------------------------


# write a message to the console before and after a function call saving the output to a variable.

output_df <- wrappr::msg_wrap(
                              func = read.csv,
                              file = "path/to/example_workbook.csv",
                              sep = "|",
                              before_func_msg = "Loading the data.",
                              after_func_msg = "The data has loaded..",
                              )
                              

#-----------------------------------------------------------------------------------------------------


# How to use the package to decorate a function using the main functions from wrappr.


load_data_func <- wrappr::lazy_eval(
                                    file = "data_file.csv",
                                    sep = "|",
                                    .f = read.csv
                                   )

load_data_func_temp_wd <- wrappr::lazy_eval(
  temp_cwd = "temp/working/dir,
  func = load_data_func,
  .f = wrappr::set_temp_wd
)

load_func_with_msg <- wrappr::lazy_eval(
  func = load_data_func_temp_wd,
  before_func_msg = "Loading the data.",
  after_func_msg = "The data has loaded..",
  .f = wrappr::msg_wrap
)

df <- load_func_with_msg()


# using the pipe symbol from the package magrittr to creare the same function.
# `.` symbol used to place the return value from the previous function into the new function.

library(magrittr)

load_data_func_pipe <- wrappr::lazy_eval(
                                    file = "data_file.csv",
                                    sep = "|",
                                    .f = read.csv
                                        ) %>%
                      wrappr::lazy_eval(
                                    temp_cwd = working_directory,
                                    func = .,
                                    .f = wrappr::set_temp_wd
                                       ) %>%
                      wrappr::lazy_eval(
                                    func = .,
                                    before_func_msg = "Loading the data.",
                                    after_func_msg = "The data has loaded..",
                                    .f = wrappr::msg_wrap
                                     )

df_with_pipe <- load_data_func_pipe()


#-----------------------------------------------------------------------------------------------------
```
