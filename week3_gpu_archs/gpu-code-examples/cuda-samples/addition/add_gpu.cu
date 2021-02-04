// SDSC SCC Training - GPU Computing and Programming
// Jan 24, 2020
// Andreas Goetz (agoetz@sdsc.edu)

// CUDA program to add two integer numbers on the GPU
//

#include<stdio.h>

//
// CUDA device function that adds two integer numbers
//
__global__ void add(int *a, int *b, int *c){
  
  *c = *a + *b;           

}

//
// main program
//
int main(void) {

  int h_a, h_b, h_c;     // host copies
  int *d_a, *d_b, *d_c;  // device copies
  int size = sizeof(int);

  // allocate device memory
  cudaMalloc((void **)&d_a, size);
  cudaMalloc((void **)&d_b, size);
  cudaMalloc((void **)&d_c, size);

  // setup input data
  h_a = 5;
  h_b = 7;

  // copy input data to device
  cudaMemcpy(d_a, &h_a, size, cudaMemcpyHostToDevice);
  cudaMemcpy(d_b, &h_b, size, cudaMemcpyHostToDevice);

  // launch kernel
  add<<<1,1>>>(d_a, d_b, d_c);

  // copy results back to host
  cudaMemcpy(&h_c, d_c, size, cudaMemcpyDeviceToHost);

  // deallocate memory
  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  // print results
  printf("\n Addition on CPU: %d + %d = %d\n", h_a, h_b, h_a + h_b);
  printf("\n Addition on GPU: %d + %d = %d\n\n",h_a, h_b, h_c);

  return 0;

}
