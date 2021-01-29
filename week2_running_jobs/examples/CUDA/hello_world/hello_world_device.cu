// UCSD Phys244
// Spring 2018
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
