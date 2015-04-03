      PROGRAM RATES
c vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c
c     ptrates.f
c
c     This program is designed to calculate X(e,e') rates and is optimized for Hall C
c     during the 12 GeV era. It started as code written by Patricia Solvignon (circa 
c     2010), and has since been modified to include Peter Bosted's fits for the low x 
c     region, and Misak Sargsian's light-cone calculations for the high x region.
c
c     It is compiled by:
c          gfortran -ffixed-line-length-none -o ptrates ptrates.f F1F209.f sub_b1d.f sub_qe_b1d.f get_qe_b1.f inclusive.f
c 
c     It has been successfully tested with GNU Fortran 4.6.3 on Ubuntu 12.04
c
c     Elena Long
c     ellie@jlab.org
c     4/4/2013 - 4/21/2014
c
c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      integer :: clck_counts_beg, clck_counts_end, clck_rate
      integer :: clck_counts_beg2, clck_counts_end2, clck_rate2
      REAL*8 pi,alpha,mp,e_ch,picobarn,nanobarn,Navo
      REAL*8 mass_D,mass_N,mass_He,md
      PARAMETER( hbarc2   = 0.389379E-3) ! barn.GeV^2
      PARAMETER( pi       = 3.14159265 )
      PARAMETER( mp       = 0.938272   ) ! GeV/c^2
      PARAMETER( md       = 1.876      ) ! GeV/c^2
      PARAMETER( mass_D   = 1.876      ) ! GeV/c^2
      PARAMETER( mass_N   = 14.0067    ) ! GeV/c^2
      PARAMETER( mass_He  = 3.7284     ) ! GeV/c^2
      PARAMETER( e_ch     = 1.602E-19  ) ! C
      PARAMETER( picobarn = 1E12       )
      PARAMETER( nanobarn = 1E9        )
      PARAMETER( Navo     = 6.022E23   ) ! mol-1

      INTEGER kin_in
      INTEGER npbin,ntbin
      INTEGER ip,it
      REAL*8 z_d,z_he,z_n,z_c,z_li
      REAL*8 a_d,a_he,a_n,a_c,a_li
      REAL*8 e_in,ep_in,th_in,y_in,Pzz_in,superth_in
      REAL*8 th_in1,ep_in1,th_in2,ep_in2
      REAL*8 A,d_r
      REAL*8 dp_p,dp_m,dtheta,dphi,acc,hms_min,theta_res
      REAL*8 deg,thrad,thincr,thmin,thmax
      REAL*8 dep,epmin,epmax
      REAL*8 s2,t2,xx,qq,w,tempqq,wnn,cent_wnn
      REAL*8 rc,rche,rcn,rcc,rcli

      REAL*8 ND
      REAL*8 rho_nd3,M_nd3,dil_nd3,pack_nd3,Pz_nd3
      REAL*8 rho_lid,M_lid,dil_lid,pack_lid,Pz_lid
      REAL*8 f_dil,Pzz_fact
      REAL*8 rho,Nelec,lumi,lumi_d
      REAL*8 rho_li,m_li,lumi_li
      REAL*8 rho_he,m_he,lumi_he,lumi_heli
      REAL*8 rho_n,m_n,lumi_n
      REAL*8 rho_c,m_c,lumi_c
      REAL*8 src_ratio_c,src_ratio_n,src_ratio_he

      REAL*8 deltae
      REAL*8 w2min,w2max,w2pion,K_fact,w2nn,cent_w2nn

      REAL*8 tb,ta,teff
      REAL*8 aux(7)

      REAL*8 pit,thit
      REAL*8 snsq,cssq,tnsq,nu,q2,w2,x,cstheta,cent_nu
      REAL*8 w2end

      REAL*8 bcurrent,tgt_thick,tgt_len

      REAL*8 mott_d,mott_he,mott_n,mott_p,mott_c,mott_li
      REAL*8 Pzz,Aout,F1out,b1out,F2out,F1in,F1qe
      REAL*8 F1d,F2d,F1he,F2he,F1n,F2n,F1c,F2c,F1li,F2li
      REAL*8 F1d_ie,F2d_ie,F1he_ie,F2he_ie,F1n_ie,F2n_ie,F1c_ie,F2c_ie
      REAL*8 F1li_ie,F2li_ie
      REAL*8 F1d_qe,F2d_qe,F1he_qe,F2he_qe,F1n_qe,F2n_qe,F1c_qe,F2c_qe
      REAL*8 F1li_qe,F2li_qe
      REAL*8 allF1out,allF2out,allF1in,allF1qe
      REAL*8 allF1d,allF2d,allF1he,allF2he,allF1n,allF2n,allF1li,allF2li
      REAL*8 F1dend,F2dend
      REAL*8 sigma_unpol,sigma_tensor,sigma_born
      REAL*8 sigma_unpol_d,sigma_unpol_he,sigma_unpol_n,sigma_unpol_c
      REAL*8 lumsig_u_d,lumsig_he,lumsig_n,lumsig_c,lumsig_li
      REAL*8 lumsig_p_d,lumsig_heli
      REAL*8 sigma_pol_d,sigma_unpol_li,allsigma_unpol_li
      REAL*8 allsigma_unpol_d,allsigma_unpol_he,allsigma_unpol_n
      REAL*8 allsigma_pol_d,tot_allsigma
      REAL*8 sigma_unpol_xem
      REAL*8 sigma_meas
      REAL*4 dis_raw,qe_raw,mod_raw
      REAL*8 ZforF1,AforF1

      ! output rates
      REAL*8  xp,q2p
      REAL*8  sigradsum,sigradave,sigma_unpol_e
      REAL*8  he_sigradsum,he_sigradave
      REAL*8  n_sigradsum,n_sigradave
      REAL*8  d_sigradsum,d_sigradave
      REAL*8  li_sigradsum,li_sigradave
      REAL*8  allsigradsum,allsigradave
      REAL*8  li_allsigradsum,li_allsigradave
      REAL*8  he_allsigradsum,he_allsigradave
      REAL*8  n_allsigradsum,n_allsigradave
      REAL*8  d_allsigradsum,d_allsigradave
      REAL*8  d_unpol_sigradsum,d_unpol_sigradave
      REAL*8  sigma,sigmasum,sigcenter,sigmasump
      REAL*8  rate
      REAL*8  lumiSig, goodRateTotal, physRateTotal
      REAL*8  goodRate_d, goodRate_n, goodRate_he, goodRate_li

      INTEGER, PARAMETER :: binMax = 14
      INTEGER ixsum(binMax),ib
      INTEGER allixsum(binMax)
      REAL*8  sigpara,sigperp,e_fact,scale,b1d_scaled,scale_time
      REAL*8  Azz,dAzz,time,pac_time,dAzz_rel
      REAL*8  b1d,db1d
      REAL*8  e_b1_abs

      REAL*8  xcent,prec_bin

      REAL*8  tot_time(100)
      REAL*8  fsyst_xs
      REAL*8  syst_Azz, syst_b1d
      REAL*8  xplat,fplat
      REAL*4  dummy

      REAL*8 m_nuc,m_amu,m_e
      INTEGER apass,zpass
      INTEGER ix,ispectro,isum,type
      INTEGER allisum
      CHARACTER targ*8
      CHARACTER csmodel*11

      LOGICAL central
      INTEGER method

      INTEGER nx,nx1,nx2,nx3,nx4,nx5,nx6
      REAL*8 prec

      PARAMETER (nx1  = 5)
      REAL*8 xval1(nx1),qqval1(nx1),prec1(nx1)

      PARAMETER (nx2  = 5)
      REAL*8 xval2(nx2),qqval2(nx2),prec2(nx2)

      PARAMETER (nx3  = 5)
      REAL*8 xval3(nx3),qqval3(nx3),prec3(nx3)

      PARAMETER (nx4  = 5)
      REAL*8 xval4(nx4),qqval4(nx4),prec4(nx4)

      PARAMETER (nx5  = 5)
      REAL*8 xval5(nx5),qqval5(nx5),prec5(nx5)

      PARAMETER (nx6  = 5)
      REAL*8 xval6(nx6),qqval6(nx6),prec6(nx6)

      REAL*8 good_x_min,good_x_max
      REAL*8 xmin(5),xmax(5)
      REAL*8 cent_x(binMax),cent_x_min(binMax),cent_x_max(binMax)
      REAL*8 N_for_x(binMax),Ngood_for_x(binMax),Ntotal_for_x(binMax)
      REAL*8 Nunpol_for_x(binMax),Nunpolgood_for_x(binMax),Nunpoltotal_for_x(binMax)
      REAL*8 thisNforx(binMax),xsum(binMax)
      REAL*8 thisNunpolforx(binMax)
      REAL*8 w_ave(binMax),sigma_sum(binMax)
      REAL*8 total_w_ave(binMax),N_sum(binMax)
      REAL*8 dAzz_drift(binMax)
      REAL*8 drift_scale
      REAL*8 ave_x,spec_x
      REAL*8 totsig_for_ave_x
    
      REAL*8 E0_PASS,TH_PASS,EP_PASS
      REAL*8 rr1,rr2,phistar,thstar
      REAL*8 thq,thq_r,cosqvec
      REAL*8 xdx
      REAL*8 P(0:23)
      REAL*8 sigrsv(7),sig_nr,sigmec

      INTEGER test

      COMMON /VPLRZ/ E0_PASS,TH_PASS,EP_PASS

c      COMMON /PARCORR/ P
c      common/tst2/sigrsv,sig_nr,sig_mec

c !$OMP THREADPRIVATE(/PARCORR/)
c !$OMP THREADPRIVATE(/tst2/)


      call system_clock ( clck_counts_beg, clck_rate ) 

      test = 0   ! Test Mode OFF
c      test = 1   ! Test Mode ON



c vvvv binMax = 11 vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c For Azz, our target range is 0.8 < x < 2.2
c      DATA cent_x/     0.8,  0.9, 1.01,  1.1,  1.2,  1.3,  1.4,  1.5,  1.6,  1.7,  1.8,  3.0,  4.0,  4.1/ 
c      DATA cent_x_min/ 0.75, 0.85,0.95, 1.05, 1.15, 1.25, 1.35, 1.45, 1.55, 1.65, 1.75, 2.85, 3.95, 4.05/ 
c      DATA cent_x_max/ 0.85, 0.95,1.05, 1.15, 1.25, 1.35, 1.45, 1.55, 1.65, 1.75, 1.85, 3.15, 4.05, 4.15/ 
c      DATA cent_x/     0.8,  0.9, 1.01,  1.1,  1.2,  1.3, 1.45, 1.65, 1.8,  2.0,  3.8,  3.0,  4.0,  4.1/ 
c      DATA cent_x_min/ 0.75, 0.85,0.95, 1.05, 1.15, 1.25, 1.35, 1.55, 1.75, 1.85, 3.75, 2.85, 3.95, 4.05/ 
c      DATA cent_x_max/ 0.85, 0.95,1.05, 1.15, 1.25, 1.35, 1.55, 1.75, 1.85, 2.15, 3.85, 3.15, 4.05, 4.15/ 
      DATA cent_x/     0.8, 0.9,  1.01,  1.1,   1.2,   1.35,  1.55, 1.75, 2.0,  3.0,   3.8, 3.0, 4.0, 4.0/
      DATA cent_x_min/ 0.75, 0.85, 0.955,1.055, 1.15,  1.275, 1.45, 1.65, 1.85, 1.925, 2.9, 3.4, 3.5, 4.0/
      DATA cent_x_max/ 0.85, 0.955,1.055,1.15,  1.275, 1.45,  1.65, 1.85, 2.15, 2.825, 3.4, 3.5, 4.0, 4.0/

c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

c vvvv binMax = 11 vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c For Azz, our target range is 0.8 < x < 1.8
c      DATA cent_x/      0.8,  0.9,  1.01,  1.1,  1.2,  1.3,  1.4,  1.5,  1.6,  1.7,  1.8/ 
c      DATA cent_x_min/  0.75, 0.85, 0.95, 1.05, 1.15, 1.25, 1.35, 1.45, 1.55, 1.65, 1.75/ 
c      DATA cent_x_max/  0.85, 0.95, 1.05, 1.15, 1.25, 1.35, 1.45, 1.55, 1.65, 1.75, 1.85/ 

c      DATA cent_x/      0.8,  0.9,  1.0,  1.1,  1.2,  1.3,  1.4,  1.55, 1.75,  3.0, 3.0/ 
c      DATA cent_x_min/  0.75, 0.85, 0.95, 1.05, 1.15, 1.25, 1.35, 1.45, 1.65, 2.95, 2.95/ 
c      DATA cent_x_max/  0.85, 0.95, 1.05, 1.15, 1.25, 1.35, 1.45, 1.65, 1.85, 3.05, 3.05/ 


c For b1, our target range is 0.09 < x < 0.58
c      DATA cent_x/      0.16, 0.275, 0.36, 0.49, 0.64,  0.7,  0.8,  0.9,  1.0,  1.1,  1.2/ 
c      DATA cent_x_min/  0.09, 0.23,  0.32, 0.40, 0.58, 0.65, 0.75, 0.85, 0.95, 1.05, 1.15/ 
c      DATA cent_x_max/  0.23, 0.32,  0.40, 0.58, 0.70, 0.75, 0.85, 0.95, 1.05, 1.15, 1.25/ 

c      DATA cent_x/      0.16, 0.29, 0.40, 0.515, 0.64,  0.8,  0.9,  1.0,  1.1,  1.2, 1.3/ 
c      DATA cent_x_min/  0.09, 0.23, 0.35, 0.45,  0.58, 0.75, 0.85, 0.95, 1.05, 1.15, 1.25/ 
c      DATA cent_x_max/  0.23, 0.35, 0.45, 0.58,  0.70, 0.85, 0.95, 1.05, 1.15, 1.25, 1.35/ 
c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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
      scale     = 5.0            ! scale b1 kumano model
      type      = 1              ! 1=physics rates, 2=total rates
      targ      = 'ND3'          ! ND3 target
c      targ      = 'LiD'          ! LiD
c      targ      = 'LiD_He2D'     ! LiD target as 4He + 2D
      csmodel   = 'Bosted_full'  ! Set the code used to calculate the cross sections
c      csmodel   = 'Bosted_dis'   ! Set the code used to calculate the cross sections
c      csmodel   = 'Bosted_qe'    ! Set the code used to calculate the cross sections
c      csmodel   = 'Sargsian'     ! Set the code used to calculate the cross sections
c !!!!!!!!!! NOTE: IF YOU USE LiD, YOU NEED TO CHANGE THE LUMINOSITY !!!!!!!!!!!!!!!!!!!!!!
c      e_in      =  11.0     ! GeV (Inrease/Decrease in 2.2 GeV increments)
c      e_in      =  8.8     ! GeV (Inrease/Decrease in 2.2 GeV increments)
c      e_in      =  6.6     ! GeV (Inrease/Decrease in 2.2 GeV increments)
c      e_in      =  4.4     ! GeV (Inrease/Decrease in 2.2 GeV increments)
      e_in      =  2.2     ! GeV (Inrease/Decrease in 2.2 GeV increments)
c      e_in      = 11.671
      w2pion    =  1.18**2  ! pion threshold
c      w2min     =  1.8**2  ! Cut on W
c      w2min     =  1.50**2  ! Cut on W
      w2min     =  0.0  ! Cut on W
c      w2max     =  1.85**2  ! Cut on W
      w2max     =  30**2  ! Cut on W
c      w2max     =  0.8**2  ! Cut on W
      m_atom    =  2.0
c      bcurrent  =  0.100    ! 0.085    ! microAmps
      bcurrent  =  0.090    ! 0.085    ! microAmps
      tgt_len   =  3.0*1.0  ! cm
c      tgt_len   =  6.0*1.0  ! cm
      ! ND3 specs
      rho_nd3   =  1.007 ! g/cm3

      dil_nd3   =  6.0/20.0 !
c      pack_nd3  =  0.80 !0.55     ! packing fraction
      pack_nd3  =  0.65 !0.55     ! packing fraction
      Pz_nd3    =  0.42 !0.35     ! vector polarization
      M_nd3     =  20.0     ! g/mole
      ! LiD specs
      rho_lid   =  0.82     ! g/cm3
      dil_lid   =  0.50     !
      pack_lid  =  0.65 !0.55     ! packing fraction
      Pz_lid    =  0.50 !0.30     !0.50     ! 64% vector polarization, Bueltman NIM A425 
      M_lid     =  9.0      ! g/mole

      ND        =  1.0     ! D-wave component
      Pzz_in    =  0.30    ! expected improvement on the target
c      Pzz_in    =  0.25    ! expected improvement on the target
c      Pzz_in    =  0.20    ! expected improvement on the target
c      Pzz_in    =  0.15    ! expected improvement on the target

c      fsyst_xs  =  0.13     ! add a 5% from F1
      fsyst_xs  =  0.05     ! add a 5% from F1

c      dAzz_rel  =  0.12     ! Relative Systematic Contribution to Azz
c      dAzz_rel  =  0.06     ! Relative Systematic Contribution to Azz
      dAzz_rel  =  0.092     ! Relative Systematic Contribution to Azz

      ! General Parameters
      rho_he = 0.1412 ! 0.1412 g/cm^3
      m_he = 4.0026
      z_d = 1; z_he = 2; z_n = 7;  z_c = 6;  z_li = 3;
      a_d = 2; a_he = 4; a_n = 14; a_c = 12; a_li = 6;



c vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c This section creates the x and Q^2 values to be used
c for each of the data points to be run
      ! HMS
c vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c      if (e_in.ne.2.2) then
         DATA prec1/    300.0,  168.0,  336.0,  720.0,  360.0/
         DATA xval1/    100, 100, 100, 100, 100/
         DATA qqval1/    99, 99, 99, 99, 99/   
c      endif

      ! vvvvv Proposal b1 vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c      DATA prec1/    168.0,  168.0,  336.0,  720.0,  360.0/
c      DATA xval1/    100.0, 100.0, 100.0, 100.0, 0.55/
c      DATA qqval1/   99, 99, 99, 99, 3.82/   
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv x=0.4 Optimized b1 vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c      DATA prec1/    168.0, 168.0, 336.0, 720.0, 360.0/
c      DATA xval1/    100.0, 100.0, 100.0, 100.0, 0.41/
c      DATA qqval1/   99,    99,    99,    99,    3.33/   
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Proposal Azz at E0!=2.2 GeV vvvvvvvvvvvvvvvvvvvvvvvv
c      DATA prec1/    3.0,  168, 336, 720, 360/
c      DATA xval1/    100,  100, 100, 100, 100/
c      DATA qqval1/   99,   99,  99,  99,  99/   
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Proposal Azz at E0= 8.8 GeV vvvvvvvvvvvvvvvvvvvvvvvv
c      if (e_in.eq.8.8) then
c         DATA prec1/    300, 216, 360, 168, 168/
c         DATA xval1/    1.4, 100, 100, 100, 100/
c         DATA qqval1/   1.5, 99,  99,  99,  99/   
c      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Proposal Azz at E0= 6.6 GeV vvvvvvvvvvvvvvvvvvvvvvvv
      if (e_in.eq.6.6) then
c         prec1(1)  = 96
c         xval1(1)  = 1.5
c         qqval1(1) = 1.8
      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Proposal Azz at E0= 4.4 GeV vvvvvvvvvvvvvvvvvvvvvvvv
      if (e_in.eq.4.4) then
c         prec1(1)  = 96
c         xval1(1)  = 1.5
c         qqval1(1) = 1.8
      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


      ! vvvvv Proposal Azz at E0= 2.2 GeV vvvvvvvvvvvvvvvvvvvvvvvv
c      DATA prec1/    3.0,  168, 336, 720, 360/
c      DATA xval1/    1.3,  100, 100, 100, 100/
c      DATA qqval1/   0.37, 99,  99,  99,  99/   
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
      ! vvvvv Proposal Azz at E0= 8.8 GeV vvvvvvvvvvvvvvvvvvvvvvvv
      if (e_in.eq.8.8) then
c         prec1(1) = 300
c         xval1(1) = 1.6
c         qqval1(1) = 4.51
      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


      ! vvvvv Proposal Azz at E0= 2.2 GeV vvvvvvvvvvvvvvvvvvvvvvvv
      if (e_in.eq.2.2) then
        prec1(1)  = 12
        xval1(1)  = 1.8
        qqval1(1) = 0.31 
      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



c ^^^^^ ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! SHMS
c vvvvv vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv

      ! vvvvv Initialize all values to not record any rates vvvvvv
       DATA prec2/    168.0,  168.0,  336.0,  720.0,  360.0/
       DATA xval2/    100, 100, 100, 100, 100/
       DATA qqval2/    99, 99, 99, 99, 99/   
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


c      DATA prec2/    144.0,  216.0,  360.0,  168.0,  168.0/
c      DATA xval2/    100, 100, 100, 100, 100/
c      DATA qqval2/    99, 99, 99, 99, 99/   

      ! vvvvv Proposal b1 vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c      DATA prec2/    72.0, 108.0, 180.0, 168.0, 168.0/
c      DATA xval2/    0.15, 0.3,   0.452, 100.0, 100.0/
c      DATA qqval2/   1.21, 2.0,   2.58,  99,    99/   
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv x=0.4 Optimized b1 vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c      DATA prec2/    360.0, 168.0, 168.0, 168.0, 168.0/
c      DATA xval2/    0.29,  100.0, 100.0, 100.0, 100.0/
c      DATA qqval2/   1.8,   99,    99,    99,    99/   
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Proposal Azz at E0= 11.0 GeV vvvvvvvvvvvvvvvvvvvvvvvv
      if (e_in.eq.11.0) then
         prec2(1) = 300
         xval2(1) = 0.953
         qqval2(1) = 1.788
      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Proposal Azz at E0= 8.8 GeV vvvvvvvvvvvvvvvvvvvvvvvv
      if (e_in.eq.8.8) then
         prec2(1) = 300
         xval2(1) = 1.8
c         xval2(1) = 0.5
         qqval2(1) = 1.5
      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Proposal Azz at E0= 6.6 GeV vvvvvvvvvvvvvvvvvvvvvvvv
      if (e_in.eq.6.6) then
c         prec2(1) = 96
c         xval2(1) = 3.7
c         qqval2(1) = 0.71
      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Proposal Azz at E0= 2.2 GeV vvvvvvvvvvvvvvvvvvvvvvvv
      if (e_in.eq.2.2) then
         prec2(1) = 12
         xval2(1) = 1.8
         qqval2(1) = 0.18
      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Potential Azz at E0=11.0 GeV vvvvvvvvvvvvvvvvvvvvvvv
c      if (e_in.eq.11.0) then
c         DATA prec2/    168, 216, 360, 168, 168/
c         DATA xval2/    1.3, 100, 100, 100, 100/
c         DATA qqval2/   2.0, 99,  99,  99,  99/   
c      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Potential Azz at E0= 4.4 GeV vvvvvvvvvvvvvvvvvvvvvvv
      if (e_in.eq.4.4) then
         prec2(1) = 24
         xval2(1) = 1.5
         qqval2(1) = 0.48
      endif
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      ! vvvvv Matching HERMES Results vvv vvvvvvvvvvvvvvvvvvvvvvvv
c      DATA xval2/    0.1, 0.3, 0.452, 0.128, 0.248/
c      DATA qqval2/   1.01, 1.5, 4.69, 2.33, 3.11/   
c      DATA prec2/    168.0,  168.0,  117.4,  982.2,  59.65/
      ! ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


c ^^^^^ ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      ! HRSs
c      DATA xval3/    0.1, 0.3, 0.5, 0.75, 1.00/
      DATA xval3/    100, 100, 100, 100, 100/
      DATA qqval3/   0.70, 1.4, 3.2, 5.2, 0.90/   
      DATA prec3/    0.50,  0.50,  0.50,  0.50,  0.50/

      ! SOLID
c      DATA xval4/    0.1, 0.3, 0.5, 0.75, 1.00/
      DATA xval4/    100, 100, 100, 100, 100/
      DATA qqval4/   0.70, 1.4, 3.2, 5.2, 0.90/   
      DATA prec4/    0.50,  0.50,  0.50,  0.50,  0.50/

      ! BB
c      DATA xval5/    0.1, 0.3, 0.5, 0.75, 1.00/
      DATA xval5/    100, 100, 100, 100, 100/
      DATA qqval5/   0.70, 1.4, 3.2, 5.2, 0.90/   
      DATA prec5/    0.50,  0.50,  0.50,  0.50,  0.50/

      ! SBS
c      DATA xval6/    0.1, 0.3, 0.5, 0.75, 1.00/
      DATA xval6/    100, 100, 100, 100, 100/
      DATA qqval6/   0.70, 1.4, 3.2, 5.2, 0.90/   
      DATA prec6/    0.50,  0.50,  0.50,  0.50,  0.50/

      ! rebinning
c      DATA xmin/ 0.00,0.200,0.400,0.650,0.90/
c      DATA xmax/ 0.20,0.400,0.600,0.850,1.10/
c      DATA xmin/ 0.00,0.200,0.352,0.650,0.45/
c      DATA xmax/ 0.20,0.400,0.552,0.850,0.65/
      DATA xmin/ 0.00,0.000,0.000,0.000,0.00/
      DATA xmax/ 0.60,0.600,0.600,0.600,0.600/
c      DATA xmin/ 0.00,0.200,0.400,0.028,0.148/
c      DATA xmax/ 0.20,0.400,0.600,0.228,0.348/

c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


c---- INPUT/OUTPUT -----------------------------------------

      OPEN(UNIT= 8, FILE='output/xs.out',            STATUS='UNKNOWN')
      OPEN(UNIT= 9, FILE='output/rates_pbin.out',    STATUS='UNKNOWN')
      OPEN(UNIT=10, FILE='output/rates.out',         STATUS='UNKNOWN')
      OPEN(UNIT=11, FILE='output/prop_table.out',    STATUS='UNKNOWN')
      OPEN(UNIT=12, FILE='output/xs-take1.out',      STATUS='UNKNOWN')
      OPEN(UNIT=13, FILE='output/xs-take2.out',      STATUS='UNKNOWN')
      OPEN(UNIT=14, FILE='output/rebinned-x.out',    STATUS='UNKNOWN')
      OPEN(UNIT=15, FILE='output/pre-rebinn-x.out',  STATUS='UNKNOWN')
      OPEN(UNIT=16, FILE='output/cs-check.out',      STATUS='UNKNOWN')
      OPEN(UNIT=17, FILE='output/cs-check-shms.out', STATUS='UNKNOWN')
      OPEN(UNIT=18, FILE='output/cs-check-hms.out',  STATUS='UNKNOWN')

c----- MAIN ------------------------------------------------
      thrad=8.0*d_r
      ep_in=6.249
      qq = 4*e_in*ep_in*sin(thrad/2)*sin(thrad/2)
      x  = qq/(2*mp*(e_in-ep_in))
      write (6,*) "e_in:",e_in
      write (6,*) "ep_in:",ep_in
      write (6,*) "qq:",qq
      write (6,*) "x:",x
c      qqval2(1) = qq
c      xval2(1)  = x
c      prec2(1)  = 100
c      qqval1(1) = qq
c      xval1(1)  = x

      if (test.eq.1) then
         write(6,*) "*******************************************"
         write(6,*) "************* TEST MODE ON ****************"
         write(6,*) "*******************************************"
      endif
      write (6,*) "------------------------------------------"
      write (6,*) "Current Central Values are:"
      write (6,*) "------------------------------------------"
      write (6,*) "  HMS:             E'max=7.3  Thmin=12.2"
      write (6,*) "      x         Q2        E'       Th"
      do ib=1,5
         xx = xval1(ib)
         qq = qqval1(ib)
         w     = sqrt(mp**2+qq/xx-qq)
         nu    = qq/2./mp/xx
         w2nn  = 2*nu*md+md**2-qq
         wnn   = sqrt(w2nn)
         y_in  = nu/e_in
         ep_in = e_in - nu
         s2    = qq/4.0/e_in/ep_in
         thrad = 2.*asin(sqrt(s2))
         th_in = thrad/d_r
         if (.not.xx.eq.100) then
            write (6,1009) "",xx,qq,ep_in,th_in,w2nn,wnn
            if ((ep_in.gt.7.3).or.(th_in.lt.12.2)) STOP "BAD INPUT"
c            if ((ep_in.gt.7.3).or.(th_in.lt.12.2)) qqval1(ib)=99
c            if ((ep_in.gt.7.3).or.(th_in.lt.10.5)) STOP "BAD INPUT"
c            if ((ep_in.gt.7.3).or.(th_in.lt.10.5)) qqval1(ib)=99 
         endif
      enddo
      write (6,*) "------------------------------------------"
      write (6,*) "  SHMS:           E'max=10.4  Thmin=7.3"
      write (6,*) "      x         Q2        E'       Th       W2nn         Wnn"
c "
      do ib=1,5
         xx = xval2(ib)
         qq = qqval2(ib)
         w     = sqrt(mp**2+qq/xx-qq)
         nu    = qq/2./mp/xx
         w2nn  = 2*nu*md+md*md-qq
         wnn   = sqrt(w2nn)
         y_in  = nu/e_in
         ep_in = e_in - nu
         s2    = qq/4.0/e_in/ep_in
         thrad = 2.*asin(sqrt(s2))
         th_in = thrad/d_r
         if (.not.xx.eq.100) then
            write (6,1009) "",xx,qq,ep_in,th_in,w2nn,wnn
            if ((ep_in.gt.10.4).or.(th_in.lt.7.3)) STOP "BAD INPUT"
c            if ((ep_in.gt.10.4).or.(th_in.lt.7.3)) qqval2(ib)=99
         endif
      enddo
      write (6,*) "------------------------------------------"


      xx =  xval2(1)
      qq = qqval2(1)
      w     = sqrt(mp**2+qq/xx-qq)
      nu    = qq/2./mp/xx
      w2nn  = 2*nu*md+md**2-qq
      wnn   = sqrt(w2nn)
      y_in  = nu/e_in
      ep_in1 = e_in - nu
      s2    = qq/4.0/e_in/ep_in1
      thrad = 2.*asin(sqrt(s2))
      th_in1 = thrad/d_r

      xx =  xval1(1)
      qq = qqval1(1)
      w     = sqrt(mp**2+qq/xx-qq)
      nu    = qq/2./mp/xx
      w2nn  = 2*nu*md+md**2-qq
      wnn   = sqrt(w2nn)
      y_in  = nu/e_in
      ep_in2 = e_in - nu
      s2    = qq/4.0/e_in/ep_in2
      thrad = 2.*asin(sqrt(s2))
      th_in2 = thrad/d_r

c      write (6,*) "Please enter E0 (GeV) you wish to use for f_dil:"
c      read (*,*) e_in1
c      write (6,*) "Please enter E' (GeV) you wish to use for f_dil:"
c      read (*,*) ep_in1
c      write (6,*) "Please enter theta (deg) you wish to use for f_dil:"
c      read (*,*) th_in1
c      write(6,*) "Q^2: ", 4.0*e_in1*ep_in1*(sin(th_in1*d_r)**2)
c      write(6,*) "x: ", 4.0*e_in1*ep_in1*(sin(th_in1*d_r)**2)/(2*mp*(e_in1-ep_in1))

      call system_clock ( clck_counts_beg2, clck_rate2 ) 




c-- Setup target parameters
      Nelec = bcurrent*1e-6/e_ch                                       ! Find number of electrons
      write(6,*) "Target: ",targ
      if (targ.eq.'ND3') then
c         rho   = 3.0 * Navo * (rho_nd3 / M_nd3) * pack_nd3 * tgt_len   ! number density in nuclei.cm^-2 
                                                                       ! = the number of ammonia molecules
                                                                       ! per unit area times 3 deuterons per molecule
         Pz    = Pz_nd3
c         f_dil = dil_nd3

c-- Calculate the luminosity
c         lumi  = Nelec * rho                ! luminosity in cm^-2
         lumi_d  = (3*Navo*(rho_nd3/M_nd3)*pack_nd3)*Nelec*tgt_len      ! luminosity in 1/(s*cm^2)
         lumi_n  = (Navo*(rho_nd3/M_nd3)*pack_nd3)*Nelec*tgt_len        ! luminosity in 1/(s*cm^2)
         lumi_he = (Navo*(rho_he/m_he)*(1-pack_nd3))*Nelec*tgt_len      ! luminosity in 1/(s*cm^2)
         lumi_li = 0
         lumi_heli = 0
         lumi_c    = 0                                                  ! luminosity in 1/(s*cm^2)
         write(6,*)" Using ND3..."
      else if (targ.eq.'LiD') then
c         rho   = 3.0 * Navo * (rho_lid / M_lid) * pack_lid * tgt_len   ! number density in nuclei.cm^-2
         Pz    = Pz_lid
         lumi_d  = (Navo*(rho_lid/M_lid)*pack_lid)*Nelec*tgt_len        ! luminosity in 1/(s*cm^2)
         lumi_n  = 0                                                    ! luminosity in 1/(s*cm^2)
         lumi_he = (Navo*(rho_he/m_he)*(1-pack_lid))*Nelec*tgt_len      ! luminosity in 1/(s*cm^2)
         lumi_li = (Navo*(rho_lid/M_lid)*pack_lid)*Nelec*tgt_len        ! luminosity in 1/(s*cm^2)
         lumi_heli = 0
         lumi_c    = 0                                                  ! luminosity in 1/(s*cm^2)
         write(6,*) "Using LiD..."
      else if (targ.eq.'LiD_He2D') then
c         rho   = 3.0 * Navo * (rho_lid / M_lid) * pack_lid * tgt_len   ! number density in nuclei.cm^-2
         Pz    = Pz_lid
         lumi_d    = 2*(Navo*(rho_lid/M_lid)*pack_lid)*Nelec*tgt_len    ! luminosity in 1/(s*cm^2)
         lumi_n    = 0                                                  ! luminosity in 1/(s*cm^2)
         lumi_he   = (Navo*(rho_he/m_he)*(1-pack_lid))*Nelec*tgt_len    ! luminosity in 1/(s*cm^2)
         lumi_heli = (Navo*(rho_lid/M_lid)*pack_lid)*Nelec*tgt_len      ! luminosity in 1/(s*cm^2)
c         lumi_li = (Navo*(rho_lid/M_lid)*pack_lid)*Nelec*tgt_len        ! luminosity in 1/(s*cm^2)
         lumi_li   = 0                                                  ! luminosity in 1/(s*cm^2)
         lumi_c    = 0                                                  ! luminosity in 1/(s*cm^2)
         write(6,*) "Using (HeD)D..."
      end if

      lumi_c = 1E-20
      write(6,*) "lumi_d  = ",lumi_d,"1/(s*cm^2)"
      write(6,*) "lumi_n  = ",lumi_n,"1/(s*cm^2)"
      write(6,*) "lumi_he = ",lumi_he,"1/(s*cm^2)"
      write(6,*) "lumi_li = ",lumi_li,"1/(s*cm^2)"


c      Pzz   = Pzz_fact *(2. - sqrt(4. - 3.*Pz**2))    ! tensor polarization
      Pzz = Pzz_in  ! considering that Pzz cannot be derived from Pz

c      write(10,*)'#    q2     x       w    rate(kHz)     Azz  
c     &      DAzz    time '


      do ib=1,binMax
         Ntotal_for_x(ib)=0
         Nunpoltotal_for_x(ib)=0
         dAzz_drift(ib) = 0
      enddo


      if (test.eq.1) GOTO 42
cLoop over the spectrometers
cvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c      do ispectro = 1,6
      do ispectro = 1,2
c      do ispectro = 2,2


         tot_time(ispectro)    = 0.0
         ! for physics extraction
        if (ispectro.eq.1.and.type.eq.1) then ! HMS
            dp_p    =  0.08   ! 8% momentum bite for the HMS
            dp_m    =  0.08   ! 8% momentum bite for the HMS
            dtheta  =  0.028  ! theta acceptance of the HMS
            dphi    =  0.058  ! phi acceptance of the HMS
            acc     =  2.*dtheta*2.*dphi
            hms_min =  10.5   ! minimum angle of the HMS
            dep     =  0.0015*ep_in 
            nx      =  nx1 
         elseif (ispectro.eq.2.and.type.eq.1) then ! SHMS
            dp_p    =  0.20   ! 20% momentum bite for the SHMS
            dp_m    =  0.08   ! 8% momentum bite for the SHMS
            dtheta  =  0.022  ! theta acceptance of the SHMS
            dphi    =  0.050  ! phi acceptance of the SHMS
            acc     =  2.*dtheta*2.*dphi
            hms_min =  5.5    ! minimum angle of the SHMS
            nx      =  nx2 

c vvvvvvvvv Playing -- DO NOT USE FOR ACTUAL PHYSICS !! vvvvvvvvvvvv
c            dp_p    =  0.20   ! 20% momentum bite for the SHMS
c            dp_m    =  0.20   ! 8% momentum bite for the SHMS
c            dtheta  =  0.06  ! theta acceptance of the SHMS
c            dphi    =  0.050  ! phi acceptance of the SHMS
c            acc     =  2.*dtheta*2.*dphi
c            hms_min =  5.5    ! minimum angle of the SHMS
c            nx      =  nx2 
c ^^^^^^^^^ Playing -- DO NOT USE FOR ACTUAL PHYSICS !! ^^^^^^^^^^^^

c            dp_p    =  0.25   ! +25% momentum bite for the SHMS
c            dp_m    =  0.15   ! -15% momentum bite for the SHMS
c            dtheta  =  0.018  ! theta acceptance of the SHMS
c            dphi    =  0.050  ! phi acceptance of the SHMS
c            acc     =  2.*dtheta*2.*dphi
c            hms_min =  5.5    ! minimum angle of the SHMS
c            dep     =  0.002*ep_in 
c            nx      =  nx2 
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
            dep     =  0.02*ep_in 
            nx      =  nx4 
         elseif (ispectro.eq.5.and.type.eq.1) then ! BB
            dp_p    =  0.40  
            dp_m    =  0.40  
            dtheta  =  0.067    ! theta acceptance of the BB
            dphi    =  0.240    ! phi acceptance of the BB
            acc     =  0.064    ! large acceptance: 0.96 sr
            hms_min =  12.5     ! minimum angle of the BB
            dep     =  0.02*ep_in 
            nx      =  nx5
         elseif (ispectro.eq.6.and.type.eq.1) then ! SBS
            dp_p    =  0.40  
            dp_m    =  0.40  
            dtheta  =  0.080   ! theta acceptance of the SBS
            dphi    =  0.210   ! phi acceptance of the SBS
            acc     =  0.076   ! large acceptance: 0.076 sr
            hms_min =  15.0    ! minimum angle of the SBS
            dep     =  0.02*ep_in 
            nx      =  nx6
         endif

c         do ib=1,nx
         do ib=1,binMax
            N_for_x(ib) = 0.0
            Nunpol_for_x(ib) = 0.0
            Ngood_for_x(ib) = 0.0
            Nunpolgood_for_x(ib) = 0.0
            w_ave(ib) = 0.0
            sigma_sum(ib) = 0.0
            xsum(ib)     = 0.0
         enddo
         ix=0
c   Loop over x bins
c   vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
         do ix = 1,nx ! number of x
            ib = 0
c            do ib=1,nx
            do ib=1,binMax
               thisNforx(ib) = 0
               thisNunpolforx(ib) = 0
            enddo
            lumiSig            = 0.0
            goodRateTotal      = 0.0
            physRateTotal      = 0.0
            goodRate_d         = 0.0
            goodRate_n         = 0.0
            goodRate_he         = 0.0
            ave_x              = 0.0
            totsig_for_ave_x  = 0.0

            do ib=1,binMax
               N_for_x(ib)            = 0.0
               xsum(ib)               = 0.0
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
 
            good_x_min = xx
            good_x_max = xx

 10         w          = sqrt(mp**2+qq/xx-qq)
            nu         = qq/2./mp/xx
            w2nn       = 2*nu*md+md**2-qq
            wnn        = sqrt(w2nn)
            y_in       = nu/e_in
            ep_in      = e_in - nu
            s2         = qq/4.0/e_in/ep_in
            thrad      = 2.*asin(sqrt(s2))
            th_in      = thrad/d_r
            superth_in = thrad/d_r
            cent_nu    = nu
            cent_w2nn  = w2nn
            cent_wnn   = wnn
            write(6,*) "c_nu:",cent_nu,"c_w2nn:",cent_w2nn,"c_wnn:",cent_wnn

            ! Binning over the momentum bite
c            dep    = 0.02*ep_in
c            dep    = 0.005*ep_in
            dep    = 0.001*ep_in
c            dep    = ep_in
            epmin  = ep_in*(1.-dp_m)
            epmax  = ep_in*(1.+dp_p)
            npbin  = int((epmax-epmin)/dep)+1

            ! binning over the angular spread
c            thmin  = th_in - dtheta/d_r
c            thmax  = th_in + dtheta/d_r
c            ntbin  = int((thmax - thmin)/theta_res)+1
c            ntbin  = 19
c            ntbin  = 10
            ntbin  = 25
c            ntbin  = 1
c            ntbin  = 3
            thincr = dtheta*2.0/float(ntbin)/d_r
            thmin  = th_in - float(ntbin/2-1/2)*thincr

            ! banner for output files
            write(9,*)'# th     pit     q2      x      sig_u     rate_u'
            write(9,*)'#                           0.6/GeV.sr)    (Hz)'
 
            ip = 0
c      Looping over momentum bins
c      vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            do ip = 1,npbin
               pit = epmin+(ip-1)*dep

               sigradsum            = 0.0
               d_sigradsum          = 0.0
               d_unpol_sigradsum    = 0.0
               he_sigradsum         = 0.0
               n_sigradsum          = 0.0
               li_sigradsum         = 0.0
               allsigradsum         = 0.0
               d_allsigradsum       = 0.0
               d_unpol_allsigradsum = 0.0
               he_allsigradsum      = 0.0
               li_allsigradsum      = 0.0
               n_allsigradsum       = 0.0

               it = 0 
               isum = 0
               allisum = 0
               if (central) then
                  ntbin = 1
               endif   
c         Looping over theta bins 
c         vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv


               do it=1,ntbin
                  if (central) then
                     thit = th_in
                  else
                     thit = thmin+(it-1)*thincr
                  endif
                  
                  thrad = thit*d_r
                  snsq  = sin(thrad/2.)**2.
                  cssq  = cos(thrad/2.)**2.
                  tnsq  = tan(thrad/2.)**2.
                  nu    = e_in - pit
                  q2    = 4.*e_in*pit*snsq
                  x     = q2/(2.*mp*nu)
                  w2    = mp*mp + q2/x - q2
                  w2nn  = 2*nu*md+md**2-q2
                  wnn   = sqrt(w2nn)

c                 The section below uses x_Bjorken (xx) and theta_e' (th_in) to determine
c                 the angle of the q-vector (thq) in degrees
c                 vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
                  E0_PASS = e_in
                  TH_PASS = thit
                  EP_PASS = pit
                  if (w2.ge.0.0) then
                      rr1 = 0.0
                      rr2 = 180.
                      call ROTATION(rr1, rr2, phistar, thstar)
                      thq = 180. - thstar
                      thq_r = thq*pi/180.
                      cosqvec = cos(thq_r)
                  endif
c                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

c                 vvv The Mott cross sections below are in barns/GeV*str (1E-24 cm^2/(GeV*str))
                  mott_p  = hbarc2*((1*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c                  mott_d  = hbarc2*((1*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c                  mott_he = hbarc2*((2*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c                  mott_n  = hbarc2*((7*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c                  mott_li = hbarc2*((3*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c                 vvvvvvvvv This part gives us the total, non-physics info vvvvvvvvvvvvvvvvvvvvvvvvvvvvv
                  b1out   = 0; Aout    = 0; F1out   = 0;
                  F1      = 0; F2      = 0; F1n     = 0; F2n    = 0;
                  F1n_qe  = 0; F2n_qe  = 0; F1c_qe  = 0; F2c_qe = 0;
                  F1n_ie  = 0; F2n_ie  = 0; F1c_ie  = 0; F2c_ie = 0;
                  F1he    = 0; F2he    = 0; F1d     = 0; F2d    = 0;
                  F1he_qe = 0; F2he_qe = 0; F1d_qe  = 0; F2d_qe = 0;
                  F1he_ie = 0; F2he_ie = 0; F1d_ie  = 0; F2d_ie = 0;
                  F1li    = 0; F1li_ie = 0; F1li_qe = 0; rcli   = 0;
                  F2li    = 0; F2li_ie = 0; F2li_qe = 0;
                  rc      = 0; rche    = 0; rcn     = 0; rcc    = 0;
                  if (lumi_d.gt.0) call F1F2QE09(z_d,a_d,q2,w2,F1d_qe,F2d_qe)          ! Get QE  F1 & F2 for 2H
                  if (lumi_he.gt.0) call F1F2QE09(z_he,a_he,q2,w2,F1he_qe,F2he_qe)      ! Get QE  F1 & F2 for 4He
                  if (lumi_li.gt.0) call F1F2QE09(z_li,a_li,q2,w2,F1li_qe,F2li_qe)      ! Get QE  F1 & F2 for 6Li
                  if (lumi_n.gt.0) call F1F2QE09(z_n,a_n,q2,w2,F1n_qe,F2n_qe)          ! Get QE  F1 & F2 for 14N
                  if (lumi_c.gt.0) call F1F2QE09(z_c,a_c,q2,w2,F1c_qe,F2c_qe)          ! Get QE  F1 & F2 for 12C
                  if (lumi_d.gt.0) call F1F2IN09(z_d,a_d,q2,w2,F1d_ie,F2d_ie,rc)       ! Get DIS F1 & F2 for 2H
                  if (lumi_he.gt.0) call F1F2IN09(z_he,a_he,q2,w2,F1he_ie,F2he_ie,rche) ! Get DIS F1 & F2 for 4He
                  if (lumi_li.gt.0) call F1F2IN09(z_li,a_li,q2,w2,F1li_ie,F2li_ie,rcli) ! Get DIS F1 & F2 for 6Li
                  if (lumi_n.gt.0) call F1F2IN09(z_n,a_n,q2,w2,F1n_ie,F2n_ie,rcn)      ! Get DIS F1 & F2 for 14N
                  if (lumi_c.gt.0) call F1F2IN09(z_c,a_c,q2,w2,F1c_ie,F2c_ie,rcc)      ! Get DIS F1 & F2 for 12C
                  if (x.ge.0.8.and.x.le.5.0) then   ! If QE:
                      call get_qe_b1d(x,q2,Aout,F1out,b1out)
                  elseif (x.lt.0.8.and.x.gt.0) then ! If DIS:
                      call get_b1d(x,q2,Aout,F1out,b1out)
                  endif

                  if (.not.(F1d_ie.gt.0)) F1d_ie = 0
                  if (.not.(F1d_qe.gt.0)) F1d_qe = 0
                  if (.not.(F1n_ie.gt.0)) F1n_ie = 0
                  if (.not.(F1n_qe.gt.0)) F1n_qe = 0
                  if (.not.(F1c_ie.gt.0)) F1c_ie = 0
                  if (.not.(F1c_qe.gt.0)) F1c_qe = 0
                  if (.not.(F1he_ie.gt.0)) F1he_ie = 0
                  if (.not.(F1he_qe.gt.0)) F1he_qe = 0
                  if (.not.(F1li_ie.gt.0)) F1li_ie = 0
                  if (.not.(F1li_qe.gt.0)) F1li_qe = 0
                  if (.not.(F2d_ie.gt.0)) F2d_ie = 0
                  if (.not.(F2d_qe.gt.0)) F2d_qe = 0
                  if (.not.(F2n_ie.gt.0)) F2n_ie = 0
                  if (.not.(F2n_qe.gt.0)) F2n_qe = 0
                  if (.not.(F2c_ie.gt.0)) F2c_ie = 0
                  if (.not.(F2c_qe.gt.0)) F2c_qe = 0
                  if (.not.(F2he_ie.gt.0)) F2he_ie = 0
                  if (.not.(F2he_qe.gt.0)) F2he_qe = 0
                  if (.not.(F2li_ie.gt.0)) F2li_ie = 0
                  if (.not.(F2li_qe.gt.0)) F2li_qe = 0
                  sigma_unpol=0; sigma_unpol_d=0; sigma_unpol_n=0;
                  sigma_unpol_li=0; sigma_unpol_he=0; sigma_unpol_c=0;
                  write(6,1010) "First cross-section measurement...",
     &                        ispectro,ip,it,"(",npbin,ntbin,")"
c                  write(6,*)"nu = ",nu
c                  write(6,*)"mott_p = ",mott_p
c                  write(6,*)"F1d_ie = ",F1d_ie
c                  write(6,*)"F2d_ie = ",F2d_ie
c                  write(6,*)"F1d_qe = ",F1d_qe
c                  write(6,*)"F2d_qe = ",F2d_qe
                  if (csmodel.eq.'Bosted_full') then
                     sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                                  + ((F2d_ie+F2d_qe)/2.)/nu)
c                     sigma_unpol_d  =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
c     +                                  + ((F2d_ie+F2d_qe)/2.)/nu)
                     sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+F1li_qe)/6.)*tnsq/mp
     +                                  + ((F2li_ie+F2li_qe)/6.)/nu)
                     sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+F1he_qe)/4.)*tnsq/mp
     +                                  + ((F2he_ie+F2he_qe)/4.)/nu)
                     sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+F1n_qe)/14.)*tnsq/mp
     +                                  + ((F2n_ie+F2n_qe)/14.)/nu)
                     sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+F1c_qe)/12.)*tnsq/mp
     +                                  + ((F2c_ie+F2c_qe)/12.)/nu)
                  endif
                  if (csmodel.eq.'Bosted_dis') then
                     sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+0)/2.)*tnsq/mp
     +                                  + ((F2d_ie+0)/2.)/nu)
