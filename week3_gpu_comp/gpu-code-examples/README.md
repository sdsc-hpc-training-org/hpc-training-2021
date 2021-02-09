# Content
=======
This directory contains the slides and exercises for the
SDSC HPC User Training 2021 in GPU computing and programming.

Lecture February 5, 2021

Andreas Goetz, SDSC (agoetz@sdsc.edu)


How to use Expanse's GPU nodes
============================

## Obtain interactive shared GPU node on SDSC Expanse (3h allocation)


* setup the module environment:

```
module purge
module load slurm
module load gpu
module load gcc 
module load pgi

```

* Then run the gpu interactive node script:

```../getgpu```

This will launch the command:

```
srun --pty --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 \
 -p gpu-shared --gpus=1 -t 03:00:00 -A sds173 /bin/bash

```

## Load the GPU environment modules
* See: [Loading the GPU CUDA Environment](https://github.com/sdsc-hpc-training-org/hpc-training-2021/blob/main/week3_gpu_comp/loading_cuda_env.md) file, located in this repository.


### Check nvcc compiler version

```
nvcc --version

```


### Check installed GPUs with NVIDIA System Management Interface (nvidia-smi)

```
nvidia-smi
```

* This will also show any currently running jobs on GPUs.

### Check visible devices (should be set to free GPU)
`echo $CUDA_VISIBLE_DEVICES`

This environment variable should be set by the queuing system to the
ID of the free GPU.



## NVIDIA CUDA Toolkit code samples
================================

### Copy and compile CUDA code samples that come with the CUDA Toolkit

Install into cuda code directory directory <gpu-code-examples>:

```
mkdir gpu-code-examples

cp -r /cm/shared/apps/cuda10.2/sdk/10.2.89 ./gpu-code-examples
cd gpu-code-examples

```

* Compile the samples:

```
make -j 6

```

* Or compile only samples of interest, e.g. `deviceQuery`:

```
cd 1_Utilities/deviceQuery
make

```


### Check out the many code samples
This is a very instructive resource, it is a good idea to have a look
at these.


### Run deviceQuery to query information on available GPUs
```
cd 1_Utilities/deviceQuery/
./deviceQuery
```


## Simple code samples accompanying slides
=======================================

### See directory cuda-samples
Compile with
```
nvcc example.cu -o example.x
```

### See directory openacc-samples
Compile with
```
pgcc example.c -o example.x -acc -Minfo=accel
```
