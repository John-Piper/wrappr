#' Wraps a message before and/or after a function
#'
#' @param func function.
#' @param ... Additional arguments to be passed into the param func.
#' @param before_func_msg character.
#' @param after_func_msg character.
#' @param print_func function.  The default is print.  Can use related function like message.
#' @param use_msg character.  The default is "both".  Selects which messages to print in the function.  Use `before`, `after`, `both` or `none`.
#' @param print_return_var boolean.  The default is FALSE.  Prints the output from the called func using the print argument from param print_func.
#'
#' @return Unknown.  The return type from the param func.
#'
#' @examples
#'
#' numbers <- c(1,2,3,4,5)
#'
#' answer <- msg_wrap(
#'                    sum,
#'                    numbers,
#'                    before_func_msg = "Currently summing the numbers",
#'                    after_func_msg = "Summing the numbers complete"
#'                    )
#'
#' numbers_with_na <- c(1,2,3,NA,5)
#'
#' answer_na_removed <- msg_wrap(
#'                               sum,
#'                               numbers,
#'                               na.rm = TRUE,
#'                               before_func_msg = "Sum with na.rm set to TRUE",
#'                               use_msg = "before"
#'                               )
#
#'
#' numbers_to_sum <- c(10,20,30)
#'
#' msg_wrap((function(x) sum(x[x%%2 == 1])),
#'          x = numbers_to_sum,
#'          before_func_msg = "Result from sum of odd numbers",
#'          use_msg = "before",
#'          print_return_var = TRUE
#'          )
#'
#' @export
msg_wrap <- function(func,
                     ...,
                     before_func_msg = "",
                     after_func_msg = "",
                     print_func = print,
                     use_msg = "both",
                     print_return_var = FALSE) {

  stopifnot(use_msg %in% c("before", "after", "both", "none"))

  if (any(use_msg == "before", use_msg == "both")) {

    print_func(before_func_msg)

  }

  return_var <- func(...)

  if (print_return_var) {

    print_func(return_var)

  }

  if (any(use_msg == "after", use_msg == "both")) {

    print_func(after_func_msg)

  }

  return_var

}
