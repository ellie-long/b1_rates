      PROGRAM QVECTOR

      ! Written by Karl Slifer

      IMPLICIT NONE

     &                                  
      INTEGER NL,NE

      PARAMETER( NL        = 1000    )
      PARAMETER( NE        = 6       )

      INTEGER I,K,IX,IQ
      REAL*8 E0_PASS,TH_PASS,EP_PASS
      REAL*8 RR1,RR2,PHISTAR,THSTAR,XNU
      REAL*8 ANGLE(NL,NE),ANGLE_R,PI,MP
      REAL*8 XX,QQ,NU,W2,W,THRAD,TH,TH_MIN,COSQVEC
      REAL*8 W2_GEV,XVAL(5),THVAL(5),S2

      COMMON /VPLRZ/ E0_PASS,TH_PASS,EP_PASS
c      DATA XVAL/0.15, 0.25, 0.35, 0.45, 0.55/
c      DATA THVAL/12.5, 9.5,13.16, 10.32, 12.5/
      DATA XVAL/0.10, 0.30, 0.5, 0.625, 0.75/
      DATA THVAL/10, 10, 10, 10, 10/


      PI = ACOS(-1.)
      MP = 938.272

      E0_PASS    = 11000.0   ! MEV

      WRITE(6,*)'   x      Q2       W      EP      TH0      THQ   COSQ'
  
      DO IX = 1,5
         XX       = XVAL(IX)
         TH_PASS  = THVAL(IX)
         THRAD    = TH_PASS*PI/180.0
         S2       = (SIN(THRAD/2.))**2
         QQ       = (4.0*E0_PASS**2*S2)/(1.+(4.0*E0_PASS*S2/2./MP/XX))
         W2       = MP**2 + QQ/XX - QQ
         W2_GEV   = W2*1E-6
         IF (W2_GEV.GE.0.0) THEN
            W        = SQRT(W2)
            EP_PASS  = E0_PASS - QQ/2./MP/XX

            RR1=0.0
            RR2=180.
            CALL ROTATION(RR1,RR2,PHISTAR,THSTAR)
            K = 1
            I = 1
            ANGLE(K,I) = 180. - THSTAR
            ANGLE_R    = ANGLE(K,I)*PI/180.
            COSQVEC    = cos(ANGLE_R)
            WRITE(6,'(7(F7.3,1X))')XX,QQ*1E-6,W*1E-3,
     &              EP_PASS*1E-3,TH_PASS,ANGLE(K,I),COSQVEC
            WRITE(66,'(F10.3)') ANGLE(K,I)
         ENDIF
      ENDDO
      RETURN
      END



      SUBROUTINE ROTATION(PHIT,THET,PHI,THR)
      ![ PHIT,THET,PHI,THR ] = deg
      IMPLICIT NONE
      REAL*8 PI,PHIT,THET,PHI,THR
      REAL*8 CSP,SNP,CST,SNT,COSTHS,QVEC,E0,TH,EP
      REAL*8 CSTHEQ,SNTHEQ,RR
      COMMON /VPLRZ/ E0,TH,EP
      REAL*8 X(3)

      !-------------------------------
      PI     =  ACOS(-1.)

      CSP    = COS(PHIT*PI/180.)
      SNP    = SIN(PHIT*PI/180.)
      CST    = COS(THET*PI/180.)
      SNT    = SIN(THET*PI/180.)
      COSTHS = COS(TH*PI/180.)
      QVEC   = SQRT( E0**2 + EP**2 - 2.*E0*EP*COSTHS )

      IF (ABS(TH-180.0).LT.1E-6) THEN
        CSTHEQ = 1.0
        SNTHEQ = 0.0
      ELSE
        CSTHEQ=(E0-EP*COSTHS)/QVEC
        SNTHEQ=SQRT(1.-CSTHEQ**2)
      ENDIF

      X(1) =  SNT*CSP*CSTHEQ + CST*SNTHEQ
      X(2) =  SNT*SNP
      X(3) = -SNT*CSP*SNTHEQ + CST*CSTHEQ
      
      CALL CARSPH(X,RR,THR,PHI)

      IF (ABS(RR-1.).GT.1.E-6) STOP ' RR'

      THR = THR*180./PI
      PHI = PHI*180./PI

      RETURN
      END

      SUBROUTINE CARSPH(X,R,THTA,PHI)
      IMPLICIT NONE
      REAL*8 R,THTA,PHI
      REAL*8 PI,R1
      REAL*8 X(3)

      !TRANSITION FROM CARTESIAN TO SPHERICAL COORDINATES

      PI  = ACOS(-1.)
      R1  = X(1)**2+X(2)**2
      R   = SQRT(R1+X(3)**2)
      R1  = SQRT(R1)

      IF (R.LT.1.E-12) THEN
        THTA = 0.
        PHI  = 0.
      ELSE
        IF (R1.EQ.0.0) THEN
          PHI  = 0.0
          THTA = 0.0
          IF (X(3).LT.0.0) THTA=PI
        ELSE
          THTA = ACOS(X(3)/R)
          PHI  = ATAN2(X(2),X(1))
        ENDIF
      ENDIF

      RETURN
      END
