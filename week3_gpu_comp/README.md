# SDSC HPC User Training:  Spring 2020
**WEEK 3:** 01/24/2020

## TOPIC: GPU Computing and Programming

**Presented By:** [Andreas Goetz, SDSC](https://www.sdsc.edu/research/researcher_spotlight/goetz_andreas.html) (agoetz  at  sdsc.edu)

### READING AND PRESENTATIONS:

Lecture slides:
* [https://github.com/sdsc-hpc-training-org/hpc-training-2021/blob/main/week3_gpu_comp/sdsc-scc-gpu-computing-mpt-2021-02-05.pdf](https://github.com/sdsc-hpc-training-org/hpc-training-2021/blob/main/week3_gpu_comp/sdsc-scc-gpu-computing-mpt-2021-02-05.pdf)

Example source code accompanying the lecture slides with instructions are in directory gpu-code-examples.


## WEEK3 TASKS:
### TASK 1:  Using GPU nodes  
    Clone this repository;
    `cd` into the `gpu-code-examples` directory

```
% cd gpu-code-examples
```
See the README.md file in the tarfile directory and
follow instructions on "How to use Expanse's GPU nodes"


# Obtain interactive shared GPU node on SDSC Expanse
Source `getgpu.rc`, which defines an alias `getgpu` that you can use to obtain an interactive GPU node:
`source getgpu.rc`
`getgpu`

The script `getgpu.rc` defines the SLURM launch command below to obtain an interactive node with access to 1 K80 GPU on the shared GPU nodes for 3h. You can also execute this command directly on the command line:

```
alias getgpu='srun --pty --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 \
 -p gpu-shared --gpus=1 -t 03:00:00 -A sds173 /bin/bash

```

It may take some time to get the *interactive node*.

Load the GPU environment modules

```
module purge
module load slurm
module load gpu
```
* Once you have loaded the *gpu* module, you will have access to the CUDA libraries. Run the *avail*
```
[mthomas@exp-9-55 ~]$ module avail

--------------- /cm/shared/apps/spack/gpu/lmod/linux-centos8-x86_64/Core ---------------
   beast1/1.8.4                intel/19.0.5.281       openmpi/4.0.4-nocuda
   beast1/1.10.4        (D)    libbeagle/3.1.2        openmpi/4.0.4        (D)
   beast2/2.5.2                libjpeg-turbo/2.0.4    pgi/18.10
   beast2/2.6.3         (D)    libtirpc/1.2.6         pgi/19.7
   cmake/3.18.2                matlab/2020b           pgi/20.4             (D)
   intel-mkl/2020.3.279        nvhpc/20.9             subversion/1.14.0
   intel-mpi/2019.8.254        openjdk/11.0.2

-------------------------------- /cm/local/modulefiles ---------------------------------
   cmjob    lua/5.3.5    shared    singularitypro/3.5    slurm/expanse/20.02.3 (L)

-------------------------- /cm/shared/apps/xsede/modulefiles ---------------------------
   cue-login-env    xdinfo/1.5-1    xdusage/2.1-1

-------------------------------- /usr/share/modulefiles --------------------------------
   DefaultModules    gct/6.2       gpu/0.15.4     (L)
   cpu/0.15.4        globus/6.0    nostack/0.15.4

-------------------------------- /cm/shared/modulefiles --------------------------------
   cuda10.2/blas/10.2.89      cuda10.2/profiler/10.2.89    sdsc/1.0
   cuda10.2/fft/10.2.89       cuda10.2/toolkit/10.2.89     xsede/xdusage/2.1-1
   cuda10.2/nsight/10.2.89    default-environment

```
* Select the cuda modules you need and load them:
```
module add cuda10.2/toolkit/10.2.89 
```
* You can then see that NVCC compiler is available

```
[mthomas@exp-9-55 ~]$ which nvcc
/cm/shared/apps/cuda10.2/toolkit/10.2.89/bin/nvcc
```


Note: MPT (2/4/21) This should not be needed:
If you get a license error when executing the PGI compilers, execute the following:
```
export LM_LICENSE_FILE=40200@elprado.sdsc.edu:$LM_LICENSE_FILE
```


### TASKS 2 and 3 begin in the section called:
*"Simple code samples accompanying slides"*

Change to directory cuda-samples, compile with
```
nvcc example.cu -o example.x
```

### TASK 2:  cd into the GPU code directory:
```
% cd gpu-code-examples/cuda-samples
```

See the README.md files for instructions.
Run the following examples

	- hello_world
	- addition


### TASK 3:  cd into the OpenACC code directory:
```
% cd gpu-code-examples/openacc-samples
```
See the README.md file for instructions.

Compile C code with OpenACC pragmas with
```
pgcc example.c -o example.x -acc -Minfo=accel
```

Compile and run the following example:
```
	 - saxpy
```	 
The more ambitious are free to reproduce timings for the `laplace-2d` example (see README.md file)
