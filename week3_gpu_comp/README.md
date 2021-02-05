# SDSC HPC User Training:  Spring 2020
**WEEK 3:** 01/24/2020

## TOPIC: GPU Computing and Programming

**Presented By:** [Andreas Goetz, SDSC](https://www.sdsc.edu/research/researcher_spotlight/goetz_andreas.html) (agoetz  at  sdsc.edu)

### READING AND PRESENTATIONS:

Lecture slides:
* [TBA](TBA)

Example source code accompanying the lecture slides with instructions are in directory gpu-code-examples.


## WEEK3 TASKS:
### TASK 1:  Using GPU nodes  
    Clone this repository;
    `cd` into the `gpu-code-examples` directory

```
% cd gpu-code-examples
```
See the README.md file in the tarfile directory and
follow instructions on "How to use Comet's GPU nodes"


# Obtain interactive shared GPU node on SDSC Comet
Source `getgpu.rc`, which defines an alias `getgpu` that you can use to obtain an interactive GPU node:
`source getgpu.rc`
`getgpu`

The script `getgpu.rc` defines the SLURM launch command below to obtain an interactive node with access to 1 K80 GPU on the shared GPU nodes for 3h. You can also execute this command directly on the command line:

```
srun --partition=gpu-shared --reservation=gputraining \
     --nodes=1 --ntasks-per-node=6 --gres=gpu:k80:1 \
     -t 03:00:00 --pty --wait=0 /bin/bash
```

It may take some time to get the interactive node.

Load the CUDA and PGI compiler modules
```
module purge
module load gnutools
module load cuda
module load pgi
```

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
