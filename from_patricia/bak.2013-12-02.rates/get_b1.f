      PROGRAM get_F1

      IMPLICIT NONE

c      INTEGER Z,A
      REAL*8 Z,A
      REAL*8 q2,w2,rc
      REAL*8 inf1,inf2,qef1,qef2
      REAL*8 x,mp,Aout,b1

      mp = 0.938272 ! GeV/c^2
      Z = 1
      A = 2
      q2 = 1.01
      w2 = 9.97


c      write(6,*) "Number of protons in the nucleus: "
c      read(5,*) Z
c      write(6,*) "Total number of nucleons in the nucleus: "
c      read(5,*) A
      write(6,*) "Enter Q^2 in (GeV/c)^2: "
      read(5,*) q2
      write(6,*) "Enter W^2 in GeV^2: "
      read(5,*) w2

      x = q2/(w2+q2-(mp**2))

      
      call get_b1d(x,q2,Aout,F1out,b1out)
      call F1F2IN09(Z,A,q2,w2,inf1,inf2,rc)  
      call F1F2QE09(Z,A,q2,w2,qef1,qef2) 

      write(6,*) "inf1        qef1         inf2         qef2"
      write(6,1001) inf1,qef1,inf2,qef2,"d " 

      qef1 = 0
      inf2 = 0
      qef2 = 0
      call get_b1d(x,q2,Aout,inf1,b1)
      write(6,1001) inf1,qef1,inf2,qef2,"d2" 




      Z = 2
      A = 4
      call F1F2IN09(Z,A,q2,w2,inf1,inf2,rc)  
      call F1F2QE09(Z,A,q2,w2,qef1,qef2) 
      write(6,1001) inf1,qef1,inf2,qef2,"He" 

      Z = 7
      A = 14
      call F1F2IN09(Z,A,q2,w2,inf1,inf2,rc)  
      call F1F2QE09(Z,A,q2,w2,qef1,qef2) 
      write(6,1001) inf1,qef1,inf2,qef2,"N " 

      write(6,*)"Q2 = ",q2
      write(6,*)"W2 = ",w2



 1001 format(4(E10.3,1x),A2)
      END
