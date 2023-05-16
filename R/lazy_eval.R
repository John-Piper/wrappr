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

  func <- .f

  return_func <- function(..., .f = NA, overwrite_args = FALSE, return_new_closure = FALSE) {

    new_func_args <- list(...)

    if (length(new_func_args) > 0) {

      if (overwrite_args) {

        current_func_args <- new_func_args

      } else {

        current_func_args <- c(current_func_args, new_func_args)

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

      unlisted_func_args <- unlist(current_func_args, recursive = FALSE)

      new_closure_func <- wrappr::lazy_eval(unlisted_func_args, .f = func)

      warning_msg_new_closure <- paste0("Please be careful returning a new closure function in the current ",
                                        "closure function when using the argument `TRUE` for the param `return_new_closure`.",
                                        "  Unexpected results can occur if the arguments used in the functions params in the param `.f` ",
                                        "use different data types.")

      warning(warning_msg_new_closure)

      return(new_closure_func)

    }

    return_result <- do.call(func, current_func_args)

    return_result

  }

  return_func

}
