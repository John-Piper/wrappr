#' Delay a function call until you need to call it
#'
#' @param func function.  A function that will be called when evoked later
#' @param ... Additional arguments to be passed to the param func.
#'
#' @return function
#'
#' @examples
#' \dontrun{
#' # Setup to load a csv file
#'
#' load_file_two <- TRUE
#'
#' csv_one <- lazy_eval(
#'                      read.csv,
#'                      file = "file/address/of/file_one.csv
#'                     )
#'
#' csv_two <- lazy_eval(
#'                      read.csv,
#'                      file = "file/address/of/file_two.csv
#'                     )
#'
#' data <- ifelse(load_file_two, csv_one(), csv_two())
#' }
#'
#' @export
lazy_eval <- function(func, ...) {

  return_func <- function() {

    return_value <- func(...)

    return_value

  }

  return_func

}

