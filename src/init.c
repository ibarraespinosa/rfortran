#include <R_ext/RS.h>
#include <stdlib.h> // for NULL
#include <R_ext/Rdynload.h>

/* FIXME:
 Check these declarations against the C/Fortran source code.


 */

/* .Fortran calls */
extern void F77_NAME(base_types)(void *, void *, void *);
extern void F77_NAME(cbrt_dp)(void *, void *, void *);
extern void F77_NAME(checkntf)(void *);
extern void F77_NAME(lineq_gausselim_dp)(void *, void *, void *, void *, void *);
extern void F77_NAME(quadratic_dp)(void *, void *, void *, void *, void *, void *, void *);
extern void F77_NAME(quadratic_pascal_dp)(void *, void *, void *, void *, void *, void *, void *);
extern void F77_NAME(quadratic_pascal_reduced_dp)(void *, void *, void *, void *, void *, void *, void *);
extern void F77_NAME(quadratic_reduced_dp)(void *, void *, void *, void *, void *, void *);

static const R_FortranMethodDef FortranEntries[] = {
    {"base_types",                  (DL_FUNC) &F77_NAME(base_types),                  3},
    {"cbrt_dp",                     (DL_FUNC) &F77_NAME(cbrt_dp),                     3},
    {"checkntf",                    (DL_FUNC) &F77_NAME(checkntf),                    1},
    {"lineq_gausselim_dp",          (DL_FUNC) &F77_NAME(lineq_gausselim_dp),          5},
    {"quadratic_dp",                (DL_FUNC) &F77_NAME(quadratic_dp),                7},
    {"quadratic_pascal_dp",         (DL_FUNC) &F77_NAME(quadratic_pascal_dp),         7},
    {"quadratic_pascal_reduced_dp", (DL_FUNC) &F77_NAME(quadratic_pascal_reduced_dp), 7},
    {"quadratic_reduced_dp",        (DL_FUNC) &F77_NAME(quadratic_reduced_dp),        6},
    {NULL, NULL, 0}
};

void R_init_rfortran(DllInfo *dll)
{
    R_registerRoutines(dll, NULL, NULL, FortranEntries, NULL);
    R_useDynamicSymbols(dll, FALSE);
}
