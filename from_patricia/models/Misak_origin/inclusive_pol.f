      program nestfun
      common/par/pi,pm,dm
*************************************************
* Code for calculation of inelastic 
* scattering from deuteron
*************************************************
        pi = acos(-1.0)
        pm   = 0.938272
****************************************
*      Initialization
****************************************
        xxx = fd(0.0,0.0,0)
        ilc = 1  ! 0-virtul nucleon, 1- light-cone
        it  = 0  ! 0-p and n, 1 - p, 2, n
        ib  = 0  ! (0)- non Bjorken limit (1)-Bjorken limit 
        imc = 0  ! (0)- no EMC, (1) - EMC in Color Screening 
        ipol= 0
        ini = 1 ! (1)- initialization, 
        xx = sigma_in(ei,er,uet,ilc,it,ib,imc,ipol,ini)
****************************************
*      Momentum and asymmetry distribution
****************************************
*        do ip = 0,600,10
*           p = float(ip)/1000.
*       a0 = fd(p,p,1)
*       t20 = fd(p,p,2)
*       asm = t20/a0
*       write(12,*)ip,asm
*       enddo

*****************************************
*   Initial Parameters
*****************************************
        ei  = 11.0   ! initial electron energy
*        uet = 10.0 
*        ue = uet*pi/180.0
        q2 = 5.0

        
*        x  = .001
        write(11,*)"x,w,asm_vn,asm_lc"
        do ix = 0,32
        x = 0.1+float(ix)*0.05
        q0 = q2/2.0/pm/x

        er = ei-q0
        if(q0.ge.ei)go to 1
        
        ue = 2.0*asin(sqrt(q2/4.0/ei/er))
        uet = ue*180.0/pi
        w2 = pm**2 + 2.0*q0*pm - Q2
        if(w2.le.0.0)goto 1
        wm = sqrt(w2)
        ini = 0
	it  = 0
        ib  = 1
        asm_vn = 0.0
        asm_lc = 0.0

        do ilc =0,1
        ipol= 1
	cross_un   =  sigma_in(ei,er,uet,ilc,it,ib,imc,ipol,ini)	
        ipol= 2
	cross_t20  =  sigma_in(ei,er,uet,ilc,it,ib,imc,ipol,ini)	
        asm = cross_t20/cross_un
        if(ilc.eq.0)asm_vn = asm
        if(ilc.eq.1)asm_lc = asm
        enddo

        write(6,12)x,wm,asm_vn,asm_lc
        write(11,12)x,wm,asm_vn,asm_lc
 12     format(4(f12.4))
 1      continue
        enddo
	end



      function sigma_in(ei,er,uet,ilc,it,ib,imc,ipol,ini)
*************************************************
*     calculates inelastic cross section from deuteron 
*     ei   - initial electron energy    (GeV/c)   
*     er   - scattered electron energy  (GeV/c)
*     uet  - scattered electron angle in degr. 
*     ilc  = 0  ! 0-virtul nucleon, 1- light-cone
*     it   = 0-p and n, 1 - p, 2 - n
*     ib   = 0 - no Bjorken, 1 - Bjorken limit
*     imc  = 0 - noemc, 1- color screening
*     ipol = 1 - unpolorized 2 - tensor polorized
*     ini = 1 - initializes the parameters,
*           0 - calculates tre cross section      
*     cross section is in nb/sr/GeV
*************************************************
      common/par/pi,pm,dm
      common/ttarget/an,zp,zn,tm,emin
      common/photon/q2,q0,qv
      common/emc/iemc
      common/lc/ilc0
      common/pol/ipolo
      sigma_in = 0.0
      if(ini.eq.1)then
      pi = acos(-1.0)
      pm   = 0.938272
      pmn  = 0.939566
      dm   = 1.875613
      an   = 2.0
      zp   = 1.0
      zn   = an - zp
      emin = 0.002226
      tm   = dm
      else
      ilc0 = ilc
      iemc = imc
      ipolo= ipol
       
      ue = uet*pi/180.0
      q0 = ei - er
      q2 = 4.0*ei*er*sin(ue/2.0)**2
      qv = sqrt(q2 + q0**2)
      x = q2/(2.0*pm*q0)
*      write(6,*)"x",x
      tn = (sin(ue/2.0)/cos(ue/2.0))
      sigma = f2_a2(x,q2,it,ib) + 2.0*q0/pm*tn**2 *f1_a2(x,q2,it,ib)
      sigma_in = gmott(ei,ue)/q0 * sigma
      endif
      return
      end


C==== Mott Factor=====
      function gmott(ei,ue)
      g1=(1./137)**2*cos(ue/2.)**2
      g2=4.*ei**2*sin(ue/2.)**4
      gmott=g1/g2*0.389385*1000.*1000.*1000.  ! picobarn
      return
      end


	function f2_a2(x,q2,it,ib)
***********************************************
* F2 structure function for Deuteron
* x  - Bjorken x
*     ib  = 0 - no Bjorken, 1 - Bjorken limit
*********************************************** 
        common/par/pi,pm,dm
        common/photon/q2m,q0,qv
	external pta,ptb,undint_d
        common/Bjl/ibj
        common/itn/itn
        itn = it
        ibj = ib
        q2m =  q2
        q0  = q2/2.0/pm/x
        qv  = sqrt(q2 + q0**2)
        ala = x
	alb = 1.99
	eps = 0.000001
	call gadap2(ala,alb,pta,ptb,undint_d,eps,sum)
	f2_a2  = sum * 2.0*acos(-1.0)
	return
	end 

	function f1_a2(x,q2,it,ib)
        common/par/pi,pm,dm
        r = 0.18
        q0 = q2/(2.0*pm*x)
        f1_a2 = f2_a2(x,q2,it,ib)/((1.0+r)*2.0*x)*(1.0+2.0*pm*x/q0)
        return
        end


	function pta(al)
	pta=0.0
	return
	end

	function ptb(al)
	ptb = 1.0
	return
	end

 

      function undint_d(al,pt)
