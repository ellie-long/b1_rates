      subroutine sfun(x,q2,mode,f2p,flp,f1p,rp,f2n,fln,f1n,rn,
     xf2c,flc,f1c,f2b,flb,f1b)
      implicit real*8(a-h,o-z)
      COMMON/GAUS96/XI(96),WI(96),XX(97),NTERMS
      COMMON/INPUT/alambda,flavor,qsct,qsdt,iord
      data pi,pi2/3.14159,9.8696/
      XLAM=alambda
c      write(*,*)'XLAM',XLAM
      IFL=4
      xlam2=xlam*xlam
      t=dlog(q2/xlam2)
c      write(*,*)'t',t
      al=alpha(t)/(4.*pi)
      argmin=qsdt/4./xlam2
      scale=dsqrt(q2)

      cf=4./3.
      ca=3.
      enf=flavor
      iorder=iord
      dpsi2=2./9.
      ZETA2=1.64493406684823
      ZETA3=1.20205690315959

      ww2=(1.-x)*q2/x
      epsc4=qsdt/q2
c      write(*,*)'ww2,epsc4',ww2,epsc4
      fpsc4=qsdt/ww2
      epsc=epsc4/4.
      thcq=1.
      if(epsc.gt.1.) thcq=0.
      thcw=1.
      if(fpsc4.gt.1.) thcw=0.
      epsb4=qsct/q2
      fpsb4=qsct/ww2
      epsb=epsb4/4.
      thbq=1.
      if(epsb.gt.1.) thbq=0.
      thbw=1.
      if(fpsb4.gt.1.) thbw=0.
c      call mrs99(x,scale,mode,upv,dnv,usea,dsea,str,chm,bot,glu)
      upv=QPDFXQ('UPVAL',X,Q2,IFLAG)
      dnv=QPDFXQ('DNVAL',X,Q2,IFLAG)
      usea=QPDFXQ('UB',X,Q2,IFLAG)
      dsea=QPDFXQ('DB',X,Q2,IFLAG)
      str=QPDFXQ('SB',X,Q2,IFLAG)
      chm=QPDFXQ('CB',X,Q2,IFLAG)
      bot=QPDFXQ('BB',X,Q2,IFLAG)
      glu=QPDFXQ('GLUON',X,Q2,IFLAG)      
c      write(*,*)'did we get here',x,q2,upv,dnv,glu
      if(epsc.gt.1.) chm=0.
      if(epsb.gt.1.) bot=0.
      fp=(4.*upv+dnv+8.*usea+2.*dsea+2.*str)/9.
      fn=(4.*dnv+upv+2.*usea+8.*dsea+2.*str)/9.
      fc=8.*chm/9.
      fb=2.*bot/9.

      ffp=0.
      ffn=0.
      ffc=0.
      ffb=0.
      chmq=0.
      chmg=0.
      chmgsw=0.
      chmdcg=0.
      chmlq=0.
      chmlg=0.
      botq=0.
      botg=0.
      botgsw=0.
      botdcg=0.
      fflp=0.
      ffln=0.
      fflc=0.
      fflb=0.

      IF(IORD.LE.0.) THEN 
        GO TO 27
      ELSE
        GO TO 22
      ENDIF
   22 CONTINUE
      IF3=0

      FAC=FLAVOR
      facc=1.
      facb=1.

      IF(ifl.EQ.3.OR.ifl.EQ.4) then
      FAC=6./9.
      facc=4./9.
      facb=1./9.
      endif

      IF(IFL.EQ.1) IF3=1
      CF=4./3.
      AL1=dLOG(1.-X)

      ffp=Fp+Fp*AL*CF*(-9.-2.*PI2/3.+AL1*(-3.+2.*AL1))
      ffn=Fn+Fn*AL*CF*(-9.-2.*PI2/3.+AL1*(-3.+2.*AL1))
c      ffc=ffc+fc*AL*CF*(-9.-2.*PI2/3.+AL1*(-3.+2.*AL1))
c      ffb=ffb+fb*AL*CF*(-9.-2.*PI2/3.+AL1*(-3.+2.*AL1))

      DO 23 I=1,NTERMS
      Y=0.5*(1.-X)*XI(I)+0.5*(1.+X)
      XY=X/Y
      AL1=dLOG(1.-Y)
c      call mrs99(xy,scale,mode,upv,dnv,usea,dsea,str,chm,bot,glu)
      upv=QPDFXQ('UPVAL',XY,Q2,IFLAG)
      dnv=QPDFXQ('DNVAL',XY,Q2,IFLAG)
      usea=QPDFXQ('UB',XY,Q2,IFLAG)
      dsea=QPDFXQ('DB',XY,Q2,IFLAG)
      str=QPDFXQ('SB',XY,Q2,IFLAG)
      chm=QPDFXQ('CB',XY,Q2,IFLAG)
      bot=QPDFXQ('BB',XY,Q2,IFLAG)
      glu=QPDFXQ('GLUON',XY,Q2,IFLAG)      
c      write(*,*)'did we make it',xy,upv,glu
      if(epsc.gt.1.) chm=0.
      if(epsb.gt.1.) bot=0.
      fpxy=(4.*upv+dnv+8.*usea+2.*dsea+2.*str)/9.
      fnxy=(4.*dnv+upv+2.*usea+8.*dsea+2.*str)/9.
      fcxy=8.*chm/9.
      fbxy=2.*bot/9.
      gluxy=glu
      C22=CF*(6.+4.*Y-2.*(1.+Y*Y)/(1.-Y)*dLOG(Y)-2.*(1.+Y)*AL1
     2-IF3*2.*(1.+Y))
      C23=CF*(-3.+4.*AL1)/(1.-Y)
      CG2=2.*FAC*(-1.+8.*Y*(1.-Y)+(1.-2.*Y+2.*Y*Y)*dLOG(1./Y-1.))
      f1lq=4.*cf*y
      f1lg=8.*enf*y*(1.-y)

      ffp=ffp+.5*(1.-X)*WI(I)*AL*(C22*fpxy+C23*(fpxy-fp))
      ffn=ffn+.5*(1.-X)*WI(I)*AL*(C22*fnxy+C23*(fnxy-fn))