c                     sigma_unpol_d  =  2.*mott_p*(2.*((F1d_ie+0)/2.)*tnsq/mp
c     +                                  + ((F2d_ie+0)/2.)/nu)
                     sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+0)/6.)*tnsq/mp
     +                                  + ((F2li_ie+0)/6.)/nu)
                     sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+0)/4.)*tnsq/mp
     +                                  + ((F2he_ie+0)/4.)/nu)
                     sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+0)/14.)*tnsq/mp
     +                                  + ((F2n_ie+0)/14.)/nu)
                     sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+0)/12.)*tnsq/mp
     +                                  + ((F2c_ie+0)/12.)/nu)
                  endif
                  if (csmodel.eq.'Bosted_qe') then
                     sigma_unpol    =  2.*mott_p*(2.*((0+F1d_qe)/2.)*tnsq/mp
     +                                  + ((0+F2d_qe)/2.)/nu)
c                     sigma_unpol_d  =  2.*mott_p*(2.*((0+F1d_qe)/2.)*tnsq/mp
c     +                                  + ((0+F2d_qe)/2.)/nu)
                     sigma_unpol_li =  6.*mott_p*(2.*((0+F1li_qe)/6.)*tnsq/mp
     +                                  + ((0+F2li_qe)/6.)/nu)
                     sigma_unpol_he =  4.*mott_p*(2.*((0+F1he_qe)/4.)*tnsq/mp
     +                                  + ((0+F2he_qe)/4.)/nu)
                     sigma_unpol_n  = 14.*mott_p*(2.*((0+F1n_qe)/14.)*tnsq/mp
     +                                  + ((0+F2n_qe)/14.)/nu)
                     sigma_unpol_c  = 12.*mott_p*(2.*((0+F1c_qe)/12.)*tnsq/mp
     +                                  + ((0+F2c_qe)/12.)/nu)
                  endif
                  if (csmodel.eq.'Sargsian'.and.q2.lt.10) then
                     if(x.lt.1.1.or.x.gt.3.0.or.x.eq.3.0.or.e_in.lt.3.0) then
                        sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                                     + ((F2d_ie+F2d_qe)/2.)/nu)
                        sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+F1li_qe)/6.)*tnsq/mp
     +                                     + ((F2li_ie+F2li_qe)/6.)/nu)
                        sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+F1he_qe)/4.)*tnsq/mp
     +                                     + ((F2he_ie+F2he_qe)/4.)/nu)
                        sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+F1n_qe)/14.)*tnsq/mp
     +                                     + ((F2n_ie+F2n_qe)/14.)/nu)
                        sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+F1c_qe)/12.)*tnsq/mp
     +                                     + ((F2c_ie+F2c_qe)/12.)/nu)
                     elseif ((x.gt.1.1.or.x.eq.1.1).and.x.lt.3.0.and.e_in.gt.3.0) then
                        if (lumi_d.gt.0) call init_incl(e_in,pit,thit,x,a_d,z_d,sigma_unpol)
                        if (lumi_li.gt.0) call init_incl(e_in,pit,thit,x,a_li,z_li,sigma_unpol_li)
                        if (lumi_he.gt.0) call init_incl(e_in,pit,thit,x,a_he,z_he,sigma_unpol_he)
                        if (lumi_n.gt.0) call init_incl(e_in,pit,thit,x,a_n,z_n,sigma_unpol_n)
                        if (lumi_c.gt.0) call init_incl(e_in,pit,thit,x,a_c,z_c,sigma_unpol_c)
                     endif
                  endif
