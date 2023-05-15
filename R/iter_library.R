#' Pass in a character Vector of Package Names to install and load into the Environment.
#'
#' @importFrom utils install.packages installed.packages available.packages
#' @param package_names character vector.  Names of the packages to install and load into the Environment.
#' @param lib_arg NULL or character.  Default to NULL.  Used for the lib param in install.packages
#' @param continue_on_failed_install Boolean.  Stops R if a packages fails to install and parameter is set to FALSE.
#'
#' @return Boolean.  FALSE if no packages are passed into the library function else TRUE.
#'
#' @examples
#'
#' \dontrun{
#'  # Character Vector of packages to load and check to install
#'  packages_to_load <- c("consolechoice", "dplyr", "ggplot2")
#'
#'  iter_library(packages_to_load)
#'
#'  # R can continue working if a new package fails to load
#'  # by setting continue_on_failed_install to TRUE
#'  packages_that_might_not_load <- c("consolechoice", "packageThatDoesNotExist")
#'
#'  iter_library(packages_that_might_not_load, continue_on_failed_install = TRUE)
#'
#' }
#' @export
iter_library <- function(package_names, lib_arg = NULL, continue_on_failed_install = FALSE) {

  package_names_installed <- installed.packages()[, "Package"]

  packages_to_install <- package_names[!(package_names %in% package_names_installed)]

  if (length(packages_to_install) > 0) {

    available_packages <- rownames(available.packages())

    for (i in seq_along(packages_to_install)) {

      package_to_install <- packages_to_install[i]

      # Only install packages that are on CRAN
      if (package_to_install %in% available_packages) {

        install.packages(package_to_install, lib = lib_arg)

      }

      # Checks if new package has been installed.
      has_installed <- package_to_install %in% installed.packages()[, "Package"]

      if (!has_installed) {

        warning(paste(package_to_install, "has not installed and will not be loaded into the Environment."))

        stopifnot(continue_on_failed_install)

        # Removes the package that has not installed so it does not pass in the function library.
        package_names <- package_names[!(package_names %in% packages_to_install)]

      }

    }

  }

  if (length(package_names) == 0) {

    return(FALSE)

  }

  for (i in seq_along(package_names)) {

    library(package_names[i], character.only = TRUE)

  }

  return(TRUE)

}