c      ffc=ffc+.5*(1.-X)*WI(I)*AL*(C22*fcxy+C23*(fcxy-fc))
c      ffb=ffb+.5*(1.-X)*WI(I)*AL*(C22*fbxy+C23*(fbxy-fb))

      fflp=fflp+.5*(1.-x)*wi(i)*al*f1lq*fpxy
      ffln=ffln+.5*(1.-x)*wi(i)*al*f1lq*fnxy

      IF(IFL-1) 23,23,24
   24 CONTINUE

      ffp=ffp+.5*(1.-X)*WI(I)*AL*CG2*gluxy
      ffn=ffn+.5*(1.-X)*WI(I)*AL*CG2*gluxy

      fflp=fflp+.5*(1.-x)*wi(i)*al*dpsi2*f1lg*gluxy
      ffln=ffln+.5*(1.-x)*wi(i)*al*dpsi2*f1lg*gluxy

      FSXY=DPSI2*(UPV+DNV+2.*USEA+2.*DSEA+2.*STR)
      Y1=1.-Y
      Y2=Y*Y
      Y3=Y*Y2
      Y4=Y3*Y
      Y5=Y4*Y
      DL=DLOG(Y)
      DL2=DL*DL
      DLM1=DLOG(Y1)
      YP1=Y+1.
      DLP1=DLOG(YP1)
      DLM2=DLOG(1.-Y2)
      DL3=DLOG(Y/Y1)
      DL4=DLOG(Y2/Y1)
      ALI2 =FASTLI2(Y)
      ALI2M=FASTLI2(-Y)
      ALI21=FASTLI2(Y1)
      ALI3 =FASTLI3(Y)
      ALI3M=FASTLI3(-Y)
      S12M =FASTS12(-Y)
      FACT1=4.*DL*(6.-3.*Y+47.*Y2-9.*Y3)/(15.*Y2)
     X-4.*ALI2M*(DL-2.*DLP1)-8.*ZETA3-2.*DL2*DLM2
     X+4.*DL*DLP1*DLP1-4.*DL*ALI2+0.4*(5.-3.*Y2)*DL2
     X-4.*(2.+10.*Y2+5.*Y3-3.*Y5)*(ALI2M+DL*DLP1)/(5.*Y3)
     X+4.*ZETA2*(DLM2-0.2*(5.-3.*Y2))+8.*S12M+4.*ALI3+4.*ALI3M
     X-23.*DLM1/3.-(144.+294.*Y-1729.*Y2+216.*Y3)/(90.*Y2)
      FACT2=ALI2+DL3*DL3-3.*ZETA2-(3.-22.*Y)*DL/(3.*Y)
     X+(6.-25.*Y)*DLM1/(6.*Y)-(78.-355.*Y)/(36.*Y)
      FACT3=DL4-(6.-25.*Y)/(6.*Y)
      FNS2LQ=4.*CF*(CA-2.*CF)*Y*FACT1
     X+8.*CF*CF*Y*FACT2-(8./3.)*CF*ENF*Y*FACT3
      FS2LQ=(16./9.)*CF*ENF*(3.*(1.-2.*Y-2.*Y2)*Y1*DLM1/Y
     X+9.*Y*(ALI2+DL2-ZETA2)+9.*(1.-Y-2.*Y2)*DL
     X-9.*Y*Y1-Y1*Y1*Y1/Y)
      FACT4=(1.-3.*Y-27.*Y2+29.*Y3)*DLM1/(3.*Y2)
     X-2.*Y1*DL*DLM1+2.*YP1*ALI2M+4.*ALI2+3.*DL2
     X+2.*(Y-2.)*ZETA2+Y1*DLM1*DLM1+2.*YP1*DL*DLP1
     X+(24.+192.*Y-317.*Y2)*DL/(24.*Y)+(-8.+24.*Y+501.*Y2-517.*Y3)
     X/(72.*Y2)
      FACT5=ALI2+2.*(5.+3.*Y2)*DL2/15.-(1.+3.*Y-4.*Y2)*DLM1/
     X(2.*Y)+(-2.+10.*Y3-12.*Y5)*(ALI2M+DL*DLP1)/(15.*Y3)
     X-(5.+12.*Y2)*ZETA2/15.+(4.+13.*Y+48.*Y2-36.*Y3)*DL/(30.*Y2)
     X-(4.-Y-198.*Y2+195.*Y3)/(30.*Y2)
      FACT6=-4.*ALI21+2.*YP1*(ALI2M+DL*DLP1)+Y1*DLM1*DLM1
     X+(-6.+2.*Y)*DL*DLM1+(-1./Y-9.+29./3.*Y+1./3./Y2)*DLM1
     X+3.*DL2+(1./Y+8.-13.*Y)*DL+2.*Y*ZETA2+1./3./Y+17./3.-53./9.*Y
     X-1./9./Y2
      FACT7=ALI21+DL*DLM1+(-2./3.+4./5.*Y2+2./15./Y3)*(ALI2M+DL*DLP1)
     X+(1./2./Y+3./2.-2.*Y)*DLM1-(2./3.+2./5.*Y2)*DL2
     X+(-13./2./Y-39.+18.*Y-2./Y2)/15.*DL
     X+(-2./3.+4./5.*Y2)*ZETA2-8./15./Y-19./5.+21./5.*Y+2./15./Y2
      F2LG=16.*CA*ENF*Y*FACT6+16.*CF*ENF*Y*FACT7
      fflp=fflp+0.5*(1.-x)*WI(I)*AL*AL*
     X(FNS2LQ*fpxy+FS2LQ*FSXY+DPSI2*F2LG*gluxy)
      ffln=ffln+0.5*(1.-x)*WI(I)*AL*AL*
     X(FNS2LQ*fnxy+FS2LQ*FSXY+DPSI2*F2LG*gluxy)

   23 CONTINUE
   21 CONTINUE

      r7=dsqrt(7.d0)
      xcmax=1./(1.+epsc4)
      if(xcmax.le.x) go to 321
      DO 323 I=1,NTERMS
      Y=0.5*(xcmax-X)*XI(I)+0.5*(xcmax+X)
      XY=X/Y
c      call mrs99(xy,scale,mode,upv,dnv,usea,dsea,str,chm,bot,glu)
      upv=QPDFXQ('UPVAL',XY,Q2,IFLAG)
      dnv=QPDFXQ('DNVAL',XY,Q2,IFLAG)
      usea=QPDFXQ('UB',XY,Q2,IFLAG)
      dsea=QPDFXQ('DB',XY,Q2,IFLAG)
      str=QPDFXQ('SB',XY,Q2,IFLAG)
      chm=QPDFXQ('CB',XY,Q2,IFLAG)
      bot=QPDFXQ('BB',XY,Q2,IFLAG)
      glu=QPDFXQ('GLUON',XY,Q2,IFLAG)      
      if(epsc.gt.1.) chm=0.
      gluxy=glu
      fcxy=8.*chm/9.
      del=0.01
      xyu=xy*(1.+0.5*del)
      if(xyu.gt.1.d0) then
      dfcxy=0.d0
      go to 1324
      endif
c      call mrs99(xyu,scale,mode,upv,dnv,usea,dsea,str,chm,bot,glu)
      upv=QPDFXQ('UPVAL',XYU,Q2,IFLAG)
      dnv=QPDFXQ('DNVAL',XYU,Q2,IFLAG)
      usea=QPDFXQ('UB',XYU,Q2,IFLAG)
      dsea=QPDFXQ('DB',XYU,Q2,IFLAG)
      str=QPDFXQ('SB',XYU,Q2,IFLAG)
      chm=QPDFXQ('CB',XYU,Q2,IFLAG)
      bot=QPDFXQ('BB',XYU,Q2,IFLAG)
      glu=QPDFXQ('GLUON',XYU,Q2,IFLAG)      
      if(epsc.gt.1.) chm=0.
      fcxyu=8.*chm/9.
      xyl=xy*(1.-0.5*del)
