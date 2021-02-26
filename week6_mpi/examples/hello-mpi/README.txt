[1] Compile:


### MODULE ENV: updated 01/28/2020 (MPT)
 module purge 
 module load slurm 
 module load cpu
 module load gcc/10.2.0
 module load openmpi/4.0.4

mpifort -o hello_mpi hello_mpi.f90

[2a] Run using Slurm:

sbatch hellompi-slurm.sb

