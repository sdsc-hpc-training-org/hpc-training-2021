Content
=======
This directory contains the slides and exercises for the SCC 2020
training in GPU computing and programming.

Lecture January 24, 2020

Andreas Goetz, SDSC (agoetz@sdsc.edu)


How to use Comet's GPU nodes
============================

# Obtain interactive shared GPU node on SDSC Comet (3h allocation)
`../getgpu` 

This will launch the command

```
srun --partition=gpu-shared --reservation=gputraining \
     --nodes=1 --ntasks-per-node=6 --gres=gpu:k80:1 \
	 -t 03:00:00 --pty --wait=0 /bin/bash
```


# Load CUDA and PGI compiler modules
```
module purge
module load gnutools
module load cuda
module load pgi
```


# Check nvcc compiler version
` nvcc --version`


# Check installed GPUs with NVIDIA System Management Interface (nvidia-smi)
`nvidia-smi`

This will also show any currently running jobs on GPUs.


# Check visible devices (should be set to free GPU)
`echo $CUDA_VISIBLE_DEVICES`

This environment variable should be set by the queuing system to the 
ID of the free GPU.



NVIDIA CUDA Toolkit code samples
================================

# Copy and compile CUDA code samples that come with the CUDA Toolkit
Install into current directory:
```
cuda-install-samples-7.0.sh ./
cd NVIDIA_CUDA-7.0_Samples
```

Compile the samples:
```
make -j 6
```

Or compile only samples of interest, e.g. `deviceQuery`:
```
cd 1_Utilities/deviceQuery
make
```


# Check out the many code samples
This is a very instructive resource, it is a good idea to have a look
at these.


# Run deviceQuery to query information on available GPUs
```
cd 1_Utilities/deviceQuery/
./deviceQuery
```


Simple code samples accompanying slides
=======================================

# See directory cuda-samples
Compile with 
```
nvcc example.cu -o example.x
```

# See directory openacc-samples
Compile with 
```
pgcc example.c -o example.x -acc -Minfo=accel
```


