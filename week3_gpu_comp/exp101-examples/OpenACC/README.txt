[1] Compile Code:

(a) Get an interactive GPU debug node:

module load slurm
srun --pty --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 -p gpu-debug --gpus=1 -t 00:10:00 /bin/bash

(b) On the GPU node:
module purge
module load slurm
module load gpu
module load pgi
pgcc -o laplace2d.openacc.exe -fast -Minfo -acc -ta=tesla:cc70 laplace2d.c

Compiler output:

GetTimer:
     20, include "timer.h"
          61, FMA (fused multiply-add) instruction(s) generated
laplace:
     47, Loop not fused: function call before adjacent loop
         Loop unrolled 8 times
         FMA (fused multiply-add) instruction(s) generated
     55, StartTimer inlined, size=2 (inline) file laplace2d.c (37)
     59, Generating create(Anew[:][:]) [if not already present]
         Generating copy(A[:][:]) [if not already present]
         Loop not vectorized/parallelized: potential early exits
     61, Generating implicit copy(error) [if not already present]
     64, Loop is parallelizable
     66, Loop is parallelizable
         Generating Tesla code
         64, #pragma acc loop gang, vector(4) /* blockIdx.y threadIdx.y */
             Generating implicit reduction(max:error)
         66, #pragma acc loop gang, vector(32) /* blockIdx.x threadIdx.x */
     75, Loop is parallelizable
     77, Loop is parallelizable
         Generating Tesla code
         75, #pragma acc loop gang, vector(4) /* blockIdx.y threadIdx.y */
         77, #pragma acc loop gang, vector(32) /* blockIdx.x threadIdx.x */
     88, GetTimer inlined, size=9 (inline) file laplace2d.c (54)

(Exit out of debug node after this)

[2] Run job:

sbatch openacc-gpu-shared.sb 
