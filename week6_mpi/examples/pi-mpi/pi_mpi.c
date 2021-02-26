#include <stdio.h>
#include <mpi.h>

int main(int argc, char *argv[]) 
  {
  int numprocs, rank;
  int i, iglob, INTERVALS, INTLOC, len;
  char hostname[MPI_MAX_PROCESSOR_NAME];
  double n_1, x;
  double pi, piloc;

  MPI_Init(&argc, &argv);
  MPI_Comm_size(MPI_COMM_WORLD, &numprocs);
  MPI_Comm_rank(MPI_COMM_WORLD, &rank);
  MPI_Get_processor_name(hostname, &len);

  INTERVALS=1024000;
  printf("Hello from MPI task= %d on %s\n", rank, hostname);
  MPI_Barrier(MPI_COMM_WORLD);
  if (rank == 0) 
    {
    printf("Number of MPI tasks = %d\n", numprocs);
    }

  INTLOC=INTERVALS/numprocs;
  piloc=0.0;
  n_1=1.0/(double)INTERVALS;
  for (i = 0; i < INTLOC; i++)
    {
    iglob = INTLOC*rank+i;
    x = n_1 * ((double)iglob  - 0.5);
    piloc += 4.0 / (1.0 + x * x);
    }
  MPI_Reduce(&piloc,&pi,1,MPI_DOUBLE,MPI_SUM,0,MPI_COMM_WORLD);
  if (rank == 0)
    {
    pi *= n_1; 
    printf ("Pi = %.12lf\n", pi); 
    }

  MPI_Finalize();
  }  
