program bcast
   include "mpif.h"
   integer myid, ierr,numprocs
   integer source,count
   integer buffer(4)
   integer status(MPI_STATUS_SIZE),request
   call MPI_INIT( ierr )
   call MPI_COMM_RANK( MPI_COMM_WORLD, myid, ierr )
   call MPI_COMM_SIZE( MPI_COMM_WORLD, numprocs, ierr )
   source=0
   count=4
   if(myid .eq. source)then
    do i=1,count
     buffer(i)=i
    enddo
   endif
   Call MPI_Bcast(buffer, count, MPI_INTEGER,source,&
        MPI_COMM_WORLD,ierr)
   write(*,*)"processor ",myid," recv buff= ",buffer
   call MPI_FINALIZE(ierr)
   stop
end