c                  if (x.gt.1.75) then
                  if (x.gt.0) then
                        call elastic(z_d,a_d,q2,thit,e_in,sigma_unpol)
                        call elastic(z_li,a_li,q2,thit,e_in,sigma_unpol_li)
                        call elastic(z_he,a_he,q2,thit,e_in,sigma_unpol_he)
                        call elastic(z_n,a_n,q2,thit,e_in,sigma_unpol_n)
                        call elastic(z_c,a_c,q2,thit,e_in,sigma_unpol_c)
                  endif
                  sigma_unpol_d  = sigma_unpol
                  sigma_pol_d    = sigma_unpol_d*(1+0.5*Pzz*Aout)

c                  write(6,*)"sigma_unpol = ",sigma_unpol

                  if (targ.eq.'ND3') then
                     tot_allsigma = sigma_unpol_d + sigma_unpol_he + sigma_unpol_n
                  elseif (targ.eq.'LiD') then
                     tot_allsigma = sigma_unpol_d + sigma_unpol_he + sigma_unpol_li
                  elseif (targ.eq.'LiD_He2D') then
                     tot_allsigma = sigma_unpol_d + sigma_unpol_he
                  endif
c                  tot_allsigma = sigma_pol_d + sigma_unpol_he + sigma_unpol_n