****************************************
* DIS  scattering from the deuteron
****************************************
      common/par/pi,pm,dm
      common/ttarget/a,zp,zn,tm,emin
      common/photon/q2,q0,qv
      common/itn/itn
      common/bjl/ibj
      common/lc/ilc
      common/pol/ipol
      undint_d = 0.0
      alq  = 2.0*(q0 - qv)/dm
      qplus = q0 + qv
**************************************************************
* definition of tilde_nu and tilde_x, which enters as 
* an argument in the structure function. 
* It is defined through  the final hadronic mass w2
***************************************************************
      d  = -q2 + 2.0*q0*dm+dm**2
      als = 2.0-al
      pmn = dm/2.0
      psz = (pm**2 + pt**2 - als**2*pmn**2)/(2.0*als*pmn)
      es  = sqrt(pm**2 + pt**2 + psz**2)
      wf2 = d -2.0*es*(q0+dm) + 2.0*psz*qv + pm**2

      tl_nu = (wf2 + q2 - pm**2)/(2.0*pm)
      tl_x = q2/(2.0*tl_nu*pm)
      if(ibj.eq.1)then
      tl_x = q2/(2.0*pm*q0)/al
      endif
****************************************************************
* definition of nu^prime, which is the four-product of p*q/m
* where p is the interacting nucleon's four momenta
* pr_nu = 1/2m (p_{+}q_{-} + p_{-}q_{+})
****************************************************************
       pplusd = dm - (pm**2 + pt**2)/((2.0-al)*pmn)
       pr_nu  = (dm/2.0)/(2.0*pm)*(pplusd*alq+qplus*al)

****************************************************************
* definitions of cos\delta and sin\delta
****************************************************************
       cos_delta = q0/qv
       sin_delta = sqrt(q2)/qv

****************************************************************
* calculation of integrand
****************************************************************
      a10   = (1.0+cos_delta)**2 * (al+alq*pm*pr_nu/Q2)**2
      a1    = (pmn/pm)**2*a10 + sin_delta**2*pt**2/(2.0*pm**2)
      a_d   = q0/pr_nu * a1
      if(ibj.eq.1)then
      a_d  = (pmn/pm)*al
      endif
*************************************
* virtual nucleon approximation
*************************************
      if(ilc.eq.0)then
      p = sqrt(pt**2 + psz**2) 
*     west = (dm - es)/pmn
      wes   = es/al/als
      ia = 2
      f2pro = f2p(tl_x,Q2,p,ia)
      f2neu = f2n(tl_x,Q2,p,ia)
      if(itn.eq.1)f2neu = 0.0
      if(itn.eq.2)f2pro = 0.0
      pz = -psz  ! stugel
      write(10,*)al,p,pz
      term   = a_d*(f2pro+f2neu)*fd(p,pz,ipol)*wes
*      term   = fd(p,pz,ipol)
      else 
****************************************
* LC approximation
****************************************
      pk = sqrt((pm**2 + pt**2)/(al*(2.0-al))-pm**2)
      ek = sqrt(pm**2 + pk**2)
      ia  = 2
      f2pro = f2p(tl_x,Q2,pk,ia)
      f2neu = f2n(tl_x,Q2,pk,ia)
      if(itn.eq.1)f2neu = 0.0
      if(itn.eq.2)f2pro = 0.0
      pkz = (ek-al*ek)! stugel
      term   = a_d*(f2pro+f2neu)*ek*fd(pk,pkz,ipol)/(2.0-al)/al**2
      endif
******************************************

      undint_d = term*pt 
      return
      end



*********************************************************
* inelastic structure functions for proton and neutron 
* the EMC effects are programmed here 
*********************************************************
      function f2p(x,q2,p,ia)
      common/emc/iemc
      f2p=0.0
      if(x.gt.1)return
      if(iemc.eq.0)then !no emc effects
      f2p = f2p_b(x,q2)
      elseif(iemc.eq.1)then ! emc effect in Color Screening model
      f2p = f2p_b(x,q2)*delta(x,p,ia)
      endif
      return
      end

      function f2n(x,q2,p,ia)
      common/emc/iemc
      f2n=0.0
      if(x.gt.1)return
      if(iemc.eq.0)then !no emc effects
      f2n = f2n_b(x,q2)
      elseif(iemc.eq.1)then ! emc effect in Color Screening model
      f2n = f2n_b(x,q2)*delta(x,p,ia)
      endif
      return
      end

	function delta(x,p,ia)
        common/ttarget/an,zp,zn,tm,emin
	pm = 0.938279
        Delta_E = 0.6
        ebound  = 0.002226
	delta   = 1.0
	if(x.le.0.3)return
	z   = (p**2 /pm + 2.*ebound)/Delta_E
	fnc  = 1.0/(1 + z)**2
	delta = fnc
	if(x.gt.0.3.and.x.lt.0.6)then
	delta = 1.0 +  (fnc-1.0) * (x-0.3)/0.3
	endif
	return
	end


*******************************************************
* Bodek - Ritchie Parameterization
*******************************************************
C............................................
C     ****** PROTON INELASTIC CONTRIBUTION ******

*****************************************************
*        Proton inelastic cross section
****************************************************
      function sigma_inp(ei,er,uet)
      common/par/pi,pm,dm
      sigma_inp = 0.0
      ue = uet*pi/180.0
      q0 = ei - er
      q2 = 4.0*ei*er*sin(ue/2.0)**2
      qv = sqrt(q2 + q0**2)
      x = q2/(2.0*pm*q0)
      if(x.gt.1.0)return
      tn = (sin(ue/2.0)/cos(ue/2.0))
      r = 0.18
      f1p_b = f2p_b(x,q2)/((1.0+r)*2.0*x)*(1.0+2.0*pm*x/q0)
 	
      sigma = f2p_b(x,q2) + 2.0*q0/pm*tn**2 *f1p_b
      sigma_inp = gmott(ei,ue)/q0 * sigma
      return
      end