C      call mrs99(xyl,scale,mode,upv,dnv,usea,dsea,str,chm,bot,glu)
      upv=QPDFXQ('UPVAL',XYL,Q2,IFLAG)
      dnv=QPDFXQ('DNVAL',XYL,Q2,IFLAG)
      usea=QPDFXQ('UB',XYL,Q2,IFLAG)
      dsea=QPDFXQ('DB',XYL,Q2,IFLAG)
      str=QPDFXQ('SB',XYL,Q2,IFLAG)
      chm=QPDFXQ('CB',XYL,Q2,IFLAG)
      bot=QPDFXQ('BB',XYL,Q2,IFLAG)
      glu=QPDFXQ('GLUON',XYL,Q2,IFLAG)      
      if(epsc.gt.1.) chm=0.
      fcxyl=8.*chm/9.
      dfcxy=(fcxyu-fcxyl)/del
 1324 c0c=cheavy(2,y,epsc)
      if(epsc.gt.1.d0) c0c=0.d0
      cg21c=2.*facc*cheavy(1,y,epsc)
      cg22c=2.*facc*c0c*dlog(1./epsc)
      clg2c=2.*facc*cheavy(3,y,epsc)
      f1lq=cheavy(4,y,epsc)      

      ffc=ffc+0.5*(xcmax-x)*wi(i)*c0c*(-dfcxy+3.*fcxy)
      ffc=ffc+0.5*(xcmax-x)*wi(i)*al*(cg21c-cg22c)*gluxy
      fflc=fflc+0.5*(xcmax-x)*wi(i)*al*f1lq*fcxy
      fflc=fflc+0.5*(xcmax-x)*wi(i)*al*clg2c*gluxy



      chmg=chmg+.5*(xcmax-X)*WI(I)*AL*(cg21c-cg22c)*gluxy
      chmgsw=chmgsw+.5*(xcmax-X)*WI(I)*AL*(cg21c      )*gluxy
      chmdcg=chmdcg+.5*(xcmax-X)*WI(I)*AL*(cg22c      )*gluxy
      chmlg=chmlg+0.5*(xcmax-x)*wi(i)*al*clg2c*gluxy

      fcextra=coeff2(y,epsc)
      ffc=ffc+0.5*(xcmax-x)*wi(i)*fcxy*fcextra
      c1c=cheavy(5,y,epsc)
      fflc=fflc+0.5*(xcmax-x)*wi(i)*al*al*c1c*fcxy
      cl1c=4.*cf*(1.+y-2.*y*y+2.*y*dlog(y))
      clg22c=2.*facc*cl1c*dlog(1./epsc)
      fflc=fflc-0.5*(xcmax-x)*wi(i)*al*al*clg22c*gluxy
      chmlg=chmlg-0.5*(xcmax-x)*wi(i)*al*al*clg22c*gluxy

  323 CONTINUE
  321 CONTINUE

      xbmax=1./(1.+epsb4)
      if(xbmax.le.x) go to 421
      DO 423 I=1,NTERMS
      Y=0.5*(xbmax-X)*XI(I)+0.5*(xbmax+X)
      XY=X/Y
c      call mrs99(xy,scale,mode,upv,dnv,usea,dsea,str,chm,bot,glu)
      upv=QPDFXQ('UPVAL',XY,Q2,IFLAG)
      dnv=QPDFXQ('DNVAL',XY,Q2,IFLAG)
      usea=QPDFXQ('UB',XY,Q2,IFLAG)
      dsea=QPDFXQ('DB',XY,Q2,IFLAG)
      str=QPDFXQ('SB',XY,Q2,IFLAG)
      chm=QPDFXQ('CB',XY,Q2,IFLAG)
      bot=QPDFXQ('BB',XY,Q2,IFLAG)
      glu=QPDFXQ('GLUON',XY,Q2,IFLAG)      
      if(epsb.gt.1.) bot=0.
      gluxy=glu
      fbxy=2.*bot/9.
      del=0.01
      xyu=xy*(1.+0.5*del)
      if(xyu.gt.1.d0) then
      dfbxy=0.d0
      go to 1424
      endif
c      call mrs99(xyu,scale,mode,upv,dnv,usea,dsea,str,chm,bot,glu)
      upv=QPDFXQ('UPVAL',XYU,Q2,IFLAG)
      dnv=QPDFXQ('DNVAL',XYU,Q2,IFLAG)
      usea=QPDFXQ('UB',XYU,Q2,IFLAG)
      dsea=QPDFXQ('DB',XYU,Q2,IFLAG)
      str=QPDFXQ('SB',XYU,Q2,IFLAG)
      chm=QPDFXQ('CB',XYU,Q2,IFLAG)
      bot=QPDFXQ('BB',XYU,Q2,IFLAG)
      glu=QPDFXQ('GLUON',XYU,Q2,IFLAG)      
      if(epsb.gt.1.) bot=0.
      fbxyu=2.*bot/9.
      xyl=xy*(1.-0.5*del)
