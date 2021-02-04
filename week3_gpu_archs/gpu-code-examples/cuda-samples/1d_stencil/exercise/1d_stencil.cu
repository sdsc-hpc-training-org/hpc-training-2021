// SDSC Summer Institute 2018
// Andreas Goetz (agoetz@sdsc.edu)

// CUDA program that performs 1D stencil operation in parallel on the GPU
//
// /* FIXME */ COMMENTS REQUIRE ATTENTION

#include<stdio.h>

// define vector length, stencil radius, 
#define N (1024*1024*8l)
#define RADIUS 3
#define GRIDSIZE 128
#define BLOCKSIZE 256

// -------------------------------------------------------
// CUDA device function that performs 1D stencil operation
// -------------------------------------------------------
__global__ void stencil_1D(int *in, int *out, long dim){

  long gindex = threadIdx.x + blockDim.x * blockIdx.x;
  int stride = gridDim.x * blockDim.x;

  // Go through all data
  // Step all threads in a block to avoid synchronization problem
  while ( gindex < (dim + blockDim.x) ) {

    /* FIXME - CAN WE USE SHARED MEMORY? */

    // Apply the stencil
    int result = 0;
    for (int offset = -RADIUS; offset <= RADIUS; offset++) {
      if ( gindex + offset < dim && gindex + offset > -1)
	result += in[gindex + offset];
    }

    // Store the result
    if (gindex < dim)
      out[gindex] = result;

    // Update global index and quit if we are done
    gindex += stride;

    __syncthreads();

  }

}

// ------------
// main program
// ------------
int main(void){

  int *h_in, *h_out;
  int *d_in, *d_out;
  long size = N * sizeof(int);
  int i, j, ij, result, err;

  // allocate host memory
  h_in = new int[N];
  h_out = new int[N];

  // initialize vector
  for (i=0; i<N; i++){
    //    h_in[i] = i+1;
    h_in[i] = 1;
  }

  // allocate device memory
  cudaMalloc((void **)&d_in, size);
  cudaMalloc((void **)&d_out, size);

  // copy input data to device
  cudaMemcpy(d_in, h_in, size, cudaMemcpyHostToDevice);

  // Apply stencil by launching a sufficient number of blocks
  printf("\n---------------------------\n");
  printf("Launching 1D stencil kernel\n");
  printf("---------------------------\n");
  printf("Vector length     = %ld (%ld MB)\n",N,N*4/1024/1024);
  printf("Stencil radius    = %d\n",RADIUS);
  printf("Blocks            = %d\n",GRIDSIZE);
  printf("Threads per block = %d\n",BLOCKSIZE);
  printf("Total threads     = %d\n",GRIDSIZE*BLOCKSIZE);

  stencil_1D<<<GRIDSIZE,BLOCKSIZE>>>(d_in, d_out, N);

  // copy results back to host
  cudaMemcpy(h_out, d_out, size, cudaMemcpyDeviceToHost);

  // deallocate device memory
  cudaFree(d_in);
  cudaFree(d_out);

  // check results
  err = 0;
  for (i=0; i<N; i++){
    result = 0;
    for (j=-RADIUS; j<=RADIUS; j++){
      ij = i+j;
      if (ij>=0 && ij<N)
        result += h_in[ij];
    }
    if (h_out[i] != result) {
      err++;
      // printf("h_out[%d]=%d\n",i,h_out[i]);
    }
  }

  if (err != 0){
    printf("\n Error, %d elements do not match!\n\n", err);
  } else {
    printf("\n Success! All elements match CPU result.\n\n");
  }

  // deallocate host memory
  free(h_in);
  free(h_out);

  return 0;

}
