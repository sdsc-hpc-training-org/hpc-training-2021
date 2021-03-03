      PROGRAM HEATEQN
      implicit none
      include "mpif.h"
      integer :: iglobal, ilocal, itime
      integer :: ierr, nnodes, my_id
      integer :: dest, from, status(MPI_STATUS_SIZE),tag
      integer :: msg_size
      real*8 :: xalp,delx,delt,pi
      real*8 :: T(0:100,0:5), TG(0:10)
      CHARACTER(20) :: FILEN

      delx = 0.1d0
      delt = 1d-4
      xalp = 2.0d0
 
      call MPI_INIT(ierr)
      call MPI_COMM_SIZE(MPI_COMM_WORLD, nnodes, ierr)
      call MPI_COMM_RANK(MPI_COMM_WORLD, my_id, ierr)

      if (nnodes.ne.3) then
         if (my_id.eq.0) then
          print *, "This test needs exactly 3 tasks"
         endif
         call MPI_FINALIZE(ierr)
         STOP
      endif
      print *, "Process ", my_id, "of", nnodes ,"has started"
!************* Initial Conditions *********************************
      pi = 4d0*datan(1d0)
      do ilocal = 0, 4
        iglobal = 3*my_id+ilocal
        T(0,ilocal) = dsin(pi*delx*dfloat(iglobal))
      enddo
      write(*,*)"Processor", my_id, "has finished setting initial 
     +   conditions"
!************* Iterations ****************************************
      do itime = 1 , 3 
       if (my_id.eq.0) then
         write(*,*)"Running Iteration Number ", itime
       endif
       do ilocal = 1, 3
         T(itime,ilocal)=T(itime-1,ilocal)+
     +   xalp*delt/delx/delx*
     +   (T(itime-1,ilocal-1)-2*T(itime-1,ilocal)+T(itime-1,ilocal+1))
       enddo
       if (my_id.eq.0) then
         write(*,*)"Sending and receiving overlap points"
         dest = 1
         msg_size = 1
         tag=2001
       call MPI_SEND(T(itime,3),msg_size,MPI_DOUBLE_PRECISION,dest,
     +                 tag,MPI_COMM_WORLD,ierr)
       endif 
       if (my_id.eq.1) then
         from = 0
         dest = 2
         msg_size = 1
         tag=2002
         call MPI_SEND(T(itime,3),msg_size,MPI_DOUBLE_PRECISION,dest,
     +                 tag,MPI_COMM_WORLD,ierr)
         tag=MPI_ANY_TAG
         call MPI_RECV(T(itime,0),msg_size,MPI_DOUBLE_PRECISION,from,
     +                 tag,MPI_COMM_WORLD,status,ierr)
       endif
       if (my_id.eq.2) then
         from = 1 
         dest = 1 
         msg_size = 1
         tag=2003
         call MPI_SEND(T(itime,1),msg_size,MPI_DOUBLE_PRECISION,dest,
     +                 tag,MPI_COMM_WORLD,ierr)
         tag=MPI_ANY_TAG
         call MPI_RECV(T(itime,0),msg_size,MPI_DOUBLE_PRECISION,from,
     +                 tag,MPI_COMM_WORLD,status,ierr)
       endif
       if (my_id.eq.1) then
         from = 2 
          dest = 0 
         msg_size = 1
         tag=MPI_ANY_TAG
         call MPI_RECV(T(itime,4),msg_size,MPI_DOUBLE_PRECISION,from,
     +                 tag,MPI_COMM_WORLD,status,ierr)
         tag=2004
         call MPI_SEND(T(itime,1),msg_size,MPI_DOUBLE_PRECISION,dest,
     +                 tag,MPI_COMM_WORLD,ierr)
       endif
       if (my_id.eq.0) then
         from = 1 
         msg_size = 1
         tag=MPI_ANY_TAG
         call MPI_RECV(T(itime,4),msg_size,MPI_DOUBLE_PRECISION,from,
     +                 tag,MPI_COMM_WORLD,status,ierr)
       endif
      enddo

      if (my_id.eq.0) then
        write(*,*)"SOLUTION SENT TO FILE AFTER 3 TIMESTEPS:"
      endif
      FILEN = 'data'//char(my_id+48)//'.dat'
      open (5, file=FILEN) 
      write(5,*)"Processor ",my_id
      do ilocal = 0 , 4
       iglobal = 3*my_id + ilocal
       write(5,*)"ilocal=",ilocal,";iglobal=",iglobal,";T=",T(3,ilocal)
      enddo 
      close(5)
      call MPI_FINALIZE(ierr)

      END
