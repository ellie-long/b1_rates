      PROGRAM RATES
c----------
c     Get rates for the b1d proposal
c
c--   Patricia Solvignon, Nov. 16, 2010
c  
      REAL*8 pi,alpha,mp,e_ch,picobarn,nanobarn,Navo
      PARAMETER( hbarc2   = 0.389379E-3) ! barn.GeV^2
      PARAMETER( pi       = 3.14159265 )
      PARAMETER( mp       = 0.938272    )
      PARAMETER( e_ch     = 1.602E-19  )
      PARAMETER( picobarn = 1E12       )
      PARAMETER( nanobarn = 1E9        )
      PARAMETER( Navo     = 6.022E23   )   ! mol-1

      INTEGER kin_in
      INTEGER npbin,ntbin
      INTEGER ip,it
      REAL*8 e_in,ep_in,th_in,y_in,Pzz_in
      REAL*8 A,d_r
      REAL*8 dp_p,dp_m,dtheta,dphi,acc,hms_min
      REAL*8 deg,thrad,thincr,thmin
      REAL*8 dep,epmin,epmax
      REAL*8 s2,t2,xx,qq,w

      REAL*8 ND
      REAL*8 rho_nd3,M_nd3,dil_nd3,pack_nd3,Pz_nd3
      REAL*8 rho_lid,M_lid,dil_lid,pack_lid,Pz_lid
      REAL*8 f_dil,Pzz_fact
      REAL*8 rho,Nelec,lumi

      REAL*8 deltae
      REAL*8 w2min,w2pion,K_fact

      REAL*8 tb,ta,teff
      REAL*8 aux(7)

      REAL*8 pit,thit
      REAL*8 snsq,cssq,tnsq,nu,q2,w2,x

      REAL*8 bcurrent,tgt_thick,tgt_len

      REAL*8 mott
      REAL*8 Pzz,Aout,F1out,b1out
      REAL*8 sigma_unpol,sigma_tensor,sigma_born
      REAL*8 sigma_unpol_xem
      REAL*8 sigma_meas
      REAL*4 dis_raw,qe_raw,mod_raw

      ! output rates
      REAL*8  xp,q2p
      REAL*8  sigradsum,sigradave,sigma_unpol_e
      REAL*8  sigma,sigmasum,sigcenter,sigmasump
      REAL*8  rate
      REAL*8  ratetot
      REAL*8  totrate(11),sigsum(11)
      INTEGER ixsum(11),ib
      REAL*8  sigpara,sigperp,e_fact,scale,b1d_scaled,scale_time
      REAL*8  Azz,dAzz,time
      REAL*8  b1d,db1d
      REAL*8  e_b1_abs

      REAL*8  xcent,prec_bin

      REAL*8  tot_time(100)
      REAL*8  fsyst_xs
      REAL*8  syst_Azz, syst_b1d
      REAL*4  dummy

      REAL*8 m_nuc,m_amu,m_e
      INTEGER apass,zpass
      INTEGER ix,ispectro,isum,type
      CHARACTER targ*3

      LOGICAL central
      INTEGER method

      INTEGER nx,nx1,nx2,nx3,nx4,nx5,nx6
      REAL*8 prec

      PARAMETER (nx1  = 11)
      REAL*8 xval1(nx1),qqval1(nx1),prec1(nx1)

      PARAMETER (nx2  = 11)
      REAL*8 xval2(nx2),qqval2(nx2),prec2(nx2)

      PARAMETER (nx3  = 11)
      REAL*8 xval3(nx3),qqval3(nx3),prec3(nx3)

      PARAMETER (nx4  = 11)
      REAL*8 xval4(nx4),qqval4(nx4),prec4(nx4)

      PARAMETER (nx5  = 11)
      REAL*8 xval5(nx5),qqval5(nx5),prec5(nx5)

      PARAMETER (nx6  = 11)
      REAL*8 xval6(nx6),qqval6(nx6),prec6(nx6)

      REAL*8 xmin(11),xmax(11)

      ! 11 GeV kinematics
      ! HMS

      DATA xval1/    0.150, 0.200, 0.250, 0.300, 0.350, 0.400, 0.450, 0.500, 0.550, 0.600, 0.650/
      DATA qqval1/   2.245, 3.203, 4.173, 5.145, 6.125, 7.106, 8.081, 9.056,10.029,11.003,11.969/
      DATA prec1/    1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00/

      ! SHMS
      DATA xval2/    0.150, 0.200, 0.250, 0.300, 0.350, 0.400, 0.450, 0.500, 0.550, 0.600, 0.650/
      DATA qqval2/   2.245, 3.203, 4.173, 5.145, 6.125, 7.106, 8.081, 9.056,10.029,11.003,11.969/  
      DATA prec2/    1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00/   

      ! HRSs
      DATA xval3/    0.150, 0.200, 0.250, 0.300, 0.350, 0.400, 0.450, 0.500, 0.550, 0.600, 0.650/   
      DATA qqval3/   2.245, 3.203, 4.173, 5.145, 6.125, 7.106, 8.081, 9.056,10.029,11.003,11.969/  
      DATA prec3/    1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00/   

      ! SOLID
      DATA xval4/    0.150, 0.200, 0.250, 0.300, 0.350, 0.400, 0.450, 0.500, 0.550, 0.600, 0.650/   
      DATA qqval4/   2.245, 3.203, 4.173, 5.145, 6.125, 7.106, 8.081, 9.056,10.029,11.003,11.969/  
      DATA prec4/    1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00/   

      ! BB
      DATA xval5/    0.150, 0.200, 0.250, 0.300, 0.350, 0.400, 0.450, 0.500, 0.550, 0.600, 0.650/ 
      DATA qqval5/   2.245, 3.203, 4.173, 5.145, 6.125, 7.106, 8.081, 9.056,10.029,11.003,11.969/ 
      DATA prec5/    1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00/  

      ! SBS
      DATA xval6/    0.150, 0.200, 0.250, 0.300, 0.350, 0.400, 0.450, 0.500, 0.550, 0.600, 0.650/  
      DATA qqval6/   2.245, 3.203, 4.173, 5.145, 6.125, 7.106, 8.081, 9.056,10.029,11.003,11.969/ 
      DATA prec6/    1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00,  1.00/  

      ! rebinning
      DATA xmin/ 0.125,0.175,0.225,0.275,0.325,0.375,0.425,0.475,0.525,0.575,0.625/
      DATA xmax/ 0.175,0.225,0.275,0.325,0.375,0.425,0.475,0.525,0.575,0.625,0.675/

