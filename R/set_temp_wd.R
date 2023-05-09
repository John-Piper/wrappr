#' Sets a temporary working directory for a function argument
#'
#' @param temp_cwd character.  Folder path to temporarily set the working directory
#' @param func function.  A function that used a directory path
#' @param ... Additional arguments to be passed to the param func.
#' @param err_msg character.  Message sent to stop function if an error occurs.
#'
#' @return Unknown.  The return type from the param func.
#' @export
#'
#' @examples
#' \dontrun{
#'
#' # open a csv file using a temp working directory
#' temp_wd <- "example/folder/address/to/change"
#'
#' get_data <- set_temp_wd(temp_wd, read.csv, file = "file.csv")
#'
#' }
set_temp_wd <- function(temp_cwd,
                        func,
                        ...,
                        err_msg = "An error has occured in the function use_temp_wd") {

  current_wd <- getwd()

  tryCatch({

    setwd(temp_cwd)

    return_var <- func(...)

  }, error = function(e) {

    warning(e)

    setwd(current_wd)

    stop(err_msg, call. = FALSE)

  })

  setwd(current_wd)

  return_var

}
