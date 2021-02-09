## Loading the CUDA environment on GPUs

### Getting access to a GPU node
You will either access the node directly using the *srun* command to obtain an interactive node, or via the *sbatch* command that submits your *batchscript* to the Slurm queue.

#### Verify that you are on a GPU node:
* Run the *nvidia-smi* command:

```
[mthomas@exp-7-59 ~]$ nvidia-smi
Mon Feb  8 22:17:24 2021       
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 450.51.05    Driver Version: 450.51.05    CUDA Version: 11.0     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|                               |                      |               MIG M. |
|===============================+======================+======================|
|   0  Tesla V100-SXM2...  On   | 00000000:18:00.0 Off |                    0 |
| N/A   32C    P0    41W / 300W |      0MiB / 32510MiB |      0%      Default |
|                               |                      |                  N/A |
+-------------------------------+----------------------+----------------------+
                                                                               
+-----------------------------------------------------------------------------+
| Processes:                                                                  |
|  GPU   GI   CI        PID   Type   Process name                  GPU Memory |
|        ID   ID                                                   Usage      |
|=============================================================================|
|  No running processes found                                                 |
+-----------------------------------------------------------------------------+
```

### Set up the GPU module environment

Load the GPU environment modules -- add these lines to your batch script, or enter them on the command line

```
module purge
module load slurm
module load  gpu/0.15.4
module load pgi

```
### Once you have loaded the *gpu* module, you will have access to the CUDA libraries. Run the *avail*
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
### Select the cuda modules you need and load them:
```
module add cuda10.2/toolkit/10.2.89 
```
### You can then see that NVCC compiler is available

```
[mthomas@exp-9-55 ~]$ which nvcc
/cm/shared/apps/cuda10.2/toolkit/10.2.89/bin/nvcc
```


### Note: MPT (2/4/21) This should not be needed:
If you get a license error when executing the PGI compilers, execute the following:
```
export LM_LICENSE_FILE=40200@elprado.sdsc.edu:$LM_LICENSE_FILE
```

