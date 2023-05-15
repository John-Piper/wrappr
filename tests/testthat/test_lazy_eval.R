library("wrappr")


#########
# Tests #
#########


test_that("wrappr::lazy_eval returns a closure.", {

  test_variable <- wrappr::lazy_eval(1,2,3,4, .f = sum)

  expect_type(test_variable, "closure")


})


test_that("calling the clousure with no arguments will call the original function", {

  test_args_for_func <- c(1,2,3,4)

  test_func <- wrappr::lazy_eval(test_args_for_func, .f = sum)

  test_variable <- test_func()

  test_answer <- sum(test_args_for_func)

  expect_equal(test_variable, test_answer)

})


test_that("calling the clousure with added arguments and function works as expected", {

  orignal_test_args_for_func <- c(7,8,9)

  added_test_args_for_func <- c(1,2,3,4)

  all_test_args <- c(orignal_test_args_for_func, added_test_args_for_func)

  test_func <- wrappr::lazy_eval(7,8,9, .f = sum)

  test_variable_sum <- test_func(added_test_args_for_func)

  test_answer_sum <- sum(all_test_args)

  test_variable_range <- test_func(added_test_args_for_func, .f = range)

  test_answer_range <- range(all_test_args)

  test_variable_min <- test_func(added_test_args_for_func, .f = min)

  test_answer_min <- min(all_test_args)

  test_variable_max <- test_func(added_test_args_for_func, .f = max)

  test_answer_max <- max(all_test_args)

  expect_equal(test_variable_sum, test_answer_sum)

  expect_equal(test_variable_range[1], test_answer_range[1])

  expect_equal(test_variable_range[2], test_answer_range[2])

  expect_equal(test_variable_min, test_answer_min)

  expect_equal(test_variable_max, test_answer_max)

})


test_that("calling the clousure with replaced arguments and function works as expected", {

  orignal_test_args_for_func <- c(7,8,9)

  added_test_args_for_func <- c(1,2,3,4)

  test_func <- wrappr::lazy_eval(7,8,9, .f = sum)

  test_variable_sum <- test_func(added_test_args_for_func, overwrite_args = TRUE)

  test_answer_sum <- sum(added_test_args_for_func)

  test_variable_range <- test_func(added_test_args_for_func, .f = range, overwrite_args = TRUE)

  test_answer_range <- range(added_test_args_for_func)

  test_variable_min <- test_func(added_test_args_for_func, .f = min, overwrite_args = TRUE)

  test_answer_min <- min(added_test_args_for_func)

  test_variable_max <- test_func(added_test_args_for_func, .f = max, overwrite_args = TRUE)

  test_answer_max <- max(added_test_args_for_func)

  expect_equal(test_variable_sum, test_answer_sum)

  expect_equal(test_variable_range[1], test_answer_range[1])

  expect_equal(test_variable_range[2], test_answer_range[2])

  expect_equal(test_variable_min, test_answer_min)

  expect_equal(test_variable_max, test_answer_max)

})


test_that("Updating arguments and returing new closure will still call the expected results", {

  original_args <- c(1,2,3,4)

  new_args <- c(1,8,9)

  combined_args <- c(original_args, new_args)

  original_func <- sum

  new_func <- min

  lazy_func <- wrappr::lazy_eval(original_args, .f = original_func)

  new_lazy_func <- suppressWarnings(lazy_func(new_args, return_new_closure = TRUE))

  expect_type(new_lazy_func, "closure")

  test_result_one <- new_lazy_func()

  expected_result_one <- sum(combined_args)

  expect_equal(test_result_one, expected_result_one)

  added_numbers <- c(1,2,3)

  test_result_two <- new_lazy_func(added_numbers)

  expected_result_two <- sum(c(combined_args, added_numbers))

  expect_equal(test_result_two, expected_result_two)

  test_result_three <- new_lazy_func(added_numbers, overwrite_args = TRUE)

  expected_result_three <- sum(added_numbers)

  expect_equal(test_result_three, expected_result_three)

})


test_that("expected warning message when a non function is passed in the closure function .f param", {

  test_func <- wrappr::lazy_eval(1, 2, .f = sum)

  expect_warning(test_func(.f = "mean"))

  expect_no_warning(test_func(.f = function(...) { print(...) }))

})


test_that("expect an error when the param .f is not explicitly used or the argument in the .f param is not a function", {

  expect_error(wrappr::lazy_eval(1,2, sum))

  expect_error(wrappr::lazy_eval(1,2,3,4, sum))


})


test_that("New param arguments added to the closure function works as expected", {

  values_for_test <- c(1,2, NA)

  test_func <- wrappr::lazy_eval(values_for_test, .f = sum)

  test_results_one <- test_func()

  expected_results_one <- sum(values_for_test)

  expect_equal(test_results_one, expected_results_one)

  test_results_two <- test_func(na.rm = TRUE)

  expected_results_two <- sum(values_for_test, na.rm = TRUE)

  expect_equal(test_results_two, expected_results_two)

  test_result_three <- suppressWarnings(test_func(3,4, return_new_closure = TRUE))

  expected_result_three <- sum(c(values_for_test, 3,4), na.rm = TRUE)

  expect_equal(test_result_three(na.rm = TRUE), expected_result_three)

})


test_that("A warning message is printed to the console when the param `return_new_closure` is set to `TRUE` in the closure function", {

  test_func <- wrappr::lazy_eval(1,2, .f = sum)

  expect_warning(test_func(1,2, return_new_closure = TRUE))

})


test_that("An anonymous can be used in lazy_eval", {

  test_func <- wrappr::lazy_eval("hello", "world", .f = function(word_1, word_2) {paste(word_1, word_2)})

  test_result_one <- test_func()

  expected_result_one <- "hello world"

  expect_equal(test_result_one, expected_result_one)

  test_result_two <- test_func("again", .f = function(...) {paste(...)})

  expected_result_two <- "hello world again"

  expect_equal(test_result_two, expected_result_two)

})