C****** parameterization of  Proton inelastic  contribution ******

      FUNCTION f2p_b(xp,q2)
      common/par/pi,pm,dm
      f2p_b = 0.
      yn  =  q2/(2.0*pm*xp)
      fm2 = -q2 + 2.0*pm*yn + pm**2
      IF(xp.GT.1..OR.fm2.LT.pm**2)return
      fm     = sqrt(fm2)
      wwi    = (2.*yn*pm+1.642)/(q2+0.376)
      t      = 1.-1./wwi
      gw     = 0.256*t**3+2.178*t**4+0.898*t**5-6.716*t**6+3.756*t**7
      f2p_b = b(fm,q2)*gw*wwi*xp
      RETURN
      END
C..........................................
C     ****** NEUTRON INELASTIC CONTRIBUTION ******
*****************************************************
*        Neutron inelastic cross section
****************************************************
      function sigma_inn(ei,er,uet)
      common/par/pi,pm,dm
      sigma_inn = 0.0
      ue = uet*pi/180.0
      q0 = ei - er
      q2 = 4.0*ei*er*sin(ue/2.0)**2
      qv = sqrt(q2 + q0**2)
      x = q2/(2.0*pm*q0)
      if(x.gt.1.0)return
      tn = (sin(ue/2.0)/cos(ue/2.0))
      r = 0.18
      f1n_b = f2n_b(x,q2)/((1.0+r)*2.0*x)*(1.0+2.0*pm*x/q0)
 	
      sigma = f2n_b(x,q2) + 2.0*q0/pm*tn**2 *f1n_b
      sigma_inn = gmott(ei,ue)/q0 * sigma
      return
      end


C..........................................
C****** Parameterization of neutron structure fucion ******

      FUNCTION f2n_b(xp,q2)
      common/par/pi,pm,dm
      f2n_b = 0.
      yn  =  q2/(2.0*pm*xp)
      fm2 = -q2 + 2.0*pm*yn + pm**2 
      IF(xp.GT.1..OR.fm2.LT.pm**2)return
      fm     = sqrt(fm2)
      wwi    = (2.*yn*pm+1.642)/(q2+0.376)
      t      = 1.-1./wwi
      gw     = 0.064*t**3+0.225*t**4+4.106*t**5-7.079*t**6+3.055*t**7
      f2n_b = b(fm,q2)*gw*wwi*xp *corrp3_1(xp) *corrp3_2(xp)

********** corr1(xp)*corr2(xp) ! these are with p2
******************************************************
      RETURN
      END
C----------------------------------------------------------------------

      function corr1(x)
      a0 =  1.1216 
      a1 = -0.63962 
      a2 = 0.91810 
      corr1 = a0 + a1*x + a2*x**2
      return
      end

      function corr2(x)
      a0 =  1.0089  
      a1 = -0.82109E-01 
      a2 =  0.12066
      corr2 = a0 + a1*x + a2*x**2
      return
      end

      function corrp3_1(x)
************************************
*  This is correctio function in the 
* iteration 1 fited with p3
***************************************
      a0 =  0.99404 
      a1 =  0.46975
      a2 = -1.6549 
      a3 =  1.7274 
      corrp3_1 = a0 + a1*x + a2*x**2 + a3*x**3
      return
      end

      function corrp3_2(x)
************************************
*  This is correctio function in the 
* iteration 1 fited with p3
***************************************
      a0 =  0.97879  
      a1 =  0.20701 
      a2 = -0.61507
      a3 =  0.53608
      corrp3_2 = a0 + a1*x + a2*x**2 + a3*x**3
      return
      end
*******************************                                         
*     Deuteron Wave function                                            
*******************************                                         
                                                                        
      FUNCTION FD(X,xz,I)                                                  
**************************************************************             
*  DEUTRON WAVE FUNCTION WITH PARIS POTENTIAL                *
* x  - momentum in GeV/c                                     *
* xz - z component of the momentum in GeV/C                  *
* i - 0, initialization, 1 unpolarized, 2-tensor polarized   * 
*
* Modified to include the tensor polarization
* 27-July-03
* Miami
**************************************************************        
      COMMON/PARIS/C(13),D(13),BM(13)                                   
      fd = 0.0
      IF(I.EQ.0)THEN                                                    
      FD = 0.0                                                          
      C(1)=0.88688076                                                   
      C(2)=-0.34717093                                                  
      C(3)=-3.050238                                                    
      C(4)=56.207766                                                    
      C(5)=-749.57334                                                   
      C(6)=5336.5279                                                    
      C(7)=-22706.863                                                   
      C(8)=60434.4690                                                   
      C(9)=-102920.58                                                   
      C(10)=112233.57                                                   
      C(11)=-75925.226                                                  
      C(12)=29059.715                                                   
      A=0.                                                              
      DO 401 J=1,12                                                     
401   A=A+C(J)                                                          
      C(13)=-A                                                          
      D(1)=0.023135193                                                  
      D(2)=-0.85604572                                                  
      D(3)=5.6068193                                                    
      D(4)=-69.462922                                                   
      D(5)=416.31118                                                    
      D(6)=-1254.6621                                                   
      D(7)=1238.783                                                     
      D(8)=3373.9172                                                    
      D(9)=-13041.151                                                   
      D(10)=19512.524                                                   
      DO 402 J=1,13                                                     
402   BM(J)=0.23162461+(J-1)                                            
      A=0.                                                              
      B=0.                                                              
      CC=0.                                                             
      DO 3 J=1,10                                                       
      A=A+D(J)/BM(J)**2                                                 
      B=B+D(J)                                                          
3     CC=CC+D(J)*BM(J)**2                                               
      D(11)=BM(11)**2/(BM(13)**2-BM(11)**2)/(BM(12)**2-BM(11)           
     ***2)*(-BM(12)**2*BM(13)**2*A+(BM(12)**2+BM(13)**2)*B-CC)          
      D(12)=BM(12)**2/(BM(11)**2-BM(12)**2)/(BM(13)**2-BM(12)           
     ***2)*(-BM(13)**2*BM(11)**2*A+(BM(13)**2+BM(11)**2)*B-CC)          
      D(13)=BM(13)**2/(BM(12)**2-BM(13)**2)/(BM(11)**2-BM(13)           
     ***2)*(-BM(11)**2*BM(12)**2*A+(BM(11)**2+BM(12)**2)*B-CC)          
      ELSEif(i.eq.1)then    !unpolorized                                 
      FD=(U(X/0.197328)**2+W(X/0.197328)**2)/0.197328**3               
