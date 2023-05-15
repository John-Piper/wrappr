library(wrappr)


###############
# Tests setup #
###############


not_a_cran_package_name <- "not_a_package_name_on_cran"


#########
# Tests #
#########

#
# test_that("iter_library returns false when a invalid library trys to install and continue_on_failed_install = TRUE", {
#
#   return_result <- suppressWarnings(wrappr::iter_library(not_a_cran_package_name, continue_on_failed_install = TRUE))
#
#   expect_false(return_result)
#
# })


test_that("iter_library has an error when an invalid library trys to install.", {

  expect_error(SuppressWarnings(wrappr::iter_library(not_a_cran_package_name)))

})


test_that("iter_library has an error when no arguments for package_names is passed in the function.", {

  expect_error(wrappr::iter_library())

})
