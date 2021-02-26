[1] load the  MODULE ENV (updated 02/25/2020)

 module purge
 module load slurm
 module load cpu
 module load gcc/10.2.0
 module load openmpi/4.0.4

[2] Compile:

mpicc -o pi_mpi pi_mpi.c


[3] Run using Slurm:

sbatch pi-mpi.sb
