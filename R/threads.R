#' Check the number of threads
#'
#' @description \code{get_threads} check the number of threads in this machine
#'
#' @return Integer with the maxnumber of threads
#'
#' @param print show Fortran subroutine
#' @useDynLib rfortran
#' @export
#' @examples {
#' get_threads(TRUE)
#' }
get_threads <- function(print = FALSE) {
  .Fortran("checkntf",
           nt = integer(1L))$nt
  if(print) {
    cat(paste0(
      "SUBROUTINE checkntf (nt)\n",
        "USE OMP_LIB\n",
        "IMPLICIT NONE\n",
        "INTEGER nt\n",
        "nt = OMP_GET_MAX_THREADS()\n",
        "RETURN\n",
        "END"
        ))
  }
}
