#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#ifdef _OPENMP
#include <omp.h>
#endif

int main (int argc, char* argv[]) 
{
  long unsigned int throws = argc>1 ? strtoul(argv[1],NULL,10) : 1000000;

  // Fork a team of threads
  #pragma omp parallel
  {

    // Obtain and print thread number
    printf("Hello from thread = %d\n", omp_get_thread_num());

    #pragma omp single
    {
      printf("Threre are %d threads!\n", omp_get_num_threads());
    }

  }

  int i;
  double pi = 0;
  double timer = omp_get_wtime();

  /* Parallel loop with reduction for calculating PI */  
  #pragma omp parallel private(i), shared(throws), reduction(+:pi)
  {
    struct drand48_data pr;
    srand48_r(omp_get_thread_num(), &pr);

    #pragma omp for
    for(i=0; i<throws; ++i)
    {
      double x,y;
      drand48_r(&pr, &x);
      drand48_r(&pr, &y);
      pi += sqrt(x*x+y*y)<=1 ? 1 : 0;
    }
  }
  pi = pi*4/throws;
  timer = omp_get_wtime()-timer;

  printf ("PI = %.12lf, Err = %e, Time = %f\n", pi, M_PI-pi, timer); 
}
