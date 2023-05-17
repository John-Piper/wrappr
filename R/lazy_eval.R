#' save and Delay a function call with the option to change the function and args when called
#'
#' @importFrom methods is
#' @param ... Additional arguments to be passed to the param .f.  Also in closure function returned.
#' @param .f function.  A function that will be called when needed.  Also in closure function returned.
#'
#' @return closure function with same function params plus an extra boolean param overwright_args set to FALSE.
#'
#' @examples
#'
#' # perform simple calculations using the same data
#' numbers <- c(1,2,3,4,5)
#'
#' func <- lazy_eval(numbers, .f = sum)
#'
#' sum_result <- func()
#'
#' max_result <- func(.f = max)
#'
#' mean_result <- func(.f = mean)
#'
#' range_result <- func(.f = function(...) { max(...) - min(...)})
#'
#' add_more_num_result <- func(4,5,6, NA, na.rm = TRUE)
#'
#' # overwrite_args set to TRUE will replace the original params for the function
#' new_num_result <- func(4,5,6, NA, na.rm = TRUE, overwrite_args = TRUE)
#'
#' @export
lazy_eval <- function(..., .f) {

  if (!("function" %in% is(.f))) {

    stop("A function is required to be passed into the param `.f` in lazy_eval.")

  }

  current_func_args <- list(...)

  # Check if a list has been passed into the function so it can unlist the top list
  # without removing the original data types.  Required if lazy_eval called via recursion.
  if (length(current_func_args) > 0) {

    if (is.list(current_func_args[[1]])) {

      current_func_args <- current_func_args[[1]]

    }

  }

  func <- .f

  return_func <- function(..., .f = NA, overwrite_args = FALSE, return_new_closure = FALSE) {

    new_func_args <- list(...)

    if (length(new_func_args) > 0) {

      if (overwrite_args) {

        current_func_args <- new_func_args

      } else {

        names_of_new_func_args <- names(new_func_args)

        for (name in names_of_new_func_args) {

          if (name %in% names(current_func_args)) {

            current_func_args[[name]] <- new_func_args[[name]]

            new_func_args[[name]] <- NULL

          }

        }

        if (length(new_func_args) > 0 ) {

          current_func_args <- c(current_func_args, new_func_args)

        }

      }

    }

    if("function" %in% is(.f)) {

      func <- .f

    } else if(!is.na(.f)) {

      current_function_name <- deparse(func)

      warning_msg_non_func_arg <- paste0(
                            "A function was not passed into the closure function param `.f`",
                            "  The original function `", current_function_name, "` that was used ",
                            "in lazy_eval function call has been used instead."
                            )

      warning(warning_msg_non_func_arg, call. = FALSE)

    }

    if (return_new_closure) {

      return(wrappr::lazy_eval(current_func_args, .f = func))

    }

    return(do.call(func, current_func_args))

  }

  return_func

}
