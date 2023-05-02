#' checks if variable exists in enviroment and returns back or creates a new variable
#'
#' @param var character.  The name of the variable to check in the global environment.
#' @param func function.  A function that returns a value.
#' @param ... Additional arguments to be passed to the param func.
#' @param warning_msg character.  Message sent to stop function if an error occurs.
#'
#' @return Unknown.  The return type from the param func or the existing variable in global enviroment.
#' @export
#'
#' @examples
#'
#' # A simple created dataframe with 2 columns
#'
#' df <- data.frame(col_1 = c("a","b","c"), col_2 = c(1,2,3))
#'
#' # check if the variable `df` is already created and return the current value
#' # in the variable saved in the global environment or create an empty data frame
#'
#'
#'
#' df <- get_cache_or_create(
#'                           "df",
#'                           function() data.frame(col_1 = NA_Character_, col_2 = NA_integer_)
#'                           )
#'
#' # same check for df_2.  empty data frame returned because df_2 is not in global environment
#'
#' df_2 <- get_cache_or_create(
#'                           "df_2",
#'                           function() data.frame(col_1 = NA_character_, col_2 = NA_integer_)
#'                           )
#'
get_cache_or_create <- function(
                                var,
                                func,
                                ...,
                                warning_msg = NA_character_
                                ) {

  if (!exists(var)) {

    tryCatch({

    return_var <- func(...)

    }, error = function(e) {

      if (!is.na(warning_msg)) {

        warning(warning_msg)

      }

      stop(e$message)

    }
    )

  } else {

    return_var <- get(var)

  }

  return_var

}
