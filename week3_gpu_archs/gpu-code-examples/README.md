Content
=======
This directory contains the slides and exercises for the
SDSC HPC User Training 2021 in GPU computing and programming.

Lecture February 5, 2021

Andreas Goetz, SDSC (agoetz@sdsc.edu)


How to use Expanse's GPU nodes
============================

# Obtain interactive shared GPU node on SDSC Expanse (3h allocation)
* setup your CUDA environment:
#Environment

```
module purge
module load slurm
module load gpu
module load pgi

```

* Then run the gpu interactive node script:

```../getgpu```

This will launch the command:

```
srun --pty --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 \
 -p gpu-shared --gpus=1 -t 03:00:00 -A sds173 /bin/bash

```


# Load CUDA and PGI compiler modules

```

module purge
module load gnutools
module purge
module load slurm
module load gpu
module load pgi


```


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

Install into current directory:

```
cuda-install-samples-7.0.sh ./
cd NVIDIA_CUDA-7.0_Samples

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
