#include <mpi.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <string.h>

int main (int argc, char *argv[])
{
    int myid, numprocs, i, j;
    int size, tag1, tag2;
    float s_buf[10];
    float r_buf[10];
    MPI_Status reqstat;
    double t_start = 0.0, t_end = 0.0, t = 0.0;

    MPI_Init(&argc, &argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
    MPI_Comm_rank(MPI_COMM_WORLD, &myid);
    
    size = 10;
    tag1 = 1;
    tag2 = 2;
    if(numprocs != 2) {
        if(myid == 0) {
            fprintf(stderr, "This test requires exactly two processes\n");
        }

        MPI_Finalize();
        exit(EXIT_FAILURE);
    }
    for(i = 0; i < 10; i++) {
         s_buf[i] = myid+i*4.0;
    }
    if(myid == 0) {
        MPI_Ssend(s_buf, size, MPI_FLOAT, 1, tag1, MPI_COMM_WORLD);
        MPI_Recv(r_buf, size, MPI_FLOAT, 1, tag2, MPI_COMM_WORLD, &reqstat);
        for (i = 0; i < 10; i++ ){
          printf("PRIM: r_buf[%d] = %f\n", i, r_buf[i] );
        }
    }
    else if(myid == 1) {
        MPI_Ssend(s_buf, size, MPI_FLOAT, 0, tag2, MPI_COMM_WORLD);
        MPI_Recv(r_buf, size, MPI_FLOAT, 0, tag1, MPI_COMM_WORLD, &reqstat);
        for (i = 0; i < 10; i++ ){
          printf("r_buf[%d] = %f\n", i, r_buf[i] );
        }
    }

   MPI_Finalize();
   return 0;
}
