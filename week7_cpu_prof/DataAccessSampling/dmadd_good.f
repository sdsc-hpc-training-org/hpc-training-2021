      program dmadd
      implicit none

C     Fortran code to illustrate the impact of loop nesting order on the
C     performance of a 2D matrix addition.

      character(len=32) :: arg
      integer i, j, n
      integer clock1, clock2
      double precision, allocatable :: x(:,:), y (:,:), z(:,:)
      double precision elapsed_time, time

C     Get the array rank from command line
      call get_command_argument(1, arg)
      read(arg,*) n

C     Allocate arrays for arguments and result
      allocate(x(n,n), y(n,n), z(n,n))

C     Initialize the arrays x and y
      do j=1,n
         do i=1,n
            x(i,j) = i*1.1 + j*2.2
            y(i,j) = i*3.3 + j*4.4
         enddo
      enddo

C     Add arrays x and y
      call system_clock(clock1)
      do j=1,n
         do i=1,n
            z(i,j) = x(i,j) + y(i,j)
         enddo
      enddo
      call system_clock(clock2)
      time = elapsed_time(clock1, clock2)

C     Following code prevents compiler from optimizing away matrix
C     addition operation. Leaves open the possibility that the results
C     will be used
      if (z(1,1) == -1.0) then
         open (3,file="z.out",form="unformatted",access="sequential")
         write(3) z
      endif

      write(*,*) 'n    = ', n
      write(*,*) 'time = ', time

      end program dmadd

C     -------------------------------------------------------------------

      double precision function elapsed_time(c1, c2)
      implicit none

C     Return the elapsed time bewteen the clock counts c1 and
C     c2. Although c2 corresponds to a later time than c1, we need to
C     explicitly test for the possibility that the system clock had
C     rolled over.

      integer, intent(in) :: c1, c2
      integer ticks, clockrate, clockmax

      call system_clock(count_max=clockmax, count_rate=clockrate)

      ticks = c2-c1
      if(ticks < 0) then
         ticks = clockmax + ticks
      endif
      elapsed_time = dble(ticks)/dble(clockrate)

      return
      end function elapsed_time
