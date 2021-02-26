program factorial
   include "mpif.h"
   integer myid, ierr,numprocs
   integer myidp1, ifactorial, root
   integer status(MPI_STATUS_SIZE),request

   root = 0
   call MPI_INIT( ierr )
   call MPI_COMM_RANK( MPI_COMM_WORLD, myid, ierr )
   call MPI_COMM_SIZE( MPI_COMM_WORLD, numprocs, ierr )
   myidp1 = myid+1
   call MPI_Reduce(myidp1,ifactorial,1,MPI_INTEGER,MPI_PROD,root,MPI_COMM_WORLD,ierr)
   if (myid.eq.root) then
      write(*,*)numprocs,"! = ",ifactorial
   endif
   call MPI_FINALIZE(ierr)
   stop
end
