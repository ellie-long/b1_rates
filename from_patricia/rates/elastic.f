c ***************************************************************************
c **
c ** elastic.f
c **
c ** Subroutine to estimate the inclusive elastic cross section
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
      REAL*8 Z,A,QSQ,TH,E,XS,EPRIME,THETA,EP_EL,NU,x
      REAL*8 GEN,GEP,GMN,GMP,GD
      REAL*8 a0,a1,a2,a3,b0,b1,b2,b3,Ae,Be,F
      REAL*8 a4,a5,a6,atot1,atot2
      REAL*8 tau,mp,LAMBDASQ,alpha1,r,r0
      REAL*8 mun,mup,hbarc,alpha,hbar
      REAL*8 XSP,XSN,XSmott,delta,XS_IN

      mp       = 0.938272        ! GeV/c
      tau      = QSQ/(4.*mp**2) 
      LAMBDASQ = 0.71            ! (GeV/c)^2
      mun      = -1.9130
      mup      = 2.7928
      hbarc    = 0.197327    ! fm*GeV
      alpha    = 1.0/137.0
c      EPRIME   = E/(1+((E/mp)*(1-cos(TH))))
      EPRIME   = QSQ/(4*E*sin(TH/2)**2)
      NU       = E-EPRIME
      THETA    = TH*180/3.14159
      x        = QSQ/(2*0.938*NU)
      if (x.lt.2.02) then
         XS_IN    = XS
      else
         XS_IN    = 1E-200
c         XS_IN    = XS
      endif
      write(6,*) "XS_IN: ",XS_IN

! Define deuteron elastic scattering
      if (A.eq.2.and.Z.eq.1) then
         ! Define deuteron form factors
         a0 = -1.85931E-2
         a1 = -1.37215e+01
         a2 = 3.23622e+01
         a3 = -4.29740e+01
         atot1 = a0+a1*QSQ+a2*QSQ**2+a3*QSQ**3

         a4 = -2.68235
         a5 = -1.47849
         a6 = 0.0782541
         atot2 = a4+a5*QSQ+a6*QSQ**2
         Ae = 10**(atot1)+10**(atot2)

         b0 = -2.26938
         b1 = -3.18194
         b2 = 0.147926
         Be = 10**(b0+b1*QSQ+b2*QSQ**2)

         EP_EL = E-QSQ/(2*1.876)
         ! Define cross section
         XSmott = (1**2*alpha**2*hbarc**2*cos(TH/2)**2)/
     &               (4*E**2*sin(TH/2)**4)*0.01 ! barn
c         XSmott = ((1*alpha*cos(TH/2.)/(2.*E*sin(TH/2.)**2))**2.) ! barn/GeV*str 
                                                                        ! (1E-24 cm^2/(GeV/str))
c         XSmott = XSmott/(1+(2.*E/1.876)*sin(TH/2)**2)
c         XSmott = XSmott/(1-(QSQ/(2.*1.876**2))*sin(TH/2.)**2/cos(TH/2.)**2)
c         XS = XSmott

         delta = 5000/sqrt(3.14159)*exp(-5000**2*(EPRIME-EP_EL)**2)
         XS = XS_IN + (XSmott*EPRIME/E*(Ae+Be*tan(TH/2)**2)*delta)
         if (x.gt.2.02) then
           XS = 0
         endif

         write (6,*) "QSQ = ",QSQ
         write (6,*) "E   = ",E
         write (6,*) "E'  = ",EPRIME
         write (6,*) "TH  = ",THETA
         write (6,*) "E'el= ",EP_EL
         write (6,*) "delt= ",delta
c         write (6,*) "atot1= ",atot1
c         write (6,*) "atot2= ",atot2
c         write (6,*) "A   = ",Ae
c         write (6,*) "B   = ",Be
         write (6,*) "XSM = ",XSmott
         write (6,*) "XS  = ",XS
c      endif

! Define large nuclei elastic scattering
      elseif (Z.gt.1) then
         hbar = 0.197327 ! fm*GeV/c
         r0=1.2 ! fm
         r=r0*A**(1/3)   ! fm
         XSmott = (1**2*alpha**2*hbarc**2*cos(TH/2)**2)/
     &               (4*E**2*sin(TH/2)**4)*EPRIME/E ! barn
c         XSmott = hbarc*((1*alpha*cos(TH/2.)/(2.*E*sin(TH/2)**2))**2.) ! barn/GeV*str 
                                                                        ! (1E-24 cm^2/(GeV/str))
         alpha1=sqrt(QSQ)*r/hbar
         F=(3/alpha1**3)*(sin(alpha1)-alpha1*cos(alpha1))
         XS=XSmott*F
      endif

! Define nucleon elastic scattering
      if (A.eq.1) then
c        Define GEn using the Galster fit
         Ae = 1.70
         Be = 3.30
         GD = 1/((1+QSQ/LAMBDASQ)**2)
         GEN = Ae*tau*GD/(1+Be*tau)

c        Define GEp using Kelly fit
         a0 = 1
         a1 = -0.24
         b1 = 10.98
         b2 = 12.82
         b3 = 21.97
         GEP = (a0+a1*tau)/(1+b1*tau+b2*tau**2+b3*tau**3)

c        Define GMn using Kelly fit
         a0 = 1
         a1 = 2.33
         b1 = 14.72
         b2 = 24.20
         b3 = 84.1
         GMN = mun*(a0+a1*tau)/(1+b1*tau+b2*tau**2+b3*tau**3)

c        Define GMp using Kelly fit
         a0 = 1
         a1 = 0.12
         b1 = 10.97
         b2 = 18.86
         b3 = 6.55
         GMP = mup*(a0+a1*tau)/(1+b1*tau+b2*tau**2+b3*tau**3)

c        Define cross section

         XSmott = (1**2*alpha**2*hbarc**2*cos(TH/2)**2)/
     &               (4*E**2*sin(TH/2)**4)*EPRIME/E ! barn
c         XSmott = hbarc*((1*alpha*cos(TH/2.)/(2.*E*sin(TH/2)**2))**2.) ! barn/GeV*str 
                                                                        ! (1E-24 cm^2/(GeV/str))


         XSP = XSmott*((GEP**2+tau*GMP**2)/(1+tau) +
     &          2*tau*(GMP**2)*(tan(TH/2)**2))

         XSN = XSmott*((GEN**2+tau*GMN**2)/(1+tau) +
     &          2*tau*(GMN**2)*(tan(TH/2)**2))

c         XSP = ((4*(7.29735257e-3)*(7.29735257e-3)*3.8937e-32)*
c     &        EPRIME*EPRIME*(cos(TH/2)*cos(TH/2))*(1/(QSQ*QSQ)))*
c     &        (EPRIME/E)*(((GEP*GEP + tau*GMP*GMP)/(1+tau)) + 
c     &        2*tau*GMP*GMP*(tan(TH/2)*tan(TH/2)))*1E28
c         XSN = ((4*(7.29735257e-3)*(7.29735257e-3)*3.8937e-32)*
c     &        EPRIME*EPRIME*(cos(TH/2)*cos(TH/2))*(1/(QSQ*QSQ)))*
c     &        (EPRIME/E)*(((GEN*GEN + tau*GMN*GMN)/(1+tau)) + 
c     &        2*tau*GMN*GMN*(tan(TH/2)*tan(TH/2)))*1E28

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
      endif


      RETURN
      END









