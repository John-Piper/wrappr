#' Checks if variable exists in environment and returns back or creates a new variable
#'
#' @param var character.  The name of the variable to check in the global environment.
#' @param func function.  A function that returns a value.
#' @param ... Additional arguments to be passed to the param func.
#' @param exists_func_args list.  A list of arguments to use in base::exists.
#' @param get_func_args list.  A list of arguments to use in bass::get.
#' @param warning_msg character.  Message sent to stop function if an error occurs.
#'
#' @return Unknown.  The return type from the param func or the existing variable in global environment.
#'
#' @examples
#' \dontrun{
#' df <- data.frame(col_1 = c("a","b","c"), col_2 = c(1,2,3))
#'
#' create_blank_df <- function() {
#'
#'     data.frame(col_1 = NA_character_, col_2 = NA_integer_)
#'
#'     }
#'
#' df_1 <- get_cache_or_create(
#'                           "df",
#'                           create_blank_df
#'                           )
#'
#' df_2 <- get_cache_or_create(
#'                           "df_2",
#'                           create_blank_df
#'                           )
#' }
#' @export
get_cache_or_create <- function(
                                var,
                                func,
                                ...,
                                exists_func_args = NA,
                                get_func_args = NA,
                                warning_msg = NA_character_
                                ) {

  if (is.list(exists_func_args)) {

    exists_func_args$x <- var

    var_exists <- do.call(exists, exists_func_args)

    } else {

      var_exists <- exists(var)

    }

  if (!var_exists) {

    tryCatch({

    return_var <- func(...)

    }, error = function(e) {

      if (!is.na(warning_msg) & is.character(warning_msg)) {

        warning(warning_msg)

      }

      stop(e$message, call. = FALSE)

    }
    )

  } else {

    if (is.list(get_func_args)) {

      get_func_args$x <- var

      return_var <- do.call(get, get_func_args)

    } else {

    return_var <- get(var)

    }

  }

  return_var

}
