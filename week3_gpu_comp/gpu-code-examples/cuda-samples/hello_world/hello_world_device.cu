// SDSC SCC Training - GPU Computing and Programming
// Jan 24, 2020
// Andreas Goetz (agoetz@sdsc.edu)

// Hello World Program in CUDA C
//
// Contains a function that is executed on the device (GPU)
//

#include<stdio.h>

__global__ void my_kernel(void){
}

int main(void) {

  my_kernel<<<1,1>>>();
  printf("Hello World!\n");
  return 0;

}
