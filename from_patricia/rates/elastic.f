c ***************************************************************************
c **  Subroutine to estimate the inclusive elastic cross section
c ** based on the EM form factors given by the Kelly Fit (PRC 70, 068202 2004)
c **
c ** QSQ must be in (GeV/c)^2, TH in radians, and E in GeV
c **
c ** Elena Long
c ** ellie@jlab.org
c ** 2015-02-24
c **
c ***************************************************************************

      SUBROUTINE elastic(Z, A, QSQ, TH, E, XS)
      implicit none
      REAL*8 Z,A,QSQ,TH,E,XS,EPRIME
      REAL*8 GEN,GEP,GMN,GMP,GD
      REAL*8 a0,a1,b1,b2,b3,AGEN,BGEN
      REAL*8 tau,mp,LAMBDASQ
      REAL*8 mun,mup
      REAL*8 XSP,XSN

      mp = 0.938272        ! GeV/c
      tau = QSQ/(2.*mp**2) 
      LAMBDASQ = 0.71      ! (GeV/c)^2
      mun = -1.9130
      mup = 2.7928

c     Define GEn using the Galster fit
      AGEN = 1.70
      BGEN = 3.30
      GD = 1/((1+QSQ/LAMBDASQ)**2)
      GEN = AGEN*tau*GD/(1+BGEN*tau)

c     Define GEp using Kelly fit
      a0 = 1
      a1 = -0.24
      b1 = 10.98
      b2 = 12.82
      b3 = 21.97
      GEP = (a0+a1*tau)/(1+b1*tau+b2*tau**2+b3*tau**3)

c     Define GMn using Kelly fit
      a0 = 1
      a1 = 2.33
      b1 = 14.72
      b2 = 24.20
      b3 = 84.1
      GMN = mun*(a0+a1*tau)/(1+b1*tau+b2*tau**2+b3*tau**3)

c     Define GMp using Kelly fit
      a0 = 1
      a1 = 0.12
      b1 = 10.97
      b2 = 18.86
      b3 = 6.55
      GMP = mup*(a0+a1*tau)/(1+b1*tau+b2*tau**2+b3*tau**3)

c     Define cross section

      EPRIME = E/(1+((E/mp)*(1-cos(TH))))
      XSP = ((4*(7.29735257e-3)*(7.29735257e-3)*3.8937e-32)*
     &     EPRIME*EPRIME*(cos(TH/2)*cos(TH/2))*(1/(QSQ*QSQ)))*
     &     (EPRIME/E)*(((GEP*GEP + tau*GMP*GMP)/(1+tau)) + 
     &     2*tau*GMP*GMP*(tan(TH/2)*tan(TH/2)))*1E28
      XSN = ((4*(7.29735257e-3)*(7.29735257e-3)*3.8937e-32)*
     &     EPRIME*EPRIME*(cos(TH/2)*cos(TH/2))*(1/(QSQ*QSQ)))*
     &     (EPRIME/E)*(((GEN*GEN + tau*GMN*GMN)/(1+tau)) + 
     &     2*tau*GMN*GMN*(tan(TH/2)*tan(TH/2)))*1E28

      XS = (A-Z)*XSN + Z*XSP

      write (6,*) "EPRIME = ",EPRIME," GeV" 
      write (6,*) "-------------------------------" 
      write (6,*) "According to the JJ Kelly fit, " 
      write (6,*) "GEN = ",GEN 
      write (6,*) "GMN = ",GMN 
      write (6,*) "GEP = ",GEP 
      write (6,*) "GMP = ",GMP 
      write (6,*) " - - - - - - - - - - - - - - - " 
      write (6,*) "GEP/G_D = ",(GEP/GD) 
      write (6,*) "GEN/G_D = ",(GEN/GD) 
      write (6,*) "GMP/(mu_p*G_D) = ",(GMP/(mup*GD)) 
      write (6,*) "GMN/(mu_n*G_D) = ",(GMN/(mun*GD)) 
      write (6,*) "-------------------------------" 

      write (6,*) "Assuming free nucleons, we find:" 
      write (6,*) "(dsigma/dOmega)_p = ",XSP," m^2" 
      write (6,*) "(dsigma/dOmega)_n = ",XSN," m^2" 
      write (6,*) " - - - - - - - - - - - - - - - " 
      write (6,*) "XS = ",XS

      RETURN
      END









