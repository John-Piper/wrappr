library("wrappr")


###############
# Tests setup #
###############


cwd_before_tests <- getwd()

test_working_directory <- paste0(cwd_before_tests, "/folder_files_for_tests/")

file_name_to_load_in_test_folder_comma_sep_with_header <- "csv_file_to_load_with_header.csv"

file_name_to_load_in_test_folder_not_comma_sep_without_header <- "csv_tab_file_to_load_without_header.csv"


#--------------------------------------------------------------------------------------------------------------------------------


#########
# Tests #
#########


test_that("Expect the original version of the dataframe in the created enviroment to return on the second run of the wrapper func and not from the function read.csv", {

  setwd(test_working_directory)

  # creating a new environment to work in test_that environment
  test_env <- new.env()

  test_env$original_df <- wrappr::get_cache_or_create("original_df",
                                         func = read.csv,
                                         file = file_name_to_load_in_test_folder_comma_sep_with_header,
                                         fileEncoding = "UTF-8-BOM",
                                         exists_func_args = list(envir = test_env),
                                         get_func_args = list(envir = test_env)
                                         )

  expect_s3_class(test_env$original_df, "data.frame")

  test_env$test_df <- wrappr::get_cache_or_create("original_df",
                                         func = read.csv,
                                         file = file_name_to_load_in_test_folder_not_comma_sep_without_header,
                                         fileEncoding = "UTF-8-BOM",
                                         exists_func_args = list(envir = test_env),
                                         get_func_args = list(envir = test_env)
                                         )

  expect_identical(test_env$original_df, test_env$test_df)

  setwd(cwd_before_tests)

  rm(list = ls(envir = test_env), envir = test_env)

})


test_that("Expect the a different data framw to load from read.csv the second time using the wrapper func after deleting the original created data frame", {

  setwd(test_working_directory)

  # creating a new environment to work in test_that environment
  test_env <- new.env()

  test_env$original_df <- wrappr::get_cache_or_create("original_df",
                                                      func = read.csv,
                                                      file = file_name_to_load_in_test_folder_comma_sep_with_header,
                                                      fileEncoding = "UTF-8-BOM",
                                                      exists_func_args = list(envir = test_env),
                                                      get_func_args = list(envir = test_env)
  )

  rm("original_df", envir = test_env)

  test_env$test_df <- wrappr::get_cache_or_create("original_df",
                                                  func = read.csv,
                                                  file = file_name_to_load_in_test_folder_not_comma_sep_without_header,
                                                  fileEncoding = "UTF-8-BOM",
                                                  exists_func_args = list(envir = test_env),
                                                  get_func_args = list(envir = test_env)
  )

  test_env$original_df <- wrappr::get_cache_or_create("original_df",
                                                      func = read.csv,
                                                      file = file_name_to_load_in_test_folder_comma_sep_with_header,
                                                      fileEncoding = "UTF-8-BOM",
                                                      exists_func_args = list(envir = test_env),
                                                      get_func_args = list(envir = test_env)
  )

  expect_false(identical(test_env$original_df, test_env$test_df))

  setwd(cwd_before_tests)

  rm(list = ls(envir = test_env), envir = test_env)

})


test_that("An error occurs when the inner function fails", {

  expect_error(

    suppressWarnings({

      get_cache_or_create("a", read.csv, "incorrect_file_path.csc")

    })

  )

})

