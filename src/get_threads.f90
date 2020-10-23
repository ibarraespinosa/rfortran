SUBROUTINE checkntf (nt) ! # nocov start
USE OMP_LIB
IMPLICIT NONE


INTEGER nt
#ifdef _OPENMP
nt = OMP_GET_MAX_THREADS()
#endif

RETURN
END ! # nocov end