c---- INPUT/OUTPUT -----------------------------------------

      OPEN(UNIT= 8, FILE='output/xs.out',     STATUS='UNKNOWN')
      OPEN(UNIT= 9, FILE='output/rates_pbin.out',  STATUS='UNKNOWN')
      OPEN(UNIT=10, FILE='output/rates.out',  STATUS='UNKNOWN')
      OPEN(UNIT=11, FILE='output/prop_table.out',  STATUS='UNKNOWN')

c---- CONSTANT -------------------------------------------

      alpha   =  1.0/137.0
      d_r     =  pi/180.0     ! deg --> rad
      m_e     = .5109991D-03  ! Electron mass in GeV/c^2.
      m_amu   = .9314943D0    ! Atomic mass unit in GeV/c^2.
c
c---- PARAMETER -------------------------------------------

      central   = .false.   ! true --> use only central angle
                            ! false --> use acceptance phase space

      scale_time= 1.0 
      scale     = 5.0       ! scale b1 kumano model
      type      = 1         ! 1=physics rates, 2=total rates
      targ      = 'ND3'     ! ND3 or LiD
c      targ      = 'LiD'
c      e_in      = 5.5 
      e_in      =  11.0
      w2pion    =  1.18**2  ! pion threshold
      w2min     =  2.00**2  ! Cut on W
      m_atom    =  2.0
      bcurrent  =  0.115    ! 0.085    ! microAmps
      tgt_len   =  3.0*1.0  ! cm
      ! ND3 specs
      rho_nd3   =  1.007 !0.917    ! g/cm3

      dil_nd3   =  6.0/20.0 !
      pack_nd3  =  0.80 !0.55     ! packing fraction
      Pz_nd3    =  0.42 !0.35     ! vector polarization
      M_nd3     =  20.0     ! g/mole
      ! LiD specs
      rho_lid   =  0.82     ! g/cm3
      dil_lid   =  0.50     !
      pack_lid  =  0.55     ! 
      Pz_lid    =  0.30     !0.50     ! 64% vector polarization, Bueltman NIM A425 
      M_lid     =  9.0      ! g/mole

      ND        =  0.05     ! D-wave component
      Pzz_in    =  0.25     ! expected improvement on the target

      fsyst_xs  =  0.13     ! add a 5% from F1


c----- MAIN ------------------------------------------------