c vvvvvvvvvvv DO NOT TRUST VARIABLES BELOW -- I THINK THEY'RE BAD vvvvvvvvvvvv
                  if (tot_allsigma.gt.0.0) then
                      allsigradsum         = allsigradsum + sigma_pol_d
                      d_unpol_allsigradsum = d_unpol_allsigradsum + sigma_unpol_d
                      d_allsigradsum       = d_allsigradsum + sigma_pol_d
                      he_allsigradsum      = he_allsigradsum + sigma_unpol_he
                      li_allsigradsum      = li_allsigradsum + sigma_unpol_li
                      n_allsigradsum       = n_allsigradsum + sigma_unpol_n
                      allisum              = allisum + 1
                  endif
c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

                  lumiSig =   (lumi_d*sigma_pol_d)
     +                      + (lumi_he*sigma_unpol_he)
     +                      + (lumi_heli*sigma_unpol_he)
     +                      + (lumi_n*sigma_unpol_n)
     +                      + (lumi_li*sigma_unpol_li)
                  goodRateTotal = goodRateTotal 
     +                  + (lumiSig*dep*thincr*d_r*2*dphi*1E-24)
                  goodRate_d = goodRate_d 
     +                  + (lumi_d*sigma_pol_d*dep*thincr*d_r*2*dphi*1E-24)
                  goodRate_n = goodRate_n 
     +                  + (lumi_n*sigma_unpol_n*dep*thincr*d_r*2*dphi*1E-24)
                  goodRate_he = goodRate_he
     +                  + (lumi_he*sigma_unpol_he*dep*thincr*d_r*2*dphi*1E-24)
     +                + (lumi_heli*sigma_unpol_he*dep*thincr*d_r*2*dphi*1E-24)
                  goodRate_li = goodRate_li
     +                  + (lumi_li*sigma_unpol_li*dep*thincr*d_r*2*dphi*1E-24)

c vvvvvvvvvvvvvv This sets the physics cuts to get the physRateTotal vvvvvvvvvv
c                 if (w2.le.w2min) then
                 if (x.lt.0.75) then
                    sigma_unpol    = 0.0
                    sigma_unpol_d  = 0.0
                    sigma_unpol_he = 0.0
                    sigma_unpol_li = 0.0
                    sigma_unpol_n  = 0.0
                    sigma_unpol_c  = 0.0
                    sigma_pol_d    = 0.0
                 endif
c                 if (w2.ge.w2max) then
                 if (x.gt.2.15) then
c                 if (x.gt.1.85) then
                    sigma_unpol    = 0.0
                    sigma_unpol_d  = 0.0
                    sigma_unpol_li = 0.0
                    sigma_unpol_he = 0.0
                    sigma_unpol_n  = 0.0
                    sigma_unpol_c  = 0.0
                    sigma_pol_d    = 0.0
                 endif
c                 if (q2.lt.1.0) then
c                    sigma_unpol    = 0.0
c                    sigma_unpol_d  = 0.0
c                    sigma_unpol_li = 0.0
c                    sigma_unpol_he = 0.0
c                    sigma_unpol_n  = 0.0
c                    sigma_unpol_c  = 0.0
c                    sigma_pol_d    = 0.0
c                 endif

c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
                  lumiSig = lumi_d*sigma_pol_d 
c     +                      + lumi_he*sigma_unpol_he 
c     +                      + lumi_n*sigma_unpol_n
                  physRateTotal = physRateTotal 
     +                            + lumiSig*dep*thincr*d_r*2*dphi*1E-24
                     
c                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

                  apass = 2
                  zpass = 1
                  m_nuc = m_atom*m_amu-float(zpass)*m_e

                  ! Radiative correction need to be implemented here
c                  sigma_meas   = sigma_born
c



                  do ib=1,binMax
                     if (x.gt.cent_x_min(ib).and.x.lt.cent_x_max(ib).and.sigma_unpol.gt.0.0) then
                        N_for_x(ib) = lumi_d*sigma_pol_d 
     +                    + lumi_li*sigma_unpol_li
     +                    + lumi_he*sigma_unpol_he
     +                    + lumi_heli*sigma_unpol_he
     +                    + lumi_n*sigma_unpol_n
                        Nunpol_for_x(ib) = lumi_d*sigma_unpol_d 
     +                    + lumi_li*sigma_unpol_li
     +                    + lumi_he*sigma_unpol_he
     +                    + lumi_heli*sigma_unpol_he
     +                    + lumi_n*sigma_unpol_n
c                        write(6,*)"Nunpol_for_x(",ib,") = ",Nunpol_for_x(ib)
                          xsum(ib) = xsum(ib) + 1
                          w_ave(ib) = w_ave(ib) + tot_allsigma*sqrt(w2)
                          sigma_sum(ib) = sigma_sum(ib) + tot_allsigma
                          Ngood_for_x(ib) = Ngood_for_x(ib) + 
     +                        N_for_x(ib)*dep*thincr*d_r*2*dphi*1E-24*prec*3600
                          Nunpolgood_for_x(ib) = Nunpolgood_for_x(ib) + 
     +                        Nunpol_for_x(ib)*dep*thincr*d_r*2*dphi*1E-24*prec*3600
                          thisNforx(ib) = thisNforx(ib) + 
     +                        N_for_x(ib)*dep*thincr*d_r*2*dphi*1E-24*prec*3600
                          thisNunpolforx(ib) = thisNunpolforx(ib) + 
     +                        Nunpol_for_x(ib)*dep*thincr*d_r*2*dphi*1E-24*prec*3600

c                        write(6,*)"Nunpolgood_for_x(",ib,") = ",Nunpolgood_for_x(ib)
                     endif
                  enddo

c                  write(6,*)"sigma_unpol = ",sigma_unpol
c                  write(6,*)"sigma_unpol_d = ",sigma_unpol_d
                  if (sigma_unpol.gt.0.0) then ! DIS
                     sigradsum         = sigradsum + sigma_pol_d
                     d_unpol_sigradsum = d_unpol_sigradsum + sigma_unpol_d
                     d_sigradsum       = d_sigradsum + sigma_pol_d
                     li_sigradsum      = li_sigradsum + sigma_unpol_li
                     he_sigradsum      = he_sigradsum + sigma_unpol_he
                     n_sigradsum       = n_sigradsum + sigma_unpol_n
                     isum              = isum + 1
                     ave_x             = ave_x + x*sigma_unpol_d
                     totsig_for_ave_x  = totsig_for_ave_x + sigma_unpol_d
c                     write(6,*)"totsig_for_ave_x = ",totsig_for_ave_x
c                     write(6,*)"ave_x = ",ave_x
                     if (x.lt.good_x_min) then 
                        good_x_min = x
                     endif
                     if (x.gt.good_x_max) then 
                        good_x_max = x
                     endif
                  endif
                  write(12,1002)ispectro, ix, ip, it, isum,
     &              thit,superth_in,q2,qq,x,xx,w2,w*w,
     &              sigma_unpol_d,sigma_unpol_he,sigma_unpol_n,
     &              F1d,F2d,F1he,F2he,F1n,F2n,
     &              pit,thit,thq,
     &              tot_allsigma,sigma_unpol_li,nu,w2nn,wnn

               enddo ! loop over theta bins


c         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
               write(8,*)ispectro,x,th_in,pit,sigradsum,isum
               write(13,*)ispectro,x,th_in,pit,sigradsum,isum

c              vvvvvvv For total, non-physics, rates vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
               allsigradave         = 0.0
               d_allsigradave       = 0.0
               d_unpol_allsigradave = 0.0
               li_allsigradave      = 0.0
               he_allsigradave      = 0.0
               n_allsigradave       = 0.0
               if (allisum.gt.0) then
                  allsigradave         = allsigradsum/allisum
                  d_allsigradave       = d_allsigradsum/allisum
                  d_unpol_allsigradave = d_unpol_allsigradsum/allisum
                  li_allsigradave      = li_allsigradsum/allisum
                  he_allsigradave      = he_allsigradsum/allisum
                  n_allsigradave       = n_allsigradsum/allisum
                  q2p          = 2.0*e_in*pit*(1-cos(th_in*d_r))
                  xp           = q2p/(2.0*mp*(e_in-pit))
               endif
c              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

               sigradave         = 0.0
               d_sigradave       = 0.0
               d_unpol_sigradave = 0.0
               he_sigradave      = 0.0
               li_sigradave      = 0.0
               n_sigradave       = 0.0
               if (isum.gt.0) then
                  sigradave         = sigradsum/isum
                  d_sigradave       = d_sigradsum/isum
                  d_unpol_sigradave = d_unpol_sigradsum/isum
                  li_sigradave      = li_sigradsum/isum
                  he_sigradave      = he_sigradsum/isum
                  n_sigradave       = n_sigradsum/isum
                  q2p          = 2.0*e_in*pit*(1-cos(th_in*d_r))
                  xp           = q2p/(2.0*mp*(e_in-pit))

                  write(9,1003)ispectro,th_in, pit, q2p, xp,sigradave, physRateTotal,
     &                         d_sigradsum,he_sigradsum,n_sigradsum,li_sigradsum
                  sigmasump = sigmasump + sigradave
               endif
            enddo  ! loop over p bins
