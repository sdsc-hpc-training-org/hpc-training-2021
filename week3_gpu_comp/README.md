# SDSC HPC User Training:  Spring 2020
**WEEK 3:** 01/24/2020

## TOPIC: GPU Computing and Programming

**Presented By:** [Andreas Goetz, SDSC](https://www.sdsc.edu/research/researcher_spotlight/goetz_andreas.html) (agoetz  at  sdsc.edu)

### READINGS AND PRESENTATIONS:

* **Lecture slides:** [https://github.com/sdsc-hpc-training-org/hpc-training-2021/blob/main/week3_gpu_comp/sdsc-scc-gpu-computing-mpt-2021-02-05.pdf](https://github.com/sdsc-hpc-training-org/hpc-training-2021/blob/main/week3_gpu_comp/sdsc-scc-gpu-computing-mpt-2021-02-05.pdf)
* **Video Recording:** [Week 3: GPU Computing and Programming](https://www.youtube.com/watch?v=l5FSJ1kJHdA&t=1235s)
* **Source Code/Examples:** 
    * [exp101-examples](https://github.com/sdsc-hpc-training-org/hpc-training-2021/tree/main/week3_gpu_comp/exp101-examples/OpenACC)
    * [gpu-code-examples](https://github.com/sdsc-hpc-training-org/hpc-training-2021/tree/main/week3_gpu_comp/gpu-code-examples)


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

### Load the GPU environment modules
* See: [Loading the GPU CUDA Environment](https://github.com/sdsc-hpc-training-org/hpc-training-2021/blob/main/week3_gpu_comp/loading_cuda_env.md) file, located in this repository.

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

### Note: Reporting your work:
We will track your work using automated scripts
You will need to name the directories and permissions as described in the ``reporting_your_work.md`` document.