c-- Setup target parameters
      if (targ.eq.'ND3') then
         rho   = 3.0 * Navo * (rho_nd3 / M_nd3) * pack_nd3 * tgt_len   ! number density in nuclei.cm^-2 
                                                                       ! = the number of ammonia molecules 
                                                                       ! per unit area times 3 deuterons per molecule
         Pz    = Pz_nd3
         f_dil = dil_nd3
         write(6,*)'using ND3'

      elseif (targ.eq.'LiD') then
         rho   = 3.0 * Navo * (rho_lid / M_lid) * pack_lid * tgt_len   ! number density in nuclei.cm^-2
         Pz    = Pz_lid
         f_dil = dil_lid
         write(6,*)'using LiD'
      endif

c      Pzz   = Pzz_fact *(2. - sqrt(4. - 3.*Pz**2))    ! tensor polarization
      Pzz = Pzz_in

c-- Calculate the luminosity
      Nelec = bcurrent*1e-6/e_ch
      lumi  = Nelec * rho                ! luminosity in cm^-2

c      write(10,*)'#    q2     x       w    rate(kHz)     Azz  
c     &      DAzz    time '

      do ispectro = 1,2

         tot_time(ispectro)    = 0.0
         ! for physics extraction
        if (ispectro.eq.1.and.type.eq.1) then ! HMS
            dp_p    =  0.08   ! 8% momentum bite for the HMS
            dp_m    =  0.08   ! 8% momentum bite for the HMS
            dtheta  =  0.028  ! theta acceptance of the HMS
            dphi    =  0.058  ! phi acceptance of the HMS
            acc     =  2.*dtheta*2.*dphi
            hms_min =  10.5   ! minimum angle of the HMS
            nx      =  nx1 
         elseif (ispectro.eq.2.and.type.eq.1) then ! SHMS
            dp_p    =  0.20   ! 20% momentum bite for the SHMS
            dp_m    =  0.08   ! 8% momentum bite for the SHMS
            dtheta  =  0.022  ! theta acceptance of the SHMS
            dphi    =  0.050  ! phi acceptance of the SHMS
            acc     =  2.*dtheta*2.*dphi
            hms_min =  5.5    ! minimum angle of the SHMS
            nx      =  nx2 
         elseif (ispectro.eq.3.and.type.eq.1) then ! HRS
            dp_p    =  0.03   ! 20% momentum bite for the HRS
            dp_m    =  0.03   ! 8% momentum bite for the HRS
            dtheta  =  0.040  ! theta acceptance of the HRS
            dphi    =  0.020  ! phi acceptance of the HRS
            acc     =  2.*dtheta*2.*dphi
            hms_min =  12.5    ! minimum angle of the HRS
            nx      =  nx3 
         elseif (ispectro.eq.4.and.type.eq.1) then ! SOLID
            dp_p    =  0.08  
            dp_m    =  0.08  
            dtheta  =  0.028  ! theta acceptance of the SoLID
            dphi    =  0.058  ! phi acceptance of the SoLID
            acc     =  1.43   ! large acceptance: 1.43 sr
            hms_min =  12.5   ! minimum angle of the SoLID
            nx      =  nx4 
         elseif (ispectro.eq.5.and.type.eq.1) then ! BB
            dp_p    =  0.40  
            dp_m    =  0.40  
            dtheta  =  0.067    ! theta acceptance of the BB
            dphi    =  0.240    ! phi acceptance of the BB
            acc     =  0.064    ! large acceptance: 0.96 sr
            hms_min =  12.5     ! minimum angle of the BB
            nx      =  nx5
         elseif (ispectro.eq.6.and.type.eq.1) then ! SBS
            dp_p    =  0.40  
            dp_m    =  0.40  
            dtheta  =  0.080   ! theta acceptance of the SBS
            dphi    =  0.210   ! phi acceptance of the SBS
            acc     =  0.076   ! large acceptance: 0.076 sr
            hms_min =  15.0    ! minimum angle of the SBS
            nx      =  nx6
         endif

         ix=0
         do ix = 1,nx ! number of x
            ib = 0
            ratetot = 0.0
            do ib=1,11
               totrate(ib)  = 0.0
               sigsum(ib)   = 0.0
               ixsum(ib)    = 0.0
            enddo
            if (ispectro.eq.1) then
               xx       = xval1(ix)
               qq       = qqval1(ix)
               prec     = prec1(ix)
            elseif (ispectro.eq.2) then
               xx       = xval2(ix)
               qq       = qqval2(ix)
               prec     = prec2(ix)
            elseif (ispectro.eq.3) then
               xx       = xval3(ix)
               qq       = qqval3(ix)
               prec     = prec3(ix)
            elseif (ispectro.eq.4) then
               xx       = xval4(ix)
               qq       = qqval4(ix)
               prec     = prec4(ix)
            elseif (ispectro.eq.5) then
               xx       = xval5(ix)
               qq       = qqval5(ix)
               prec     = prec5(ix)
            elseif (ispectro.eq.6) then
               xx       = xval6(ix)
               qq       = qqval6(ix)
               prec     = prec6(ix)
            endif

 10         w     = sqrt(mp**2+qq/xx-qq)
            nu    = qq/2./mp/xx
            y_in  = nu/e_in
            ep_in = e_in - nu
            s2    = qq/4.0/e_in/ep_in
            thrad = 2.*asin(sqrt(s2))
            th_in = thrad/d_r
       
            ! Binning over the momentum bite
            dep    = 0.02*ep_in
            epmin  = ep_in*(1.-dp_m)
            epmax  = ep_in*(1.+dp_p)
            npbin  = int((epmax-epmin)/dep)+1

            ! binning over the angular spread
            ntbin  = 19
            thincr = dtheta*2.0/float(ntbin)/d_r
            thmin  = th_in - float(ntbin/2-1/2)*thincr

            ! banner for output files
            write(9,*)'# th     pit     q2      x      sig_u     rate_u'
            write(9,*)'#                            (b/GeV.sr)    (Hz)'
            write(6,*)'coucou0',xx,nu,ep_in,s2,th_in,y_in,thrad,thincr
 
            ip = 0
            do ip = 1,npbin
               pit = epmin+(ip-1)*dep

               sigradsum = 0.0
               it = 0 
               isum = 0
               if (central) then
                  ntbin = 1
               endif    
               do it=1,ntbin
                  if (central) then
                     thit = th_in
                  else
                     thit = thmin+(it-1)*thincr
 	          endif
                  ! Cross section results to log file.
	          thrad = thit*d_r
	          snsq  = sin(thrad/2.)**2.
                  cssq  = cos(thrad/2.)**2.
                  tnsq  = tan(thrad/2.)**2.
 	          nu    = e_in - pit
	          q2    = 4.*e_in*pit*snsq
	          x     = q2/(2.*mp*nu)
                  w2    = mp**2 + q2/x - q2
                  mott  = hbarc2*(alpha*cos(thrad/2.)/2./e_in/snsq)**2.   ! in barn