c      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            sigcenter = sigmasump/npbin
            w2 = w*w
            F1d = 0
            F2d = 0
            ave_x = ave_x/totsig_for_ave_x
            spec_x = xx
            xx = ave_x

            call F1F2QE09(z_d,a_d,qq,w2,F1d_qe,F2d_qe)     !      Get F1 for Deuterium
            call F1F2IN09(z_d,a_d,qq,w2,F1d_ie,F2d_ie,rc)  !      Get F1 for Deuterium
            if (.not.(F1d_ie.gt.0)) F1d_ie = 0
            if (.not.(F1d_qe.gt.0)) F1d_qe = 0
            if (.not.(F1n_ie.gt.0)) F1n_ie = 0
            if (.not.(F1n_qe.gt.0)) F1n_qe = 0
            if (.not.(F1c_ie.gt.0)) F1c_ie = 0
            if (.not.(F1c_qe.gt.0)) F1c_qe = 0
            if (.not.(F1he_ie.gt.0)) F1he_ie = 0
            if (.not.(F1he_qe.gt.0)) F1he_qe = 0
            if (.not.(F1li_ie.gt.0)) F1li_ie = 0
            if (.not.(F1li_qe.gt.0)) F1li_qe = 0
            if (.not.(F2d_ie.gt.0)) F2d_ie = 0
            if (.not.(F2d_qe.gt.0)) F2d_qe = 0
            if (.not.(F2n_ie.gt.0)) F2n_ie = 0
            if (.not.(F2n_qe.gt.0)) F2n_qe = 0
            if (.not.(F2c_ie.gt.0)) F2c_ie = 0
            if (.not.(F2c_qe.gt.0)) F2c_qe = 0
            if (.not.(F2he_ie.gt.0)) F2he_ie = 0
            if (.not.(F2he_qe.gt.0)) F2he_qe = 0
            if (.not.(F2li_ie.gt.0)) F2li_ie = 0
            if (.not.(F2li_qe.gt.0)) F2li_qe = 0

            ! calculate the time assuming the settings spread
            Aout = 0
            b1d = 0
            if (spec_x.lt.0.75) then
               call get_b1d(spec_x,qq,Aout,F1out,b1out)
            elseif (spec_x.ge.0.75) then
               call get_qe_b1d(spec_x,qq,Aout,F1out,b1out)
            endif
            Azz  = Aout
            b1d  = b1out
            b1d_scaled = b1out/scale

c           vvvvv Define the rates in terms of physics and total for the output vvv
            physRate = physRateTotal
            totalrate = goodRateTotal
c           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


            pac_time = prec*2.0
c            pac_time = prec
            time = pac_time
            if (targ.eq.'ND3') then
c               f_dil = 0.95*(goodRate_d/(goodRate_d + goodRate_n + goodRate_he))
               f_dil = (goodRate_d/(goodRate_d + goodRate_n + goodRate_he))
            elseif (targ.eq.'LiD') then
c               f_dil = 0.95*(goodRate_d/(goodRate_d + goodRate_li + goodRate_he))
               f_dil = (goodRate_d/(goodRate_d + goodRate_li + goodRate_he))
            elseif (targ.eq.'LiD_He2D') then
c               f_dil = 0.95*(goodRate_d/(goodRate_d + goodRate_he))
               f_dil = (goodRate_d/(goodRate_d + goodRate_he))
            endif
c           vvvvv Error on Azz using A_meas^(2)
            dAzz = (4./(f_dil*Pzz))*(1/SQRT(time*physrate*3600.0))
c            F1d = F1out*2
            db1d  = abs(-1.5*dAzz)*(F1d_ie+F1d_qe)/2
            syst_Azz = sqrt((Aout*dAzz_rel)**2 + 0.0037**2)
            if (spec_x.ge.0.6) then
c               syst_Azz  = Aout*0.1   ! to be adjusted
               syst_Azz  = Aout*0.14
            endif
            if (spec_x.eq.0.15) then
               syst_Azz = sqrt((Aout*dAzz_rel)**2 + 0.0046**2)
            endif 
            if (spec_x.eq.0.3) then
               syst_Azz = sqrt((Aout*dAzz_rel)**2 + 0.0037**2)
            endif 
            if (spec_x.eq.0.452) then
               syst_Azz = sqrt((Aout*dAzz_rel)**2 + 0.0028**2)
            endif 
            if (spec_x.eq.0.55) then
               syst_Azz = sqrt((Aout*dAzz_rel)**2 + 0.0021**2)
            endif 
            syst_b1d = abs(-1.5*syst_Azz)*(F1d_ie+F1d_qe)/2

            xdx = xmax(ix) - xx

c           The bit below is just to test the cross section calculations in
c           order to make sure that they're working correctly. It should be
c           removed later.
c           vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            thrad = superth_in*d_r
            snsq  = sin(thrad/2.)**2.
            cssq  = cos(thrad/2.)**2.
            tnsq  = tan(thrad/2.)**2.
            nu    = qq/2./mp/xx
            cstheta = cos(thrad/2.)
            nu    = e_in - pit
c           ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


c            The section below uses x_Bjorken (xx) and theta_e' (th_in) to determine
c            the angle of the q-vector (thq) in degrees
c            vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
             E0_PASS = e_in 
             TH_PASS = th_in
             EP_PASS = ep_in
             if (w2.ge.0.0) then
                 rr1 = 0.0
                 rr2 = 180.
                 call ROTATION(rr1, rr2, phistar, thstar)
                 thq = 180. - thstar
                 thq_r = thq*pi/180.
                 cosqvec = cos(thq_r)
             endif
c            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
            write(11,1005)ispectro,xx,qq,w,
     &                    ep_in,superth_in,
     &                    physRateTotal,
     &                    Azz,dAzz,
     &                    b1d,db1d,
     &                    time,
     &                    syst_Azz,syst_b1d,
     &                    thq,cosqvec,
     &                    sigma_unpol,w2,
     &                    q2,x,nu,
     &                    pac_time,e_in,
     &                    xdx,
     &                    goodRateTotal,goodRate_he,goodRate_n,
     &                    f_dil,spec_x,
     &                    good_x_min,good_x_max,
     &                    goodRate_li,cent_nu,cent_w2nn,cent_wnn

            do ib=1,binMax
               F1d = 0
               F2d = 0
               rc  = 0

               w2 = (w_ave(ib)/sigma_sum(ib))**2
               qq = (w2 - mp**2)/(1/cent_x(ib) - 1)

               call F1F2QE09(z_d,a_d,qq,w2,F1d_qe,F2d_qe)
               call F1F2IN09(z_d,a_d,qq,w2,F1d_ie,F2d_ie,rc)
               if (.not.(F1d_ie.gt.0)) F1d_ie = 0
               if (.not.(F1d_qe.gt.0)) F1d_qe = 0
               if (.not.(F1n_ie.gt.0)) F1n_ie = 0
               if (.not.(F1n_qe.gt.0)) F1n_qe = 0
               if (.not.(F1c_ie.gt.0)) F1c_ie = 0
               if (.not.(F1c_qe.gt.0)) F1c_qe = 0
               if (.not.(F1he_ie.gt.0)) F1he_ie = 0
               if (.not.(F1he_qe.gt.0)) F1he_qe = 0
               if (.not.(F1li_ie.gt.0)) F1li_ie = 0
               if (.not.(F1li_qe.gt.0)) F1li_qe = 0
               if (.not.(F2d_ie.gt.0)) F2d_ie = 0
               if (.not.(F2d_qe.gt.0)) F2d_qe = 0
               if (.not.(F2n_ie.gt.0)) F2n_ie = 0
               if (.not.(F2n_qe.gt.0)) F2n_qe = 0
               if (.not.(F2c_ie.gt.0)) F2c_ie = 0
               if (.not.(F2c_qe.gt.0)) F2c_qe = 0
               if (.not.(F2he_ie.gt.0)) F2he_ie = 0
               if (.not.(F2he_qe.gt.0)) F2he_qe = 0
               if (.not.(F2li_ie.gt.0)) F2li_ie = 0
               if (.not.(F2li_qe.gt.0)) F2li_qe = 0

               F1d = F1d_qe+F1d_ie
               Aout = 0
               F1out = 0
               b1out = 0
               if(cent_x(ib).lt.0.75) then
                  call get_b1d(cent_x(ib),qq,Aout,F1out,b1out)
               elseif(cent_x(ib).ge.0.75) then
                  call get_qe_b1d(cent_x(ib),qq,Aout,F1out,b1out)
               endif
   
               dAzz = (2./(f_dil*Pzz))*SQRT(thisNforx(ib)/thisNunpolforx(ib)**2
     +                    + thisNforx(ib)**2/thisNunpolforx(ib)**3)

               db1d  = abs(-1.5*dAzz)*F1d/2
   
               syst_Azz = sqrt((Aout*dAzz_rel)**2 + 0.0037**2)
               if (spec_x.gt.0.6) then
c                  syst_Azz = Aout*0.1
                  syst_Azz = Aout*0.14
               endif
               syst_b1d = abs(-1.5*syst_Azz)*(F1d_ie+F1d_qe)/2
               if (thisNforx(ib).ne.0.0) then
                  drift_scale = 0
                  drift_scale = thisNforx(ib)*0.20/Pzz_in
                  if (spec_x.eq.0.15) then
                     dAzz_drift(ib) = dAzz_drift(ib) +0.0032*drift_scale
                  elseif (spec_x.eq.0.3) then
                     dAzz_drift(ib) = dAzz_drift(ib) +0.0037*drift_scale
                  elseif (spec_x.eq.0.452) then
                     dAzz_drift(ib) = dAzz_drift(ib) +0.0029*drift_scale
                  elseif (spec_x.eq.0.55) then
                     dAzz_drift(ib) = dAzz_drift(ib) +0.0019*drift_scale
                  else 
                     dAzz_drift(ib) = dAzz_drift(ib) +0.0019*drift_scale
                  endif 

               endif
c               dAzz_drift(ib) = 0 ! To be fixed later 
   

               write(15,1007) ispectro,spec_x,cent_x(ib),xdx,
     &                        dAzz,db1d,
     &                        w2,qq,
     &                        thisNforx(ib),
     &                        syst_Azz,syst_b1d,
     &                        Aout,b1out
            enddo

c            write(6,*)'--------------------------'
c            write(6,*)'For ',targ
c            write(6,*)'lumi= ',lumi
c            write(6,*)'rho= ',rho
c            write(6,*)'Pzz= ',pzz
            tot_time(ispectro)    = tot_time(ispectro) + time/3600

         enddo  ! loop over x-value
c   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

         f_dil = 0.95*0.3
c         do ib=1,nx
         do ib=1,binMax
            F1d = 0
            F2d = 0
            rc  = 0

            w_ave(ib) = w_ave(ib)/sigma_sum(ib)

            if(Ngood_for_x(ib).gt.0.0) then
               if(ispectro.eq.1.or.ispectro.eq.2) then
c                  write(6,*) "*(&)&*(^$#*(^*&%$*&#$ HEY LOOK AT ME WHOO----------------"
                  Ntotal_for_x(ib) = Ntotal_for_x(ib) + Ngood_for_x(ib)
                  Nunpoltotal_for_x(ib) = Nunpoltotal_for_x(ib) + Nunpolgood_for_x(ib)
                  total_w_ave(ib)  = total_w_ave(ib)  
     +                                      + w_ave(ib)*Ngood_for_x(ib)
               endif
            endif
            write(6,*) "Ntotal_for_x(",ib,") = ",Ntotal_for_x(ib)
            write(6,*) "Nunpoltotal_for_x(",ib,") = ",Nunpoltotal_for_x(ib)
            w2 = w_ave(ib)**2
            qq = (w2 - mp**2)/(1/cent_x(ib) - 1)

            xdx = cent_x_max(ib) - cent_x(ib)

            if (cent_x(ib).gt.0.9.and.cent_x(ib).lt.3.0) then
               call F1F2QE09(z_d,a_d,qq,w2,F1d,F2d)
            elseif (cent_x(ib).lt.0.9.and.cent_x(ib).gt.0) then
               call F1F2IN09(z_d,a_d,qq,w2,F1d,F2d,rc)
            endif

c            dAzz = (4./(f_dil*Pzz))*(1/SQRT(Ngood_for_x(ib)))
c            dAzz = (2./(f_dil*Pzz))*SQRT(Ngood_for_x(ib)/Nunpol_for_x(ib)**2
c     +                    + Ngood_for_x(ib)**2/Nunpol_for_x(ib)**3)
c            db1d  = abs(-1.5*dAzz)*F1d/2
         enddo

      enddo  ! loop over the spectro
c^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

         f_dil = 0.95*0.3
         do ib=1,binMax
            F1d = 0
            F2d = 0
            rc  = 0

            total_w_ave(ib) = total_w_ave(ib)/Ntotal_for_x(ib)

            w2 = total_w_ave(ib)**2
            qq = (w2 - mp**2)/(1/cent_x(ib) - 1)
            xdx = cent_x_max(ib) - cent_x(ib)

c           The section below calculates the dilution factor based on the cross-sections
c           at the central angle/energy of the detectors and x
c           vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
            thrad = th_in1*d_r
            if (qqval2(1).eq.99.and.xval2(1).eq.100) thrad = th_in2*d_r
            snsq  = sin(thrad/2.)**2.
            cssq  = cos(thrad/2.)**2.
            tnsq  = tan(thrad/2.)**2.
            nu    = e_in - ep_in1
            if (qqval2(1).eq.99.and.xval2(1).eq.100) nu = e_in - ep_in2
            q2    = 4.*e_in*ep_in1*snsq
            if (qqval2(1).eq.99.and.xval2(1).eq.100) q2 = 4.*e_in*ep_in2*snsq
c            x     = q2/(2.*mp*nu)
            x     = cent_x(ib)
            w2    = mp*mp + q2/x - q2
