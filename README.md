
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- date: "24 de Septiembre de 2020" -->

# An R package to play with Fortran and OpenMP

I want to learn more R+Fortran so I created this package to play with
R+Fortran

**ALWAYS READ THE
[R-EXTS](https://cran.r-project.org/doc/manuals/r-release/R-exts.html)
MANUAL**

## Comparison R and Fortran

| R                | Fortran |
| ---------------- | ------- |
| dim(numeric(1L)) | rank?   |
| TODO add more    |         |

## Implementing several new fortran subroutines

I’ve found a nice repo
[AstroFrog](https://github.com/astrofrog/fortranlib) with lots of
fortran subroutines that I will implementing as R functions here. The
implementation in R is vectorial, hence in Fortra arrays with the
required dimension.

| id | Fortran                                                                                     | R                                                                                                |
| -- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| 1  | OpenMP                                                                                      | [get\_threads](https://ibarraespinosa.github.io/rfortran/reference/get_threads.html)             |
| 2  | [base\_types.f90](https://github.com/astrofrog/fortranlib/blob/master/src/base_types.f90)   | [get\_types](https://ibarraespinosa.github.io/rfortran/reference/get_types.html)                 |
| 3  | [lib\_algebra.f90](https://github.com/astrofrog/fortranlib/blob/master/src/lib_algebra.f90) | [quadratic\_reduced](https://ibarraespinosa.github.io/rfortran/reference/quadratic_reduced.html) |
| 4  | [lib\_algebra.f90](https://github.com/astrofrog/fortranlib/blob/master/src/lib_algebra.f90) | [quadratic](https://ibarraespinosa.github.io/rfortran/reference/quadratic.html)                  |
| 5  | [lib\_algebra.f90](https://github.com/astrofrog/fortranlib/blob/master/src/lib_algebra.f90) | [cbrt](https://ibarraespinosa.github.io/rfortran/reference/cbrt.html)                            |

## Add plays

If you know any play, fortran subroutine, trick or anything let me know,
make a [pull request](https://github.com/ibarraespinosa/rfortran/pulls)
or anything
