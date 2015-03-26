      SUBROUTINE QE_b1(QQ)
      IMPLICIT NONE

      integer :: clck_counts_beg, clck_counts_end, clck_rate
      DOUBLE PRECISION x,Aout,QQ,xplat
      INTEGER ix
      

      call system_clock ( clck_counts_beg, clck_rate )

      OPEN(UNIT= 8, FILE='../models/output/Azz_frankfurt.dat', 
     &              STATUS='UNKNOWN')


      do ix=1,500
           x = dble(ix)/100
           xplat=1.64203-0.177032*log(QQ)
           if (x.le.0.75) then
                Aout = 0      
           elseif (x.gt.0.75.and.x.lt.1) then
                Aout = -56.8296 + 246.102*x - 351.484*x*x 
     &                 + 111.641*x*x*x + 163.698*x*x*x*x 
     &                 - 148.174*x*x*x*x*x + 35.0491*x*x*x*x*x*x
           elseif (x.gt.1.and.x.lt.xplat) then
                Aout=(1/(xplat-1))*x+(1/(1-xplat))
c                Aout=(1+(1/(xplat-1))/xplat)*x
c     &               -(1/(1-xplat))
           elseif (x.ge.xplat.or.x.eq.xplat) then
                Aout = 1
           endif

c           if (x.le.0.75) then
c                Aout = 0
c           elseif (x.gt.0.75.and.x.lt.1.425) then
c                Aout = -56.8296 + 246.102*x - 351.484*x*x 
c     &                 + 111.641*x*x*x + 163.698*x*x*x*x 
c     &                 - 148.174*x*x*x*x*x + 35.0491*x*x*x*x*x*x
c           elseif (x.ge.1.425) then
c                Aout = 1
c           endif
c           Aout = (2./(0.3*0.35))*Aout
           Aout = -Aout
           write(8,1001)x,Aout
      enddo

      call system_clock ( clck_counts_end, clck_rate )
      write(6,*) "-------------------------------------------"
      write(6,*) "QE_b1 Clock:"
      write (6, *)  (clck_counts_end - clck_counts_beg)/real (clck_rate)
      RETURN

 1020 continue
      stop

 1001 format(2(1x,E10.3))


      END