c     fd = 0.85*exp(-7.*x)
*26-jun-1996      if(x.gt.1.8)FD=0.0
      elseif(i.eq.2)then  ! tensor polorized
      uu = U(X/0.197328)    
      ww = W(X/0.197328)
                  xx = 0.0
      if(x.gt.0.0)xx = xz/x
      ap = -sqrt(2.0)*(1.0-3.0*xx**2)*uu*ww
      bp =  (1.0/2.0)*(1.0-3.0*xx**2)*ww**2
      fd = (ap + bp)/0.197328**3     
      ENDIF                                                             
      RETURN                                                            
      END                                                               
C ***** S PARTIAL WAVE ******                                           
      FUNCTION U(X)                                                     
      COMMON/PARIS/C(13),D(13),BM(13)                                   
      A=0.                                                              
      DO 1 J=1,13                                                       
1     A=C(J)/(X*X+BM(J)**2)+A                                           
      F=0.79788456                                                      
      U=A*F/SQRT(4.*3.14159265)                                         
      RETURN                                                            
      END                                                               
C  **** D PARTIAL WAVE *****                                            
      FUNCTION W(X)                                                    
      COMMON/PARIS/C(13),D(13),BM(13)                                   
      A=0.                                                              
      DO 1 J=1,13                                                       
1     A=D(J)/(X*X+BM(J)**2)+A                                           
      F=0.79788456                                                      
      W=A*F/SQRT(4.*3.14159265)                                        
      RETURN                                                            
      END                                                               
                                                                        
      function uu(x)
      q = X/0.197328
      uu = u(q)/0.197328**(3./2.)
      return
      end               
      function ww(x)
      q = X/0.197328
      ww = w(q)/0.197328**(3./2.)
      return
      end               
   



C  *******************************                                      
C  *    BODEK PARAMETRIZATION    *                                      
C  *******************************                                      
      FUNCTION B(WM,QSQ)                                                
      DIMENSION C(24)                                                   
      INTEGER LSPIN(4)                                                  
      DATA PMSQ/0.880324/,PM2/1.876512/,PM/0.938256/                    
      DATA NRES/4/,NBKG/5/                                              
      DATA LSPIN/1,2,3,2/                                               
      DATA C/1.0741163,0.75531124,3.3506491,1.7447015,3.5102405,1.040004
     *,1.2299128,0.10625394,0.48132786,1.5101467,0.081661975,0.65587179,
     *1.7176216,0.12551987,0.7473379,1.953819,0.19891522,-0.17498537,   
     *0.0096701919,-0.035256748,3.5185207,-0.59993696,4.7615828,0.411675
     *89/                                                               
      B=0.                                                              
      IF(WM.LE.0.94)RETURN                                              
      WSQ=WM**2                                                         
      OMEGA=1.+(WSQ-PMSQ)/QSQ                                           
      X=1./OMEGA                                                        
      XPX=C(22)+C(23)*(X-C(24))**2                                      
      PIEMSQ=(C(1)-PM)**2                                               
********************************************************
*     added part
********************************************************
      B1 = 0.0
      IF(WM.EQ.C(1))GOTO 11 
******************************************************** 
      B1=AMAX1(0.,(WM-C(1)))/(WM-C(1))*C(2)       ! 0/0                 
********************************************************
11    EB1=C(3)*(WM-C(1))                                                
      IF(EB1.GT.25.)GO TO 1                                             
      B1=B1*(1.0-EXP(-EB1))                                             
*********************************************************
*     added part
*********************************************************  
      B2 = 0.0
      IF(WM.EQ.C(4))GOTO 12  
*********************************************************
1     B2=AMAX1(0.,(WM-C(4)))/(WM-C(4))*(1.-C(2))   ! 0/0                
*********************************************************
12    EB2=C(5)*(WSQ-C(4)**2)                                            
      IF(EB2.GT.25.) GO TO 2                                            
      B2=B2*(1.-EXP(-EB2))                                              
2     CONTINUE                                                          
      BBKG=B1+B2                                                        
      BRES=C(2)+B2                                                      
      RESSUM=0.                                                         
      DO 30 I=1,NRES                                                    
      INDEX=(I-1)*3+1+NBKG                                              
      RAM=C(INDEX)                                                      
      IF(I.EQ.1)RAM=C(INDEX)+C(18)*QSQ+C(19)*QSQ**2                     
      RMA=C(INDEX+1)                                                    
      IF(I.EQ.3)RMA=RMA*(1.+C(20)/(1.+C(21)*QSQ))                       
      RWD=C(INDEX+2)                                                    
      QSTARN=SQRT(AMAX1(0.,((WSQ+PMSQ-PIEMSQ)/(2.*WM))**2-PMSQ))        
      QSTARO=SQRT(AMAX1(0.,((RMA**2-PMSQ+PIEMSQ)/(2.*RMA))**2-PIEMSQ))  
      IF(QSTARO.LE.1.E-10)GO TO 40                                      
      TERM=6.08974*QSTARN                                               
      TERMO=6.08974*QSTARO                                              
      J=2*LSPIN(I)                                                      
      K=J+1                                                             
      GAMRES=RWD*(TERM/TERMO)**K*(1.+TERMO**J)/(1.+TERM**J)             
      GAMRES=GAMRES/2.                                                  
      BRWIG=GAMRES/((WM-RMA)**2+GAMRES**2)/3.1415926                    
      RES=RAM*BRWIG/PM2                                                 
      GO TO 30                                                          
40    RES=0.                                                            
30    RESSUM=RESSUM+RES                                                 
      B=BBKG*(1.+(1.-BBKG)*XPX)+RESSUM*(1.-BRES)                        
      RETURN                                                            
      END                                                               









      	function f2_wtl(ia,x,Q2)
