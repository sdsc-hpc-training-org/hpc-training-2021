#include <stdio.h>
#include <stdlib.h>
#include <mpi.h>
#include <math.h>
int main(argc,argv)
int argc;
char *argv[];
{
    int myid, numprocs;
    int tag,source,destination,count;
    int s_buf, r_buf;
    MPI_Status status;
    MPI_Request request;
 
    MPI_Init(&argc,&argv);
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    tag=1;
    source=0;
    destination=1;
    count=1;
    request=MPI_REQUEST_NULL;
    if(myid == source){
      s_buf=1024;
      MPI_Isend(&s_buf,count,MPI_INT,destination,tag,MPI_COMM_WORLD,&request);
    }
    if(myid == destination){
        MPI_Irecv(&r_buf,count,MPI_INT,source,tag,MPI_COMM_WORLD,&request);
    }
    MPI_Wait(&request,&status);
    if(myid == source){
      printf("processor %d  sent %d\n",myid,s_buf);
    }
    if(myid == destination){
      printf("processor %d  got %d\n",myid,r_buf);
    }
    MPI_Finalize();
}
