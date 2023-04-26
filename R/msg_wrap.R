#' Wraps a message before and after a function
#'
#' @param before_func_msg character.
#' @param after_func_msg character.
#' @param func function
#' @param ... Additional arguments to be passed to the param func.
#' @param print_func function the default is print.  Can use related function like message.
#' @param use_msg character.  Selects which messages to print in the function.  Use `before`, `after` or `both`.
#'
#' @return Unknown.  The return type from the param func.
#' @export
#'
#' @examples
#' 
#' library(wrappr)
#' 
#' numbers <- c(1,2,3,4,5)
#'
#' # wrapping a message before and after the sum function
#' answer <- msg_wrap(
#'                    sum,
#'                    numbers,
#'                    before_func_msg = "Currently summing the numbers",
#'                    after_func_msg = "Summing the numbers complete"
#'                    )
#' 
#' numbers_with_na <- c(1,2,3,NA,5)
#' 
#' # Summing with message only at start and NA removed
#' answer_na_removed <- msg_wrap(
#'                               sum,
#'                               numbers,
#'                               na.rm = TRUE,
#'                               before_func_msg = "Sum with na.rm set to TRUE",
#'                               use_msg = "before"
#'                               )
msg_wrap <- function(func, ..., 
                     before_func_msg = "", 
                     after_func_msg = "", 
                     print_func = print,
                     use_msg = "both") {
  
  stopifnot(use_msg %in% c("before", "after", "both"))
  
  if (any(use_msg == "before", use_msg == "both")) {
    
    print_func(before_func_msg)  
    
  }
  
  return_var <- func(...)
  
  if (any(use_msg == "after", use_msg == "both")) {
    
    print_func(after_func_msg)
    
  }
  
  return_var
  
}