c                 write(6,*)'before calling: ',x,q2,nu,thit,pit
                  if (x.lt.1.0.and.w2.gt.w2min) then ! DIS 
c                  if (x.lt.1.0.and.w2.gt.w2pion.and.w2.lt.w2min) then ! resonance
                     call get_b1d(x,q2,Aout,F1out,b1out)
                  endif
c                 write(6,*)'after calling: ',x,q2,Aout,F1out,b1out
                  sigma_unpol  = (2./mp)*mott*(tnsq + q2/2./nu**2)*F1out
                  apass = 2
                  zpass = 1
                  m_nuc = m_atom*m_amu-float(zpass)*m_e

                  sigma_tensor = sigma_unpol*0.5*Pzz*Aout
                  sigma_born   = sigma_unpol + sigma_tensor
               
                  ! Radiative correction need to be implemented here
                  sigma_meas   = sigma_born
                  !
                  if (type.eq.1) then ! physics rates
                     if (x.lt.1.0.and.w2.gt.w2min.and.sigma_unpol.gt.0.0) then ! DIS
c                     if (x.lt.1.0.and.w2.gt.w2pion.and.w2.lt.w2min.and.sigma_unpol.gt.0.0) then ! resonance
                        sigradsum  = sigradsum + sigma_unpol
                        isum       = isum + 1
                     endif
                  elseif (type.eq.2) then
                     sigradsum  = sigradsum + sigma_unpol
                     isum       = isum + 1
                  endif
                  write(8,1002)ispectro, ix, thit, q2, x, sqrt(w2), 
     &              sigma_unpol, Aout,sigma_tensor,sigma_born
	       enddo ! loop over theta bins