c           vvv The Mott cross sections below are in barns (1E-24 cm^2)
            mott_p  = hbarc2*((1*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c            mott_d  = hbarc2*((1*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c            mott_he = hbarc2*((2*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c            mott_li = hbarc2*((3*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c            mott_n  = hbarc2*((7*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
            b1out   = 0; Aout    = 0; F1out   = 0;
            F1      = 0; F2      = 0; F1n     = 0; F2n     = 0;
            F1n_qe  = 0; F2n_qe  = 0; F1c_qe  = 0; F2c_qe  = 0;
            F1n_ie  = 0; F2n_ie  = 0; F1c_ie  = 0; F2c_ie  = 0;
            F1he    = 0; F2he    = 0; F1d     = 0; F2d     = 0;
            F1he_qe = 0; F2he_qe = 0; F1d_qe  = 0; F2d_qe  = 0;
            F1he_ie = 0; F2he_ie = 0; F1d_ie  = 0; F2d_ie  = 0;
            rc      = 0; rche    = 0; rcn     = 0; rcc     = 0;
            F1li_qe = 0; F1li_ie = 0; F2li_qe = 0; F2li_ie = 0;
            F1li    = 0; F2li    = 0; rcli    = 0;
            if (lumi_d.gt.0) call F1F2QE09(z_d,a_d,q2,w2,F1d_qe,F2d_qe)          ! Get QE  F1 & F2 for 2H
            if (lumi_he.gt.0) call F1F2QE09(z_he,a_he,q2,w2,F1he_qe,F2he_qe)      ! Get QE  F1 & F2 for 4He
            if (lumi_li.gt.0) call F1F2QE09(z_li,a_li,q2,w2,F1li_qe,F2li_qe)      ! Get QE  F1 & F2 for 4He
            if (lumi_n.gt.0) call F1F2QE09(z_n,a_n,q2,w2,F1n_qe,F2n_qe)          ! Get QE  F1 & F2 for 14N
            if (lumi_c.gt.0) call F1F2QE09(z_c,a_c,q2,w2,F1c_qe,F2c_qe)          ! Get QE  F1 & F2 for 12C
            if (lumi_d.gt.0) call F1F2IN09(z_d,a_d,q2,w2,F1d_ie,F2d_ie,rc)       ! Get DIS F1 & F2 for 2H
            if (lumi_he.gt.0) call F1F2IN09(z_he,a_he,q2,w2,F1he_ie,F2he_ie,rche) ! Get DIS F1 & F2 for 4He
            if (lumi_li.gt.0) call F1F2IN09(z_li,a_li,q2,w2,F1li_ie,F2li_ie,rcli) ! Get DIS F1 & F2 for 4He
            if (lumi_n.gt.0) call F1F2IN09(z_n,a_n,q2,w2,F1n_ie,F2n_ie,rcn)      ! Get DIS F1 & F2 for 14N
            if (lumi_c.gt.0) call F1F2IN09(z_c,a_c,q2,w2,F1c_ie,F2c_ie,rcc)      ! Get DIS F1 & F2 for 12C
            if (x.ge.0.75.and.x.le.5.0) then   ! If QE:
                call get_qe_b1d(x,q2,Aout,F1out,b1out)
            elseif (x.lt.0.75.and.x.gt.0) then ! If DIS:
                call get_b1d(x,q2,Aout,F1out,b1out)
            endif

c vvvv VERY PRELIMINARY PLATEAU CHANGES WIth Q^2 vvvvvvvvv



c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
            if (.not.(F1d_ie.gt.0)) F1d_ie = 0
            if (.not.(F1d_qe.gt.0)) F1d_qe = 0
            if (.not.(F1n_ie.gt.0)) F1n_ie = 0
            if (.not.(F1n_qe.gt.0)) F1n_qe = 0
            if (.not.(F1c_ie.gt.0)) F1c_ie = 0
            if (.not.(F1c_qe.gt.0)) F1c_qe = 0
            if (.not.(F1he_ie.gt.0)) F1he_ie = 0
            if (.not.(F1he_qe.gt.0)) F1he_qe = 0
            if (.not.(F1li_ie.gt.0)) F1li_ie = 0
            if (.not.(F1li_qe.gt.0)) F1li_qe = 0
            if (.not.(F2d_ie.gt.0)) F2d_ie = 0
            if (.not.(F2d_qe.gt.0)) F2d_qe = 0
            if (.not.(F2n_ie.gt.0)) F2n_ie = 0
            if (.not.(F2n_qe.gt.0)) F2n_qe = 0
            if (.not.(F2c_ie.gt.0)) F2c_ie = 0
            if (.not.(F2c_qe.gt.0)) F2c_qe = 0
            if (.not.(F2he_ie.gt.0)) F2he_ie = 0
            if (.not.(F2he_qe.gt.0)) F2he_qe = 0
            if (.not.(F2li_ie.gt.0)) F2li_ie = 0
            if (.not.(F2li_qe.gt.0)) F2li_qe = 0
            write(6,1010) "Second cross-section measurement...",
     &           ispectro,ib,0,"(",11,0,")"
            sigma_unpol=0; sigma_unpol_d=0; sigma_unpol_n=0;
            sigma_unpol_li=0; sigma_unpol_he=0; sigma_unpol_c=0;
            if (csmodel.eq.'Bosted_full') then
               sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                            + ((F2d_ie+F2d_qe)/2.)/nu)
               sigma_unpol_d  =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                            + ((F2d_ie+F2d_qe)/2.)/nu)
               sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+F1li_qe)/6.)*tnsq/mp
     +                            + ((F2li_ie+F2li_qe)/6.)/nu)
               sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+F1he_qe)/4.)*tnsq/mp
     +                         + ((F2he_ie+F2he_qe)/4.)/nu)
               sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+F1n_qe)/14.)*tnsq/mp
     +                            + ((F2n_ie+F2n_qe)/14.)/nu)
               sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+F1c_qe)/12.)*tnsq/mp
     +                            + ((F2c_ie+F2c_qe)/12.)/nu)
            endif
            if (csmodel.eq.'Bosted_dis') then
               sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+0)/2.)*tnsq/mp
     +                            + ((F2d_ie+0)/2.)/nu)
               sigma_unpol_d  =  2.*mott_p*(2.*((F1d_ie+0)/2.)*tnsq/mp
     +                            + ((F2d_ie+0)/2.)/nu)
               sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+0)/6.)*tnsq/mp
     +                            + ((F2li_ie+0)/6.)/nu)
               sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+0)/4.)*tnsq/mp
     +                         + ((F2he_ie+0)/4.)/nu)
               sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+0)/14.)*tnsq/mp
     +                            + ((F2n_ie+0)/14.)/nu)
               sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+0)/12.)*tnsq/mp
     +                            + ((F2c_ie+0)/12.)/nu)
            endif
            if (csmodel.eq.'Bosted_qe') then
               sigma_unpol    =  2.*mott_p*(2.*((0+F1d_qe)/2.)*tnsq/mp
     +                            + ((0+F2d_qe)/2.)/nu)
               sigma_unpol_d  =  2.*mott_p*(2.*((0+F1d_qe)/2.)*tnsq/mp
     +                            + ((0+F2d_qe)/2.)/nu)
               sigma_unpol_li =  6.*mott_p*(2.*((0+F1li_qe)/6.)*tnsq/mp
     +                            + ((0+F2li_qe)/6.)/nu)
               sigma_unpol_he =  4.*mott_p*(2.*((0+F1he_qe)/4.)*tnsq/mp
     +                            + ((0+F2he_qe)/4.)/nu)
               sigma_unpol_n  = 14.*mott_p*(2.*((0+F1n_qe)/14.)*tnsq/mp
     +                            + ((0+F2n_qe)/14.)/nu)
               sigma_unpol_c  = 12.*mott_p*(2.*((0+F1c_qe)/12.)*tnsq/mp
     +                            + ((0+F2c_qe)/12.)/nu)
            endif
            if (csmodel.eq.'Sargsian'.and.q2.lt.10) then
                     if(x.lt.1.1.or.x.gt.3.00.or.x.eq.3.0.or.e_in.lt.3.0) then
                        sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                                     + ((F2d_ie+F2d_qe)/2.)/nu)
                        sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+F1li_qe)/6.)*tnsq/mp
     +                                     + ((F2li_ie+F2li_qe)/6.)/nu)
                        sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+F1he_qe)/4.)*tnsq/mp
     +                                     + ((F2he_ie+F2he_qe)/4.)/nu)
                        sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+F1n_qe)/14.)*tnsq/mp
     +                                     + ((F2n_ie+F2n_qe)/14.)/nu)
                        sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+F1c_qe)/12.)*tnsq/mp
     +                                     + ((F2c_ie+F2c_qe)/12.)/nu)
                     elseif ((x.gt.1.1.or.x.eq.1.1).and.x.lt.3.0.and.e_in.gt.3.0) then
                        if (qqval2(1).eq.99.and.xval2(1).eq.100) ep_in1 = ep_in2
                        if (lumi_d.gt.0) call init_incl(e_in,ep_in1,th_in1,x,a_d,z_d,sigma_unpol)
                        if (lumi_li.gt.0) call init_incl(e_in,ep_in1,th_in1,x,a_li,z_li,sigma_unpol_li)
                        if (lumi_he.gt.0) call init_incl(e_in,ep_in1,th_in1,x,a_he,z_he,sigma_unpol_he)
                        if (lumi_n.gt.0) call init_incl(e_in,ep_in1,th_in1,x,a_n,z_n,sigma_unpol_n)
                        if (lumi_c.gt.0) call init_incl(e_in,ep_in1,th_in1,x,a_c,z_c,sigma_unpol_c)

                    endif
               sigma_unpol_d  = sigma_unpol
            endif

            sigma_pol_d    = sigma_unpol_d*(1+0.5*Pzz*Aout)

            f_dil = (lumi_d*sigma_unpol_d)/(lumi_he*sigma_unpol_he 
     +                + lumi_heli*sigma_unpol_he
     +                + lumi_n*sigma_unpol_n
     +                + lumi_d*sigma_unpol_d
     +                + lumi_li*sigma_unpol_li)
            write(6,*)"x = ",x
            write(6,*)"sigma_unpol_d = ",sigma_unpol_d
            write(6,*)"lumi_d*sigma_unpol_d = ",lumi_d*sigma_unpol_d
            write(6,*)"lumi_he*sigma_unpol_he = ",lumi_he*sigma_unpol_he
            write(6,*)"lumi_heli*sigma_unpol_he = ",lumi_he*sigma_unpol_he
            write(6,*)"lumi_n*sigma_unpol_n = ",lumi_n*sigma_unpol_n
            write(6,*)"lumi_li*sigma_unpol_li = ",lumi_li*sigma_unpol_li
            
c                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^



c            dAzz = (4./(f_dil*Pzz))*(1/SQRT(Ntotal_for_x(ib)))
            dAzz = (2./(f_dil*Pzz))*SQRT(Ntotal_for_x(ib)/Nunpoltotal_for_x(ib)**2
     +                 + Ntotal_for_x(ib)**2/Nunpoltotal_for_x(ib)**3)
            write(6,*)"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! dAzz = ",dAzz
            write(6,*)"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! f_dil = ",f_dil
            write(6,*)"!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!! Pzz = ",Pzz
            write(6,*)"!!!!!!!!!!!!!!!! Ntotal_for_x(",ib,") = ",Ntotal_for_x(ib)
            write(6,*)"!!!!!!!!!!! Nunpoltotal_for_x(",ib,") = ",Nunpoltotal_for_x(ib)

c            dAzz = sqrt(Aout**2)*0.092
            db1d  = abs(-1.5*dAzz)*(F1d_ie+F1d_qe)/2

            dAzz_drift(ib) = dAzz_drift(ib)/Ntotal_for_x(ib)

            syst_Azz = sqrt((Aout*dAzz_rel)**2 + dAzz_drift(ib)**2)
c            syst_b1d = abs(-1.5*syst_Azz)*F1d/2
            if (e_in.eq.8.8) then
               if (cent_x(ib).eq.0.8)  Aout = -6.2808628/43.223160
               if (cent_x(ib).eq.0.9)  Aout =  8.9649267/217.15784
               if (cent_x(ib).eq.1.01) Aout =  47.345345/656.46704
               if (cent_x(ib).eq.1.1)  Aout =  3.9828267/271.58017
               if (cent_x(ib).eq.1.2)  Aout = -14.298948/84.742477
               if (cent_x(ib).eq.1.3)  Aout = -14.969424/33.356781
               if (cent_x(ib).eq.1.4)  Aout = -11.588662/15.864805
               if (cent_x(ib).eq.1.5)  Aout = -7.9374537/8.7540216
               if (cent_x(ib).eq.1.6)  Aout = -4.9408193/5.3990588
               if (cent_x(ib).eq.1.7)  Aout = -2.7280214/3.5652487
               if (cent_x(ib).eq.1.8)  Aout = -1.2216212/2.3818970
            endif
            if (cent_x(ib).ge.0.6) then
c               syst_Azz = Aout*0.1 ! To be fixed later
               syst_Azz = abs(Aout*0.14) ! To be fixed later
            endif
            syst_b1d = abs(-1.5*syst_Azz)*(F1d_ie+F1d_qe)/2
            write(14,1006) 2,cent_x(ib),xdx,dAzz,db1d,
c     &                     total_w_ave(ib),qq,Ntotal_for_x(ib),
     &                     total_w_ave(ib),q2,Ntotal_for_x(ib),
     &                     syst_Azz,syst_b1d,
c     &                     Aout,b1out,
     &                     0.0,b1out,
c     &                     0.75*Aout,b1out,
     &                     sigma_unpol_d,sigma_unpol_n,sigma_unpol_he,
     &                     f_dil,sigma_unpol_li
c            write(14,1006) 2,cent_x(ib),xdx,dAzz,db1d,
c     &                     total_w_ave(ib),qq,Ntotal_for_x(ib),
c     &                     syst_Azz,syst_b1d,
c     &                     1.25*Aout,b1out
c     &                     sigma_unpol_d,sigma_unpol_n,sigma_unpol_he,
c     &                     f_dil

         enddo


c     The section below calculates the dilution factor based on the cross-sections
c     for a large scan in x. To make the code run faster, use:
c        do ib=1,2
c     to actually run the code, use:
c        do ib=0,6000
c     vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
c      do ib=1,2
c     vvvvvvvvvvv SHMS vvvvvvvvvvvvvvvvvvv

c      write(6,*) "Entering Parallel" 

c !$OMP PARALLEL DEFAULT(PRIVATE) FIRSTPRIVATE(e_in,th_in1,d_r,alpha,Pzz,csmodel,z_d,a_d,lumi_d,z_he,a_he,lumi_he,z_n,a_n,lumi_n,a_li,z_li,lumi_li,a_c,z_c,lumi_c)

c !$OMP DO

42    do ib=10,400
c      write(6,*)"ib",ib

c         e_in    = 11.0 ! GeV
c         e_in    = 6.6 ! GeV
c         e_in    = 6.519 ! GeV
c         e_in    = 11.671 ! GeV
c         e_in    = 5.766 ! GeV
c         e_in    = 1.245  ! GeV
c         ep_in1  = e_in - ib*0.001 ! GeV
         x       = ib*0.01
c         th_in1  = 17.00 ! Degrees
c         th_in1  = 8.00 ! Degrees
c         ep_in1  = 4.045 ! GeV
c         write(6,*) "th_in1 = ", th_in1
         thrad   = th_in1*d_r
         snsq    = sin(thrad/2.)**2.
         cssq    = cos(thrad/2.)**2.
         tnsq    = tan(thrad/2.)**2.
         ep_in1 = e_in/(1+(4*e_in*snsq)/(2*mp*x))
         nu      = e_in - ep_in1
         q2      = 4.*e_in*ep_in1*snsq
c         x       = q2/(2.*mp*nu)
c         x       = cent_x(ib)
         w2      = mp*mp + q2/x - q2
         xplat=1.64203-0.177032*log(q2)
