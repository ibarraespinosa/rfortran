
<!-- README.md is generated from README.Rmd. Please edit that file -->

<!-- date: "24 de Septiembre de 2020" -->

# An R package to play with Fortran and OpenMP

Functions:

**R:**

``` r
library(rfortran)
get_threads()
#> [1] 12
```

**Fortran:**

``` fortran
SUBROUTINE checkntf (nt) ! # nocov start
USE OMP_LIB
IMPLICIT NONE


INTEGER nt


nt = OMP_GET_MAX_THREADS()

RETURN
END ! # nocov end
```

**Makevars:**

``` bash
USE_FC_TO_LINK =
PKG_FFLAGS = $(SHLIB_OPENMP_FFLAGS)
PKG_LIBS = $(SHLIB_OPENMP_FFLAGS)


C_OBJS = init.o
FT_OBJS = get_threads.o

all:
    @$(MAKE) $(SHLIB)
    @rm -f  *.o

$(SHLIB): $(FT_OBJS) $(C_OBJS)

init.o:  get_threads.o
```

**C: generated with
`tools::package_native_routine_registration_skeleton(".")`**

init.c

``` c
#include <R_ext/RS.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME: 
   Check these declarations against the C/Fortran source code.
*/

/* .Fortran calls */
extern void F77_NAME(checkntf)(void *);

static const R_FortranMethodDef FortranEntries[] = {
    {"checkntf", (DL_FUNC) &F77_NAME(checkntf), 1},
    {NULL, NULL, 0}
};

void R_init_rfortran(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, NULL, FortranEntries, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
```