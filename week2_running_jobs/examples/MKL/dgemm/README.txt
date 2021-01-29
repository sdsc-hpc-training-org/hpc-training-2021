### MPT:  10/7/2020 -- Example is not working

[1] Compile:

module purge
module load slurm
module load cpu
module load gpu/0.15.4  
module load intel/19.0.5.281
module load intel-mkl/2020.3.279

ifort -o dgemm_example  -mkl -static-intel dgemm_example.f

[2] Run:

sbatch dgemm-slurm.sb

NOTE: for other compilers, replace "ifort"
with the one you want to use.