c      call mrs99(xyl,scale,mode,upv,dnv,usea,dsea,str,chm,bot,glu)
      upv=QPDFXQ('UPVAL',XYL,Q2,IFLAG)
      dnv=QPDFXQ('DNVAL',XYL,Q2,IFLAG)
      usea=QPDFXQ('UB',XYL,Q2,IFLAG)
      dsea=QPDFXQ('DB',XYL,Q2,IFLAG)
      str=QPDFXQ('SB',XYL,Q2,IFLAG)
      chm=QPDFXQ('CB',XYL,Q2,IFLAG)
      bot=QPDFXQ('BB',XYL,Q2,IFLAG)
      glu=QPDFXQ('GLUON',XYL,Q2,IFLAG)      
      if(epsb.gt.1.) bot=0.
      fbxyl=2.*bot/9.
      dfbxy=(fbxyu-fbxyl)/del

 1424 c0b=cheavy(2,y,epsb)
      if(epsb.gt.1.d0) c0b=0.d0
      cg21b=2.*facb*cheavy(1,y,epsb)
      cg22b=2.*facb*c0b*dlog(1./epsb)
      clg2b=2.*facb*cheavy(3,y,epsb)
      f1lq=cheavy(4,y,epsb)      

      ffb=ffb+0.5*(xbmax-x)*wi(i)*c0b*(-dfbxy+3.*fbxy)
      ffb=ffb+0.5*(xbmax-x)*wi(i)*al*(cg21b-cg22b)*gluxy
      fflb=fflb+0.5*(xcmax-x)*wi(i)*al*f1lq*fbxy
      fflb=fflb+0.5*(xcmax-x)*wi(i)*al*clg2b*gluxy

      botg=botg+.5*(xbmax-X)*WI(I)*AL*(cg21b-cg22b)*gluxy
      botgsw=botgsw+.5*(xbmax-X)*WI(I)*AL*(cg21b      )*gluxy
      botdcg=botdcg+.5*(xbmax-X)*WI(I)*AL*(cg22b      )*gluxy

      fbextra=coeff2(y,epsb)
      ffb=ffb+0.5*(xbmax-x)*wi(i)*fbxy*fbextra
      c1b=cheavy(5,y,epsb)
      fflb=fflb+0.5*(xbmax-x)*wi(i)*al*al*c1b*fbxy
      cl1b=4.*cf*(1.+y-2.*y*y+2.*y*dlog(y))
      clg22b=2.*facb*cl1b*dlog(1./epsb)
      fflb=fflb-0.5*(xbmax-x)*wi(i)*al*al*clg22b*gluxy
      botlg=botlg-0.5*(xbmax-x)*wi(i)*al*al*clg22b*gluxy

  423 CONTINUE
  421 CONTINUE

      if(ffc.lt.0.) ffc=0.
      if(ffb.lt.0.) ffb=0.
      f2p=ffp+ffc+ffb
      f2n=ffn+ffc+ffb
      f2c=ffc
      f2b=ffb
      chmq=ffc-chmg
      chmlq=fflc-chmlg
      botq=ffb-botg

      flp=fflp+fflc+fflb
      fln=ffln+fflc+fflb
      flc=fflc
      flb=fflb
      f1p=f2p-flp
      f1n=f2n-fln
      f1c=f2c-flc
      f1b=f2b-flb
      rp=flp/f1p
      rn=fln/f1n

   27 RETURN
      END
      real*8 function coeff2(y,eps)
      implicit real*8(a-h,o-z)
      dimension z1(17),z2(17)
  
      data z1/-0.183E+01,0.400E+01,0.159E+02,-0.357E+02,
     .-0.186E+00,-0.988E+02,0.712E+02,0.631E+02,-0.136E+01,
     .0.175E+03,-0.158E+03,-0.433E+02,0.375E+01,-0.913E+02,
     .0.842E+02,0.107E+02,0.629E+00/
      data z2/-0.204E+01,-0.127E+01,0.117E+01,-0.208E+00,
     .-0.228E+02,0.261E+03,-0.340E+03,0.153E+03,-0.591E+02,
     .-0.199E+04,-0.113E+04,0.299E+04,-0.408E+04,-0.446E+04,
     . 0.307E+05,-0.282E+05,0.144E+02/

      epsl=eps
      eps4=4.d0*eps
      x0=1.d0/(1.d0+eps4)
      yx0=y/x0
      yx01=1.d0-yx0
      epsl2=epsl*epsl
      epsl3=epsl2*epsl
      if(y.lt.0.05) go to 100    
      a0=z1(1)+z1(2)*epsl+z1(3)*epsl2+z1(4)*epsl3
      a1=z1(5)+z1(6)*epsl+z1(7)*epsl2+z1(8)*epsl3
      a2=z1(9)+z1(10)*epsl+z1(11)*epsl2+z1(12)*epsl3
      a3=z1(13)+z1(14)*epsl+z1(15)*epsl2+z1(16)*epsl3
      fac=a0+a1*yx0+a2*yx0*yx0+a3*yx0*yx0*yx0
      coeff2=fac*yx01**z1(17)
      return
  100 continue
      a0=z2(1)+z2(2)*epsl+z2(3)*epsl2+z2(4)*epsl3
      a1=z2(5)+z2(6)*epsl+z2(7)*epsl2+z2(8)*epsl3
      a2=z2(9)+z2(10)*epsl+z2(11)*epsl2+z2(12)*epsl3
      a3=z2(13)+z2(14)*epsl+z2(15)*epsl2+z2(16)*epsl3
      fac=a0+a1*yx0+a2*yx0*yx0+a3*yx0*yx0*yx0
      coeff2=fac*yx01**z2(17)
      return
      end

      real*8 function coeff3(y,eps)
      implicit real*8(a-h,o-z)
      dimension z1(17),z2(17)

      data z1/-0.857E+00,0.217E+02,-0.199E+02,0.162E+02,
     .0.204E+00,-0.142E+03,0.101E+03,-0.575E+02,0.832E+00,
     .0.175E+03,-0.139E+03,0.604E+02,0.344E-01,-0.648E+02,
     .0.538E+02,-0.160E+02,0.000E+00/
      data z2/-0.334E-03,0.677E-02,-0.108E-02,0.825E-03,
     .-0.425E+04,0.883E+05,-0.562E+05,0.601E+05,0.562E+07,
     .-0.122E+09,0.912E+08,-0.928E+08,-0.236E+10,0.499E+11,
     .-0.449E+11,0.412E+11,0.000E+00/

      epsl=eps
      eps4=4.d0*eps
      x0=1.d0/(1.d0+eps)
      yx0=y/x0
      yx01=1.d0-yx0
      epsl2=epsl*epsl
      epsl3=epsl2*epsl
      if(y.lt.0.05) go to 100    
      a0=z1(1)+z1(2)*epsl+z1(3)*epsl2+z1(4)*epsl3
      a1=z1(5)+z1(6)*epsl+z1(7)*epsl2+z1(8)*epsl3
      a2=z1(9)+z1(10)*epsl+z1(11)*epsl2+z1(12)*epsl3
      a3=z1(13)+z1(14)*epsl+z1(15)*epsl2+z1(16)*epsl3
      fac=a0+a1*yx0+a2*yx0*yx0+a3*yx0*yx0*yx0
      coeff3=fac*yx01**z1(17)
      return
  100 continue
      a0=z2(1)+z2(2)*epsl+z2(3)*epsl2+z2(4)*epsl3
      a1=z2(5)+z2(6)*epsl+z2(7)*epsl2+z2(8)*epsl3
      a2=z2(9)+z2(10)*epsl+z2(11)*epsl2+z2(12)*epsl3
      a3=z2(13)+z2(14)*epsl+z2(15)*epsl2+z2(16)*epsl3
      fac=a0+a1*yx0+a2*yx0*yx0+a3*yx0*yx0*yx0
      coeff3=fac*yx01**z2(17)
      return
      end
      DOUBLE PRECISION FUNCTION ALPHA(T)
      IMPLICIT REAL*8(A-H,O-Z)
      COMMON/INPUT/alambda,flavor,qsct,qsdt,iord
      DATA PI/3.14159/
      DATA TOL/.0005/
      ITH=0
      TT=T
      qsdtt=qsdt/4.
      qsctt=qsct/4.
      AL=ALAMBDA
      AL2=AL*AL
      FLAV=4.
      QS=AL2*dEXP(T)

      if(qs.lt.0.5d0) then   !!  running stops below 0.5
          qs=0.5d0
          t=dlog(qs/al2)
          tt=t
      endif

      IF(QS.gt.QSCTT) GO        TO 12  
      IF(QS.lt.QSDTT) GO        TO 312  
   11 CONTINUE
      B0=11-2.*FLAV/3. 
      IF(IORD)1,1,2
c     IF(IORD)2,2,2     !TAKE CARE !!
    1 CONTINUE
      ALPHA=4.*PI/B0/T
      RETURN
    2 CONTINUE
      X1=4.*PI/B0
      B1=102.-38.*FLAV/3.
      X2=B1/B0**2
      AS=X1/T*(1.-X2*dLOG(T)/T)
    5 CONTINUE
      F=-T+X1/AS-X2*dLOG(X1/AS+X2)
      FP=-X1/AS**2*(1.-X2/(X1/AS+X2))
      AS2=AS-F/FP
      DEL=ABS(F/FP/AS)
      IF(DEL-TOL)3,3,4
    3 CONTINUE
      ALPHA=AS2
      IF(ITH.EQ.0) RETURN
      GO TO (13,14,15) ITH
    4 CONTINUE
      AS=AS2
      GO TO 5
   12 ITH=1
      T=dLOG(QSCTT/AL2)
      GO TO 11
   13 ALFQC4=ALPHA
      FLAV=5.   
      ITH=2
      GO TO 11
   14 ALFQC5=ALPHA
      ITH=3
      T=TT
      GO TO 11
   15 ALFQS5=ALPHA
      ALFINV=1./ALFQS5+1./ALFQC4-1./ALFQC5
      ALPHA=1./ALFINV
      RETURN

  311 CONTINUE
      B0=11-2.*FLAV/3. 
      IF(IORD)31,31,32
c     IF(IORD)32,32,32  !TAKE CARE !!
   31 CONTINUE
      ALPHA=4.*PI/B0/T
      RETURN
   32 CONTINUE
      X1=4.*PI/B0
      B1=102.-38.*FLAV/3.
      X2=B1/B0**2
      AS=X1/T*(1.-X2*dLOG(T)/T)
   35 CONTINUE
      F=-T+X1/AS-X2*dLOG(X1/AS+X2)
      FP=-X1/AS**2*(1.-X2/(X1/AS+X2))
      AS2=AS-F/FP
      DEL=ABS(F/FP/AS)
      IF(DEL-TOL)33,33,34
   33 CONTINUE
      ALPHA=AS2
      IF(ITH.EQ.0) RETURN
      GO TO (313,314,315) ITH
   34 CONTINUE
      AS=AS2
      GO TO 35
  312 ITH=1
      T=dLOG(QSDTT/AL2)
      GO TO 311
  313 ALFQC4=ALPHA
      FLAV=3.   
      ITH=2
      GO TO 311
  314 ALFQC3=ALPHA
      ITH=3
      T=TT
      GO TO 311
  315 ALFQS3=ALPHA
      ALFINV=1./ALFQS3+1./ALFQC4-1./ALFQC3
      ALPHA=1./ALFINV
      RETURN
      END
      SUBROUTINE WATE96
