! MD5 of template: 9b6b4bb463e1543bdbfe618866a80346
! Algebra routines
!
! ------------------------------------------------------------------------------
! Copyright (c) 2009-13, Thomas P. Robitaille
!
! All rights reserved.
!
! Redistribution and use in source and binary forms, with or without
! modification, are permitted provided that the following conditions are met:
!
!  * Redistributions of source code must retain the above copyright notice, this
!    list of conditions and the following disclaimer.
!
!  * Redistributions in binary form must reproduce the above copyright notice,
!    this list of conditions and the following disclaimer in the documentation
!    and/or other materials provided with the distribution.
!
! THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
! AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
! IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
! DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
! FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
! DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
! SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
! CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
! OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
! OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
! ------------------------------------------------------------------------------
subroutine cbrt_dp(x, lx, y)
    implicit none

    integer, parameter :: dp = selected_real_kind(p=15,r=307)
    integer :: lx, i
    real(kind = dp) :: x(lx), y(lx)
    real(kind = dp) :: alpha = 1._dp / 3._dp

do i = 1, lx
    if(x(i) >= 0.) then
       y(i) = x(i)**alpha
    else
       y(i) = - (abs(x(i)))**alpha
    end if
enddo

end subroutine


subroutine quadratic_reduced_dp(bb,cc,x1,x2,lx,  delta)
    implicit none

    integer, parameter :: dp = selected_real_kind(p=15,r=307)
    real(dp),intent(in)  :: bb(lx),cc(lx)
    real(dp),intent(out) :: x1(lx),x2(lx)
    real(dp) :: delta(lx)
    integer :: lx, i

do i = 1, lx
    delta(i) = bb(i)*bb(i) - 4._dp*cc(i)

    if(delta(i) > 0) then
       delta(i) = sqrt(delta(i))
       x1(i) = ( - bb(i) - delta(i) ) * 0.5_dp
       x2(i) = ( - bb(i) + delta(i) ) * 0.5_dp
    else
       x1(i) = huge(x1(i))
       x2(i) = huge(x2(i))
    end if
enddo
end subroutine quadratic_reduced_dp


subroutine quadratic_dp(a,bb,cc,x1,x2, lx)
    implicit none

    integer, parameter :: dp = selected_real_kind(p=15,r=307)
    real(dp),intent(in)  :: a(lx),bb(lx),cc(lx)
    real(dp),intent(out) :: x1(lx),x2(lx)
    real(dp) :: delta(lx),factor(lx)
    integer :: lx, i

do i = 1, lx
    delta(i) = bb(i)*bb(i) - 4._dp*a(i)*cc(i)

    if(delta(i) > 0) then
       delta(i) = sqrt(delta(i))
       factor(i) = 0.5_dp / a(i)
       x1(i) = ( - bb(i) - delta(i) ) * factor(i)
       x2(i) = ( - bb(i) + delta(i) ) * factor(i)
    else
       x1(i) = huge(x1(i))
       x2(i) = huge(x2(i))
    end if
enddo
end subroutine quadratic_dp

subroutine quadratic_pascal_dp(a,bb,cc,x1,x2,lx)
    implicit none

    integer, parameter :: dp = selected_real_kind(p=15,r=307)
    real(dp),intent(in)  :: a(lx),bb(lx),cc(lx)
    real(dp),intent(out) :: x1(lx),x2(lx)
    real(dp) :: delta(lx),factor(lx),q(lx)
    integer :: lx, i

do i = 1, lx
    delta(i) = bb(i)*bb(i) - 4._dp*a(i)*cc(i)

    if(delta(i) > 0) then
       delta(i) = sqrt(delta(i))
       !sign return the value of delta with the sign of b
       delta(i) = sign(delta(i),bb(i))

       q(i) = -0.5_dp * (bb(i) + delta(i))
       x1(i) = q(i) / a(i)
       x2(i) = cc(i) / q(i)
    else if(delta(i) < 0) then
       x1(i) = -huge(x1(i))
       x2(i) = -huge(x2(i))
    else
       x1(i) = - 2.0_dp * cc(i) / bb(i)
       x2(i) = -huge(x2(i))
    end if
enddo
end subroutine quadratic_pascal_dp

subroutine quadratic_pascal_reduced_dp(bb,cc,x1,x2,lx)
    implicit none

    integer, parameter :: dp = selected_real_kind(p=15,r=307)
    real(dp),intent(in)  :: bb(lx),cc(lx)
    real(dp),intent(out) :: x1(lx),x2(lx)
    real(dp) :: delta(lx),factor(lx),q(lx)
    integer :: lx, i

do i = 1, lx
    delta(i) = bb(i)*bb(i) - 4._dp*cc(i)

    if(delta(i) > 0) then
       delta(i) = sqrt(delta(i))
       !sign return the value of delta with the sign of b
       delta(i) = sign(delta(i),bb(i))

       q(i) = -0.5_dp * (bb(i) + delta(i))
       x1(i) = q(i)
       x2(i) = cc(i) / q(i)
    else if(delta(i) < 0) then
       x1(i) = -huge(x1(i))
       x2(i) = -huge(x2(i))
    else
      x1(i) = - 2.0_dp * cc(i) / bb(i)
      x2(i) = -huge(x2(i))
    end if
enddo
end subroutine quadratic_pascal_reduced_dp


subroutine lineq_gausselim_dp(rowsa,colsa,lb, a, b)

   implicit none
   integer, parameter :: dp = selected_real_kind(p=15,r=307)
   integer :: rowsa, colsa, lb
   real(dp),intent(inout) :: a(rowsa,colsa),b(lb)
   real(dp) :: frac
   integer :: i,j
   integer :: n

   n = size(a,1)

   do i=1,n-1
      ! stopping on R
 !     if(a(i,i)==0) stop "Zero pivot value"
      do j=i+1,n
         if(a(i,j).ne.0.) then
            frac = a(i,j)/a(i,i)
            b(j) = b(j) - frac * b(i)
            a(i:,j) = a(i:,j) - frac * a(i:,i)
         end if
      end do
   end do

   do i=n,2,-1
      do j=i-1,1,-1
         if(a(i,j).ne.0.) then
            frac = a(i,j)/a(i,i)
            b(j) = b(j) - frac * b(i)
            a(i:,j) = a(i:,j) - frac * a(i:,i)
         end if
      end do
   end do

   do i=1,n
      b(i) = b(i) / a(i,i)
   end do

 end subroutine lineq_gausselim_dp