c           vvv The Mott cross sections below are in barns (1E-24 cm^2)
         mott_p  = hbarc2*((1*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c         mott_d  = hbarc2*((1*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c         mott_he = hbarc2*((2*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c         mott_li = hbarc2*((3*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c         mott_n  = hbarc2*((7*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
c         mott_c  = hbarc2*((6*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
         b1out   = 0; Aout    = 0; F1out = 0;
         F1      = 0; F2      = 0; F1n    = 0; F2n    = 0;
         F1n_qe  = 0; F2n_qe  = 0; F1c_qe = 0; F2c_qe = 0;
         F1n_ie  = 0; F2n_ie  = 0; F1c_ie = 0; F2c_ie = 0;
         F1he    = 0; F2he    = 0; F1d    = 0; F2d    = 0;
         F1he_qe = 0; F2he_qe = 0; F1d_qe = 0; F2d_qe = 0;
         F1he_ie = 0; F2he_ie = 0; F1d_ie = 0; F2d_ie = 0;
         F1li    = 0; F2li    = 0; 
         F1li_qe = 0; F2li_qe = 0;
         F1li_ie = 0; F2li_ie = 0; rcli   = 0;
         rc      = 0; rche    = 0; rcn    = 0; rcc    = 0;

c !$OMP CRITICAL
         if (x.ge.0.75.and.x.le.5.0) then       ! If Quasi-Elastic:
             call get_qe_b1d(x,q2,Aout,F1out,b1out)
         elseif (x.lt.0.75.and.x.gt.0) then          ! If DIS:
             call get_b1d(x,q2,Aout,F1out,b1out)
         endif
c !$OMP END CRITICAL

         if(csmodel.eq.'Bosted_full'.or.csmodel.eq.'Bosted_dis'.or.csmodel.eq.'Bosted_qe') then


            if (lumi_d.gt.0) call F1F2QE09(z_d,a_d,q2,w2,F1d_qe,F2d_qe)     !      Get F1 for Deuterium
            if (lumi_he.gt.0) call F1F2QE09(z_he,a_he,q2,w2,F1he_qe,F2he_qe) !      Get F1 and F2 for Helium-4
            if (lumi_li.gt.0) call F1F2QE09(z_li,a_li,q2,w2,F1li_qe,F2li_qe) !      Get F1 and F2 for Lithium-6
            if (lumi_n.gt.0) call F1F2QE09(z_n,a_n,q2,w2,F1n_qe,F2n_qe)     !      Get F1 and F2 for Nitrogen-14
            if (lumi_c.gt.0) call F1F2QE09(z_c,a_c,q2,w2,F1c_qe,F2c_qe)     !      Get F1 and F2 for Carbon-12
            if (lumi_d.gt.0) call F1F2IN09(z_d,a_d,q2,w2,F1d_ie,F2d_ie,rc)       !      Get F1 for Deuterium
            if (lumi_he.gt.0) call F1F2IN09(z_he,a_he,q2,w2,F1he_ie,F2he_ie,rche) !      Get F1 for Helium-4
            if (lumi_li.gt.0) call F1F2IN09(z_li,a_li,q2,w2,F1li_ie,F2li_ie,rcli) !      Get F1 for Lithium-6
            if (lumi_n.gt.0) call F1F2IN09(z_n,a_n,q2,w2,F1n_ie,F2n_ie,rcn)      !      Get F1 for Nitrogen-14
            if (lumi_c.gt.0) call F1F2IN09(z_c,a_c,q2,w2,F1c_ie,F2c_ie,rcc)      !      Get F1 for Carbon-12
   
            if (.not.(F1d_ie.gt.0)) F1d_ie = 0
            if (.not.(F1d_qe.gt.0)) F1d_qe = 0
            if (.not.(F1n_ie.gt.0)) F1n_ie = 0
            if (.not.(F1n_qe.gt.0)) F1n_qe = 0
            if (.not.(F1c_ie.gt.0)) F1c_ie = 0
            if (.not.(F1c_qe.gt.0)) F1c_qe = 0
            if (.not.(F1he_ie.gt.0)) F1he_ie = 0
            if (.not.(F1he_qe.gt.0)) F1he_qe = 0
            if (.not.(F1li_ie.gt.0)) F1li_ie = 0
            if (.not.(F1li_qe.gt.0)) F1li_qe = 0
            if (.not.(F2d_ie.gt.0)) F2d_ie = 0
            if (.not.(F2d_qe.gt.0)) F2d_qe = 0
            if (.not.(F2n_ie.gt.0)) F2n_ie = 0
            if (.not.(F2n_qe.gt.0)) F2n_qe = 0
            if (.not.(F2c_ie.gt.0)) F2c_ie = 0
            if (.not.(F2c_qe.gt.0)) F2c_qe = 0
            if (.not.(F2he_ie.gt.0)) F2he_ie = 0
            if (.not.(F2he_qe.gt.0)) F2he_qe = 0
            if (.not.(F2li_ie.gt.0)) F2li_ie = 0
            if (.not.(F2li_qe.gt.0)) F2li_qe = 0
         endif

         write(6,1010) "Third cross-section measurement...",
     &         ispectro,ib,0,"(",200,0,")"
         sigma_unpol=0; sigma_unpol_d=0; sigma_unpol_n=0;
         sigma_unpol_li=0; sigma_unpol_he=0; sigma_unpol_c=0;
         if (csmodel.eq.'Bosted_full') then
            sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                         + ((F2d_ie+F2d_qe)/2.)/nu)
            sigma_unpol_d  =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                         + ((F2d_ie+F2d_qe)/2.)/nu)
            sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+F1li_qe)/6.)*tnsq/mp
     +                         + ((F2li_ie+F2li_qe)/6.)/nu)
            sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+F1he_qe)/4.)*tnsq/mp
     +                      + ((F2he_ie+F2he_qe)/4.)/nu)
            sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+F1n_qe)/14.)*tnsq/mp
     +                         + ((F2n_ie+F2n_qe)/14.)/nu)
            sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+F1c_qe)/12.)*tnsq/mp
     +                         + ((F2c_ie+F2c_qe)/12.)/nu)
         endif
         if (csmodel.eq.'Bosted_dis') then
            sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+0)/2.)*tnsq/mp
     +                         + ((F2d_ie+0)/2.)/nu)
            sigma_unpol_d  =  2.*mott_p*(2.*((F1d_ie+0)/2.)*tnsq/mp
     +                         + ((F2d_ie+0)/2.)/nu)
            sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+0)/6.)*tnsq/mp
     +                         + ((F2li_ie+0)/6.)/nu)
            sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+0)/4.)*tnsq/mp
     +                      + ((F2he_ie+0)/4.)/nu)
            sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+0)/14.)*tnsq/mp
     +                         + ((F2n_ie+0)/14.)/nu)
            sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+0)/12.)*tnsq/mp
     +                         + ((F2c_ie+0)/12.)/nu)
         endif
         if (csmodel.eq.'Bosted_qe') then
            sigma_unpol    =  2.*mott_p*(2.*((0+F1d_qe)/2.)*tnsq/mp
     +                         + ((0+F2d_qe)/2.)/nu)
            sigma_unpol_d  =  2.*mott_p*(2.*((0+F1d_qe)/2.)*tnsq/mp
     +                         + ((0+F2d_qe)/2.)/nu)
            sigma_unpol_li =  6.*mott_p*(2.*((0+F1li_qe)/6.)*tnsq/mp
     +                         + ((0+F2li_qe)/6.)/nu)
            sigma_unpol_he =  4.*mott_p*(2.*((0+F1he_qe)/4.)*tnsq/mp
     +                         + ((0+F2he_qe)/4.)/nu)
            sigma_unpol_n  = 14.*mott_p*(2.*((0+F1n_qe)/14.)*tnsq/mp
     +                         + ((0+F2n_qe)/14.)/nu)
            sigma_unpol_c  = 12.*mott_p*(2.*((0+F1c_qe)/12.)*tnsq/mp
     +                         + ((0+F2c_qe)/12.)/nu)
         endif
         if (csmodel.eq.'Sargsian'.and.q2.lt.10) then
c !$OMP CRITICAL
            if(x.lt.1.1.or.x.gt.3.0.or.x.eq.3.0.or.e_in.lt.3.0) then
               if (lumi_d.gt.0) call F1F2QE09(z_d,a_d,q2,w2,F1d_qe,F2d_qe)     !      Get F1 for Deuterium
               if (lumi_he.gt.0) call F1F2QE09(z_he,a_he,q2,w2,F1he_qe,F2he_qe) !      Get F1 and F2 for Helium-4
               if (lumi_li.gt.0) call F1F2QE09(z_li,a_li,q2,w2,F1li_qe,F2li_qe) !      Get F1 and F2 for Lithium-6
               if (lumi_n.gt.0) call F1F2QE09(z_n,a_n,q2,w2,F1n_qe,F2n_qe)     !      Get F1 and F2 for Nitrogen-14
               if (lumi_c.gt.0) call F1F2QE09(z_c,a_c,q2,w2,F1c_qe,F2c_qe)     !      Get F1 and F2 for Carbon-12
               if (lumi_d.gt.0) call F1F2IN09(z_d,a_d,q2,w2,F1d_ie,F2d_ie,rc)       !      Get F1 for Deuterium
               if (lumi_he.gt.0) call F1F2IN09(z_he,a_he,q2,w2,F1he_ie,F2he_ie,rche) !      Get F1 for Helium-4
               if (lumi_li.gt.0) call F1F2IN09(z_li,a_li,q2,w2,F1li_ie,F2li_ie,rcli) !      Get F1 for Lithium-6
               if (lumi_n.gt.0) call F1F2IN09(z_n,a_n,q2,w2,F1n_ie,F2n_ie,rcn)      !      Get F1 for Nitrogen-14
               if (lumi_c.gt.0) call F1F2IN09(z_c,a_c,q2,w2,F1c_ie,F2c_ie,rcc)      !      Get F1 for Carbon-12
               if (.not.(F1d_ie.gt.0)) F1d_ie = 0
               if (.not.(F1d_qe.gt.0)) F1d_qe = 0
               if (.not.(F1n_ie.gt.0)) F1n_ie = 0
               if (.not.(F1n_qe.gt.0)) F1n_qe = 0
               if (.not.(F1c_ie.gt.0)) F1c_ie = 0
               if (.not.(F1c_qe.gt.0)) F1c_qe = 0
               if (.not.(F1he_ie.gt.0)) F1he_ie = 0
               if (.not.(F1he_qe.gt.0)) F1he_qe = 0
               if (.not.(F1li_ie.gt.0)) F1li_ie = 0
               if (.not.(F1li_qe.gt.0)) F1li_qe = 0
               if (.not.(F2d_ie.gt.0)) F2d_ie = 0
               if (.not.(F2d_qe.gt.0)) F2d_qe = 0
               if (.not.(F2n_ie.gt.0)) F2n_ie = 0
               if (.not.(F2n_qe.gt.0)) F2n_qe = 0
               if (.not.(F2c_ie.gt.0)) F2c_ie = 0
               if (.not.(F2c_qe.gt.0)) F2c_qe = 0
               if (.not.(F2he_ie.gt.0)) F2he_ie = 0
               if (.not.(F2he_qe.gt.0)) F2he_qe = 0
               if (.not.(F2li_ie.gt.0)) F2li_ie = 0
               if (.not.(F2li_qe.gt.0)) F2li_qe = 0

               sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                            + ((F2d_ie+F2d_qe)/2.)/nu)
               sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+F1li_qe)/6.)*tnsq/mp
     +                            + ((F2li_ie+F2li_qe)/6.)/nu)
               sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+F1he_qe)/4.)*tnsq/mp
     +                            + ((F2he_ie+F2he_qe)/4.)/nu)
               sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+F1n_qe)/14.)*tnsq/mp
     +                            + ((F2n_ie+F2n_qe)/14.)/nu)
               sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+F1c_qe)/12.)*tnsq/mp
     +                            + ((F2c_ie+F2c_qe)/12.)/nu)
            elseif((x.gt.1.1.or.x.eq.1.1).and.x.lt.3.0.and.e_in.gt.3.0) then
               if (lumi_d.gt.0) call init_incl(e_in,ep_in1,th_in1,x,a_d,z_d,sigma_unpol)
               if (lumi_li.gt.0) call init_incl(e_in,ep_in1,th_in1,x,a_li,z_li,sigma_unpol_li)
               if (lumi_he.gt.0) call init_incl(e_in,ep_in1,th_in1,x,a_he,z_he,sigma_unpol_he)
               if (lumi_n.gt.0) call init_incl(e_in,ep_in1,th_in1,x,a_n,z_n,sigma_unpol_n)
               if (lumi_c.gt.0) call init_incl(e_in,ep_in1,th_in1,x,a_c,z_c,sigma_unpol_c)
            endif
c !$OMP END CRITICAL
            sigma_unpol_d  = sigma_unpol
         endif
         if (x.gt.0) then
               call elastic(z_d,a_d,q2,thrad,e_in,sigma_unpol_d)
               call elastic(z_li,a_li,q2,thrad,e_in,sigma_unpol_li)
               call elastic(z_he,a_he,q2,thrad,e_in,sigma_unpol_he)
               call elastic(z_n,a_n,q2,thrad,e_in,sigma_unpol_n)
               call elastic(z_c,a_c,q2,thrad,e_in,sigma_unpol_c)
         endif

c         sigma_unpol_d  = 2*mott_p
c         write(6,*) "sigma_unpol_d = ",sigma_unpol_d

         sigma_pol_d    = sigma_unpol_d*(1+0.5*Pzz*Aout)


         lumsig_p_d  = lumi_d*sigma_pol_d
         lumsig_u_d  = lumi_d*sigma_unpol_d
         lumsig_he   = lumi_he*sigma_unpol_he
         lumsig_n    = lumi_n*sigma_unpol_n
         lumsig_c    = lumi_c*sigma_unpol_c
         lumsig_li   = lumi_li*sigma_unpol_li
         lumsig_heli = lumi_heli*sigma_unpol_he + lumi_heli*sigma_unpol_d
c         lumsig_heli = lumi_heli*sigma_unpol_he


c         if (x.lt.xplat) then
              f_dil = (lumi_d*sigma_unpol_d)/(lumi_he*sigma_unpol_he 
     +                  + lumi_heli*sigma_unpol_he
     +                  + lumi_li*sigma_unpol_li
     +                  + lumi_n*sigma_unpol_n
     +                  + lumi_d*sigma_unpol_d)
c              fplat = f_dil
c         else
c              f_dil = fplat
c         endif


         src_ratio_n  = (sigma_unpol_n /sigma_unpol_d)*(a_d/a_n)
         src_ratio_he = (sigma_unpol_he/sigma_unpol_d)*(a_d/a_he)
         src_ratio_c  = (sigma_unpol_c /sigma_unpol_d)*(a_d/a_c)

         write(16,1008) x,q2,th_in1,e_in,ep_in1,nu,w2,
     &                  sigma_pol_d,
     &                  sigma_unpol_d,sigma_unpol_n,sigma_unpol_he,
     &                  f_dil,sigma_unpol_c,
     &                  src_ratio_n,src_ratio_he,src_ratio_c,
     &                  sigma_unpol_li,
     &                  lumsig_p_d,lumsig_u_d,lumsig_he,
     &                  lumsig_n,lumsig_c,lumsig_li,lumsig_heli
         write(17,1008) x,q2,th_in1,e_in,ep_in1,nu,w2,
     &                  sigma_pol_d,
     &                  sigma_unpol_d,sigma_unpol_n,sigma_unpol_he,
     &                  f_dil,sigma_unpol_c,
     &                  src_ratio_n,src_ratio_he,src_ratio_c,
     &                  sigma_unpol_li,
     &                  lumsig_p_d,lumsig_u_d,lumsig_he,
     &                  lumsig_n,lumsig_c,lumsig_li,lumsig_heli
 
      enddo     

      if (test.eq.1.) GOTO 43

      write(6,*) "ispectro = ",ispectro
c     ^^^^^^^^^^^ SHMS ^^^^^^^^^^^^^^^^^^^

c     vvvvvvvvvvvv HMS vvvvvvvvvvvvvvvvvvv
c       do ib=10,300
       do ib=10,300
c         e_in    = 11.0 ! GeV
c         e_in    = 6.6 ! GeV
c         e_in    = 6.519 ! GeV
c         e_in    = 11.671 ! GeV
c         e_in    = 5.766 ! GeV
c         ep_in1  = e_in - ib*0.001 ! GeV
         x       = ib*0.01
c         th_in1  = 18.00 ! Degrees
c         ep_in1  = 5.80 ! GeV
         thrad   = th_in2*d_r
         snsq    = sin(thrad/2.)**2.
         cssq    = cos(thrad/2.)**2.
         tnsq    = tan(thrad/2.)**2.
         ep_in2 = e_in/(1+(4*e_in*snsq)/(2*mp*x))
         nu      = e_in - ep_in2
         q2      = 4.*e_in*ep_in2*snsq
c         x       = q2/(2.*mp*nu)
c         x       = cent_x(ib)
         w2      = mp*mp + q2/x - q2
         xplat=1.64203-0.177032*log(q2)