C*******************************************************************
C*****                                                         *****
C***** THE X(I) AND W(I) ARE THE DIRECT OUTPUT FROM A PROGRAM  *****
C***** USING NAG ROUTINE D01BCF TO CALCULATE THE               *****
C***** GAUSS-LEGENDRE WEIGHTS FOR 96 POINT INTEGRATION.        *****
C***** THEY AGREE TO TYPICALLY 14 DECIMAL PLACES WITH THE      *****
C***** TABLE IN ABRAMOWITZ & STEGUN, PAGE 919.                 *****
C*****                                                         *****
C***** ---->   PETER HARRIMAN, APRIL 3RD 1990.                 *****
C*****                                                         *****
C*******************************************************************
      IMPLICIT REAL*8 (A-H,O-Z)
      DIMENSION X(48),W(48)
      COMMON/GAUS96/XI(96),WI(96),XX(97),NTERMS
      NTERMS=96

      X( 1)=   0.01627674484960183561
      X( 2)=   0.04881298513604856015
      X( 3)=   0.08129749546442434360
      X( 4)=   0.11369585011066471632
      X( 5)=   0.14597371465489567682
      X( 6)=   0.17809688236761733390
      X( 7)=   0.21003131046056591064
      X( 8)=   0.24174315616383866556
      X( 9)=   0.27319881259104774468
      X(10)=   0.30436494435449495954
      X(11)=   0.33520852289262397655
      X(12)=   0.36569686147231213885
      X(13)=   0.39579764982890709712
      X(14)=   0.42547898840729897474
      X(15)=   0.45470942216774136446
      X(16)=   0.48345797392059470382
      X(17)=   0.51169417715466604391
      X(18)=   0.53938810832435567233
      X(19)=   0.56651041856139533470
      X(20)=   0.59303236477757022282
      X(21)=   0.61892584012546672523
      X(22)=   0.64416340378496526886
      X(23)=   0.66871831004391424358
      X(24)=   0.69256453664216964528
      X(25)=   0.71567681234896561582
      X(26)=   0.73803064374439816819
      X(27)=   0.75960234117664555964
      X(28)=   0.78036904386743123629
      X(29)=   0.80030874413913884180
      X(30)=   0.81940031073792957139
      X(31)=   0.83762351122818502758
      X(32)=   0.85495903343459936363
      X(33)=   0.87138850590929436968
      X(34)=   0.88689451740241818933
      X(35)=   0.90146063531585023110
      X(36)=   0.91507142312089592706
      X(37)=   0.92771245672230655266
      X(38)=   0.93937033975275308073
      X(39)=   0.95003271778443564022
      X(40)=   0.95968829144874048809
      X(41)=   0.96832682846326217918
      X(42)=   0.97593917458513455843
      X(43)=   0.98251726356301274934
      X(44)=   0.98805412632962202890
      X(45)=   0.99254390032376081654
      X(46)=   0.99598184298720747465
      X(47)=   0.99836437586317963722
      X(48)=   0.99968950388322870559
      W( 1)=   0.03255061449236316962
      W( 2)=   0.03251611871386883307
      W( 3)=   0.03244716371406427668
      W( 4)=   0.03234382256857594104
      W( 5)=   0.03220620479403026124
      W( 6)=   0.03203445623199267876
      W( 7)=   0.03182875889441101874
      W( 8)=   0.03158933077072719007
      W( 9)=   0.03131642559686137819
      W(10)=   0.03101033258631386231
      W(11)=   0.03067137612366917839
      W(12)=   0.03029991542082762553
      W(13)=   0.02989634413632842385
      W(14)=   0.02946108995816795100
      W(15)=   0.02899461415055528410
      W(16)=   0.02849741106508543861
      W(17)=   0.02797000761684838950
      W(18)=   0.02741296272602931385
      W(19)=   0.02682686672559184485
      W(20)=   0.02621234073567250055
      W(21)=   0.02557003600534944960
      W(22)=   0.02490063322248370695
      W(23)=   0.02420484179236479915
      W(24)=   0.02348339908592633665
      W(25)=   0.02273706965832950717
      W(26)=   0.02196664443874448477
      W(27)=   0.02117293989219144572
      W(28)=   0.02035679715433347898
      W(29)=   0.01951908114014518992
      W(30)=   0.01866067962741165898
      W(31)=   0.01778250231604547316
      W(32)=   0.01688547986424539715
      W(33)=   0.01597056290256253144
      W(34)=   0.01503872102699521608
      W(35)=   0.01409094177231515264
      W(36)=   0.01312822956696188190
      W(37)=   0.01215160467108866759
      W(38)=   0.01116210209983888144
      W(39)=   0.01016077053500880978
      W(40)=   0.00914867123078384552
      W(41)=   0.00812687692569928101
      W(42)=   0.00709647079115442616
      W(43)=   0.00605854550423662775
      W(44)=   0.00501420274292825661
      W(45)=   0.00396455433844564804
      W(46)=   0.00291073181793626202
      W(47)=   0.00185396078894924657
      W(48)=   0.00079679206555731759
      DO 1 I=1,48
      XI(I)=-X(49-I)
      WI(I)=W(49-I)
      XI(I+48)=X(I)
      WI(I+48)=W(I)
    1 CONTINUE
      DO 2 I=1,96
    2 XX(I)=0.5*(XI(I)+1.)
      XX(97)=1.0
      EXPON=1.0
      DO 3 I=1,96
      YI=2.*(0.5*(1.+XI(I)))**EXPON-1.
      WI(I)=WI(I)/(1.+XI(I))*(1.+YI)*EXPON
      XI(I)=YI
      XX(I)=0.5*(1.+YI)
    3 CONTINUE
      RETURN
      END

      real*8 function cheavy(i,z,eps)
      implicit real*8(a-h,o-z)

c     this function returns the values of C_g(z,Q^2) 
c     and the deriv. wrt log Q^2. Here eps=m^2/Q^2.
c     If i=1  C_g for F2.  If i=2 deriv of C_g for F2 
c     If i=3  C_g for FL.  If i=4 (1-m2/Q2)*beta*Clq(massless)
c     If i=5  (1-m2/Q2)*beta*Clq(1)(massless)
      if(i.gt.5) stop
      z1=1.-z
      z2=z*z
      eps2=eps*eps
      beta2=1.-4.*eps*z/z1
      if(beta2.lt.0.) go to 10
      beta=dsqrt(beta2)
      a=z2+z1*z1
      b=4.*z*(1.-3.*z)
      c=-8.*z2
      aa=8.*z*z1-1.
      bb=-4.*z*z1
      arg=(1.+beta)/(1.-beta)
      fac=dlog(arg)
      cf=4./3.
      ca=3.
      enf=4.
      ZETA2=1.64493406684823
      ZETA3=1.20205690315959
      go to (1,2,3,4,5) i
    1 cheavy=(a+b*eps+c*eps2)*fac+(aa+bb*eps)*beta
      return
    2 cheavy=(-b*eps-2.*c*eps2)*fac+(a+b*eps+c*eps2)/beta
     .      +(-bb*eps)*beta +(aa+bb*eps)*2.*z*eps/z1/beta
      return
    3 cheavy=-bb*beta+c*eps*fac
      return
    4 cheavy=(1.-eps)*beta*4.*cf*z
      return
    5 y=z
      Y1=1.-Y
      Y2=Y*Y
      Y3=Y*Y2
      Y4=Y3*Y
      Y5=Y4*Y
      DL=DLOG(Y)
      DL2=DL*DL
      DLM1=DLOG(Y1)
      YP1=Y+1.
      DLP1=DLOG(YP1)
      DLM2=DLOG(1.-Y2)
      DL3=DLOG(Y/Y1)
      DL4=DLOG(Y2/Y1)
      ALI2 =FASTLI2(Y)
      ALI2M=FASTLI2(-Y)
      ALI21=FASTLI2(Y1)
      ALI3 =FASTLI3(Y)
      ALI3M=FASTLI3(-Y)
      S12M =FASTS12(-Y)
      FACT1=4.*DL*(6.-3.*Y+47.*Y2-9.*Y3)/(15.*Y2)
     X-4.*ALI2M*(DL-2.*DLP1)-8.*ZETA3-2.*DL2*DLM2
     X+4.*DL*DLP1*DLP1-4.*DL*ALI2+0.4*(5.-3.*Y2)*DL2
     X-4.*(2.+10.*Y2+5.*Y3-3.*Y5)*(ALI2M+DL*DLP1)/(5.*Y3)
     X+4.*ZETA2*(DLM2-0.2*(5.-3.*Y2))+8.*S12M+4.*ALI3+4.*ALI3M
     X-23.*DLM1/3.-(144.+294.*Y-1729.*Y2+216.*Y3)/(90.*Y2)
      FACT2=ALI2+DL3*DL3-3.*ZETA2-(3.-22.*Y)*DL/(3.*Y)
     X+(6.-25.*Y)*DLM1/(6.*Y)-(78.-355.*Y)/(36.*Y)
      FACT3=DL4-(6.-25.*Y)/(6.*Y)
      FNS2LQ=4.*CF*(CA-2.*CF)*Y*FACT1
     X+8.*CF*CF*Y*FACT2-(8./3.)*CF*ENF*Y*FACT3
      cheavy=(1.-eps)*beta*FNS2LQ
      return

   10 print 99
   99 format(1x,'x > x0')
      stop
      end
      FUNCTION  FASTLI2(X)
      IMPLICIT REAL*8(A-H,O-Z)
      COMPLEX*16 WGPLG
      FASTLI2=WGPLG(1,1,X)
      RETURN
      END
      FUNCTION  FASTS12(X)
      IMPLICIT REAL*8(A-H,O-Z)
      COMPLEX*16 WGPLG
      FASTS12=WGPLG(1,2,X)
      RETURN
      END
      FUNCTION  FASTLI3(X)
      IMPLICIT REAL*8(A-H,O-Z)
      COMPLEX*16 WGPLG
      FASTLI3=WGPLG(2,1,X)
      RETURN
      END
