
[![Travis-CI Build
Status](https://travis-ci.org/ibarraespinosa/rfortran.svg?branch=master)](https://travis-ci.org/ibarraespinosa/rfortran)
 [![R build
    status](https://github.com/ibarraespinosa/rfortran/workflows/Check/badge.svg)](https://github.com/ibarraespinosa/rfortran/actions)
    
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- date: "24 de Septiembre de 2020" -->

# An R package to play with Fortran and OpenMP

I want to learn more R+Fortran so I created this package to play with
R+Fortran

**ALWAYS READ THE
[R-EXTS](https://cran.r-project.org/doc/manuals/r-release/R-exts.html)
MANUAL**

## Comparison R and Fortran

(TODO Move to wiki or vignette)

``` r
ma <- array(1:6, c(3,2))
dim(ma)          # shape in fortran
#> [1] 3 2
length(ma)       # size in fortran
#> [1] 6
nrow(ma)         # size(ma, 1)
#> [1] 3
ncol(ma)         # size(ma, 2)
#> [1] 2
length(dim(ma))  # rank ma
#> [1] 2
print(ma)
#>      [,1] [,2]
#> [1,]    1    4
#> [2,]    2    5
#> [3,]    3    6
```

``` r
library(inline)
code <- "
      real, dimension(3,2) :: a
      print *, 'size of a: ', size(a)
      print *, 'size of 1 dim a : ', size(a,1)
      print *, 'size of 2 dim a : ',size(a,2)
      print *, 'rank a: ', rank(a)
      print *, 'shape a: ', shape(a)
"
cubefn <- cfunction(body = code, convention=".Fortran")
print(cubefn)
#> An object of class 'CFunc'
#> function () 
#> .Primitive(".Fortran")(<pointer: 0x7f9a1dc07150>)
#> <environment: 0x56428c50fc10>
#> code:
#>   1: 
#>   2:        SUBROUTINE file312f6a470742 (  )
#>   3: 
#>   4: 
#>   5:       real, dimension(3,2) :: a
#>   6:       print *, 'size of a: ', size(a)
#>   7:       print *, 'size of 1 dim a : ', size(a,1)
#>   8:       print *, 'size of 2 dim a : ',size(a,2)
#>   9:       print *, 'rank a: ', rank(a)
#>  10:       print *, 'shape a: ', shape(a)
#>  11: 
#>  12:       RETURN
#>  13:       END
#>  14:
cubefn()
#> list()
```

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

``` r
library(rfortran)
get_threads()
#> [1] 12
cbrt(1:3)
#> [1] 1.000000 1.259921 1.442250
dp_quadratic_reduced(1:4,4:1)
#>               x1             x2      delta delta_positive
#> 1  1.797693e+308  1.797693e+308 -15.000000          FALSE
#> 2  1.797693e+308  1.797693e+308  -8.000000          FALSE
#> 3  -2.000000e+00  -1.000000e+00   1.000000           TRUE
#> 4  -3.732051e+00  -2.679492e-01   3.464102           TRUE
dp_quadratic(1:4,4:1,4:1)
#>               x1             x2 a delta delta_positive
#> 1  1.797693e+308  1.797693e+308 4     0          FALSE
#> 2  1.797693e+308  1.797693e+308 3     0          FALSE
#> 3  1.797693e+308  1.797693e+308 2     0          FALSE
#> 4  -3.732051e+00  -2.679492e-01 1     0          FALSE
dp_quadratic_pascal(1:4,4:1,4:1)
#>               x1             x2 a delta delta_positive
#> 1 -1.797693e+308 -1.797693e+308 4     0          FALSE
#> 2 -1.797693e+308 -1.797693e+308 3     0          FALSE
#> 3 -1.797693e+308 -1.797693e+308 2     0          FALSE
#> 4  -3.732051e+00  -2.679492e-01 1     0          FALSE
```

## Add more

If you know any play, fortran subroutine, trick or anything let me know,
make a [pull request](https://github.com/ibarraespinosa/rfortran/pulls)
or anything
