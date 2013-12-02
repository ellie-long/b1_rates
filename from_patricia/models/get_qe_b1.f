      PROGRAM QE_b1

      integer :: clck_counts_beg, clck_counts_end, clck_rate
      DOUBLE PRECISION x,Aout
      INTEGER ix

      call system_clock ( clck_counts_beg, clck_rate )

      OPEN(UNIT= 8, FILE='output/Azz_frankfurt.dat', STATUS='UNKNOWN')

      do ix=1,300
           x = dble(ix)/100
           if (x.le.0.75) then
                Aout = 0
           elseif (x.gt.0.75.and.x.lt.1.425) then
                Aout = -56.8296 + 246.102*x - 351.484*x*x 
     &                 + 111.641*x*x*x + 163.698*x*x*x*x 
     &                 - 148.174*x*x*x*x*x + 35.0491*x*x*x*x*x*x
           elseif (x.ge.1.425) then
                Aout = 1
           endif
c           Aout = (2./(0.3*0.35))*Aout
           write(8,1001)x,Aout
      enddo

      call system_clock ( clck_counts_end, clck_rate )
      write(6,*) "-------------------------------------------"
      write(6,*) "Clock:"
      write (6, *)  (clck_counts_end - clck_counts_beg)/real (clck_rate)

 1020 continue
      stop

 1001 format(2(1x,E10.3))

      END
