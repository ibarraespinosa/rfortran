#' Defines numeric types
#'
#' @description \code{get_threads} check the number of threads in this machine
#'
#' @return Integer with the maxnumber of threads
#'
#' @useDynLib rfortran
#' @export
#' @examples {
#' get_threads()
#' }
get_types <- function() {
 a <- .Fortran("base_types",
           idpx = integer(1L),
           spx = integer(1L),
           dpx = integer(1L))

 cat("selected_int_kind(13): ", a$idx, "\n")
 cat("selected_real_kind(p=6,r=37): ", a$spx, "\n")
 cat("selected_real_kind(p=15,r=307): ", a$dpx, "\n")

}
