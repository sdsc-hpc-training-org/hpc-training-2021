program factorial
  implicit none

  ! define variables, some with initial values
  integer :: nfact = 1
  integer :: n

  ! compute factorials
  do n = 1, 10
     nfact = nfact * n
     write(*,*) n, nfact
  end do
end program factorial