C
C   24/08/89 101231638  MEMBER NAME  WGPLG    (ZWPROD.S)    F77
C   NOTE THAT WGPLG(1,1,X) IS DILOG(X) !! 
      COMPLEX FUNCTION WGPLG*16(N,P,X)
      INTEGER P,P1,NC(10),INDEX(31)
      DOUBLE PRECISION FCT(0:4),SGN(0:4),U(0:4),S1(4,4),C(4,4)
      DOUBLE PRECISION A(0:30,10)
      DOUBLE PRECISION X,X1,H,ALFA,R,Q,C1,C2,B0,B1,B2,ZERO,HALF
 
      COMPLEX*16 V(0:5),SK,SM
 
      DATA FCT /1.0D0,1.0D0,2.0D0,6.0D0,24.0D0/
      DATA SGN /1.0D0,-1.0D0,1.0D0,-1.0D0,1.0D0/
      DATA ZERO /0.0D0/, HALF /0.5D0/
      DATA C1 /1.33333 33333 333D0/, C2 /0.33333 33333 3333D0/
 
      DATA S1(1,1) /1.64493 40668 482D0/
      DATA S1(1,2) /1.20205 69031 596D0/
      DATA S1(1,3) /1.08232 32337 111D0/
      DATA S1(1,4) /1.03692 77551 434D0/
      DATA S1(2,1) /1.20205 69031 596D0/
      DATA S1(2,2) /2.70580 80842 778D-1/
      DATA S1(2,3) /9.65511 59989 444D-2/
      DATA S1(3,1) /1.08232 32337 111D0/
      DATA S1(3,2) /9.65511 59989 444D-2/
      DATA S1(4,1) /1.03692 77551 434D0/
 
      DATA C(1,1) / 1.64493 40668 482D0/
      DATA C(1,2) / 1.20205 69031 596D0/
      DATA C(1,3) / 1.08232 32337 111D0/
      DATA C(1,4) / 1.03692 77551 434D0/
      DATA C(2,1) / 0.00000 00000 000D0/
      DATA C(2,2) /-1.89406 56589 945D0/
      DATA C(2,3) /-3.01423 21054 407D0/
      DATA C(3,1) / 1.89406 56589 945D0/
      DATA C(3,2) / 3.01423 21054 407D0/
      DATA C(4,1) / 0.00000 00000 000D0/
 
      DATA INDEX /1,2,3,4,6*0,5,6,7,7*0,8,9,8*0,10/
 
      DATA NC /24,26,28,30,22,24,26,19,22,17/
 
      DATA A( 0,1) / .96753 21504 3498D0/
      DATA A( 1,1) / .16607 30329 2785D0/
      DATA A( 2,1) / .02487 93229 2423D0/
      DATA A( 3,1) / .00468 63619 5945D0/
      DATA A( 4,1) / .00100 16274 9616D0/
      DATA A( 5,1) / .00023 20021 9609D0/
      DATA A( 6,1) / .00005 68178 2272D0/
      DATA A( 7,1) / .00001 44963 0056D0/
      DATA A( 8,1) / .00000 38163 2946D0/
      DATA A( 9,1) / .00000 10299 0426D0/
      DATA A(10,1) / .00000 02835 7538D0/
      DATA A(11,1) / .00000 00793 8705D0/
      DATA A(12,1) / .00000 00225 3670D0/
      DATA A(13,1) / .00000 00064 7434D0/
      DATA A(14,1) / .00000 00018 7912D0/
      DATA A(15,1) / .00000 00005 5029D0/
      DATA A(16,1) / .00000 00001 6242D0/
      DATA A(17,1) / .00000 00000 4827D0/
      DATA A(18,1) / .00000 00000 1444D0/
      DATA A(19,1) / .00000 00000 0434D0/
      DATA A(20,1) / .00000 00000 0131D0/
      DATA A(21,1) / .00000 00000 0040D0/
      DATA A(22,1) / .00000 00000 0012D0/
      DATA A(23,1) / .00000 00000 0004D0/
      DATA A(24,1) / .00000 00000 0001D0/
 
      DATA A( 0,2) / .95180 88912 7832D0/
      DATA A( 1,2) / .43131 13184 6532D0/
      DATA A( 2,2) / .10002 25071 4905D0/
      DATA A( 3,2) / .02442 41559 5220D0/
      DATA A( 4,2) / .00622 51246 3724D0/
      DATA A( 5,2) / .00164 07883 1235D0/
      DATA A( 6,2) / .00044 40792 0265D0/
      DATA A( 7,2) / .00012 27749 4168D0/
      DATA A( 8,2) / .00003 45398 1284D0/
      DATA A( 9,2) / .00000 98586 9565D0/
      DATA A(10,2) / .00000 28485 6995D0/
      DATA A(11,2) / .00000 08317 0847D0/
      DATA A(12,2) / .00000 02450 3950D0/
      DATA A(13,2) / .00000 00727 6496D0/
      DATA A(14,2) / .00000 00217 5802D0/
      DATA A(15,2) / .00000 00065 4616D0/
      DATA A(16,2) / .00000 00019 8033D0/
      DATA A(17,2) / .00000 00006 0204D0/
      DATA A(18,2) / .00000 00001 8385D0/
      DATA A(19,2) / .00000 00000 5637D0/
      DATA A(20,2) / .00000 00000 1735D0/
      DATA A(21,2) / .00000 00000 0536D0/
      DATA A(22,2) / .00000 00000 0166D0/
      DATA A(23,2) / .00000 00000 0052D0/
      DATA A(24,2) / .00000 00000 0016D0/
      DATA A(25,2) / .00000 00000 0005D0/
      DATA A(26,2) / .00000 00000 0002D0/
 
      DATA A( 0,3) / .98161 02799 1365D0/
      DATA A( 1,3) / .72926 80632 0726D0/
      DATA A( 2,3) / .22774 71490 9321D0/
      DATA A( 3,3) / .06809 08329 6197D0/
      DATA A( 4,3) / .02013 70118 3064D0/
      DATA A( 5,3) / .00595 47848 0197D0/
      DATA A( 6,3) / .00176 76901 3959D0/
      DATA A( 7,3) / .00052 74821 8502D0/
      DATA A( 8,3) / .00015 82746 1460D0/
      DATA A( 9,3) / .00004 77492 2076D0/
      DATA A(10,3) / .00001 44792 0408D0/
      DATA A(11,3) / .00000 44115 4886D0/
      DATA A(12,3) / .00000 13500 3870D0/
      DATA A(13,3) / .00000 04148 1779D0/
      DATA A(14,3) / .00000 01279 3307D0/
      DATA A(15,3) / .00000 00395 9070D0/
      DATA A(16,3) / .00000 00122 9055D0/
      DATA A(17,3) / .00000 00038 2658D0/
      DATA A(18,3) / .00000 00011 9459D0/
      DATA A(19,3) / .00000 00003 7386D0/
      DATA A(20,3) / .00000 00001 1727D0/
      DATA A(21,3) / .00000 00000 3687D0/
      DATA A(22,3) / .00000 00000 1161D0/
      DATA A(23,3) / .00000 00000 0366D0/
      DATA A(24,3) / .00000 00000 0116D0/
      DATA A(25,3) / .00000 00000 0037D0/
      DATA A(26,3) / .00000 00000 0012D0/
      DATA A(27,3) / .00000 00000 0004D0/
      DATA A(28,3) / .00000 00000 0001D0/
 
      DATA A( 0,4) /1.06405 21184 614 D0/
      DATA A( 1,4) /1.06917 20744 981 D0/
      DATA A( 2,4) / .41527 19325 1768D0/
      DATA A( 3,4) / .14610 33293 6222D0/
      DATA A( 4,4) / .04904 73264 8784D0/
      DATA A( 5,4) / .01606 34086 0396D0/
      DATA A( 6,4) / .00518 88935 0790D0/
      DATA A( 7,4) / .00166 29871 7324D0/
      DATA A( 8,4) / .00053 05827 9969D0/
      DATA A( 9,4) / .00016 88702 9251D0/
      DATA A(10,4) / .00005 36832 8059D0/
      DATA A(11,4) / .00001 70592 3313D0/
      DATA A(12,4) / .00000 54217 4374D0/
      DATA A(13,4) / .00000 17239 4082D0/
      DATA A(14,4) / .00000 05485 3275D0/
      DATA A(15,4) / .00000 01746 7795D0/
      DATA A(16,4) / .00000 00556 7550D0/
      DATA A(17,4) / .00000 00177 6234D0/
      DATA A(18,4) / .00000 00056 7224D0/
      DATA A(19,4) / .00000 00018 1313D0/
      DATA A(20,4) / .00000 00005 8012D0/
      DATA A(21,4) / .00000 00001 8579D0/
      DATA A(22,4) / .00000 00000 5955D0/
      DATA A(23,4) / .00000 00000 1911D0/
      DATA A(24,4) / .00000 00000 0614D0/
      DATA A(25,4) / .00000 00000 0197D0/
      DATA A(26,4) / .00000 00000 0063D0/
      DATA A(27,4) / .00000 00000 0020D0/
      DATA A(28,4) / .00000 00000 0007D0/
      DATA A(29,4) / .00000 00000 0002D0/
      DATA A(30,4) / .00000 00000 0001D0/

      DATA A( 0,5) / .97920 86066 9175D0/
      DATA A( 1,5) / .08518 81314 8683D0/
      DATA A( 2,5) / .00855 98522 2013D0/
      DATA A( 3,5) / .00121 17721 4413D0/
      DATA A( 4,5) / .00020 72276 8531D0/
      DATA A( 5,5) / .00003 99695 8691D0/
      DATA A( 6,5) / .00000 83806 4065D0/
      DATA A( 7,5) / .00000 18684 8945D0/
      DATA A( 8,5) / .00000 04366 6087D0/
      DATA A( 9,5) / .00000 01059 1733D0/
      DATA A(10,5) / .00000 00264 7892D0/
      DATA A(11,5) / .00000 00067 8700D0/
      DATA A(12,5) / .00000 00017 7654D0/
      DATA A(13,5) / .00000 00004 7342D0/
      DATA A(14,5) / .00000 00001 2812D0/
      DATA A(15,5) / .00000 00000 3514D0/
      DATA A(16,5) / .00000 00000 0975D0/
      DATA A(17,5) / .00000 00000 0274D0/
      DATA A(18,5) / .00000 00000 0077D0/
      DATA A(19,5) / .00000 00000 0022D0/
      DATA A(20,5) / .00000 00000 0006D0/
      DATA A(21,5) / .00000 00000 0002D0/
      DATA A(22,5) / .00000 00000 0001D0/
 
      DATA A( 0,6) / .95021 85196 3952D0/
      DATA A( 1,6) / .29052 52916 1433D0/
      DATA A( 2,6) / .05081 77406 1716D0/
      DATA A( 3,6) / .00995 54376 7280D0/
      DATA A( 4,6) / .00211 73389 5031D0/
      DATA A( 5,6) / .00047 85947 0550D0/
      DATA A( 6,6) / .00011 33432 1308D0/
      DATA A( 7,6) / .00002 78473 3104D0/
      DATA A( 8,6) / .00000 70478 8108D0/
      DATA A( 9,6) / .00000 18278 8740D0/
      DATA A(10,6) / .00000 04838 7492D0/
      DATA A(11,6) / .00000 01303 3842D0/
      DATA A(12,6) / .00000 00356 3769D0/
      DATA A(13,6) / .00000 00098 7174D0/
      DATA A(14,6) / .00000 00027 6586D0/
      DATA A(15,6) / .00000 00007 8279D0/
      DATA A(16,6) / .00000 00002 2354D0/
      DATA A(17,6) / .00000 00000 6435D0/
      DATA A(18,6) / .00000 00000 1866D0/
      DATA A(19,6) / .00000 00000 0545D0/
      DATA A(20,6) / .00000 00000 0160D0/
      DATA A(21,6) / .00000 00000 0047D0/
      DATA A(22,6) / .00000 00000 0014D0/
      DATA A(23,6) / .00000 00000 0004D0/
      DATA A(24,6) / .00000 00000 0001D0/

      DATA A( 0,7) / .95064 03218 6777D0/
      DATA A( 1,7) / .54138 28546 5171D0/
      DATA A( 2,7) / .13649 97959 0321D0/
      DATA A( 3,7) / .03417 94232 8207D0/
      DATA A( 4,7) / .00869 02788 3583D0/
      DATA A( 5,7) / .00225 28408 4155D0/
      DATA A( 6,7) / .00059 51608 9806D0/
      DATA A( 7,7) / .00015 99561 7766D0/
      DATA A( 8,7) / .00004 36521 3096D0/
      DATA A( 9,7) / .00001 20747 4688D0/
      DATA A(10,7) / .00000 33801 8176D0/
      DATA A(11,7) / .00000 09563 2476D0/
      DATA A(12,7) / .00000 02731 3129D0/
      DATA A(13,7) / .00000 00786 6968D0/
      DATA A(14,7) / .00000 00228 3195D0/
      DATA A(15,7) / .00000 00066 7205D0/
      DATA A(16,7) / .00000 00019 6191D0/
      DATA A(17,7) / .00000 00005 8018D0/
      DATA A(18,7) / .00000 00001 7246D0/
      DATA A(19,7) / .00000 00000 5151D0/
      DATA A(20,7) / .00000 00000 1545D0/
      DATA A(21,7) / .00000 00000 0465D0/
      DATA A(22,7) / .00000 00000 0141D0/
      DATA A(23,7) / .00000 00000 0043D0/
      DATA A(24,7) / .00000 00000 0013D0/
      DATA A(25,7) / .00000 00000 0004D0/
      DATA A(26,7) / .00000 00000 0001D0/
 
      DATA A( 0,8) / .98800 01167 2229D0/
      DATA A( 1,8) / .04364 06760 9601D0/
      DATA A( 2,8) / .00295 09117 8278D0/
      DATA A( 3,8) / .00031 47780 9720D0/
      DATA A( 4,8) / .00004 31484 6029D0/
      DATA A( 5,8) / .00000 69381 8230D0/
      DATA A( 6,8) / .00000 12464 0350D0/
      DATA A( 7,8) / .00000 02429 3628D0/
      DATA A( 8,8) / .00000 00504 0827D0/
      DATA A( 9,8) / .00000 00109 9075D0/
      DATA A(10,8) / .00000 00024 9467D0/
      DATA A(11,8) / .00000 00005 8540D0/
      DATA A(12,8) / .00000 00001 4127D0/
      DATA A(13,8) / .00000 00000 3492D0/
      DATA A(14,8) / .00000 00000 0881D0/
      DATA A(15,8) / .00000 00000 0226D0/
      DATA A(16,8) / .00000 00000 0059D0/
      DATA A(17,8) / .00000 00000 0016D0/
      DATA A(18,8) / .00000 00000 0004D0/
      DATA A(19,8) / .00000 00000 0001D0/

      DATA A( 0,9) / .95768 50654 6350D0/
      DATA A( 1,9) / .19725 24967 9534D0/
      DATA A( 2,9) / .02603 37031 3918D0/
      DATA A( 3,9) / .00409 38216 8261D0/
      DATA A( 4,9) / .00072 68170 7110D0/
      DATA A( 5,9) / .00014 09187 9261D0/
      DATA A( 6,9) / .00002 92045 8914D0/
      DATA A( 7,9) / .00000 63763 1144D0/
      DATA A( 8,9) / .00000 14516 7850D0/
      DATA A( 9,9) / .00000 03420 5281D0/
      DATA A(10,9) / .00000 00829 4302D0/
      DATA A(11,9) / .00000 00206 0784D0/
      DATA A(12,9) / .00000 00052 2823D0/
      DATA A(13,9) / .00000 00013 5066D0/
      DATA A(14,9) / .00000 00003 5451D0/
      DATA A(15,9) / .00000 00000 9436D0/
      DATA A(16,9) / .00000 00000 2543D0/
      DATA A(17,9) / .00000 00000 0693D0/
      DATA A(18,9) / .00000 00000 0191D0/
      DATA A(19,9) / .00000 00000 0053D0/
      DATA A(20,9) / .00000 00000 0015D0/
      DATA A(21,9) / .00000 00000 0004D0/
      DATA A(22,9) / .00000 00000 0001D0/
 
      DATA A( 0,10) / .99343 65167 1347D0/
      DATA A( 1,10) / .02225 77012 6826D0/
      DATA A( 2,10) / .00101 47557 4703D0/
      DATA A( 3,10) / .00008 17515 6250D0/
      DATA A( 4,10) / .00000 89997 3547D0/
      DATA A( 5,10) / .00000 12082 3987D0/
      DATA A( 6,10) / .00000 01861 6913D0/
      DATA A( 7,10) / .00000 00317 4723D0/
      DATA A( 8,10) / .00000 00058 5215D0/
      DATA A( 9,10) / .00000 00011 4739D0/
      DATA A(10,10) / .00000 00002 3652D0/
      DATA A(11,10) / .00000 00000 5082D0/
      DATA A(12,10) / .00000 00000 1131D0/
      DATA A(13,10) / .00000 00000 0259D0/
      DATA A(14,10) / .00000 00000 0061D0/
      DATA A(15,10) / .00000 00000 0015D0/
      DATA A(16,10) / .00000 00000 0004D0/
      DATA A(17,10) / .00000 00000 0001D0/
 
      IF(N .LT. 1 .OR. N .GT. 4 .OR. P .LT. 1 .OR. P .GT. 4 .OR.
     1   N+P .GT. 5) THEN
       WGPLG=ZERO
       PRINT 1000, N,P
       RETURN
      END IF
      IF(X .EQ. SGN(0)) THEN
       WGPLG=S1(N,P)
       RETURN
      END IF
 
      IF(X .GT. FCT(2) .OR. X .LT. SGN(1)) THEN
       X1=SGN(0)/X
       H=C1*X1+C2
       ALFA=H+H
       V(0)=SGN(0)
       V(1)=LOG(DCMPLX(-X,ZERO))
       DO 33 L = 2,N+P
   33  V(L)=V(1)*V(L-1)/L
       SK=ZERO
       DO 34 K = 0,P-1
       P1=P-K
       R=X1**P1/(FCT(P1)*FCT(N-1))
       SM=ZERO
       DO 35 M = 0,K
       N1=N+K-M
       L=INDEX(10*N1+P1-10)
       B1=ZERO
       B2=ZERO
       DO 31 I = NC(L),0,-1
       B0=A(I,L)+ALFA*B1-B2
       B2=B1
   31  B1=B0
       Q=(FCT(N1-1)/FCT(K-M))*(B0-H*B2)*R/P1**N1
   35  SM=SM+V(M)*Q
   34  SK=SK+SGN(K)*SM
       SM=ZERO
       DO 36 M = 0,N-1
   36  SM=SM+V(M)*C(N-M,P)
       WGPLG=SGN(N)*SK+SGN(P)*(SM+V(N+P))
       RETURN
      END IF 

      IF(X .GT. HALF) THEN
       X1=SGN(0)-X
       H=C1*X1+C2
       ALFA=H+H
       V(0)=SGN(0)
       U(0)=SGN(0)
       V(1)=LOG(DCMPLX(X1,ZERO))
       U(1)=LOG(X)
       DO 23 L = 2,P
   23  V(L)=V(1)*V(L-1)/L
       DO 26 L = 2,N
   26  U(L)=U(1)*U(L-1)/L
       SK=ZERO
       DO 24 K = 0,N-1
       P1=N-K
       R=X1**P1/FCT(P1)
       SM=ZERO
       DO 25 M = 0,P-1
       N1=P-M
       L=INDEX(10*N1+P1-10)
       B1=ZERO
       B2=ZERO
       DO 12 I = NC(L),0,-1
       B0=A(I,L)+ALFA*B1-B2
       B2=B1
   12  B1=B0
       Q=SGN(M)*(B0-H*B2)*R/P1**N1
   25  SM=SM+V(M)*Q
   24  SK=SK+U(K)*(S1(P1,P)-SM)
       WGPLG=SK+SGN(P)*U(N)*V(P)
       RETURN
      END IF
 
      L=INDEX(10*N+P-10)
      H=C1*X+C2
      ALFA=H+H
      B1=ZERO
      B2=ZERO
      DO 11 I = NC(L),0,-1
      B0=A(I,L)+ALFA*B1-B2
      B2=B1
   11 B1=B0
      WGPLG=(B0-H*B2)*X**P/(FCT(P)*P**N)
      RETURN
 1000 FORMAT(/' ***** CERN SUBROUTINE WGPLG ... ILLEGAL VALUES',
     1        '   N = ',I3,'   P = ',I3)
      END
