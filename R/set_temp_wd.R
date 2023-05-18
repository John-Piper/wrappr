#' Sets a temporary working directory for a function argument
#'
#' @param temp_cwd character.  Folder path to temporarily set the working directory
#' @param func function.  A function that used a directory path
#' @param ... Additional arguments to be passed to the param func.
#' @param err_msg character.  Message sent to stop function if an error occurs.
#'
#' @return Unknown.  The return type from the param func.
#'
#' @examples
#' \dontrun{
#'
#' temp_wd <- "example/folder/address/to/change"
#'
#' get_data <- set_temp_wd(temp_wd, read.csv, file = "file.csv")
#'
#' }
#' @export
set_temp_wd <- function(temp_cwd,
                        func,
                        ...,
                        err_msg = "An error has occured in the function set_temp_wd") {

  current_wd <- getwd()

  on.exit(setwd(current_wd))

  tryCatch({

    setwd(temp_cwd)

    return_var <- func(...)

  }, error = function(e) {

    warning(e)

    stop(err_msg, call. = FALSE)

  })

  setwd(current_wd)

  return_var

}
