c vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c
c sub_qe_b1d.f
c
c This code is written to get Azz and b1 in the 
c QE region. Currently, it's using a model by
c Frankfurt and Strikman from their 1988 Phys. Rept.
c paper.
c
c Elena Long
c ellie@jlab.org
c 9/12/2013
c 
c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 


      SUBROUTINE get_qe_b1d(x,QQ,Aout,F1out,b1out)
      IMPLICIT NONE
     
      DOUBLE PRECISION mp 
      DOUBLE PRECISION x,QQ,Aout,F1out,b1out
      DOUBLE PRECISION w2,F1d,F2d,xplat
      INTEGER z_d,a_d

      mp = 0.938272
      z_d = 1
      a_d = 2
      w2 = mp*mp + QQ/x - QQ
      call F1F2QE09(z_d,a_d,QQ,w2,F1d,F2d)
c      call F1F2QE21(z_d,a_d,QQ,w2,F1d,F2d)
      F1out = F1d
      xplat=1.64203-0.177032*log(QQ)
      if (x.le.0.75) then
           Aout = 0      
c      elseif (x.gt.0.75.and.x.lt.1.425) then
      elseif (x.gt.0.75.and.x.lt.1) then
           Aout = -56.8296 + 246.102*x - 351.484*x*x + 111.641*x*x*x 
     &            + 163.698*x*x*x*x - 148.174*x*x*x*x*x + 35.0491*x*x*x*x*x*x
      elseif (x.gt.1.and.x.lt.xplat) then
           Aout=(1/(xplat-1))*x+(1/(1-xplat))
c           Aout=(1+(1/(xplat-1))/xplat)*x
c     &               -(1/(1-xplat))
c      elseif (x.ge.1.425) then
      elseif (x.ge.xplat.or.x.eq.xplat) then
           Aout = 1
      endif


      b1out = (-3./2.)*Aout*F1d
      RETURN
      END



