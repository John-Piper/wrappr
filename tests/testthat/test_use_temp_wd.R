library("wrappr")


##################
# Variable setup #
##################


cwd_before_tests <- getwd()

test_working_directory <- paste0(cwd_before_tests, "/folder_files_for_tests/")

file_name_to_load_in_test_folder_comma_sep_with_header <- "csv_file_to_load_with_header.csv"

file_name_to_load_in_test_folder_not_comma_sep_without_header <- "csv_tab_file_to_load_without_header.csv"

test_one_expected_df <- data.frame(Index = 1:5, Name = c("A", "B", "C", "D", "E"), Age = c(23,60,34,56,84))

test_two_expected_df <- data.frame(Col1 = 1:5, Col2 = c("A", "B", "C", "D", "E"), Col3 = c(23,60,34,56,84))





#--------------------------------------------------------------------------------------------------------------------------------


############
# test One #
############


test_that("Expect the working directory to be the same from before and after the wrapper function and expected df is returned.", {

  setwd(cwd_before_tests)

  return_value_from_wrappr_call <- wrappr::use_temp_wd(
                                                      temp_cwd = test_working_directory,
                                                      func = read.csv,
                                                      file = file_name_to_load_in_test_folder_comma_sep_with_header,
                                                      fileEncoding = "UTF-8-BOM"
                                                      )

  cwd_after_wrapper_func_call <- getwd()

  expect_equal(cwd_before_tests, cwd_after_wrapper_func_call)

  expect_false(test_working_directory == cwd_after_wrapper_func_call)

  expect_s3_class(return_value_from_wrappr_call, "data.frame")

  expect_equal(return_value_from_wrappr_call, test_one_expected_df)

})




test_that("The different arguments for dot dot dot (...) work as expected.", {

  return_value_from_wrappr_call <- wrappr::use_temp_wd(
    temp_cwd = test_working_directory,
    func = read.csv,
    file = file_name_to_load_in_test_folder_not_comma_sep_without_header,
    header = FALSE,
    col.names = c("Col1", "Col2", "Col3"),
    sep = "|"
  )

  expect_s3_class(return_value_from_wrappr_call, "data.frame")

  expect_equal(return_value_from_wrappr_call, test_two_expected_df)





})


test_that("Expect no errors when running the wrapper function.", {

  expect_no_error(
    wrappr::use_temp_wd(
                      temp_cwd = test_working_directory,
                      func = read.delim,
                      file = file_name_to_load_in_test_folder_comma_sep_with_header,
                      sep = ",",
                      fileEncoding = "UTF-8-BOM"
                      )
    )

})
