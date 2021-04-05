# SDSC HPC User Training: Spring 2021

###  WEEK 8: 03/12/2021

## TOPIC: GPU Profiling: nvprof, Nsight Systems, Nsight Compute	

**Presented By:** [Mahidhar Tatineni]

## READING AND PRESENTATIONS:

* **Lecture slides:** [Week 8: Expanse GPU Profiling](https://github.com/sdsc-hpc-training-org/hpc-training-2021/blob/main/week8_gpu_prof/Expanse_GPU_Profiling_MTatineni.pdf)
* **Video Recording:** [Week 8: Video TBD]
* **Source Code/Examples:** [CUDA SDK Examples on Expanse system]



## WEEK 7 TASKS:

### Task 1: Setting up to run GPU code on Expanse:
See lecture notes from Week3 which has instructions for [Working on the
GPU nodes: ](https://github.com/sdsc-hpc-training-org/hpc-training-2021/blob/main/week3_gpu_comp/README.md)
* Be sure to download the CUDA example codes.


### Task 2: Learning About NVIDIA *nvprof*
* nvprof documentation: [https://docs.nvidia.com/cuda/profiler-users-guide/index.html#nvprof-overview](https://docs.nvidia.com/cuda/profiler-users-guide/index.html#nvprof-overview)
* 
* 
* • Use CUDA SDK examples to illustrate profiling process • Import/export of profiles
• Openacc example


### Task 3: Learning About Nsight Profiler
* Nsight Systems Tutorial: [https://developer.nvidia.com/blog/transitioning-nsight-systems-nvidia-visual-profiler-nvprof/](https://developer.nvidia.com/blog/transitioning-nsight-systems-nvidia-visual-profiler-nvprof/) 
* Using CUDA SDK and vector addition examples to illustrate offline GUI use
    * Using cuSolverSp_LinearSolver  from the CUDA Example files (see Task 1)
* Nsight Systems: Simple Profiling Example (STEPS):
    * Get interactive access on a GPU node:
```
srun --pty --nodes=1 --ntasks-per-node=1 --cpus-per-task=10 -p gpu-shared -- gpus=1 -A XYZ123 -t 00:15:00 --wait 0 /bin/bash
```
* Set up profiling environment (see Slides 12-15):
```
module reset
module load cuda10.2/toolkit
export PATH=/cm/shared/examples/sdsc/nsight/v2020.5/bin:$PATH
```
    * Profile with cli and write to baseline report file:
nsys profile -t cuda,osrt -o baseline -w true ./cuSolverSp_LinearSolver
```

### Task 4: Learning About Nsight Compute 
  * Read about [Nsight Compute: ](https://developer.nvidia.com/blog/analysis-driven-optimization-preparing-for-analysis-with-nvidia-nsight-compute-part-1/)
  * Note: urrently disabled on Expanse


### Note: Reporting your work:
We will track your work using automated scripts
You will need to name the directories and permissions as described in the ``reporting_your_work.md`` document.
