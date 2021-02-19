CC=gcc
FC=gfortran

.PHONY: all clean

all: heat_openmp pi_openmp

pi_openmp: pi_openmp.c
	$(CC) -fopenmp -Wall -g -lm -o $@ $<

heat_openmp: heat_openmp.f90
	$(FC)  -ffixed-form -fopenmp -o $@ $<

clean:
	$(RM) heat_openmp pi_openmp
