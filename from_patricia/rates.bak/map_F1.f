      PROGRAM map_F1

      IMPLICIT NONE

c      INTEGER Z,A
      REAL*8 Z,A
      REAL*8 w,x(5),mp,cur_x
      REAL*8 q2,w2,rc
      REAL*8 inf1,inf2,qef1,qef2
      INTEGER i,j
      REAL*8 nu,ep,s2,thrad,theta,d_r

      mp = 0.938272  ! GeV/c^2
      d_r = 3.14159265/180.0
      Z = 1
      A = 2
c      q2 = 5.564
c      w2 = 1.290

      OPEN(UNIT=8, FILE='output/f1_map.txt', STATUS='UNKNOWN')

c      write(6,*) "Number of protons in the nucleus: "
c      read(5,*) Z
c      write(6,*) "Total number of nucleons in the nucleus: "
c      read(5,*) A
c      write(6,*) "Enter Q^2 in (GeV/c)^2: "
c      read(5,*) q2
c      write(6,*) "Enter W^2 in GeV^2: "
c      read(5,*) w2

      x(1) = 0.1
      x(2) = 0.3
      x(3) = 0.5
      x(4) = 0.75
      x(5) = 1.00
      q2 = 0.5


c      write(6,*) "x         Q^2      w2     inf1        qef1         inf2    qef2"
      cur_x = 0.1
      do 20 i=1,250
c         cur_x = x(i)

         q2=0.5
         do 10 j=1,460
            w = sqrt(mp**2+q2/cur_x-q2)
            w2 = w*w
            nu = q2/(2.*mp*cur_x)
            ep = 11.0 - nu
            s2 = q2/(4.0*11.0*ep)
            thrad = 2.0*asin(sqrt(s2))
            theta = thrad/d_r
            if (w.le.3.2.and.ep.gt.2.5.and.ep.lt.10.4.and.theta.gt.7.3) then
               call F1F2IN09(Z,A,q2,w2,inf1,inf2,rc)  
               call F1F2QE09(Z,A,q2,w2,qef1,qef2) 
               write(6,1001) cur_x,q2,w2,inf1,qef1,inf2,qef2
               write(8,1001) cur_x,q2,w2,inf1,qef1,inf2,qef2
            end if
            q2 = q2 + 0.01
   10    end do
         cur_x = cur_x + 0.01
   20  end do
 





c      Z = 2
c      A = 4
c      call F1F2IN09(Z,A,q2,w2,inf1,inf2,rc)  
c      call F1F2QE09(Z,A,q2,w2,qef1,qef2) 
c      write(6,1001) inf1,qef1,inf2,qef2,"He" 
c
c      Z = 7
c      A = 14
c      call F1F2IN09(Z,A,q2,w2,inf1,inf2,rc)  
c      call F1F2QE09(Z,A,q2,w2,qef1,qef2) 
c      write(6,1001) inf1,qef1,inf2,qef2,"N " 
c
c      write(6,*)"Q2 = ",q2
c      write(6,*)"W2 = ",w2
c


 1001 format(3(f7.3,1x),4(E10.3,1x))
      END