*********************************************************************
* f2 Structure function of proton (ia=1) and deuteron (ia=2)
* within the Whitlow parameterization. From Phys.Lett. B282 (1992)475 
* The Kinematical ranges are:x >= 0.062, Q^2>=0.6, nu<19 GeV,
*                            w^2> 3 GeV^2
**********************************************************************
	dimension cw_p(12),cw_d(12)
	data cw_p/1.417, -0.108, 1.486, -5.979, 3.524, -0.011,
     &           -0.619,  1.385, 0.270, -2.179, 4.722, -4.363/
        data cw_d/0.948, -0.115, 1.861, -4.733, 2.348, -0.065,
     &           -0.224,  1.085, 0.213, -1.687, 3.409, -3.255/
 	
	pm  = 0.938379
                   factor = 1.0
        if(ia.eq.2)factor = 2.0
	aha = 1.22*exp(3.2*x)
	ab  = 20.0
	ab1 = 7.7*(1.0/x +pm**2/Q2-1.0)
	if(ab1.lt.ab)ab=ab1 
	if(ia.eq.1)then
	f2_thr = 0.0
	do j = 1,5
	f2_thr = f2_thr + cw_p(j)*(1.0-x)**(j+2)
	enddo
	alm1 = cw_p(9) + cw_p(10)*x + cw_p(11)*x**2 + cw_p(12)*x**3
	alm2 = 0.0 
	if(q2.le.aha)alm2 = cw_p(6) + cw_p(7) *x + cw_p(8)*x**2  
	beta = 1.0
	elseif(ia.eq.2)then
	f2_thr = 0.0
	do j = 1,5
	f2_thr = f2_thr + cw_d(j)*(1.0-x)**(j+2)
	enddo
	alm1 = cw_d(9) + cw_d(10)*x + cw_d(11)*x**2 + cw_d(12)*x**3
	alm2 = 0.0 
	if(q2.le.aha)alm2 = cw_d(6) + cw_d(7) *x + cw_d(8)*x**2  
	beta = 1.0/(1.0-exp(-ab))
	endif
	fc   = 1.0 + alm1*alog(Q2/aha) + alm2*alog(Q2/aha)**2
	f2_wtl = beta * f2_thr * fc * factor
	return
	end


*help file

*********************************                                       
*   Subroutine for integration                                          
********************************                                        
      SUBROUTINE GADAP(A0,B0,F,EPS,SUM)                                 
      COMMON/GADAP1/ NUM,IFU                                            
      EXTERNAL F                                                        
      DIMENSION A(300),B(300),F1(300),F2(300),F3(300),S(300),N(300)     
*    1 FORMAT(16H GADAP:I TOO BIG)                                       
      DSUM(F1F,F2F,F3F,AA,BB)=5./18.*(BB-AA)*(F1F+1.6*F2F+F3F)          
      IF(EPS.LT.1.0E-8) EPS=1.0E-8  
      RED=1.3   
      L=1   
      I=1   
      SUM=0.    
      C=SQRT(15.)/5.    
      A(1)=A0   
      B(1)=B0   
      F1(1)=F(0.5*(1+C)*A0+0.5*(1-C)*B0)    
      F2(1)=F(0.5*(A0+B0))  
      F3(1)=F(0.5*(1-C)*A0+0.5*(1+C)*B0)    
      IFU=3 
      S(1)=  DSUM(F1(1),F2(1),F3(1),A0,B0)  
  100 CONTINUE  
      L=L+1 
      N(L)=3    
      EPS=EPS*RED   
      A(I+1)=A(I)+C*(B(I)-A(I)) 
      B(I+1)=B(I)   
      A(I+2)=A(I)+B(I)-A(I+1)   
      B(I+2)=A(I+1) 
      A(I+3)=A(I)   
      B(I+3)=A(I+2) 
      W1=A(I)+(B(I)-A(I))/5.    
      U2=2.*W1-(A(I)+A(I+2))/2. 
      F1(I+1)=F(A(I)+B(I)-W1)   
      F2(I+1)=F3(I) 
      F3(I+1)=F(B(I)-A(I+2)+W1) 
      F1(I+2)=F(U2) 
      F2(I+2)=F2(I) 
      F3(I+2)=F(B(I+2)+A(I+2)-U2)   
      F1(I+3)=F(A(I)+A(I+2)-W1) 
      F2(I+3)=F1(I) 
      F3(I+3)=F(W1) 
      IFU=IFU+6 
      IF(IFU.GT.5000) GOTO 130  
      S(I+1)=  DSUM(F1(I+1),F2(I+1),F3(I+1),A(I+1),B(I+1))  
      S(I+2)=  DSUM(F1(I+2),F2(I+2),F3(I+2),A(I+2),B(I+2))  
      S(I+3)=  DSUM(F1(I+3),F2(I+3),F3(I+3),A(I+3),B(I+3))  
      SS=S(I+1)+S(I+2)+S(I+3)   
      I=I+3 
      IF(I.GT.300)GOTO 120  
      SOLD=S(I-3)   
      IF(ABS(SOLD-SS).GT.EPS*(1.+ABS(SS))/2.) GOTO 100  
      SUM=SUM+SS    
      I=I-4 
      N(L)=0    
      L=L-1 
  110 CONTINUE  
      IF(L.EQ.1) GOTO 130   
      N(L)=N(L)-1   
      EPS=EPS/RED   
      IF(N(L).NE.0) GOTO 100    
      I=I-1 
      L=L-1 
      GOTO 110  
  120 CONTINUE
C      WRITE(6,1)    
 130  RETURN    
      END   


      SUBROUTINE GADAPu(A0,B0,F,EPS,SUM)                                 
      COMMON/GADAPu1/ NUM,IFU                                            
      EXTERNAL F                                                        
      DIMENSION A(300),B(300),F1(300),F2(300),F3(300),S(300),N(300)     
