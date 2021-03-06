# SDSC HPC User Training: Spring 2021

###  WEEK 7: 03/05/2021

## TOPIC: CPU Profiling, monitoring: gprof, mpiP/comms, uProf	

**Presented By:** [Robert Sinkovits](https://www.sdsc.edu/research/researcher_spotlight/sinkovits_robert.html) (sinkovit  at  sdsc.edu)

## READING AND PRESENTATIONS:

* **Lecture slides:** [Week 7: CPU profiling on Expanse](https://github.com/sdsc-hpc-training-org/hpc-training-2021/blob/main/week7_cpu_prof/ProfileExpanse.pdf)
* **Video Recording:** [Week 6: Video TBD]
* **Source Code/Examples:** 
   * **Note:**  The material in this repository was pulled on 3/5/21 from the following repo: 
   * https://github.com/sinkovit/profiling-tutorial
   * Check this repository for updates.

## Description:  profiling-tutorial
Brief tutorial illustrating gprof and AMD uProf with exercises that run as-is on SDSC's *Expanse*

### TimeBasedSampling
Demonstration of gprof and uProf on a contrived Fortran example. The subdirectories contain uProf output in
both CSV SQLite (.db) format.

### DataAccessSampling
Demonstration of uProf on a matrix addition problem. The subdirectories contain uProf output in
both CSV SQLite (.db) format.


## WEEK 7 TASKS:

### Task 1: Self-paced exercises – gprof
* Run the gprof example (intro.f code) and convince yourself that you understand the output.
* Modify functions f1 and f2 in intro.f to use sin, cos, and log functions. How does this affect what you see in the gprof output? (Hint – google SVML).
These functions are expensive and can lead to longer run times – adjust problem size accordingly. For your convenience, commented lines already added to file.
* Break intro.f into multiple files and rerun gprof. What does this tell you about the compiler’s inlining capabilities?
   * intro.fà2 files: main.f, library.f (sub1, sub2, f1, f2)
   * intro.fà3 files: main.f, subs.f (sub1, sub2), funcs.f (f1, f2)
* Explore other compilers (AOCC flang and GCC gfortran)

### Task 2: Self-paced exercises – uProf
* Read the uProf user guide https://developer.amd.com/wordpress/media/files/AMDuprof_Resources/User_G uide_AMD_uProf_v3.3_GA.pdf
* Once uProf is installed on Expanse
   * Profile intro.f using time based profiling
   * Profile matrix addition (dmadd_[good|bad].f) using time based and data access profiling
   * Look at the effect of omitting -g flag on uProf output
   * Investigate effect of matrix addition problem size. Do you see the same behavior for other powers of two (e.g., N=16,384, 8192) or dimensions that contain large powers of two (e.g., N=213 x 3 = 24,576)


### Note: Reporting your work:
We will track your work using automated scripts
You will need to name the directories and permissions as described in the ``reporting_your_work.md`` document.

