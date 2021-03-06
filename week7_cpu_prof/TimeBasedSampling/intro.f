      double precision function f1(x,y)
      double precision, intent(in)  :: x, y
      !f1 = abs(cos(x + y) * log(y))
      f1 = sqrt(sqrt(x))/sqrt(y) + y/x 
      return
      end function f1


      double precision function f2(x,y)
      double precision, intent(in)  :: x, y
      !f2 = sqrt(abs(sin(x + y) / y))
      f2 = sqrt(sqrt(x*y))/sqrt(y/x) + x/y 
      return
      end function f2


      subroutine sub1(a,b,c,n)
      implicit none
      integer, intent(in)           :: n
      double precision, intent(in)  :: a(n), b(n)
      double precision, intent(out) :: c(n)
      double precision f1, f2
      integer i
      do i=1,n
         c(i) = f1(a(i),b(i)) + f2(a(i),b(i))
      enddo
      end subroutine sub1


      subroutine sub2(a,b,c,n)
      implicit none
      integer, intent(in)           :: n
      double precision, intent(in)  :: a(n), b(n)
      double precision, intent(out) :: c(n)
      double precision f1
      integer i
      do i=1,n
         c(i) = f1(b(i),a(i))
      enddo
      end subroutine sub2


      program intro
      implicit none
      character(len=32) :: arg
      integer i, n
      double precision, allocatable :: x(:), y (:), z(:), w(:)
      double precision elapsed_time, time
      
C     Get the array rank from command line
      call get_command_argument(1, arg)
      read(arg,*) n

C     Allocate arrays
      allocate(w(n), x(n), y(n), z(n))

C     Initialize the arrays x and y
      do i=1,n
         x(i) = i*1.1
         y(i) = i/3.3
      enddo

      call sub1(x,y,z,n)
      call sub1(y,x,z,n)
      call sub2(x,y,w,n)

C     Following code prevents earlier operations from being optimized
C     away since it leaves open the possibility that the array w and z
C     are used.

      if (z(1) == -1.0 .and. w(1) == -1.0) then
         open (3,file="wz.out",form="unformatted",access="sequential")
         write(3) w
         write(3) z
         close(3)
      endif

      deallocate(w,x,y,z)

      end program intro
