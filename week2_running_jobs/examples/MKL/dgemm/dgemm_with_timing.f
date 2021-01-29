!==============================================================
!
! SAMPLE SOURCE CODE - SUBJECT TO THE TERMS OF SAMPLE CODE LICENSE AGREEMENT,
! http://software.intel.com/en-us/articles/intel-sample-source-code-license-agreement/
!
! Copyright 2016-2018 Intel Corporation
!
! THIS FILE IS PROVIDED "AS IS" WITH NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING BUT
! NOT LIMITED TO ANY IMPLIED WARRANTY OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
! PURPOSE, NON-INFRINGEMENT OF INTELLECTUAL PROPERTY RIGHTS.
!
! =============================================================
!*******************************************************************************
!   This example measures performance of computing the real matrix product 
!   C=alpha*A*B+beta*C using Intel(R) MKL subroutine DGEMM, where A, B, and C 
!   are matrices and alpha and beta are double precision scalars. 
!
!   In this simple example, practices such as memory management, data alignment, 
!   and I/O that are necessary for good programming style and high Intel(R) MKL 
!   performance are omitted to improve readability.
!*******************************************************************************

      PROGRAM   MAIN

      IMPLICIT NONE

      DOUBLE PRECISION ALPHA, BETA
      INTEGER          I, J, K, M, P, N, R, LOOP_COUNT
!   Consider adjusting LOOP_COUNT based on the performance of your 
!   computer to make sure that total run time is at least 1 second
      PARAMETER        (M=2000, P=200, N=1000, LOOP_COUNT=10)
      DOUBLE PRECISION A(M,P), B(P,N), C(M,N)
      DOUBLE PRECISION S_INITIAL, S_ELAPSED
      DOUBLE PRECISION DSECND
      
      PRINT *, "This example measures performance of computing the real"
      PRINT *, "matrix product C=alpha*A*B+beta*C using"
      PRINT *, "Intel(R) MKL subroutine DGEMM, where A, B, and C are "
      PRINT *, "matrices. alpha and beta are double precision scalars"
      PRINT *, ""

      PRINT *, "Initializing data for matrix multiplication C=A*B for "
      PRINT 10, " matrix A(",M," x",P, ") and matrix B(", P," x", N, ")"
10    FORMAT(a,I5,a,I5,a,I5,a,I5,a)
      PRINT *, ""
      ALPHA = 1.0 
      BETA = 0.0

      PRINT *, "Intializing matrix data"
      PRINT *, ""
      DO I = 1, M
          DO J = 1, P
              A(I,J) = (I-1) * P + J
          END DO
      END DO

      DO I = 1, P
          DO J = 1, N
              B(I,J) = -((I-1) * N + J)
          END DO
      END DO

      DO I = 1, M
          DO J = 1, N
              C(I,J) = 0.0
          END DO
      END DO

      PRINT *, "Making the first run of matrix product using "
      PRINT *, "Intel(R) MKL DGEMM subroutine to get stable "
      PRINT *, "run time measurements"
      PRINT *, ""
      CALL DGEMM('N','N',M,N,P,ALPHA,A,M,B,P,BETA,C,M)

      PRINT *, "Measuring performance of matrix product using "
      PRINT *, "Intel(R) MKL DGEMM subroutine"
      PRINT *, ""
      S_INITIAL = DSECND()
      DO R = 1, LOOP_COUNT
          CALL DGEMM('N','N',M,N,P,ALPHA,A,M,B,P,BETA,C,M)
      END DO
      S_ELAPSED = (DSECND() - S_INITIAL) / LOOP_COUNT
      PRINT *, "== Matrix multiplication using Intel(R) MKL DGEMM =="
      PRINT 50, " == completed at ",S_ELAPSED*1000," milliseconds =="
 50   FORMAT(A,F12.5,A)
      PRINT *, ""
      
      IF (S_ELAPSED < 0.9/LOOP_COUNT) THEN
          S_ELAPSED=1.D0/LOOP_COUNT/S_ELAPSED
          K=(S_ELAPSED*LOOP_COUNT)+1;
          PRINT *,"It is highly recommended to set parameter LOOP_COUNT"
          PRINT *, "for this example on your computer as ",K," to have "
          PRINT *, "total execution time about 1 second for reliability"
          PRINT *, "of measurements"
          PRINT *, ""
      ENDIF

      PRINT *, "Example completed."
      PRINT *, ""
      STOP 
      
      END