c               write(8,*)ispectro,x,th_in,pit,sigradsum,isum
               sigradave = 0.0
               if (isum.gt.0) then
                  sigradave = sigradsum/isum
                  rate   = lumi*sigradave*dep*acc*1E-24  ! in seconds
                  q2p    = 4.0*e_in*pit*(sin(0.5*th_in*d_r))**2
                  xp     = q2p/(2.0*mp*(e_in-pit))
                  do ib=1,11
                     if (xp.ge.xmin(ib).and.xp.lt.xmax(ib)) then
                        totrate(ib)  = totrate(ib) + rate
                        sigsum(ib)   = sigsum(ib) + sigradave
                        ixsum (ib)   = ixsum(ib) + 1
                        write(66,*)'check', ib,totrate(ib),ixsum(ib)
                     endif
                  enddo
                  write(9,1003)th_in, pit, q2p, xp,sigradave, rate
                  sigmasump = sigmasump + sigradave
               endif
	    enddo  ! loop over p bins
            sigcenter = sigmasump/npbin
            write(66,*)'sigcenter = ',sigcenter

            ! calculate the time assuming the settings spread
            call get_b1d(xx,qq,Aout,F1out,b1out)
            Azz  = Aout
            b1d  = b1out
            b1d_scaled = b1out/scale
            do ib=1,11
               ratetot   = ratetot + totrate(ib)  ! in Hz
            enddo

            dAzz  = prec*abs(Azz)
            time  = (4.0/f_dil/ND/Pzz/dAzz)**2/ratetot/3600.0/24.0
            WRITE(68,*)ispectro,xx,qq,w,ep_in,th_in,f_dil,ND,Pzz,ratetot,dAzz,time
            db1d  = abs(-1.5*Azz*prec)*F1out
            syst_Azz  = 1.0   ! to be fixed
            syst_b1d  = 1.0   ! to be fixed

            write(6,*)ispectro,xx,qq,w,
     &                    ep_in,th_in,
     &                    ratetot, 
     &                    Azz,dAzz,
     &                    b1d,db1d,
     &                    time/3600./24.,
     &                    syst_Azz,syst_b1d
  
            write(11,1005)ispectro,xx,qq,w,
     &                    ep_in,th_in,
     &                    ratetot, 
     &                    Azz,dAzz,
     &                    b1d,db1d,
     &                    time/3600./24.,
     &                    syst_Azz,syst_b1d


            ! get projected results for each x-bin
            do ib=1,11
               xcent = (xmin(ib)+xmax(ib))/2
               call get_b1d(xcent,qq,Aout,F1out,b1out)    
               dAzz      = (4.0/f_dil/ND/Pzz)/sqrt(totrate(ib)*time)
               Azz       = Aout
               b1d       = -1.5*Azz*F1out
               db1d      = -1.5*abs(Azz*prec_bin)*F1out
               syst_Azz  = abs(Azz)*fsyst_A
               syst_b1d  = abs(b1d)*fsyst_b1
               if (totrate(ib).gt.0.0) then
                  write(10,1004)ispectro,qq,xcent,w,totrate(ib)/1000, Azz, 
     &                    dAzz, time/3600,b1d,db1d,
     &                    th_in,ep_in,(sigsum(ib)/ixsum(ib)), 
     &                    F1out, syst_Azz,syst_b1d
               endif
            enddo

            write(6,*)'--------------------------'
            write(6,*)'For ',targ
            write(6,*)'lumi= ',lumi
            write(6,*)'rho= ',rho
            write(6,*)'Pzz= ',pzz
            tot_time(ispectro)    = tot_time(ispectro) + time/3600
c           endif
         enddo  ! loop over x-value

         if (ispectro.eq.1) then
            write(66,*)'HMS running time = ',tot_time(1),' hours (',
     &                                   tot_time(1)/24.0,' days)'
         elseif (ispectro.eq.2) then
            write(66,*)'SHMS running time = ',tot_time(2),' hours (',
     &                                    tot_time(2)/24.0,' days)'
         elseif (ispectro.eq.3) then
            write(66,*)'HRS running time = ',tot_time(3),' hours (',
     &                                   tot_time(3)/24.0,' days)'
         elseif (ispectro.eq.4) then
            write(66,*)'SOLID running time = ',tot_time(4),' hours (',
     &                                     tot_time(4)/24.0,' days)'
         elseif (ispectro.eq.5) then
            write(66,*)'BigBite running time = ',tot_time(5),' hours (',
     &                                       tot_time(5)/24.0,' days)'
         elseif (ispectro.eq.6) then
            write(66,*)'SuperBigBite running time = ',tot_time(6),
     &                                       ' hours (',
     &                                       tot_time(6)/24.0,' days)'
         endif
      enddo  ! loop over the spectro

 1020 continue
      stop
C =========================== Format Statements ================================

 1001 format(a)
 1002 format(2(i2,1x),f7.3,1x,f6.1,1x,2f7.3,4(1x,E10.3))
 1003 format(2f7.3,1x,f6.1,1x,f7.3,2(1x,E10.3))
 1004 format(i1,1x,f6.1,1x,f7.3,1x,f7.3,3(1x,E10.3),1x,f7.1,2(1x,E10.3),2(1x,f7.3),4(1x,E10.3))
 1005 format(i1,f7.2,1x,f6.1,1x,f7.2,1x,f7.2,1x,f7.2,1x,f7.3,4(1x,E10.2),1x,f10.2,2(1x,E10.2))
      end
