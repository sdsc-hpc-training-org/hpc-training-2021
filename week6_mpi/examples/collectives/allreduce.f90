program factorial
   include "mpif.h"
   integer myid, ierr,numprocs,mpi_err
   integer imax, imaxloc
   integer status(MPI_STATUS_SIZE),request
integer,parameter :: seed = 86456

   call MPI_INIT( ierr )
   call MPI_COMM_RANK( MPI_COMM_WORLD, myid, ierr )
   call MPI_COMM_SIZE( MPI_COMM_WORLD, numprocs, ierr )
   !imaxloc=IRAND(myid) 
   call srand(myid)
   imaxloc=IRAND()
   call MPI_ALLREDUCE(imaxloc,imax,1,MPI_INTEGER,MPI_MAX,MPI_COMM_WORLD,mpi_err)
   write(*,*)"On Task:",myid," IMaxLOC=",imaxloc," IMaxGlobal=",imax
   if (imax.eq.imaxloc) then
      write(*,*)"IMAX=",imax,"on task",myid
   endif
   call MPI_FINALIZE(ierr)
   stop
end