*    1 FORMAT(16H GADAPu:I TOO BIG)                                       
      DSUM(F1F,F2F,F3F,AA,BB)=5./18.*(BB-AA)*(F1F+1.6*F2F+F3F)          
      IF(EPS.LT.1.0E-8) EPS=1.0E-8  
      RED=1.3   
      L=1   
      I=1   
      SUM=0.    
      C=SQRT(15.)/5.    
      A(1)=A0   
      B(1)=B0   
      F1(1)=F(0.5*(1+C)*A0+0.5*(1-C)*B0)    
      F2(1)=F(0.5*(A0+B0))  
      F3(1)=F(0.5*(1-C)*A0+0.5*(1+C)*B0)    
      IFU=3 
      S(1)=  DSUM(F1(1),F2(1),F3(1),A0,B0)  
  100 CONTINUE  
      L=L+1 
      N(L)=3    
      EPS=EPS*RED   
      A(I+1)=A(I)+C*(B(I)-A(I)) 
      B(I+1)=B(I)   
      A(I+2)=A(I)+B(I)-A(I+1)   
      B(I+2)=A(I+1) 
      A(I+3)=A(I)   
      B(I+3)=A(I+2) 
      W1=A(I)+(B(I)-A(I))/5.    
      U2=2.*W1-(A(I)+A(I+2))/2. 
      F1(I+1)=F(A(I)+B(I)-W1)   
      F2(I+1)=F3(I) 
      F3(I+1)=F(B(I)-A(I+2)+W1) 
      F1(I+2)=F(U2) 
      F2(I+2)=F2(I) 
      F3(I+2)=F(B(I+2)+A(I+2)-U2)   
      F1(I+3)=F(A(I)+A(I+2)-W1) 
      F2(I+3)=F1(I) 
      F3(I+3)=F(W1) 
      IFU=IFU+6 
      IF(IFU.GT.5000) GOTO 130  
      S(I+1)=  DSUM(F1(I+1),F2(I+1),F3(I+1),A(I+1),B(I+1))  
      S(I+2)=  DSUM(F1(I+2),F2(I+2),F3(I+2),A(I+2),B(I+2))  
      S(I+3)=  DSUM(F1(I+3),F2(I+3),F3(I+3),A(I+3),B(I+3))  
      SS=S(I+1)+S(I+2)+S(I+3)   
      I=I+3 
      IF(I.GT.300)GOTO 120  
      SOLD=S(I-3)   
      IF(ABS(SOLD-SS).GT.EPS*(1.+ABS(SS))/2.) GOTO 100  
      SUM=SUM+SS    
      I=I-4 
      N(L)=0    
      L=L-1 
  110 CONTINUE  
      IF(L.EQ.1) GOTO 130   
      N(L)=N(L)-1   
      EPS=EPS/RED   
      IF(N(L).NE.0) GOTO 100    
      I=I-1 
      L=L-1 
      GOTO 110  
  120 CONTINUE
C      WRITE(6,1)    
 130  RETURN    
      END   

      SUBROUTINE GADAP2(A0,B0,FL,FU,F,EPS,SUM)  
      COMMON/GADAP_2/ NUM,IFU    
      EXTERNAL F,FL,FU  
      DIMENSION A(300),B(300),F1(300),F2(300),F3(300),S(300),N(300) 
*    1 FORMAT(16H GADAP:I TOO BIG)   
      DSUM(F1F,F2F,F3F,AA,BB)=5./18.*(BB-AA)*(F1F+1.6*F2F+F3F)  
      IF(EPS.LT.1.0E-8) EPS=1.0E-8  
      RED=1.4   
      L=1   
      I=1   
      SUM=0.    
      C=SQRT(15.)/5.    
      A(1)=A0   
      B(1)=B0   
      X=0.5*(1+C)*A0+0.5*(1-C)*B0   
      AY=FL(X)  
      BY=FU(X)  
      F1(1)=FGADAP(X,AY,BY,F,EPS)   
      X=0.5*(A0+B0) 
      AY=FL(X)  
      BY=FU(X)  
      F2(1)=FGADAP(X,AY,BY,F,EPS)   
      X=0.5*(1-C)*A0+0.5*(1+C)*B0   
      AY=FL(X)  
      BY=FU(X)  
      F3(1)=FGADAP(X,AY,BY,F,EPS)   
      IFU=3 
      S(1)=  DSUM(F1(1),F2(1),F3(1),A0,B0)  
  100 CONTINUE  
      L=L+1 
      N(L)=3    
      EPS=EPS*RED   
      A(I+1)=A(I)+C*(B(I)-A(I)) 
      B(I+1)=B(I)   
      A(I+2)=A(I)+B(I)-A(I+1)   
      B(I+2)=A(I+1) 
      A(I+3)=A(I)   
      B(I+3)=A(I+2) 
      W1=A(I)+(B(I)-A(I))/5.    
      U2=2.*W1-(A(I)+A(I+2))/2. 
      X=A(I)+B(I)-W1    
      AY=FL(X)  
      BY=FU(X)  
      F1(I+1)=FGADAP(X,AY,BY,F,EPS) 
      F2(I+1)=F3(I) 
      X=B(I)-A(I+2)+W1  
      AY=FL(X)  
      BY=FU(X)  
      F3(I+1)=FGADAP(X,AY,BY,F,EPS) 
      X=U2  
      AY=FL(X)  
      BY=FU(X)  
      F1(I+2)=FGADAP(X,AY,BY,F,EPS) 
      F2(I+2)=F2(I) 
      X=B(I+2)+A(I+2)-U2    
      AY=FL(X)  
      BY=FU(X)  
      F3(I+2)=FGADAP(X,AY,BY,F,EPS) 
      X=A(I)+A(I+2)-W1  
      AY=FL(X)  
      BY=FU(X)  
      F1(I+3)=FGADAP(X,AY,BY,F,EPS) 
      F2(I+3)=F1(I) 
      X=W1  
      AY=FL(X)  
      BY=FU(X)  
      F3(I+3)=FGADAP(X,AY,BY,F,EPS) 
      IFU=IFU+6 
      IF(IFU.GT.5000) GOTO 130  
      S(I+1)=  DSUM(F1(I+1),F2(I+1),F3(I+1),A(I+1),B(I+1))  
      S(I+2)=  DSUM(F1(I+2),F2(I+2),F3(I+2),A(I+2),B(I+2))  
      S(I+3)=  DSUM(F1(I+3),F2(I+3),F3(I+3),A(I+3),B(I+3))  
      SS=S(I+1)+S(I+2)+S(I+3)   
      I=I+3 
      IF(I.GT.300)GOTO 120  
      SOLD=S(I-3)   
      IF(ABS(SOLD-SS).GT.EPS*(1.+ABS(SS))/2.) GOTO 100  
      SUM=SUM+SS    
      I=I-4 
      N(L)=0    
      L=L-1 
  110 CONTINUE  
      IF(L.EQ.1) GOTO 130   
      N(L)=N(L)-1   
      EPS=EPS/RED   
      IF(N(L).NE.0) GOTO 100    
      I=I-1 
      L=L-1 
      GOTO 110  
  120 CONTINUE
