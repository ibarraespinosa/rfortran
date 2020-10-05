#' Check the number of threads
#'
#' @description \code{get_threads} check the number of threads in this machine
#'
#' @return Integer with the maxnumber of threads
#'
#' @useDynLib rfortran
#' @export
#' @examples
#' {
#'   get_threads()
#' }
get_threads <- function() {
  .Fortran("checkntf",
    nt = integer(1L)
  )$nt
}