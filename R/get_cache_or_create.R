#' checks if variable exists in enviroment and returns back or creates a new variable
#'
#' @param var character.  The name of the variable to check in the global enviroment.
#' @param func function.  A function that returns a value. 
#' @param ... Additional arguments to be passed to the param func.
#' @param err_msg character.  Message sent to stop function if an error occurs.
#'
#' @return Unknown.  The return type from the param func or the existing variable in global enviroment.
#' @export
#'
#' @examples
get_cache_or_create <- function(
                                var, 
                                func, 
                                ..., 
                                err_msg = "An error has occured in the function get_cache_or_create"
                                ) {
  
  if (!exists(var)) {
    
    tryCatch({
    
    return_var <- func(...)
    
    }, error <- function(e) {
    
      warning(e)
      
      stop(err_msg)
      
    }
    )
    
  } else {
    
    return_vae <- var
    
  }
  
  return_var
  
}