c           vvv The Mott cross sections below are in barns (1E-24 cm^2)
         mott_p  = hbarc2*((1*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
         mott_d  = hbarc2*((1*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
         mott_he = hbarc2*((2*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
         mott_li = hbarc2*((3*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
         mott_n  = hbarc2*((7*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
         mott_c  = hbarc2*((6*alpha*cos(thrad/2.)/(2.*e_in*snsq))**2.)
         b1out   = 0; Aout    = 0; F1out = 0;
         F1      = 0; F2      = 0; F1n    = 0; F2n    = 0;
         F1n_qe  = 0; F2n_qe  = 0; F1c_qe = 0; F2c_qe = 0;
         F1n_ie  = 0; F2n_ie  = 0; F1c_ie = 0; F2c_ie = 0;
         F1he    = 0; F2he    = 0; F1d    = 0; F2d    = 0;
         F1he_qe = 0; F2he_qe = 0; F1d_qe = 0; F2d_qe = 0;
         F1he_ie = 0; F2he_ie = 0; F1d_ie = 0; F2d_ie = 0;
         F1li    = 0; F2li    = 0; 
         F1li_qe = 0; F2li_qe = 0;
         F1li_ie = 0; F2li_ie = 0; rcli   = 0;
         rc      = 0; rche    = 0; rcn    = 0; rcc    = 0;
         if (lumi_d.gt.0) call F1F2QE09(z_d,a_d,q2,w2,F1d_qe,F2d_qe)     !      Get F1 for Deuterium
         if (lumi_he.gt.0) call F1F2QE09(z_he,a_he,q2,w2,F1he_qe,F2he_qe) !      Get F1 and F2 for Helium-4
         if (lumi_li.gt.0) call F1F2QE09(z_li,a_li,q2,w2,F1li_qe,F2li_qe) !      Get F1 and F2 for Helium-4
         if (lumi_n.gt.0) call F1F2QE09(z_n,a_n,q2,w2,F1n_qe,F2n_qe)     !      Get F1 and F2 for Nitrogen-14
         if (lumi_c.gt.0) call F1F2QE09(z_c,a_c,q2,w2,F1c_qe,F2c_qe)     !      Get F1 and F2 for Nitrogen-14
         if (lumi_d.gt.0) call F1F2IN09(z_d,a_d,q2,w2,F1d_ie,F2d_ie,rc)       !      Get F1 for Deuterium
         if (lumi_he.gt.0) call F1F2IN09(z_he,a_he,q2,w2,F1he_ie,F2he_ie,rche) !      Get F1 for Helium-4
         if (lumi_li.gt.0) call F1F2IN09(z_li,a_li,q2,w2,F1li_ie,F2li_ie,rcli) !      Get F1 for Helium-4
         if (lumi_n.gt.0) call F1F2IN09(z_n,a_n,q2,w2,F1n_ie,F2n_ie,rcn)      !      Get F1 for Nitrogen-14
         if (lumi_c.gt.0) call F1F2IN09(z_c,a_c,q2,w2,F1c_ie,F2c_ie,rcc)      !      Get F1 for Nitrogen-14
         if (x.ge.0.75.and.x.le.5.0) then       ! If Quasi-Elastic:
             call get_qe_b1d(x,q2,Aout,F1out,b1out)
         elseif (x.lt.0.75.and.x.gt.0) then          ! If DIS:
             call get_b1d(x,q2,Aout,F1out,b1out)
         endif
         if (.not.(F1d_ie.gt.0)) F1d_ie = 0
         if (.not.(F1d_qe.gt.0)) F1d_qe = 0
         if (.not.(F1n_ie.gt.0)) F1n_ie = 0
         if (.not.(F1n_qe.gt.0)) F1n_qe = 0
         if (.not.(F1c_ie.gt.0)) F1c_ie = 0
         if (.not.(F1c_qe.gt.0)) F1c_qe = 0
         if (.not.(F1he_ie.gt.0)) F1he_ie = 0
         if (.not.(F1he_qe.gt.0)) F1he_qe = 0
         if (.not.(F1he_ie.gt.0)) F1he_ie = 0
         if (.not.(F1li_qe.gt.0)) F1li_qe = 0
         if (.not.(F2d_ie.gt.0)) F2d_ie = 0
         if (.not.(F2d_qe.gt.0)) F2d_qe = 0
         if (.not.(F2n_ie.gt.0)) F2n_ie = 0
         if (.not.(F2n_qe.gt.0)) F2n_qe = 0
         if (.not.(F2c_ie.gt.0)) F2c_ie = 0
         if (.not.(F2c_qe.gt.0)) F2c_qe = 0
         if (.not.(F2he_ie.gt.0)) F2he_ie = 0
         if (.not.(F2he_qe.gt.0)) F2he_qe = 0
         if (.not.(F2li_ie.gt.0)) F2li_ie = 0
         if (.not.(F2li_qe.gt.0)) F2li_qe = 0
         write(6,1010) "Fourth cross-section measurement...",
     &        ispectro,ib,0,"(",200,0,")"
         sigma_unpol=0; sigma_unpol_d=0; sigma_unpol_n=0;
         sigma_unpol_li=0; sigma_unpol_he=0; sigma_unpol_c=0;
         if (csmodel.eq.'Bosted_full') then
            sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                         + ((F2d_ie+F2d_qe)/2.)/nu)
            sigma_unpol_d  =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                         + ((F2d_ie+F2d_qe)/2.)/nu)
            sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+F1li_qe)/6.)*tnsq/mp
     +                         + ((F2li_ie+F2li_qe)/6.)/nu)
            sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+F1he_qe)/4.)*tnsq/mp
     +                      + ((F2he_ie+F2he_qe)/4.)/nu)
            sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+F1n_qe)/14.)*tnsq/mp
     +                         + ((F2n_ie+F2n_qe)/14.)/nu)
            sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+F1c_qe)/12.)*tnsq/mp
     +                         + ((F2c_ie+F2c_qe)/12.)/nu)
         endif
         if (csmodel.eq.'Bosted_dis') then
            sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+0)/2.)*tnsq/mp
     +                         + ((F2d_ie+0)/2.)/nu)
            sigma_unpol_d  =  2.*mott_p*(2.*((F1d_ie+0)/2.)*tnsq/mp
     +                         + ((F2d_ie+0)/2.)/nu)
            sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+0)/6.)*tnsq/mp
     +                         + ((F2li_ie+0)/6.)/nu)
            sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+0)/4.)*tnsq/mp
     +                      + ((F2he_ie+0)/4.)/nu)
            sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+0)/14.)*tnsq/mp
     +                         + ((F2n_ie+0)/14.)/nu)
            sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+0)/12.)*tnsq/mp
     +                         + ((F2c_ie+0)/12.)/nu)
         endif
         if (csmodel.eq.'Bosted_qe') then
            sigma_unpol    =  2.*mott_p*(2.*((0+F1d_qe)/2.)*tnsq/mp
     +                         + ((0+F2d_qe)/2.)/nu)
            sigma_unpol_d  =  2.*mott_p*(2.*((0+F1d_qe)/2.)*tnsq/mp
     +                         + ((0+F2d_qe)/2.)/nu)
            sigma_unpol_li =  6.*mott_p*(2.*((0+F1li_qe)/6.)*tnsq/mp
     +                         + ((0+F2li_qe)/6.)/nu)
            sigma_unpol_he =  4.*mott_p*(2.*((0+F1he_qe)/4.)*tnsq/mp
     +                         + ((0+F2he_qe)/4.)/nu)
            sigma_unpol_n  = 14.*mott_p*(2.*((0+F1n_qe)/14.)*tnsq/mp
     +                         + ((0+F2n_qe)/14.)/nu)
            sigma_unpol_c  = 12.*mott_p*(2.*((0+F1c_qe)/12.)*tnsq/mp
     +                         + ((0+F2c_qe)/12.)/nu)
         endif
         if (csmodel.eq.'Sargsian'.and.q2.lt.10) then
            if(x.lt.1.1.or.x.gt.3.0.or.x.eq.3.0.or.e_in.lt.3.0) then
               sigma_unpol    =  2.*mott_p*(2.*((F1d_ie+F1d_qe)/2.)*tnsq/mp
     +                            + ((F2d_ie+F2d_qe)/2.)/nu)
               sigma_unpol_li =  6.*mott_p*(2.*((F1li_ie+F1li_qe)/6.)*tnsq/mp
     +                            + ((F2li_ie+F2li_qe)/6.)/nu)
               sigma_unpol_he =  4.*mott_p*(2.*((F1he_ie+F1he_qe)/4.)*tnsq/mp
     +                            + ((F2he_ie+F2he_qe)/4.)/nu)
               sigma_unpol_n  = 14.*mott_p*(2.*((F1n_ie+F1n_qe)/14.)*tnsq/mp
     +                            + ((F2n_ie+F2n_qe)/14.)/nu)
               sigma_unpol_c  = 12.*mott_p*(2.*((F1c_ie+F1c_qe)/12.)*tnsq/mp
     +                            + ((F2c_ie+F2c_qe)/12.)/nu)
            elseif((x.gt.1.1.or.x.eq.1.1).and.x.lt.3.0.and.e_in.gt.3.0) then
               if (lumi_d.gt.0) call init_incl(e_in,ep_in2,th_in2,x,a_d,z_d,sigma_unpol)
               if (lumi_li.gt.0) call init_incl(e_in,ep_in2,th_in2,x,a_li,z_li,sigma_unpol_li)
               if (lumi_he.gt.0) call init_incl(e_in,ep_in2,th_in2,x,a_he,z_he,sigma_unpol_he)
               if (lumi_n.gt.0) call init_incl(e_in,ep_in2,th_in2,x,a_n,z_n,sigma_unpol_n)
               if (lumi_c.gt.0) call init_incl(e_in,ep_in2,th_in2,x,a_c,z_c,sigma_unpol_c)
            endif
            sigma_unpol_d  = sigma_unpol
         endif

         sigma_pol_d    = sigma_unpol_d*(1+0.5*Pzz*Aout)


         lumsig_p_d  = lumi_d*sigma_pol_d
         lumsig_u_d  = lumi_d*sigma_unpol_d
         lumsig_he   = lumi_he*sigma_unpol_he
         lumsig_n    = lumi_n*sigma_unpol_n
         lumsig_c    = lumi_c*sigma_unpol_c
         lumsig_li   = lumi_li*sigma_unpol_li
         lumsig_heli = lumi_heli*sigma_unpol_he + lumi_heli*sigma_unpol_d
c         lumsig_heli = lumi_heli*sigma_unpol_he

c         if (x.lt.xplat) then
              f_dil = (lumi_d*sigma_unpol_d)/(lumi_he*sigma_unpol_he 
     +                  + lumi_heli*sigma_unpol_he
     +                  + lumi_li*sigma_unpol_li
     +                  + lumi_n*sigma_unpol_n
     +                  + lumi_d*sigma_unpol_d)
c              fplat = f_dil
c         else
c              f_dil = fplat
c         endif

         src_ratio_n  = (sigma_unpol_n /sigma_unpol_d)*(a_d/a_n)
         src_ratio_he = (sigma_unpol_he/sigma_unpol_d)*(a_d/a_he)
         src_ratio_c  = (sigma_unpol_c /sigma_unpol_d)*(a_d/a_c)


         if (qqval2(1).eq.99.and.xval2(1).eq.100) then
            write(16,1008) x,q2,th_in2,e_in,ep_in2,nu,w2,
     &                     sigma_pol_d,
     &                     sigma_unpol_d,sigma_unpol_n,sigma_unpol_he,
     &                     f_dil,sigma_unpol_c,
     &                     src_ratio_n,src_ratio_he,src_ratio_c,
     &                     sigma_unpol_li,
     &                     lumsig_p_d,lumsig_u_d,lumsig_he,
     &                     lumsig_n,lumsig_c,lumsig_li,lumsig_heli
            write(17,1008) x,q2,th_in2,e_in,ep_in2,nu,w2,
     &                     sigma_pol_d,
     &                     sigma_unpol_d,sigma_unpol_n,sigma_unpol_he,
     &                     f_dil,sigma_unpol_c,
     &                     src_ratio_n,src_ratio_he,src_ratio_c,
     &                     sigma_unpol_li,
     &                     lumsig_p_d,lumsig_u_d,lumsig_he,
     &                     lumsig_n,lumsig_c,lumsig_li,lumsig_heli
         endif

         write(18,1008) x,q2,th_in2,e_in,ep_in2,nu,w2,
     &                  sigma_pol_d,
     &                  sigma_unpol_d,sigma_unpol_n,sigma_unpol_he,
     &                  f_dil,sigma_unpol_c,
     &                  src_ratio_n,src_ratio_he,src_ratio_c,
     &                  sigma_unpol_li,
     &                  lumsig_p_d,lumsig_u_d,lumsig_he,
     &                  lumsig_n,lumsig_c,lumsig_li,lumsig_heli

      enddo     

 
c     ^^^^^^^^^^^^ HMS ^^^^^^^^^^^^^^^^^^^

c     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

c     vvvvvvvvvvvvv Reminder output vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
43    write (6,*) "------------------------------------------"
      write (6,*) "Current Central Values are:"
      write (6,*) "------------------------------------------"
      write (6,*) "  HMS:             E'max=7.3  Thmin=12.2"
      write (6,*) "      x         Q2        E'       Th"
      do ib=1,5
         xx = xval1(ib)
         qq = qqval1(ib)
         w     = sqrt(mp**2+qq/xx-qq)
         nu    = qq/2./mp/xx
         w2nn  = 2*nu*md+md**2-qq
         wnn   = sqrt(w2nn)
         y_in  = nu/e_in
         ep_in = e_in - nu
         s2    = qq/4.0/e_in/ep_in
         thrad = 2.*asin(sqrt(s2))
         th_in = thrad/d_r
         if (.not.xx.gt.98) then
            write (6,1009) "",xx,qq,ep_in,th_in,w2nn,wnn
         endif
      enddo
      write (6,*) "------------------------------------------"
      write (6,*) "  SHMS:           E'max=10.4  Thmin=7.3"
      write (6,*) "      x         Q2        E'       Th"
      do ib=1,5
         xx = xval2(ib)
         qq = qqval2(ib)
         w     = sqrt(mp**2+qq/xx-qq)
         nu    = qq/2./mp/xx
         w2nn  = 2*nu*md+md**2-qq
         wnn   = sqrt(w2nn)
         y_in  = nu/e_in
         ep_in = e_in - nu
         s2    = qq/4.0/e_in/ep_in
         thrad = 2.*asin(sqrt(s2))
         th_in = thrad/d_r
         if (.not.xx.gt.98) then
            write (6,1009) "",xx,qq,ep_in,th_in,w2nn,wnn
         endif

      enddo
      write (6,*) "------------------------------------------"
      write (6,*) "Beam E used:",e_in
      write (6,*) "E' used for f_dil:",ep_in1
      write (6,*) "Theta used for f_dil:",th_in1
      write (6,*) "Pzz used:",Pzz_in
      write (6,*) "Target material used:",targ
      if (test.eq.1) then
         write(6,*) "*******************************************"
         write(6,*) "************* TEST MODE ON ****************"
         write(6,*) "*******************************************"
      endif
c     ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

c vvvvv Writes out Q^2-dependent Azz curve vvvvvvvv
      tempqq = qqval2(1)
      if(qqval2(1).eq.99.) tempqq = qqval1(1)
      write (6,*) "qq:",tempqq
      call QE_b1(tempqq)
c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

      call system_clock ( clck_counts_end, clck_rate )
      write(6,*) "-------------------------------------------"
      write(6,*) "Clock (Total):"
      write(6,*) (clck_counts_end - clck_counts_beg) / real (clck_rate)
      call system_clock ( clck_counts_end2, clck_rate2 )
      write(6,*) "-------------------------------------------"
      write(6,*) "Clock (Ignoring input time):"
      write(6,*) (clck_counts_end2 - clck_counts_beg2) / real (clck_rate2)
      write(6,*) "-------------------------------------------"

 1020 continue
      stop
C =========================== Format Statements ================================

 1001 format(a)
c 1002 format(2(i2,1x),f7.3,1x,f6.1,1x,2f7.3,4(1x,E10.3))
 1022 format(A7,1x,E10.3)
 1002 format(5(i2,1x),8(f7.3,1x),3(E10.3,1x),6(E10.3,1x),3(f10.3,1x),5(E10.3,1x))
c 1003 format(2f7.3,1x,f6.1,1x,f7.3,2(1x,E10.3))
 1003 format(i1,2f7.3,1x,f6.1,1x,f7.3,2(1x,E10.3),4(1x,E10.3))
 1004 format(i1,1x,f6.1,1x,f7.3,1x,f7.3,3(1x,E10.3),1x,f7.1,2(1x,E10.3),2(1x,f7.3),4(1x,E10.3))
c 1005 format(i1,f7.2,1x,f6.1,1x,f7.2,1x,f7.2,1x,f7.2,1x,f10.3,4(1x,E10.2),1x,f10.2,2(1x,E10.2))
c 1005 format(i1,f7.2,1x,f6.1,1x,f7.2,1x,f7.2,1x,f7.2,1x,f10.3,4(1x,E10.2),1x,f10.2,2(1x,E10.2),f10.3,1x,f7.3)
 1005 format(i1,f7.2,1x,f6.1,1x,f7.2,1x,f7.2,1x,f7.2,1x,E10.3,4(1x,E10.3),1x,f10.2,2(1x,E10.2),f10.3,1x,f7.3,1x,E10.4,1x,f7.2,1x,f7.2,1x,f7.2,1x,f7.2,1x,f10.2,1x,f10.2,1x,f7.2,3(1x,E10.3),1x,E10.2,3(1x,f7.2),4(1x,E10.3))
c 1005 format(i1,f7.2,1x,f6.1,1x,f7.2,1x,f7.2,1x,f7.2,1x,E10.3,4(1x,E10.2),1x,f10.2,2(1x,E10.2),f10.3,1x,f7.3,1x,E10.4,1x,f7.2,1x,f7.2,1x,f7.2,1x,f7.2,1x,f10.2,1x,f10.2,1x,f7.2)
 1006 format(i1,2(f7.2,1x),2(E10.3,1x),2(f7.2,1x),10(E10.3,1x))
 1007 format(i1,3(f7.2,1x),2(E10.3,1x),2(f7.2,1x),5(E10.3,1x))
 1008 format(24(E10.3,1x))
 1009 format(A1,6(f10.3))
 1010 format(A40,i1," ",i6,i3," ",A1,2(i3),A1)
      end


c The subroutine below rotates theta and phi, which is used to calculate the
c q-vector angle. It was initially developed by Karl Slifer under qvec.f.
c vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
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


c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

c The subroutine below changes the coordinate system from cartesian to spherical,
c which is used to calculate the q-vector. It was initially developed by Karl
c Slifer under qvec.f.
c vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
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
c ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
