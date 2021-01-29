// UCSD Phys244
// Spring 2018
// Andreas Goetz (agoetz@sdsc.edu)

// CUDA program to add two vectors in parallel on the GPU
// version 2:
// launch a fixed number of blocks and threads
//
// /* FIXME */ comments need modifications
//

#include<stdio.h>

// define vector length, number of blocks NBL and threads per block TPB
#define N (255*2047)
#define NBL 256
#define TPB 128

//
// CUDA device function that adds two integer vectors
//
__global__ void add(int *a, int *b, int *c, int n){

  /* FIXME 
     INSERT HERE CODE TO CALCULATE REQUIRED INDEX AND STRIDE
   */

  while (tid < n) {
    c[tid] = a[tid] + b[tid];
    tid += stride;
  }

}

//
// main program
//
int main(void){

  int *h_a, *h_b, *h_c;
  int *d_a, *d_b, *d_c;
  int size = N * sizeof(int);
  int i, err;

  // allocate host memory
  h_a = (int *) malloc(size);
  h_b = (int *) malloc(size);
  h_c = (int *) malloc(size);

// allocate device memory
  cudaMalloc((void **)&d_a, size);
  cudaMalloc((void **)&d_b, size);
  cudaMalloc((void **)&d_c, size);

  // initialize vectors
  for (i=0; i<N; i++){
    h_a[i] = i+1;
    h_b[i] = i+1;
  }

  // copy input data to device
  cudaMemcpy(/* FIXME */);
  cudaMemcpy(/* FIXME */);

  // add vectors by launching a sufficient number of blocks of the add() kernel
  printf("\nLaunching vector addition kernel...\n");
  printf("Vector length     = %d\n",N);
  printf("Blocks            = %d\n",NBL);
  printf("Threads per block = %d\n",TPB);
  printf("Kernel copies     = %d\n",NBL*TPB);
  add<<</* FIXME */>>>(d_a, d_b, d_c, N);

  // copy results back to host
  cudaMemcpy(/* FIXME */);

  // deallocate memory
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  // check results
  err = 0;
  for (i=0; i<N; i++){
    if (h_c[i] != 2*(i+1)) err = 1;
  }
  if (err != 0){
    printf("\n Error, %d elements do not match!\n\n", err);
  } else {
    printf("\n Success! All elements match.\n\n");
  }

  // deallocate host memory
  free(h_a);
  free(h_b);
  free(h_c);

  return err;

}