C      WRITE(6,1)    
 130  RETURN    
      END   
      FUNCTION FGADAP(X,A0,B0,F,EPS)    
      COMMON/GADAP_2/ NUM,IFU    
      EXTERNAL F    
      DIMENSION A(300),B(300),F1(300),F2(300),F3(300),S(300),N(300) 
*    1 FORMAT(16H GADAP:I TOO BIG)   
      DSUM(F1F,F2F,F3F,AA,BB)=5./18.*(BB-AA)*(F1F+1.6*F2F+F3F)  
      IF(EPS.LT.1.0E-8) EPS=1.0E-8  
      RED=1.4   
      L=1   
      I=1   
      SUM=0.    
      C=SQRT(15.)/5.    
      A(1)=A0   
      B(1)=B0   
      F1(1)=F(X,0.5*(1+C)*A0+0.5*(1-C)*B0)  
      F2(1)=F(X,0.5*(A0+B0))    
      F3(1)=F(X,0.5*(1-C)*A0+0.5*(1+C)*B0)  
      IFU=3 
      S(1)=  DSUM(F1(1),F2(1),F3(1),A0,B0)  
  100 CONTINUE  
      L=L+1 
      N(L)=3    
      EPS=EPS*RED   
      A(I+1)=A(I)+C*(B(I)-A(I)) 
      B(I+1)=B(I)   
      A(I+2)=A(I)+B(I)-A(I+1)   
      B(I+2)=A(I+1) 
      A(I+3)=A(I)   
      B(I+3)=A(I+2) 
      W1=A(I)+(B(I)-A(I))/5.    
      U2=2.*W1-(A(I)+A(I+2))/2. 
      F1(I+1)=F(X,A(I)+B(I)-W1) 
      F2(I+1)=F3(I) 
      F3(I+1)=F(X,B(I)-A(I+2)+W1)   
      F1(I+2)=F(X,U2)   
      F2(I+2)=F2(I) 
      F3(I+2)=F(X,B(I+2)+A(I+2)-U2) 
      F1(I+3)=F(X,A(I)+A(I+2)-W1)   
      F2(I+3)=F1(I) 
      F3(I+3)=F(X,W1)   
      IFU=IFU+6 
      IF(IFU.GT.5000) GOTO 130  
      S(I+1)=  DSUM(F1(I+1),F2(I+1),F3(I+1),A(I+1),B(I+1))  
      S(I+2)=  DSUM(F1(I+2),F2(I+2),F3(I+2),A(I+2),B(I+2))  
      S(I+3)=  DSUM(F1(I+3),F2(I+3),F3(I+3),A(I+3),B(I+3))  
      SS=S(I+1)+S(I+2)+S(I+3)   
      I=I+3 
      IF(I.GT.300)GOTO 120  
      SOLD=S(I-3)   
      IF(ABS(SOLD-SS).GT.EPS*(1.+ABS(SS))/2.) GOTO 100  
      SUM=SUM+SS    
      I=I-4 
      N(L)=0    
      L=L-1 
  110 CONTINUE  
      IF(L.EQ.1) GOTO 130   
      N(L)=N(L)-1   
      EPS=EPS/RED   
      IF(N(L).NE.0) GOTO 100    
      I=I-1 
      L=L-1 
      GOTO 110  
  120 CONTINUE
C      WRITE(6,1)    
 130  FGADAP=SUM    
      EPS=EPS/RED   
      RETURN    
      END   




      SUBROUTINE GADAPS2(A0,B0,FL,FU,F,EPS,SUM)  
      COMMON/GADAPS_2/ NUM,IFU    
      EXTERNAL F,FL,FU  
      DIMENSION A(300),B(300),F1(300),F2(300),F3(300),S(300),N(300) 
