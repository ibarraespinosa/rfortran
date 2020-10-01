#' @title Defines numeric types
#'
#' @description function to return x^1/3
#'
#' @param x numeric
#'
#' @return Integer with the maxnumber of threads
#'
#' @useDynLib rfortran
#' @export
#' @examples {
#' cbrt(1:3)
#' }
cbrt <- function(x) {
 .Fortran("cbrt_dp",
          x = as.numeric(x),
          lx = as.integer(length(x)),
           y = numeric(length(x)))$y
}

#' @title quadratic reduced
#' @export
#' @param bb numeric
#' @param cc numeric
#' @examples {
#' quadratic_reduced(1:4,4:1)
#' }
quadratic_reduced <- function(bb,cc) {
  if(length(bb) != length(cc) ) stop("length of bb and cc must be equal")
a <-  .Fortran("quadratic_reduced_dp",
           bb = as.numeric(bb),
           cc = as.numeric(cc),
           x1 = numeric(length(bb)),
           x2 = numeric(length(bb)),
           lx = as.integer(length(bb)),
           delta = numeric(length(bb)))
return(data.frame(x1 = a$x1,
                  x2 = a$x2,
                  delta = a$delta,
                  delta_positive = ifelse(a$delta <= 0, FALSE, TRUE)))
}

#' @title quadratic
#' @param bb numeric
#' @param cc numeric
#' @param a numericL
#' @export
#' @examples {
#' quadratic(1:4,4:1,4:1)
#' }
quadratic <- function(bb,cc, a) {
  if(length(bb) != length(cc) ) stop("length of bb and cc must be equal")
  if(length(bb) != length(a) ) stop("length of bb and a must be equal")
  a <-  .Fortran("quadratic_dp",
                 a = as.numeric(a),
                 bb = as.numeric(bb),
                 cc = as.numeric(cc),
                 x1 = numeric(length(bb)),
                 x2 = numeric(length(bb)),
                 lx = as.integer(length(bb)),
                 delta = numeric(length(bb)))
  return(data.frame(x1 = a$x1,
                    x2 = a$x2,
                    a = a$a,
                    delta = a$delta,
                    delta_positive = ifelse(a$delta <= 0, FALSE, TRUE)))
}
