SUBROUTINE checkntf (nt) ! # nocov start
!$ USE OMP_LIB
IMPLICIT NONE


INTEGER nt
nt = OMP_GET_MAX_THREADS()

RETURN
END ! # nocov end