*    1 FORMAT(16H GADAP:I TOO BIG)   
      DSUM(F1F,F2F,F3F,AA,BB)=5./18.*(BB-AA)*(F1F+1.6*F2F+F3F)  
      IF(EPS.LT.1.0E-8) EPS=1.0E-8  
      RED=1.4   
      L=1   
      I=1   
      SUM=0.    
      C=SQRT(15.)/5.    
      A(1)=A0   
      B(1)=B0   
      X=0.5*(1+C)*A0+0.5*(1-C)*B0   
      AY=FL(X)  
      BY=FU(X)  
      F1(1)=FGADAPS(X,AY,BY,F,EPS)   
      X=0.5*(A0+B0) 
      AY=FL(X)  
      BY=FU(X)  
      F2(1)=FGADAPS(X,AY,BY,F,EPS)   
      X=0.5*(1-C)*A0+0.5*(1+C)*B0   
      AY=FL(X)  
      BY=FU(X)  
      F3(1)=FGADAPS(X,AY,BY,F,EPS)   
      IFU=3 
      S(1)=  DSUM(F1(1),F2(1),F3(1),A0,B0)  
  100 CONTINUE  
      L=L+1 
      N(L)=3    
      EPS=EPS*RED   
      A(I+1)=A(I)+C*(B(I)-A(I)) 
      B(I+1)=B(I)   
      A(I+2)=A(I)+B(I)-A(I+1)   
      B(I+2)=A(I+1) 
      A(I+3)=A(I)   
      B(I+3)=A(I+2) 
      W1=A(I)+(B(I)-A(I))/5.    
      U2=2.*W1-(A(I)+A(I+2))/2. 
      X=A(I)+B(I)-W1    
      AY=FL(X)  
      BY=FU(X)  
      F1(I+1)=FGADAPS(X,AY,BY,F,EPS) 
      F2(I+1)=F3(I) 
      X=B(I)-A(I+2)+W1  
      AY=FL(X)  
      BY=FU(X)  
      F3(I+1)=FGADAPS(X,AY,BY,F,EPS) 
      X=U2  
      AY=FL(X)  
      BY=FU(X)  
      F1(I+2)=FGADAPS(X,AY,BY,F,EPS) 
      F2(I+2)=F2(I) 
      X=B(I+2)+A(I+2)-U2    
      AY=FL(X)  
      BY=FU(X)  
      F3(I+2)=FGADAPS(X,AY,BY,F,EPS) 
      X=A(I)+A(I+2)-W1  
      AY=FL(X)  
      BY=FU(X)  
      F1(I+3)=FGADAPS(X,AY,BY,F,EPS) 
      F2(I+3)=F1(I) 
      X=W1  
      AY=FL(X)  
      BY=FU(X)  
      F3(I+3)=FGADAPS(X,AY,BY,F,EPS) 
      IFU=IFU+6 
      IF(IFU.GT.5000) GOTO 130  
      S(I+1)=  DSUM(F1(I+1),F2(I+1),F3(I+1),A(I+1),B(I+1))  
      S(I+2)=  DSUM(F1(I+2),F2(I+2),F3(I+2),A(I+2),B(I+2))  
      S(I+3)=  DSUM(F1(I+3),F2(I+3),F3(I+3),A(I+3),B(I+3))  
      SS=S(I+1)+S(I+2)+S(I+3)   
      I=I+3 
      IF(I.GT.300)GOTO 120  
      SOLD=S(I-3)   
      IF(ABS(SOLD-SS).GT.EPS*(1.+ABS(SS))/2.) GOTO 100  
      SUM=SUM+SS    
      I=I-4 
      N(L)=0    
      L=L-1 
  110 CONTINUE  
      IF(L.EQ.1) GOTO 130   
      N(L)=N(L)-1   
      EPS=EPS/RED   
      IF(N(L).NE.0) GOTO 100    
      I=I-1 
      L=L-1 
      GOTO 110  
  120 CONTINUE
C      WRITE(6,1)    
 130  RETURN    
      END   
      FUNCTION FGADAPS(X,A0,B0,F,EPS)    
      COMMON/GADAPS_2/ NUM,IFU    
      EXTERNAL F    
      DIMENSION A(300),B(300),F1(300),F2(300),F3(300),S(300),N(300) 
*    1 FORMAT(16H GADAP:I TOO BIG)   
      DSUM(F1F,F2F,F3F,AA,BB)=5./18.*(BB-AA)*(F1F+1.6*F2F+F3F)  
      IF(EPS.LT.1.0E-8) EPS=1.0E-8  
      RED=1.4   
      L=1   
      I=1   
      SUM=0.    
      C=SQRT(15.)/5.    
      A(1)=A0   
      B(1)=B0   
      F1(1)=F(X,0.5*(1+C)*A0+0.5*(1-C)*B0)  
      F2(1)=F(X,0.5*(A0+B0))    
      F3(1)=F(X,0.5*(1-C)*A0+0.5*(1+C)*B0)  
      IFU=3 
      S(1)=  DSUM(F1(1),F2(1),F3(1),A0,B0)  
  100 CONTINUE  
      L=L+1 
      N(L)=3    
      EPS=EPS*RED   
      A(I+1)=A(I)+C*(B(I)-A(I)) 
      B(I+1)=B(I)   
      A(I+2)=A(I)+B(I)-A(I+1)   
      B(I+2)=A(I+1) 
      A(I+3)=A(I)   
      B(I+3)=A(I+2) 
      W1=A(I)+(B(I)-A(I))/5.    
      U2=2.*W1-(A(I)+A(I+2))/2. 
      F1(I+1)=F(X,A(I)+B(I)-W1) 
      F2(I+1)=F3(I) 
      F3(I+1)=F(X,B(I)-A(I+2)+W1)   
      F1(I+2)=F(X,U2)   
      F2(I+2)=F2(I) 
      F3(I+2)=F(X,B(I+2)+A(I+2)-U2) 
      F1(I+3)=F(X,A(I)+A(I+2)-W1)   
      F2(I+3)=F1(I) 
      F3(I+3)=F(X,W1)   
      IFU=IFU+6 
      IF(IFU.GT.5000) GOTO 130  
      S(I+1)=  DSUM(F1(I+1),F2(I+1),F3(I+1),A(I+1),B(I+1))  
      S(I+2)=  DSUM(F1(I+2),F2(I+2),F3(I+2),A(I+2),B(I+2))  
      S(I+3)=  DSUM(F1(I+3),F2(I+3),F3(I+3),A(I+3),B(I+3))  
      SS=S(I+1)+S(I+2)+S(I+3)   
      I=I+3 
      IF(I.GT.300)GOTO 120  
      SOLD=S(I-3)   
      IF(ABS(SOLD-SS).GT.EPS*(1.+ABS(SS))/2.) GOTO 100  
      SUM=SUM+SS    
      I=I-4 
      N(L)=0    
      L=L-1 
  110 CONTINUE  
      IF(L.EQ.1) GOTO 130   
      N(L)=N(L)-1   
      EPS=EPS/RED   
      IF(N(L).NE.0) GOTO 100    
      I=I-1 
      L=L-1 
      GOTO 110  
  120 CONTINUE
C      WRITE(6,1)    
 130  FGADAPS=SUM    
      EPS=EPS/RED   
      RETURN    
      END   







