#include <stdio.h>
#include <omp.h>

int main(void) {

   int number_of_threads, thread_id;

   #pragma omp parallel private(thread_id)
   {
      thread_id = omp_get_thread_num();

      #pragma omp master
      {
         number_of_threads = omp_get_num_threads();
      }

      #pragma omp barrier
      printf("hello, shared memory world from thread %d of \
         %d\n", thread_id, number_of_threads);
   }

   return 0;

}
