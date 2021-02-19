      PROGRAM HEATEQN
      implicit none
      integer :: iglobal, itime, nthreads
      real*8 :: xalp,delx,delt,pi
      real*8 :: T(0:100,0:10)
      integer:: id
      integer:: OMP_GET_THREAD_NUM, OMP_GET_NUM_THREADS

!$OMP PARALLEL SHARED(nthreads)
!$OMP MASTER
      nthreads = omp_get_num_threads()
      write (*,*) 'There are', nthreads, 'threads'
!$OMP END MASTER
!$OMP END PARALLEL
      if (nthreads.ne.3) then
         write(*,*)"Use exactly 3 threads for this case"
         stop
      endif
      delx = 0.1d0
      delt = 1d-4
      xalp = 2.0d0
 
************** Initial Conditions *********************************
      pi = 4d0*datan(1d0)
      do iglobal = 0, 10
        T(0,iglobal) = dsin(pi*delx*dfloat(iglobal))
      enddo
************** Iterations ****************************************
      do itime = 1 , 3 
       write(*,*)"Running Iteration Number ", itime
!$OMP PARALLEL DO PRIVATE(iglobal) SHARED(T,xalp,delx,delt,itime)
       do iglobal = 1, 9 
        T(itime,iglobal)=T(itime-1,iglobal)+
     +  xalp*delt/delx/delx*
     +  (T(itime-1,iglobal-1)-2*T(itime-1,iglobal)+T(itime-1,iglobal+1))
       enddo
!$OMP BARRIER
      enddo
      do iglobal = 0, 10
        write(*,*)iglobal,T(3, iglobal)
      enddo
      END
