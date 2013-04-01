      REAL FUNCTION F2QCDFINE(X)
 
      VECTOR F2V(161,161)
      VECTOR Q2PASS(1)       
      VECTOR RESULT(1)
 
      Q2=Q2PASS(1)
     
      IF (Q2.LT.0.39.OR.X.LT.1E-6) THEN
        F2QCDFINE=1.
        RESULT(1)=1.
        RETURN
      ENDIF

C     Calculate grid points

      DO I=0,159
        IF(I.LE.71)THEN
        Q2G1=10**(5.*I/120.)-0.7
        Q2G2=10**(5.*(I+1)/120.)-0.7
        ELSEIF(I.EQ.72)THEN
        Q2G1=10**(5*I/120)-0.7
        Q2G2=10**(2*(I-71)/88 +3.)
        ELSE
        Q2G1=10**(2.*(I-72)/88. +3.)
        Q2G2=10**(2.*(I-71)/88. +3.)
        ENDIF
C       Q2G1=10**(5.*I/120.)-0.7
C        Q2G2=10**(5.*(I+1)/120.)-0.7
        IF (Q2.GE.Q2G1.AND.Q2.LT.Q2G2) THEN
          IQ2L=I+1
          IQ2H=I+2
          TQ=(Q2-Q2G1)/(Q2G2-Q2G1)
        ENDIF
      ENDDO

      DO I=0,159
      IF(I.LE.79)THEN
        XG1=10**(6.*I/120.-6.)
        XG2=10**(6.*(I+1)/120.-6.)
      ELSEIF(I.EQ.80)THEN
      XG1=10**(6*I/120-6.)
      XG2=10**(2./80.*(I-79)-2.)
      ELSE
      XG1=10**(2./80.*(I-80)-2.)
      XG2=10**(2./80.*(I-79)-2.)
      ENDIF
C        XG1=10**(5D-2*I-6D0)
C        XG2=10**(5D-2*(I+1)-6D0)
        IF (X.GE.XG1.AND.X.LT.XG2) THEN
          IXL=I+1
          IXH=I+2
          TX=(X-XG1)/(XG2-XG1)
        ENDIF
      ENDDO
 
      F2H=(1-TX)*F2V(IXL,IQ2H)+TX*F2V(IXH,IQ2H)
      F2L=(1-TX)*F2V(IXL,IQ2L)+TX*F2V(IXH,IQ2L)
      F2QCDFINE=(1-TQ)*F2L+TQ*F2H

      IF (F2QCDFINE.GT.0) THEN
        RESULT(1)=F2QCDFINE
      ELSE
        RESULT(1)=1E-4
      ENDIF

      RETURN 
      END


