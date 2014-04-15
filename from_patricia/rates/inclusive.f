c      PROGRAM main
c         REAL*8 e_in,pit,thit
c         REAL*8 a,z
c         REAL*8 xsec
c         e_in = 6.6
c         pit = 6.108
c         thit = 9.51
c         a = 4
c         z = 2
c         call init_incl(e_in,pit,thit,a,z,xsec)
c         ! write(6,*) "Cross Section:",xsec
c      END

        SUBROUTINE init_incl(e_in,eprime,theta,x_in,a_in,z_in,xsec)
c        PROGRAM init_incl
**********************************************************************
*      Program prepare the initial conditions for inclusive          *
*      (ee') scattering                                              *
*                                                                    *
*      Written:       January 30, 1990                               *
*      Author:        Misak Sargsyan, YERPHI                         *
*      Modification:  Hovanes Egiyan                                 *
*                                                                    *
*     Last checked on July,15, 2002, FIU                             *
*     Modificaton: M.Sargsian August,23, 2002 JLAB                   *
*     Radiative effects are checked for deuteron target              *
*     Also the code checked such a way that it calculates            *
*     scattering from the deuteron when target line in the           *
*     init_incl.dat is chosen as a deuteron                          *
*
*    Aug-Sep - 2005
*   Radiative correction code is corrected to include the 
*   radiative tail from x> 1 region
*   for He3 - Simula's parameterization is used
*   ! write(27,*) gives the output of nonrad, rad and rad/nonrad 
*   cross sections 
*
*   June-July-2010
*   now there are three different parameterizations for nucleon 
*   form-factors
*   they are defined in the init_incl.dat file as a 6th parameter 
*   in  the INCIDENT ELECTRON line
*
**********************************************************************
C-

     include 'common_incl.cmn'
C-
C        INCLUDE 'inclusive$src:COMMON_INCL.CMN'
        COMMON/prot/pm,pi
        COMMON/detr/dm,dmx
        COMMON/pair/apair
        COMMON/rad/tt,bt,dt,alfa,em,xsi
        COMMON/bound/dd,bd
        COMMON/targ/a,z,tm,rm
        COMMON/fermi/pferm
        COMMON/simp0/rep,reu,eps_r
        COMMON/pers/ps,sz
        COMMON/kemc/k_emc
        COMMON/kswell/k_swell
        COMMON/psg/psg
        COMMON/p_pl/p_pl
        COMMON/bin/width_e,width_u,i_case
        COMMON/new_int/r_acc,a_acc,k_int,s_int
        CHARACTER*10 name(2)
        CHARACTER*60 titles
        CHARACTER*10 nuclei
        common/nsimp/nw0
        common/a3case/a3case
        common/form_factors/ics
        REAL initial_data(6)
        REAL*8 e_in,eprime,theta,x_in
        REAL*8 a_in,z_in
        REAL*8 xsec
c        ! write(6,1)
**********************************************************************
*       read initial conditions file
**********************************************************************
c        DO 101 isetup = 1,121
c          OPEN (unit=15,file='init_incl.dat',status='OLD')
*          OPEN (unit=7,file='out.dat',status='UNKNOWN')
c          OPEN (unit=7,file='out.dat')
c          IF(isetup.LE.6)THEN
c            titles  = ' '
c            READ(15,24)titles
c            WRITE(7,25)titles
*            TYPE 25,titles
c            GOTO 101
c          ENDIF
          name(1) = ' '
          name(2) = ' '
          initial_data(1) = 0.0
          initial_data(2) = 0.0
          initial_data(3) = 0.0
          initial_data(4) = 0.0
          initial_data(5) = 0.0
          initial_data(6) = 0.0
c          READ(15,26,end = 102)name,initial_data
************************************************************************
*         exit loop if blank line encountered
************************************************************************
c          IF(name(1).EQ.' ')then
c            WRITE(7,27)name
c            GOTO 101
c          END IF
c          WRITE(7,27)name,initial_data
************************************************************************
*         initialize beam conditions
************************************************************************
c          IF(name(1).EQ.'INCIDENT')then
c            ei_0   = initial_data(1)
c            ei_1   = initial_data(2)/1000.
c            ei     = ei_0 + ei_1
            ei     = e_in
c            IF(name(2).EQ.' ELECTRON')then
              lepin = 7
c            ELSEIF(name(2).EQ.' PHOTON')then
c              lepin = 1
c            ENDIF
c            lepin = 7
c            ics = int(initial_data(6))
            ics = 3.000
c          ENDIF
************************************************************************
*          initialize target conditions
************************************************************************
c          IF(name(1).EQ.'TARGET')then
            a      = a_in
c            a      = initial_data(1)
            z      = z_in
c            z      = initial_data(2)
c            pferm  = initial_data(3)
c            ps     = initial_data(4) / 100.
c            bd     = initial_data(5)
            dd     = 0.0 !initial_data(6)
c            a3case = initial_data(6)
            a3case = 0.010
               if (z.eq.1.and.a.eq.2) then
                  nuclei = " D"
                  pferm  = 0.099
                  ps     = 20.00 / 100.
                  bd     = 0.025
               elseif (z.eq.2.and.a.eq.4) then
                  nuclei = " HE"
                  pferm  = 0.120
                  ps     = 20.00 / 100.
                  bd     = 0.025
               elseif (z.eq.3.and.a.eq.6) then
                  nuclei = " LI"
                  pferm  = 0.169 
                  ps     = 22.00 / 100.
                  bd     = 0.025
               elseif (z.eq.7.and.a.eq.14) then
                  nuclei = " N2"
                  pferm  = 0.220
                  ps     = 25.000 / 100.
                  bd     = 0.025
c                  ! write(6,*) "I'M HERE!! SEE?!"
               elseif (z.eq.6.and.a.eq.12) then
                  nuclei = " C"
                  pferm  = 0.221
                  ps     = 25.00 / 100.
                  bd     = 0.025
               endif
      if(a.gt.2.9.and.a.lt.3.1.and.a3case.gt.1.5)then
            if(a3case.lt.2.1)ifl=-2
            if(a3case.gt.2.9)ifl=-1
c      call he3_mom_dist(p,dist,dist_p,dist_n,dist_pn,dist_pp,ifl)
      endif
c      print *,a3case,ifl

c            CALL targ_r_length(name(2),rl)
            CALL targ_r_length(nuclei,rl)
            
c          ENDIF
************************************************************************
*          initialize target radiative conditions
************************************************************************
c          IF(name(1).EQ.'RAD_EFFECT')then
c
c            sm        = initial_data(1)           ! target thicness i
c            dt        = initial_data(2)
c            width_e   = initial_data(3)
c            width_u   = initial_data(4)
c            eps_r     = initial_data(5)
c            i_case    = initial_data(6)
            sm        = 0.150           ! target thicness i
            dt        = 0.020
            width_e   = 0.010
            width_u   = 0.010
            eps_r     = 0.050
            i_case    = 0.000

            tt     = sm * rl
c            IF(name(2).EQ.' YES')then
c              type_rad = 1.
c            ELSEIF(name(2).EQ.' NO')then
              type_rad = 0.
c            ENDIF
c          ENDIF
************************************************************************
*          nucleon swelling effects
************************************************************************
c          IF(name(1).EQ.'SWELLING')then
c            IF(name(2).EQ.' V1')then
c              psg     = initial_data(1)   !average nucleon swelling in
c              k_swell = 1
c            ELSEIF(name(2).EQ.' V2')then
              k_swell = 2                 !dynamic  nucleon swelling
              p_pl    = initial_data(2)   !prob. of p.l. configuration
c            ENDIF
c          ENDIF
************************************************************************
************************************************************************
*          EMC  effects
************************************************************************
c          IF(name(1).EQ.'EMC')then
c            k_emc = 0
c            IF(name(2).EQ.' YES')k_emc = 1
c            IF(name(2).EQ.' YES-V2')k_emc = 2
            k_emc = 1
c          ENDIF
************************************************************************
************************************************************************
*          scattered electron spectra
************************************************************************
c          IF(name(1).EQ.'Ee` -RANGE')then
c            er_low    = initial_data(1)
c            er_up     = initial_data(2)
c            er_step   = initial_data(3)
c            er_fix    = initial_data(4)
            er_low    = eprime
            er_up     = eprime
            er_step   = 0.001
            er_fix    = eprime
************************************************************************
*          electron spectra at E'
************************************************************************
c            IF(name(2).EQ.' YES') sub_type_spec = 11.
c          ENDIF
************************************************************************
*          TETAe range initialization
************************************************************************
c          IF(name(1).EQ.'THe -RANGE')then
c            the_low    = initial_data(1)
c            the_up     = initial_data(2)
c            the_step   = initial_data(3)
c            the_fix    = initial_data(4) + initial_data(5)/1000.
            the_low    = 0.000
            the_up     = 0.000
            the_step   = 0.000
            the_fix    = theta
c          ENDIF
c          IF(name(1).EQ.'Q0  -RANGE')then
c            q0_low    = initial_data(1)
c            q0_up     = initial_data(2)
c            q0_step   = initial_data(3)
c            q0_fix    = initial_data(4)
            q0_low    = 0.000
            q0_up     = 0.000
            q0_step   = 0.000
            q0_fix    = 0.000
************************************************************************
*          electron spectra at Q0
************************************************************************
c            IF(name(2).EQ.' YES') sub_type_spec = 12.
c          ENDIF
c          IF(name(1).EQ.'W   -RANGE')then
c            w_low    = initial_data(1)
c            w_up     = initial_data(2)
c            w_step   = initial_data(3)
c            w_fix    = initial_data(4)
            w_low    = 0.000
            w_up     = 0.000
            w_step   = 0.000
            w_fix    = 0.000
************************************************************************
*          electron spectra at W
************************************************************************
c            IF(name(2).EQ.' YES') sub_type_spec = 13.
c          ENDIF
c          IF(name(1).EQ.'X   -RANGE')then
c            x_low    = initial_data(1)
c            x_up     = initial_data(2)
c            x_step   = initial_data(3)
c            x_fix    = initial_data(4)
            x_low    = x_in
            x_up     = x_in
            x_step   = 0.001
            x_fix    = x_in
************************************************************************
*          electron spectra at X
************************************************************************
c            IF(name(2).EQ.' YES') sub_type_spec = 14.
            sub_type_spec = 14.
c          ENDIF
************************************************************************
*          integration accuracy
************************************************************************
c          IF(name(1).EQ.'INTEGRATIO')then
                            k_int = 0
c            r_acc = initial_data(1)
c            rep   = initial_data(2)
c            reu   = initial_data(3)
c            s_int = initial_data(4)
c            a_acc = initial_data(5)
c            nw0   = initial_data(6)

            r_acc = 0.050
            rep   = 0.000
            reu   = 0.050
            s_int = 0.010
            a_acc = 0.000
            nw0   = 0.000

            a_acc = 2.0
            IF(r_acc.EQ.0.0)k_int = 1
            if(nw0.gt.0)    k_int = 2
c          ENDIF
************************************************************************
************************************************************************
*          theoretical model selection
************************************************************************
c          IF(name(1).EQ.'VIRT.NUCL.'.and.name(2).EQ.' YES')num_model = 1
c          IF(name(1).EQ.'LIGHT-CONE'.and.name(2).EQ.' YES')num_model = 2
c          IF(name(1).EQ.'HYDROGEN  '.and.name(2).EQ.' YES')num_model = 3
          num_model = 2
************************************************************************
*          process selection
************************************************************************
c          IF(name(1).EQ.'QUASIELAST')then
            k_select(1) = 1
c          ELSEIF(name(1).EQ.'INELASTIC')then
            k_select(2) = 1
c          ENDIF
************************************************************************
*          measure of cross section
************************************************************************
c          IF(name(1).EQ.'MEASURE')then
c            IF(name(2).EQ.' MILIBARN ') v_measure = 1000000.
c            IF(name(2).EQ.' MICROBARN') v_measure = 1000.
c            IF(name(2).EQ.' NANOBARN ') v_measure = 1.
c            IF(name(2).EQ.' PICOBARN ') v_measure = 0.001
c          ENDIF
          v_measure = 1000.
          GOTO 101
************************************************************************
  101   CONTINUE
  102   CONTINUE
c        CLOSE(unit=15)
*        CALL datime(jd,jt)
*        WRITE(6,28)jd,jt
*        TYPE 28,jd,jt
c        ! write(7,1)
************************************************************************
*          beginning of calculations
************************************************************************
        IF(num_model.EQ.1)CALL vn_incl
        IF(num_model.EQ.2)CALL lcd_incl(xsec)
        IF(num_model.EQ.3)CALL hydro
************************************************************************

        RETURN

    1   FORMAT(80('='))
   24   FORMAT(a60)
   25   FORMAT(5x,a60)
   26   FORMAT(a10,a10,6f8.3)
   27   FORMAT(5x,a10,a10,6f8.3)
   28   FORMAT(80('=')/17x,'Data  --  ',i6,1x,'-- Time --  ',i4,'  --'
     &        /80('='))
*        CALL datime(jd,jt)
*        ! write(7,28)jd,jt
c        ! write(6,28)jd,jt
c	close(unit=7)
        STOP
        END

*lcd_incl.f
      SUBROUTINE lcd_incl(cross_section)
************************************************************************
*     Subroutine to calculate the inclusive (ee') cross section
*     in Ligth Cone Dynamic approximation. The EMC and nucleon
*     swellin effect by minidelocalization effect take into
*     account to.
*     The input variables are follows:
*
*                     = 0 no EMC effect taken
*                     = 1 EMC effect is taken into account only
*              KEMC         for the inelastic part of the spectra
*                     = !2 EMC effect is taken into account for ! no aviable
*                           inelastic and quasielastic part !    yet
*                     = 1 average swelling is effect taken into account
*              KSWELL
*                     = 2 dynamical swelling effect is taken into account
*
*
*      Written:        January, 1990
*      Author:         Misak Sargsyan
*      Modifications:  Hovanes Egiyan
*
************************************************************************
      EXTERNAL fdnorm
      COMMON/prot/pm,pi
      common/detr/dm,dmx
      common/pair/apair
      common/bound/dd,bd
      common/targ/a,z,tm,rm
      common/fermi/pferm
      common/simpt/rep,reu
      common/rad/tt,bt,dt,alfa,em,xsi
      common/pers/ps,sz
      common/kemc/kemc
      COMMON/ggf/ga,gd
      common/psg/psg
      common/kswell/kswell
      common/p_pl/p_pl
      COMMON/simp0/eps_p,eps_u,eps_r
      common/k_process/k_process
      COMMON/new_int/r_acc,a_acc,k_int,s_int
      common/nsimp/nw0
      REAL*8 cross_section

C-
	include 'common_incl.cmn'
C-
C      INCLUDE 'inclusive$src:COMMON_INCL.CMN'
c----------------------------------------------------------------------
C            PARAMETERS OF TARGET
      em=0.00051
      pm=0.938279
      dm=1.875
      dmx = dm - dd
      tm=a*pm
      rm=(a-1.)*pm
      bda= 0.02
      apair=5.5
      eps = 0.001
      pfermo = pferm
      if(a.eq.12)pfermo = pferm+0.03
      CALL gadap(pfermo,2.,fdnorm,eps,pfn)
*      CALL gadap(0.3,2.,fdnorm,eps,pfn)
      sz = 4.*acos(-1.)*pfn
      apair = ps / sz
      gd = 0.71   ! diple form factor parameter for nucleon in the deuteron
      ga = 0.71*(1.-psg/100.)**2    ! dipole form factor parameter for nucleon in A
C                                  OTHER PARAMETERS
      pi=3.14159
      alfa=1./137.
C*******************************************************************
C                           ----RADIATIVE PARAMETERS---
      bt=4./3.
      z01=alog(1440./z**(2./3.))
      z02=alog(183./z**(1./3.))
      z0=z01/z02
      an=0.6023
      rel=0.2818
      x01=4.*an*alfa*(rel**2)*z*(z+z0)
      x02=x01*z02
      x0=a/x02
      xsi=0.000154*z*tt*x0/a
C*******************************************************************
c      WRITE(7,*)'                                               '
c      WRITE(7,*)' ================================================'
c      WRITE(7,18)ei
   18 FORMAT(2x,'ENERGY OD INCIDENT ELECTRONS  ( GeV ) =',f9.5)
      IF(kemc.EQ.1)THEN
c        WRITE(7,*)' ================================================'
c        WRITE(7,*)' ++++++++++++++++++++++++++++++++++++++++++++++'
c        WRITE(7,*)' +       EMC EFFECT TAKE INTO ACCOUNT         +'
c        WRITE(7,*)' +      ONLY FOR INELASTIC PART OF SPECTRA    +'
c        WRITE(7,*)' ++++++++++++++++++++++++++++++++++++++++++++++'
      ENDIF
C      IF(KEMC.EQ.2)THEN     ! no include still
C      WRITE(6,*)' ================================================'
C      WRITE(6,*)' ++++++++++++++++++++++++++++++++++++++++++++++'
C      WRITE(6,*)' +       EMC EFFECT TAKE INTO ACCOUNT -- V2   +'
C      WRITE(6,*)' +       FOR INELASTIC AND QUASIELASTIC PART  +'
C      WRITE(6,*)' +            no available yet                +'
C      WRITE(6,*)' ++++++++++++++++++++++++++++++++++++++++++++++'
C      ENDIF
c      WRITE(7,*)' ================================================'
      IF(kswell.EQ.1)THEN
        IF(psg.EQ.0.0)THEN
c          WRITE(7,*)' +--------------------------------------------+'
c          WRITE(7,*)' :  NO SWELLING EFFECT TAKE INTO ACCOUNT      :'
c          WRITE(7,*)' +--------------------------------------------+'
        ELSEIF(psg.NE.0.0)THEN
c          WRITE(7,*)' +--------------------------------------------+'
c          WRITE(7,*)' : AVERAGE  SWELLING EFFECT TAKE INTO ACCOUNT :'
c          WRITE(7,*)' +--------------------------------------------+'
        ENDIF
      ELSEIF(kswell.EQ.2)THEN
c        WRITE(7,*)' +---------------------------------------------+'
c        WRITE(7,*)' :  DYNAMIC SWELLING EFFECT TAKE INTO ACCOUNT  :'
c        WRITE(7,*)' +---------------------------------------------+'
      ENDIF
c      WRITE(7,*)' ================================================'
c      WRITE(7,*)' TARGET THICNESS IN MM    =',sm
c      WRITE(7,*)' ATOMIC WEIGHT A          =',a
c      WRITE(7,*)' CHARG NUMBER  Z          =',z
c      WRITE(7,*)' PAIR MASS IN NUCLEAR     =',dmx
c      WRITE(7,*)' RESPONSE ENERGY IN GEV   =',bd
c      WRITE(7,*)' FERMI MOMETUM            =',pferm
c      WRITE(7,*)' VALUE OF HIGH COMPONENT  =',ps
c      WRITE(7,*)' LEVINGER PARAMETER       =',apair
c      WRITE(7,*)' NUCLEON DIPOL PARAMETER  =',ga
c      WRITE(7,*)' ================================================'
**********************************************************************
*     measure of cross section
**********************************************************************
      v_m = v_measure
c      IF(v_m.EQ.1000000.)WRITE(7,*)' =CROSS SECTION IN (mlbn/GeV/Str)='
c      IF(v_m.EQ.1000.)   WRITE(7,*)' =CROSS SECTION IN (mcbn/GeV/Str)='
c      IF(v_m.EQ.1.)      WRITE(7,*)' =CROSS SECTION IN (nbn/GeV/Str)= '
c      IF(v_m.EQ.0.001)   WRITE(7,*)' =CROSS SECTION IN (pkbn/GeV/Str)='
c      WRITE(7,*)' ================================================'
*********************************************************************
*     scattered angle range determination
*********************************************************************
      IF(the_step.NE.0.)k_tet_sum = (the_up - the_low) / the_step + 1
      IF(the_low.EQ.0.) k_tet_sum = 1
      DO k_tet = 1,k_tet_sum
        IF(k_tet_sum.EQ.1) uet = the_fix
        IF(k_tet_sum.GT.1) uet = the_low + float(k_tet-1) * the_step
        ue=uet*pi/180.
c        WRITE(7,*)'                                               '
c        WRITE(7,*)' ================================================'
c        WRITE(7,19)uet
c        WRITE(7,*)' ================================================'
   19   FORMAT(2x,'ANGLE OF SCATTERED ELECTRONS ( degr.) =',f9.5)
        IF(type_rad.EQ.0.0)then
c	WRITE(7,20)
c	WRITE(6,20)
	endif
c        IF(type_rad.EQ.1.0)WRITE(7,21)
**********************************************************************
*     selection electron spectra type
**********************************************************************
        IF(sub_type_spec.EQ.11.0)THEN
          k_sum = (er_up - er_low) / er_step + 1
        ELSEIF(sub_type_spec.EQ.12.0)THEN
          k_sum = (q0_up - q0_low) / q0_step + 1
        ELSEIF(sub_type_spec.EQ.13.0)THEN
          k_sum = (w_up - w_low) / w_step + 1
        ELSEIF(sub_type_spec.EQ.14.0)THEN
          k_sum = (x_up - x_low) / x_step + 1
        ENDIF
**********************************************************
c        ! write(6,*)'TOTAL NUMBERS TO BE CALCULATED  =',k_sum
c        WRITE(6,20)
**********************************************************
        kb = 0
        DO 1 ke = 1,k_sum
          kb = kb + 1
          IF(sub_type_spec.EQ.11.0)THEN
            er = er_low + float(ke-1)*er_step
          ELSEIF(sub_type_spec.EQ.12.0)THEN
            q0 = q0_low + float(ke-1)*q0_step
            er = ei - q0
          ELSEIF(sub_type_spec.EQ.13.0)THEN
            w2 = ( w_low + float(ke-1)*w_step ) ** 2
            er=(pm**2+2.*pm*ei-w2)/(2.*pm+4.*ei*sin(ue/2.)**2)
          ELSEIF(sub_type_spec.EQ.14.0)THEN
            x = x_low + float(ke-1)*x_step
            er=(2.*pm*ei*x)/(4.*ei*sin(ue/2.)**2+2.*pm*x)
          ENDIF
          gp0=ei-er
          gp2=4.*ei*er*sin(ue/2.)**2
          gpv=sqrt(gp0**2+gp2)
          w2=pm**2+2.*pm*gp0-gp2
          x=gp2/2./pm/gp0
          IF(x.GE.2.0)GOTO 1
          IF(type_rad.EQ.0.0)THEN  ! 23-Oct-2000
*            needs to be commented if rad and nonrad crss needed at the same time

            sp_ql_a = 0.0
            sp_in_a = 0.0
            sp_ql_d = 1.0
            sp_in_d = 1.0
            IF(k_select(1).EQ.1)THEN
              rep = eps_p
              reu = eps_u
              if(a.eq.2.0)then
              sp_ql_a = dgid(ei,er,ue) / v_m  ! quasielastic cross secti
              else
              sp_ql_a = dgia(ei,er,ue) / v_m  ! quasielastic cross secti
              endif
              rep = eps_p
              reu = eps_u
              sp_ql_d = dgid(ei,er,ue) / v_m  ! quasielastic cross secti
            ENDIF
            IF(k_select(2).EQ.1)THEN
              rep = eps_p
              reu = eps_u
              if(a.eq.2.0)then
              sp_in_a = dgind(ei,er,ue) / v_m ! inelastic cross section
              else
              sp_in_a = dgina(ei,er,ue) / v_m ! inelastic cross section
              endif
              rep = eps_p
              reu = eps_u
              sp_in_d = dgind(ei,er,ue) / v_m ! inelastic cross section
            ENDIF
            dgea    = sp_ql_a + sp_in_a
            dged    = sp_ql_d + sp_in_d
            IF(dged.EQ.0.0)GOTO 1
C-------------------------------------------------------
            dgw2d   =dged/(2.*pm+4.*ei*sin(ue/2.)**2)
            rel=(2.*dgea)/(a*dged)
            cross_section = dgea * 1E-6
c            WRITE(7,101)w2,er,x,sp_ql_a,sp_in_a,dgea,sp_ql_d,sp_in_d,
c     &        dged,
c     &dgw2d,rel,gp2
c            WRITE(6,103)w2,er,x,sp_ql_a,sp_in_a,dgea,sp_ql_d,sp_in_d,
c     &        dged,
c     &dgw2d,rel,gp2,cross_section,uet,ei
*            WRITE(27,*)uet,er,dgea,tdg_tot,x,epni
************************************************
* New addition 25-Apr-2000
* This allows to extract the effective 
* F2 structure functions for d and A
************************************************
      smott = gmott(ei,ue) /v_m
      epsil = 1.0/(1.0+2.0*(1.0+gp0**2/gp2)*tan(ue/2.0)**2)
      rtiv  = 0.18
      afact = 1.0 + (1.0-epsil)/epsil * 1.0/(1.0+rtiv)
      f2be_a = dgea * gp0/(smott*afact)/a 
      f2be_d = dged * gp0/(smott*afact)/2.0 
*      ! write(6,*)ue*180.0/pi
*      ! write(23,*)"uet=",uet
      ! write(23,25)gp2,x,er,gp0,dgea,dged,f2be_a,f2be_d
 25   format(f7.4,3(f8.4),4(e11.3))
      ENDIF ! 23-Oct-2000 ! needs to be commented if rad and nonrad crss needed at the same time
                 
          IF(type_rad.EQ.1.0)THEN
*******************************************************
*    Take into account radiation effects
*******************************************************
            k_process = 1
            tdg_ql    = tspec(ei,er,ue) / v_m
            k_process = 2
            tdg_in    = tspec(ei,er,ue) / v_m
            tdg_tot   = tdg_ql + tdg_in
c            WRITE(7,102)w2,er,x,tdg_ql,tdg_in,tdg_tot,gp0,gp2,uet
            ! write(21,*)w2,er,x,tdg_ql,tdg_in,tdg_tot,gp0,gp2,uet

****************************************************************
C             Fort.27-Output for PAW, Kim
*************************************************************
****************************************************
* uet     - scattered electron angle
* er      - scattered electron energt
* dgea    - cross section without radiative effects
* tdg_tot - cross section with radiative effects
*****************************************************
* neede to be uncommented for rad and nonrad crss outputs
*            ratiot = tdg_tot/dgea
*         WRITE(27,*)uet,er,dgea,tdg_tot,ratiot,x !,epni
********************************************************
          ENDIF
********************************************************
*          ! write(6,*)'CALCULATED NUMBER =',ke
********************************************************
    1   CONTINUE
c        IF(type_rad.EQ.0.0)WRITE(7,22)
c        IF(type_rad.EQ.1.0)WRITE(7,23)
      ENDDO
***************************************************************
*     Init line formats
***************************************************************
   30 FORMAT(8e10.3)
*   20 FORMAT(123('=')/4x,'W2',6x,'Ee`',5x,'X ',8x,'QL_A',7x,'IN_A',6x,
*     &'TOT_A',7x,'QL_D',7x,'IN_D',6x,'TOT_D',6x,'DGW2D',6x,' REL',
*     &        6x,' Q2 '/123('-'))
*   21 FORMAT(78('=')/5x,'W2',6x,'Ee`',6x,'X ',5x,'T_QL',7x,'T_IN',7x,
*     &'T_TOT',5x,' Q0 ',4x,' Q2 ',/78('-'))
*
c   20 FORMAT(123('=')/4x,'W2',6x,'Ee`',5x,'X ',8x,'QL_A',7x,'IN_A',6x,
   20 FORMAT(123('=')/4x,'W2',6x,'Ee`',5x,'X ',8x,'QL_A',7x,'IN_A',6x,
     &'TOT_A',7x,'QL_D',7x,'IN_D',6x,'TOT_D',6x,'DGW2D',6x,' REL',
     &        6x,' Q2 ',6x,' CS ',6x,' THETA ',6x,' E_in')
   21 FORMAT(78('=')/5x,'W2',6x,'Ee`',6x,'X ',5x,'T_QL',7x,'T_IN',7x,
     &'T_TOT',5x,' Q0 ',4x,' Q2 ',/78('-'))
***************************************************************
*     Exit line formats
***************************************************************
   22 FORMAT(123('-')/4x,'W2',6x,'Ee`',5x,'X ',8x,'QL_A',7x,'IN_A',6x,
     &'TOT_A',7x,'QL_D',7x,'IN_D',6x,'TOT_D',6x,'DGW2D',6x,' REL',
     &        6x,' Q2 '/123('='))
   23 FORMAT(78('-')/5x,'W2',6x,'Ee`',6x,'X ',5x,'T_QL',7x,'T_IN',7x,
     &'T_TOT',5x,' Q0 ',4x,' Q2 ',/78('='))
***************************************************************
*     Data  formats
***************************************************************
  101 FORMAT(3f8.4,1x,8e11.3,f8.4)
  102 FORMAT(1x,3f8.4,3e11.3,2f8.4)
  103 FORMAT(3f8.4,1x,8e11.3,f8.4,8e11.3,2f10.0)
      RETURN
      END
C..........................
C======================================================================
C                  SCCATTERING ON NUCLEUS WITH A > 2
C======================================================================
C          ************ FUL SPECTRUM NO RAD. EFFECTS ***********
      FUNCTION spec(ei,er,ue)
      COMMON/simp0/eps_p,eps_u,eps_r/k_process/k_process
      COMMON/simpt/rep,reu/targ/a,z,tm,rm
      rep = eps_p
      reu = eps_u
      IF(k_process.EQ.1)THEN
        IF(a.NE.2.0)spec=dgia(ei,er,ue)
        IF(a.EQ.2.0)spec=dgid(ei,er,ue)
      ELSEIF(k_process.EQ.2)THEN
        IF(a.NE.2.0)spec=dgina(ei,er,ue)
        IF(a.EQ.2.0)spec=dgind(ei,er,ue)
      ENDIF
      RETURN
      END
C----------------------------------------------------------------------
C****** QUASIELASTIC SCCATTERING *******
      FUNCTION dgia(ei,er,ue)
      gp0=ei-er
      gp2=4.*ei*er*sin(ue/2.)**2
      gpv=sqrt(gp0**2+gp2)
      tg2=(sin(ue/2.)/cos(ue/2.))**2
      dgia=gmott(ei,ue)*(w2ai(gp0,gpv,gp2)+2.*tg2*w1ai(gp0,gpv,gp2))
      RETURN
      END
C............................
C****** INELASTIC SCCATTERING ********
      FUNCTION dgina(ei,er,ue)
      gp0=ei-er
      gp2=4.*ei*er*sin(ue/2.)**2
      gpv=sqrt(gp0**2+gp2)
      tg2=(sin(ue/2.)/cos(ue/2.))**2
      w2cd=w2ina(gp2,gp0,gpv)
      w1cd=(1.+gp0**2/gp2)/(1.+0.18)*w2cd
      dgina=gmott(ei,ue)*(w2cd+2.*tg2*w1cd)
      RETURN
      END
C======================================================================
C
C======================================================================
C                     SCCATTERING ON DEUTRON
C======================================================================
C          ************ FUL SPECTRUM NO RAD. EFFECTS ***********
      FUNCTION specd(ei,er,ue)
      specd=dgid(ei,er,ue)+dgind(ei,er,ue)
      RETURN
      END
C----------------------------------------------------------------------
C****** QUASIELASTIC SCCATTERING ******
      FUNCTION dgid(ei,er,ue)
      gp0=ei-er
      gp2=4.*ei*er*sin(ue/2.)**2
      gpv=sqrt(gp0**2+gp2)
      tg2=(sin(ue/2.)/cos(ue/2.))**2
      dgid=gmott(ei,ue)*(w2di(gp0,gpv,gp2,3)+2.*tg2*w1di(gp0,gpv,gp2,3))
      RETURN
      END
C****** INELASTIC SCCATTERING *******
      FUNCTION dgind(ei,er,ue)
      gp0=ei-er
      gp2=4.*ei*er*sin(ue/2.)**2
      gpv=sqrt(gp0**2+gp2)
      tg2=(sin(ue/2.)/cos(ue/2.))**2
      w2cd=w2ind(gp2,gp0,gpv)
      w1cd=(1.+gp0**2/gp2)/(1.+0.18)*w2cd
      dgind=gmott(ei,ue)*(w2cd+2.*tg2*w1cd)
      RETURN
      END
C=======================================================================
C--------------------------------
      FUNCTION w2ai(q0,qv,q2)
      EXTERNAL w2aii
      COMMON/prot/pm,pi
      common/foton/gp0,gp2,gpv
      common/detr/dm,dmx
      common/pair/apair
      common/bound/bda,bd
      common/targ/a,z,tm,rm
      common/fermi/pferm
      common/simpt/rep,reu
      COMMON/new_int/r_acc,a_acc,k_int,s_int
      common/nsimp/nw0
      gp0=q0
      gpv=qv
      gp2=q2
      pfa=0.001
      pfb=sqrt((gpv+1.6)**2)
      IF(k_int.EQ.0)THEN
        CALL simps(pfa,pfb,s_int,r_acc,a_acc,w2aii,rol,rol2,rol3)
      ELSEif(k_int.eq.1)then
        CALL gadap(pfa,pfb,w2aii,rep,rol)
      Elseif(k_int.eq.2)then
	nw = 1000*nw0
*	! write(6,*)"nw0",nw,nw0
        CALL simpson(pfa,pfb,w2aii,nw,rol)
      ENDIF
      w2ci=1./2./pm*rol/4. / 1000000.
      w2bi=0.
C     DM=1.875
C     W2BI=W2DI(GP0,GPV,GP2,1)
      w2ai=w2ci+w2bi
      RETURN
      END
C.................................
      FUNCTION w2aii(pf)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/detr/dm,dmx/nuk/nuk
     */scalar/pfd,pfd2,rhma,pfq/bound/bda,bd/targ/a,z,tm,rm/fermi/pferm
     */dipol/gdip/ggf/ga,gd/kswell/kswell/p_pl/p_pl
      ef=sqrt(pf**2+pm**2)
      sing=sqrt(gp2)/gpv
      cosg=gp0/gpv
      csgmf=((pf**2+gpv**2+2.*pm*ef)-2.*pm*(gp0+pm-bd))/2./pf/gpv
      w2aif=0.
      IF(csgmf**2.gt.1.)go to 1
      gdip = ga
      aq=(gp0-gpv)/pm
      alf=(ef-pf*csgmf)/pm
      erez=(pf**2-2.*pf*gpv*csgmf+gpv**2)/2./pm+bda+rm
      al1=(ef-pf*csgmf)/(erez+ef-gpv)
      al=al1*(a+aq)-aq
      pt=pf*sqrt(1.-csgmf**2)
      p=sqrt((al-1.)**2*pm**2+pt**2)
      p = 0.0
      psqr=pf**2-2.*pf*gpv*csgmf+gpv**2
      IF(psqr.GT.0.0) p=sqrt(psqr)
      rhma=al*((pm**2+pt**2)/al+(rm**2+pt**2)/(a-al)-tm**2/a)
      pfd=ef-pf*csgmf*cosg
      pfd2=(ef-pf*csgmf*cosg)**2+pf**2*(1.-csgmf**2)*sing**2/2.
      pfq=ef*gp0-pf*gpv*csgmf
C-------------------------------------- dynamic swelling effect -----
      IF(kswell.EQ.2)THEN              !-----------------------------
        sw   = (1.-p_pl*del_a(p,0.02,0.3))/(1.-p_pl)
        gdip = ga/sw
      ENDIF
C---------------------------------------------------------------------
      si= z*rop(p,al)*(s1ip(al,alf,aq,pt)+s2ip(al,alf,aq,pt))+
     *(a-z)*ron(p,al)*(s1in(al,alf,aq,pt)+s2in(al,alf,aq,pt))
      alr=a-al
      w2aif=si*(1./pm)*(pm*pf/gpv/ef) !* 100000.
    1 CONTINUE
      nuk=1
      dm=1.875
      w2ahc=w2ii(pf)
      w2aii=w2aif+w2ahc
      RETURN
      END
C-----------------------------------------
      FUNCTION w1ai(q0,qv,q2)
      EXTERNAL w1aii
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/detr/dm,dmx/pair/apair
     */bound/bda,bd/targ/a,z,tm,rm/fermi/pferm/simpt/rep,reu
      COMMON/new_int/r_acc,a_acc,k_int,s_int
      common/nsimp/nw0
      gp0=q0
      gpv=qv
      gp2=q2
      pfa=0.001
      pfb=sqrt((gpv+1.6)**2)
      IF(k_int.EQ.0)THEN
        CALL simps(pfa,pfb,s_int,r_acc,a_acc,w1aii,rol,rol2,rol3)
      ELSEif(k_int.eq.1)then
        CALL gadap(pfa,pfb,w1aii,rep,rol)
      ELSEif(k_int.eq.2)then
	nw = 1000*nw0
        CALL simpson(pfa,pfb,w1aii,nw,rol)
      ENDIF
      w1ci=1./2./pm*rol/4. / 1000000.
      w1bi=0.
C     DM=1.875
C     W1BI=W1DI(GP0,GPV,GP2,1)
      w1ai=w1ci+w1bi
      RETURN
      END
C.................................
      FUNCTION w1aii(pf)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/detr/dm,dmx/nuk/nuk
     */scalar/pfd,pfd2,rhma,pfq/bound/bda,bd/targ/a,z,tm,rm/fermi/pferm
     */dipol/gdip/ggf/ga,gd/kswell/kswell/p_pl/p_pl
      ef=sqrt(pf**2+pm**2)
      sing=sqrt(gp2)/gpv
      cosg=gp0/gpv
      csgmf=((pf**2+gpv**2+2.*pm*ef)-2.*pm*(gp0+pm-bd))/2./pf/gpv
      w1aif=0.
      IF(csgmf**2.gt.1.)go to 1
      gdip = ga
      aq=(gp0-gpv)/pm
      alf=(ef-pf*csgmf)/pm
      erez=(pf**2-2.*pf*gpv*csgmf+gpv**2)/2./pm+bda+rm
      al1=(ef-pf*csgmf)/(erez+ef-gpv)
      al=al1*(a+aq)-aq
      pt=pf*sqrt(1.-csgmf**2)
      rhma=al*((pm**2+pt**2)/al+(rm**2+pt**2)/(a-al)-tm**2/a)
      p=sqrt((al-1.)**2*pm**2+pt**2)
      p = 0.0
      psqr=pf**2-2.*pf*gpv*csgmf+gpv**2
      IF(psqr.GT.0.0) p=sqrt(psqr)
      pfd=ef-pf*csgmf*cosg
      pfd2=(ef-pf*csgmf*cosg)**2+pf**2*(1.-csgmf**2)*sing**2/2.
      pfq=ef*gp0-pf*gpv*csgmf
C---------------------------------------- dynamic swelling effect-------
      IF(kswell.EQ.2)THEN               !-------------------------------
        sw   = (1.-p_pl*del_a(p,0.02,0.3))/(1.-p_pl)
        gdip = ga/sw
      ENDIF
C-----------------------------------------------------------------------
      c1bp = 1./3.*(gpv**2/gp2*s1ip(al,alf,aq,pt)+2.*c1ip(al,alf,aq,pt))
      c2bp = 1./3.*(gpv**2/gp2*s2ip(al,alf,aq,pt)+2.*c2ip(al,alf,aq,pt))
      c1bn = 1./3.*(gpv**2/gp2*s1in(al,alf,aq,pt)+2.*c1in(al,alf,aq,pt))
      c2bn = 1./3.*(gpv**2/gp2*s2in(al,alf,aq,pt)+2.*c2in(al,alf,aq,pt))
      cib  = z*rop(p,al)*(c1bp+c2bp) +
     &   (a-z)*ron(p,al)*(c1bn+c2bn)
      alr  = a-al
      w1aif = cib*(1./pm)*(pm*pf/gpv/ef) !* 100000.
    1 CONTINUE
      nuk=1
      dm=1.875
      w1ahc=w1ii(pf)
      w1aii=w1aif+w1ahc
      RETURN
      END
C................................
      FUNCTION rop(pp,alo)
      COMMON/prot/pm,pi/fermi/pferm/pers/ps,sz/targ/a,z,tm,rm
C     ROP=(1.-PS)*DP27(PP)*PM
      rop=(1.-ps)*table(pp,pferm) * sqrt(pm**2+pp**2)
      IF(a.EQ.12.) rop=(1.-ps)*dpn12(pp)        * sqrt(pm**2+pp**2)
      IF(a.EQ.27.) rop=(1.-ps)*dp27(pp)        * sqrt(pm**2+pp**2)
      IF(a.EQ.56.) rop=(1.-ps)*dp56(pp)        * sqrt(pm**2+pp**2)
      IF(a.EQ.208.)rop=(1.-ps)*dp208(pp)       * sqrt(pm**2+pp**2)
      RETURN
      END
C................................
      FUNCTION ron(pp,alo)
      COMMON/prot/pm,pi/fermi/pferm/pers/ps,sz/targ/a,z,tm,rm
C     RON=(1.-PS)*DN27(PP)*PM
      ron=(1.-ps)*table(pp,pferm) * sqrt(pm**2+pp**2)
      IF(a.EQ.12.) ron=(1.-ps)*dpn12(pp)        * sqrt(pm**2+pp**2)
      IF(a.EQ.27.) ron=(1.-ps)*dn27(pp)        * sqrt(pm**2+pp**2)
      IF(a.EQ.56.) ron=(1.-ps)*dn56(pp)        * sqrt(pm**2+pp**2)
      IF(a.EQ.208.)ron=(1.-ps)*dn208(pp)       * sqrt(pm**2+pp**2)
      RETURN
      END
C................................
      FUNCTION vfnr(p)
      COMMON/prot/pm,pi/fermi/pferm
      vfnr=vfc12(p)
      RETURN
      END
C................................
      FUNCTION vfc12(x)
      COMMON/fermi/pferm/pair/apair/pers/ps,sz/jil/jil
      vfc12=wfec12(x,1)*tet(pferm-x)
      RETURN
      END
C................................
      FUNCTION wfhc(xk,xf)
      COMMON/fermi/pferm/pair/apair/pers/ps,sz/jil/jil
      wfhc = apair * tet(xf-pferm)*fd(xk)
      RETURN
      END
C--------------------------------
      FUNCTION w2di(q0,qv,q2,k)
      EXTERNAL w2ii
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/detr/dm,dmx/nuk/nuk
     &/simpt/rep,reu
      COMMON/new_int/r_acc,a_acc,k_int,s_int
      common/nsimp/nw0

      nuk=k
      gp0=q0
      gpv=qv
      gp2=q2
      pfa=0.001
      pfb=sqrt((gpv+1.6)**2)
      IF(k_int.EQ.0)THEN
        CALL simps(pfa,pfb,s_int,r_acc,a_acc,w2ii,rol,rol2,rol3)
      ELSEif(k_int.eq.1)then
        CALL gadap(pfa,pfb,w2ii,rep,rol)
      ELSEif(k_int.eq.2)then
	nw = 1000*nw0
        CALL simpson(pfa,pfb,w2ii,nw,rol)
      ENDIF
      w2di=1./2./pm*rol/4. / 1000000.
      RETURN
      END
C.................................
      FUNCTION w2ii(pf)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/detr/dm,dmx/nuk/nuk
     */scalar/pfd,pfd2,rhma,pfq/fermi/pferm/pair/apair/targ/a,z,tm,rm
     */dipol/gdip/ggf/ga,gd/kswell/kswell/p_pl/p_pl
      ef    = sqrt(pm**2+pf**2)
      w2ii  = 0.0
      csgm  = (pm**2+pf**2+gpv**2-(dm+gp0-ef)**2)/(2.*pf*gpv)
      IF(csgm**2.gt.1.)return
      gdip = gd
      aq    = (gp0-gpv)/pm
      p     = 0.0
      p2    = (pf**2+gpv**2-2.*pf*gpv*csgm)
      IF(p2.GT.0.0) p     = sqrt(p2)
      es    = sqrt(pm**2+p**2)
      al    = (ef-pf*csgm)/(ef+es-gpv)*(2.+aq)-aq
      IF(al.GE.2.)RETURN
      alf   = al + aq
      pt    = pf*sqrt(1.-csgm**2)
      rhma  = al*((pm**2+pt**2)/al+(pm**2+pt**2)/(2.-al)-dm**2/2.)
      sing  = sqrt(gp2)/gpv
      cosg  = gp0/gpv
      pfd   = ef-pf*csgm*cosg
      pfd2  = (ef-pf*csgm*cosg)**2+pf**2*(1.-csgm**2)*sing**2/2.
      pfq   = ef*gp0-pf*gpv*csgm
      pk    = 0.0
      pk2   = ((pm**2+pt**2)/al/(2.-al)-pm**2)
      IF(pk2.GT.0.0) pk    = sqrt(pk2)
      ek    = sqrt(pm**2+pk**2)
C------------------------------------Dynamic swelling effect------------
      IF(kswell.EQ.2)THEN  !--------------------------------------------
        IF(nuk.EQ.1)THEN
          dl_0 = del(pk,0.0,0.6)                      ! For pair correla
          dl_1 = del(pk,0.0,0.3)
          dl   = 1./3.*dl_1 + 2./3.*dl_0
          sw   = (1.-p_pl*dl)/(1.-p_pl)
        ENDIF
        IF(nuk.NE.1)sw   = (1.-p_pl*del(pk,0.0,0.6))/(1.-p_pl)   ! For d
        gdip = ga/sw
      ENDIF
C-----------------------------------------------------------------------
      sp    = s1ip(al,alf,aq,pt)+s2ip(al,alf,aq,pt)
      sn    = s1in(al,alf,aq,pt)+s2in(al,alf,aq,pt)
      si    = sp + sn
      IF(nuk.EQ.1)THEN
        si    = z*sp + (a-z)*sn
        wfpar = wfhc(pk,p)
      ENDIF
      IF(nuk.NE.1)wfpar=fd(pk)
      w2ii  = si/al**2*wfpar*ek*pf/gpv/ef !* 100000.
      RETURN
      END
C-----------------------------------------
      FUNCTION w1di(q0,qv,q2,k)
      EXTERNAL w1ii
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/detr/dm,dmx/nuk/nuk
     &/simpt/rep,reu
      COMMON/new_int/r_acc,a_acc,k_int,s_int 
      common/nsimp/nw0
      nuk=k
      gp0=q0
      gpv=qv
      gp2=q2
      pfa=0.001
      pfb=sqrt((gpv+1.6)**2)
      IF(k_int.EQ.0)THEN
        CALL simps(pfa,pfb,s_int,r_acc,a_acc,w1ii,rol,rol2,rol3)
      ELSEif(k_int.eq.1)then
        CALL gadap(pfa,pfb,w1ii,rep,rol)
      ELSEif(k_int.eq.2)then
	nw = 1000*nw0
        CALL simpson(pfa,pfb,w1ii,nw,rol)
      ENDIF
      w1di=1./2./pm*rol/4. / 1000000.
      RETURN
      END
C.................................
      FUNCTION w1ii(pf)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/detr/dm,dmx/nuk/nuk
     */scalar/pfd,pfd2,rhma,pfq/fermi/pferm/pair/apair/targ/a,z,tm,rm
     */dipol/gdip/ggf/ga,gd/kswell/kswell/p_pl/p_pl
      ef=sqrt(pm**2+pf**2)
      w1ii=0.
      csgm=(pm**2+pf**2+gpv**2-(dm+gp0-ef)**2)/(2.*pf*gpv)
      IF(csgm**2.gt.1.)return
      gdip = gd
      aq=(gp0-gpv)/pm
      p = 0.0
      p2=(pf**2+gpv**2-2.*pf*gpv*csgm)
      IF(p2.GT.0.0)p=sqrt(p2)
      es=sqrt(pm**2+p**2)
      al=(ef-pf*csgm)/(ef+es-gpv)*(2.+aq)-aq
      IF(al.GE.2.)RETURN
      alf=al+aq
      pt=pf*sqrt(1.-csgm**2)
      rhma=al*((pm**2+pt**2)/al+(pm**2+pt**2)/(2.-al)-dm**2/2.)
      sing=sqrt(gp2)/gpv
      cosg=gp0/gpv
      pfd=ef-pf*csgm*cosg
      pfd2=(ef-pf*csgm*cosg)**2+pf**2*(1.-csgm**2)*sing**2/2.
      pfq=ef*gp0-pf*gpv*csgm
      pk = 0.0
      pk2=((pm**2+pt**2)/al/(2.-al)-pm**2)
      IF(pk2.GT.0.0) pk=sqrt(pk2)
      ek=sqrt(pm**2+pk**2)
C------------------------------------Dynamic swelling effect------------
      IF(kswell.EQ.2)THEN  !--------------------------------------------
        IF(nuk.EQ.1)THEN
          dl_0 = del(pk,0.0,0.6)                      ! For pair correla
          dl_1 = del(pk,0.0,0.3)
          dl   = 1./3.*dl_1 + 2./3.*dl_0
          sw   = (1.-p_pl*dl)/(1.-p_pl)
        ENDIF
        IF(nuk.NE.1)sw   = (1.-p_pl*del(pk,0.0,0.6))/(1.-p_pl)   ! For d
        gdip = ga/sw
      ENDIF
C-----------------------------------------------------------------------
      c1bp = 1./3.*(gpv**2/gp2*s1ip(al,alf,aq,pt)+2.*c1ip(al,alf,aq,pt))
      c2bp = 1./3.*(gpv**2/gp2*s2ip(al,alf,aq,pt)+2.*c2ip(al,alf,aq,pt))
      c1bn = 1./3.*(gpv**2/gp2*s1in(al,alf,aq,pt)+2.*c1in(al,alf,aq,pt))
      c2bn = 1./3.*(gpv**2/gp2*s2in(al,alf,aq,pt)+2.*c2in(al,alf,aq,pt))
      cpb  = c1bp + c2bp
      cnb  = c1bn + c2bn
      cib  = cpb + cnb
      IF(nuk.EQ.1)THEN
        cib  = z*cpb + (a-z)*cnb
        wfpar = wfhc(pk,p)
      ENDIF
      IF(nuk.NE.1) wfpar=fd(pk)
      w1ii = cib/al**2*wfpar*ek*pf/gpv/ef !* 100000.
      RETURN
      END
C-----------------------------------------
C------------------------------------------
      FUNCTION s1ip(al,alf,aq,pt)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/scalar/pfd,pfd2,rhma,pfq
      s1i1=f1p(gp2)**2*(pfd2+2.*pfd/gpv*rhma/2.+1./gpv**2*(rhma/2.)**2-
     *gp2/gpv**2*rhma/4.)
      s1i2=f2p(gp2)**2/4./pm**2*gp2*pfd2
      s1ip=2.*pi*8.*(s1i1+s1i2)
      RETURN
      END
C.............................
      FUNCTION s2ip(al,alf,aq,pt)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/scalar/pfd,pfd2,rhma,pfq
      s1=f1p(gp2)**2*gp2*alf*pm/gpv**2
      s2=f2p(gp2)*f1p(gp2)*(1.-gp0/gpv)*gp2/gpv
      s3=f2p(gp2)**2/2./pm**2*(1.-gp0/gpv)*gp2*pfd
      s2ip=2.*pi*2.*rhma/al/pm*(s1-s2+s3)
      RETURN
      END
C.............................
      FUNCTION c1ip(al,alf,aq,pt)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/scalar/pfd,pfd2,rhma,pfq
      c1=4.*f1p(gp2)**2*(-alf*al/aq**2*gp2+pt**2-pfq)
      c2=6.*f1p(gp2)*f2p(gp2)*gp2
      c3=f2p(gp2)**2/2./pm**2*(gp2*(6.*pm**2+pfq+2.*pt**2)-
     *2.*(al+alf)/aq*pfq*gp2-2.*alf**2/aq**2*gp2**2+4.*pfq**2)
      c1ip=2.*pi*(c1+c2+c3)
      RETURN
      END
C......................
      FUNCTION c2ip(al,alf,aq,pt)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/scalar/pfd,pfd2,rhma,pfq
      c1=alf*f1p(gp2)**2+aq*f1p(gp2)*f2p(gp2)
      c2=f2p(gp2)**2/4./pm**2*(2.*pfq*aq+gp2*alf/2.)
      c2ip=2.*pi*2.*rhma/al*(c1+c2)
      RETURN
      END
C....................................
      FUNCTION f1p(q2)
      COMMON/prot/pm,pi
      common/form_factors/ics
*      gmp=g(q2)*2.79
*      gep=g(q2)
      call proton_formfactors(q2,gep0,gmp0,ics)
      corr = g(q2)/g0(q2)*1000.
      gep = gep0*corr
      gmp = gmp0*corr

      tau=q2/4./pm**2
      f1p=(tau*gmp+gep)/(1.+tau) 
      RETURN
      END
C......................................
      FUNCTION f2p(q2)
      COMMON/prot/pm,pi
      common/form_factors/ics
*      gmp=g(q2)*2.79
*      gep=g(q2)
      call proton_formfactors(q2,gep0,gmp0,ics)
      corr = g(q2)/g0(q2)*1000.
      gep = gep0*corr
      gmp = gmp0*corr

      tau=q2/4./pm**2
      f2p=(gmp-gep)/(1.+tau)   
      RETURN
      END
C------------------------------------------
      FUNCTION s1in(al,alf,aq,pt)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/scalar/pfd,pfd2,rhma,pfq
      s1i1=f1n(gp2)**2*(pfd2+2.*pfd/gpv*rhma/2.+1./gpv**2*(rhma/2.)**2-
     *gp2/gpv**2*rhma/4.)
      s1i2=f2n(gp2)**2/4./pm**2*gp2*pfd2
      s1in=2.*pi*8.*(s1i1+s1i2)
      RETURN
      END
C.............................
      FUNCTION s2in(al,alf,aq,pt)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/scalar/pfd,pfd2,rhma,pfq
      s1=f1n(gp2)**2*gp2*alf*pm/gpv**2
      s2=f2n(gp2)*f1n(gp2)*(1.-gp0/gpv)*gp2/gpv
      s3=f2n(gp2)**2/2./pm**2*(1.-gp0/gpv)*gp2*pfd
      s2in=2.*pi*2.*rhma/al/pm*(s1-s2+s3)
      RETURN
      END
C.............................
      FUNCTION c1in(al,alf,aq,pt)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/scalar/pfd,pfd2,rhma,pfq
      c1=4.*f1n(gp2)**2*(-alf*al/aq**2*gp2+pt**2-pfq)
      c2=6.*f1n(gp2)*f2n(gp2)*gp2
      c3=f2n(gp2)**2/2./pm**2*(gp2*(6.*pm**2+pfq+2.*pt**2)-
     *2.*(al+alf)/aq*pfq*gp2-2.*alf**2/aq**2*gp2**2+4.*pfq**2)
      c1in=2.*pi*(c1+c2+c3)
      RETURN
      END
C......................
      FUNCTION c2in(al,alf,aq,pt)
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/scalar/pfd,pfd2,rhma,pfq
      c1=alf*f1n(gp2)**2+aq*f1n(gp2)*f2n(gp2)
      c2=f2n(gp2)**2/4./pm**2*(2.*pfq*aq+gp2*alf/2.)
      c2in=2.*pi*2.*rhma/al*(c1+c2)
      RETURN
      END
C.............................
      FUNCTION f1n(q2)
      COMMON/prot/pm,pi
      common/form_factors/ics
      call neutron_formfactors(q2,gen0,gmn0,ics)
      corr = g(q2)/g0(q2)*1000.
      gen = gen0*corr
      gmn = gmn0*corr

      tau=q2/4./pm**2
*      gen=1.91*g(q2)*tau/(1.+5.6*tau)
*      gmn=-1.91*g(q2)
      f1n=(tau*gmn+gen)/(1.+tau)
      RETURN
      END
C...............................
      FUNCTION f2n(q2)
      COMMON/prot/pm,pi
      common/form_factors/ics
      call neutron_formfactors(q2,gen0,gmn0,ics)
      corr = g(q2)/g0(q2)*1000.
      gen = gen0*corr
      gmn = gmn0*corr

      tau=q2/4./pm**2
*      gen=1.91*g(q2)*tau/(1.+5.6*tau)
*      gmn=-1.91*g(q2)
      f2n=(gmn-gen)/(1.+tau)
      RETURN
      END
C.................................
      FUNCTION g(q2)
      COMMON/dipol/gdip
      g =  1./(1.+q2/gdip)**2 * 1000.0
      RETURN
      END
      FUNCTION g0(q2)
      g0 = 1./(1.+q2/0.71)**2 * 1000.0
      RETURN
      END
C      ===============================================
C      I           INELASTIC CONTRIBUTION            I
C      ===============================================
C
C      ===============================================
C      I          CASE OF NUCLEUS WITH A > 2         I
C      ===============================================
      FUNCTION w2ina(q2,q0,q3)
      EXTERNAL piv2,alow,alup
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair
     */bound/bda,bd/targ/a,z,tm,rm/fermi/pferm/fotin/gp2,gp0,gpv,aq
     */podint/cosd,sind/simpt/rep,reu
      gp2=q2
      gp0=q0
      gpv=q3
      aq=(gp0-gpv)/pm
      sind=sqrt(gp2)/gpv
      cosd=gp0/gpv
      CALL gadap2(0.,2.,alow,alup,piv2,reu,ys)
      w2ina=pi*ys/ 100000.
      RETURN
      END
C..........................
      FUNCTION alow(pt2)
      COMMON/prot/pm,pi/detr/dm,dmx
     */bound/bda,bd/targ/a,z,tm,rm/fermi/pferm/fotin/gp2,gp0,gpv,aq
C     ALA=SQRT(AQ**2)/2.*(1.+SQRT(1.+4.*(PM**2+PT2)/GP2))
      alow = gp2/2./pm/gp0
      RETURN
      END
      FUNCTION alup(pt2)
      COMMON/prot/pm,pi/detr/dm,dmx
     */bound/bda,bd/targ/a,z,tm,rm/fermi/pferm/fotin/gp2,gp0,gpv,aq
      alup = 2.-0.001
      RETURN
      END
C........................................
      FUNCTION piv2(pt2,al)
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair
     */bound/bda,bd/targ/a,z,tm,rm/fermi/pferm/fotin/gp2,gp0,gpv,aq
     */podint/cosd,sind/pt2/ptran
      ptran = pt2
      pq=-gp2/2.*al/aq+aq/2.*rec(al,pt2)
      w2of=al*rec(al,pt2)-pt2+2.*pq-gp2
      yun=(2.*pq+al*rec(al,pt2)-pt2-pm**2)/2.
      expr = 0.0
      IF(yun.EQ.0.0) GOTO 2
      expr1=(1.+cosd)**2*(al+pq/gp2*aq)**2+sind**2*pt2/2./pm**2
      p3=1./2.*((pm**2+pt2)/al/pm-al*pm)
      p=sqrt(p3**2+pt2)
      xk = gp2 / 2. / yun
      expr=(expr1/(al**2)*pm/yun*(z*roinp(p,al)*w2bp(w2of,yun)
     &                      +(a-z)*roinn(p,al)*w2bn(w2of,yun)))*
     & emca(p,xk,gp2)
    2 exprh = 0.0
      IF(al.LE.0.0.OR.al.GE.2.0) GOTO 1
      pqh=-gp2/2.*al/aq+aq/2.*rech(al,pt2)
      w2fh=al*rech(al,pt2)-pt2+2.*pqh-gp2
      yunh=(2.*pqh+al*rech(al,pt2)-pt2-pm**2)/2.
      IF(yunh.EQ.0.0) GOTO 1
      xk = gp2 / 2. / yunh
      pk=sqrt((pm**2+pt2)/al/(2.-al)-pm**2)
      expr2=(1.+cosd)**2*(al+pqh/gp2*aq)**2+sind**2*pt2/2./pm**2
      exprh=(expr2/(al**2)*roh(p,al)*pm/yunh*(z*w2bp(w2fh,yunh)+
     *(a-z)*w2bn(w2fh,yunh)))*emc_pair(pk,xk,gp2)
    1 piv2 = (expr+exprh) * 100000.
      RETURN
      END
C............................................
      FUNCTION rec(all,pp2)
      COMMON/prot/pm,pi/detr/dm,dmx/targ/a,z,tm,rm/fermi/pferm
      rec=tm**2/a-(rm**2+pp2)/(a-all)
      RETURN
      END
C................................................
      FUNCTION rech(all,pp2)
      COMMON/prot/pm,pi/detr/dm,dmx/targ/a,z,tm,rm/fermi/pferm
      rech=dm**2/2.-(pm**2+pp2)/(2.-all)
      RETURN
      END
C................................................
      FUNCTION roinp(pin,all)
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair
     */targ/a,z,tm,rm/fermi/pferm/pers/ps,sz
C     ROINP=(1.-PS)*DP27(PIN)*PM
      roinp=(1.-ps)*table(pin,pferm) * sqrt(pm**2+pin**2)
      IF(a.EQ.12.) roinp=(1.-ps)*dpn12(pin)        * sqrt(pm**2+pin**2)
      IF(a.EQ.27.) roinp=(1.-ps)*dp27(pin)        * sqrt(pm**2+pin**2)
      IF(a.EQ.56.) roinp=(1.-ps)*dp56(pin)        * sqrt(pm**2+pin**2)
      IF(a.EQ.208.)roinp=(1.-ps)*dp208(pin)       * sqrt(pm**2+pin**2)
      RETURN
      END
      FUNCTION roinn(pin,all)
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair
     */targ/a,z,tm,rm/fermi/pferm/pers/ps,sz
C     ROINN=(1.-PS)*DN27(PIN)*PM
      roinn=(1.-ps)*table(pin,pferm) * sqrt(pm**2+pin**2)
      IF(a.EQ.12.) roinn=(1.-ps)*dpn12(pin)        * sqrt(pm**2+pin**2)
      IF(a.EQ.27.) roinn=(1.-ps)*dn27(pin)        * sqrt(pm**2+pin**2)
      IF(a.EQ.56.) roinn=(1.-ps)*dn56(pin)        * sqrt(pm**2+pin**2)
      IF(a.EQ.208.)roinn=(1.-ps)*dn208(pin)       * sqrt(pm**2+pin**2)
      RETURN
      END
C...........................................
      FUNCTION roh(pin,all)
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair
     */targ/a,z,tm,rm/fermi/pferm/pt2/pt2
      roh=0.
      IF(all.GE.2.)RETURN
      pk=sqrt((pm**2+pt2)/all/(2.-all)-pm**2)
      roh=wfhc(pk,pin)*sqrt(pm**2+pk**2)/(2.-all)
      RETURN
      END
C............................................
      FUNCTION emca(pk,xk,gp2)
      COMMON/kemc/kemc
      dl  = del(pk,0.03,0.4)
      emca = 1.0
*      return
      if(gp2.le.1.5)return  ! rough approximation  
      IF(xk.LE.0.33.OR.kemc.EQ.0) RETURN
      emca = dl
*      IF(xk.GT.0.65) RETURN
*      emca = 1.-(1.-dl)*(xk-0.33) / (0.65-0.33)
      IF(xk.GT.0.7) RETURN
      emca = 1.-(1.-dl)*(xk-0.33) / (0.7-0.33)
*      emca=1.
      RETURN
      END
C............................................
*******************************************************************
*     Accounting of EMC effect for correlated pair.               *
*     Here we take into account the proportional contributions    *
*     of pair with izospin = 1 (pp and nn pairs) and izospin = 0  *
*     (pn pairs).                                                 *
*******************************************************************
      FUNCTION emc_pair(pk,xk,gp2)
      COMMON/kemc/kemc
      dl_0 = del(pk,0.0,0.6)
      dl_1 = del(pk,0.0,0.6)
      dl   = 1./3.*dl_1 + 2./3.*dl_0
      emc_pair = 1.0
      if(gp2.le.1.5)return  ! rough approximation  
      IF(xk.LE.0.33.OR.kemc.EQ.0) RETURN
      emc_pair = dl
*      IF(xk.GT.0.65) RETURN
*      emc_pair = 1.-(1.-dl)*(xk-0.33) / (0.65-0.33)
      IF(xk.GT.0.7) RETURN
      emc_pair = 1.-(1.-dl)*(xk-0.33) / (0.7-0.33)
      RETURN
      END
C............................................
C      =======================================
C      I            DEUTRON CASE             I
C      =======================================
      FUNCTION w2ind(q2,q0,q3)
      EXTERNAL div2,alow,alup
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair
     */bound/bda,bd/targ/a,z,tm,rm/fermi/pferm/fotin/gp2,gp0,gpv,aq
     */podint/cosd,sind/simpt/rep,reu
      gp2=q2
      gp0=q0
      gpv=q3
      aq=(gp0-gpv)/pm
      sind=sqrt(gp2)/gpv
      cosd=gp0/gpv
      CALL gadap2(0.,2.,alow,alup,div2,reu,yn)
      w2ind=pi*yn / 100000.
      RETURN
      END
C..........................
      FUNCTION div2(pt2,al)
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair
     */bound/bda,bd/targ/a,z,tm,rm/fermi/pferm/fotin/gp2,gp0,gpv,aq
     */podint/cosd,sind
      div2 = 0.0
      IF(al.LE.0.0.OR.al.GE.2.0) RETURN
      recd=2.*pm**2-(pm**2+pt2)/(2.-al)
      pq=-gp2/2.*al/aq+aq/2.*recd
      w2of=al*recd-pt2+2.*pq-gp2
      yun=(2.*pq+al*recd-pt2-pm**2)/2.
      IF(yun.EQ.0.0) RETURN
      expr1=(1.+cosd)**2*(al+pq/gp2*aq)**2+sind**2*pt2/2./pm**2
      xk = gp2 / 2. / yun
      pk=sqrt((pm**2+pt2)/al/(2.-al)-pm**2)
      roind=fd(pk)*sqrt(pm**2+pk**2)/(2.-al)
      expr=expr1/(al**2)*roind*pm/yun*(w2bp(w2of,yun)+w2bn(w2of,yun))
      div2=expr*emcd(pk,xk,gp2) * 100000.
      RETURN
      END
C...........................................
*******************************************************************
*     Accounting of EMC effect for Deuteron.                      *
*******************************************************************
      FUNCTION emcd(pk,xk,gp2)
      COMMON/kemc/kemc
      dl = del(pk,0.0002,0.8)
      emcd = 1.0
      if(gp2.le.1.5)return
      IF(xk.LE.0.33.OR.kemc.EQ.0) RETURN
      emcd = dl
*      IF(xk.GT.0.65) RETURN
*      emcd = 1.-(1.-dl)*(xk-0.33) / (0.65-0.33)
      IF(xk.GT.0.7) RETURN
      emcd = 1.-(1.-dl)*(xk-0.33) / (0.7-0.33)
      RETURN
      END
C...........................................
*******************************************************************
*     EMC factor in the Point_Like Configuration Suppression      *
*     Model. (see. M.I.Strikman and L.L.Frankfurt                 *
*             Jour. Sov.Nucl.Phys......1985)                      *
*******************************************************************
      FUNCTION del(pk,eps,delta_e)    !delta factor for deuteron
      COMMON/prot/pm,pi
      del =1. / (1.  + 2.*(pk**2/2./pm+eps)/delta_e)**2
      RETURN
      END
C...................................
      FUNCTION del_a(pk,eps,delta_e)  !delta factor for nucleus
      COMMON/prot/pm,pi
      del_a =1. / (1.  + (pk**2/2./pm+eps)/delta_e)**2
      RETURN
      END
C............................................
C     ****** PROTON INELASTIC CONTRIBUTION ******
      FUNCTION w2bp(fm2,yn)
      COMMON/prot/pm,pi/fotin/gp2,gp0,gpv,aq
      w2bp=0.
      IF(yn.LE.0.0)RETURN
      xp=gp2/(2.*yn)
      IF(xp.GT.1..OR.fm2.LT.pm**2)return
      fm=sqrt(fm2)
      wwi=(2.*yn+1.642)/(gp2+0.376)
      t=1.-1./wwi
      gw=0.256*t**3+2.178*t**4+0.898*t**5-6.716*t**6+3.756*t**7
      w2bp=b(fm,gp2)*gw*wwi*xp
      RETURN
      END
C..........................................
C     ****** NEUTRON INELASTIC CONTRIBUTION ******
      FUNCTION w2bn(fm2,yn)
      COMMON/prot/pm,pi/fotin/gp2,gp0,gpv,aq
      w2bn=0.
      IF(yn.LE.0.0)RETURN
      xp=gp2/(2.*yn)
      IF(xp.GT.1..OR.fm2.LT.pm**2)return
      fm=sqrt(fm2)
      wwi=(2.*yn+1.642)/(gp2+0.376)
      t=1.-1./wwi
      gw=0.064*t**3+0.225*t**4+4.106*t**5-7.079*t**6+3.055*t**7
      w2bn=b(fm,gp2)*gw*wwi*xp
      RETURN
      END
C..........................................
C==== MOTT FACTOR=====
      FUNCTION gmott(ei,ue)
      g1=(1./137)**2*cos(ue/2.)**2
      g2=4.*ei**2*sin(ue/2.)**4
      gmott=g1/g2*0.389385*1000.*1000.
      RETURN
      END
C---------------------------------------------------------------------
C         ************************************
C         *  INCLUSION OF RADIATIVE EFFECTS  *
C         ************************************
      FUNCTION tspec(e,es,ul)
      EXTERNAL teli,telr
      COMMON/prot/pm,pi/detr/dm,dmx/targ/aj,z,tm,rm/simpt/re,ae
     */rad/tt,bt,dt,alfa,em,xsi/electr/ei,er,ue/rembo/r/tir/ti
      COMMON/simp0/eps_p,eps_u,eps_r/k_process/k_process
      ei=e
      er=es
      ue=ul
      gp2=4.*ei*er*sin(ue/2.)**2
      gp0=ei-er
      gpv=sqrt(gp2+gp0**2)
      tr=alfa*(alog(gp2/em**2)-1.)/(pi*bt)
      ti=bt*(tt/2.+tr)
*      ermax=ei/(1.+ei*(1.-cos(ue))/pm)
      ermax=ei/(1.+ei*(1.-cos(ue))/tm)
*      r=(pm+ei*(1.-cos(ue)))/(pm-ermax*(1.-cos(ue)))
      r=(tm+ei*(1.-cos(ue)))/(tm-ermax*(1.-cos(ue)))
*      esmn=er/(1.-er*(1.-cos(ue))/pm)
      esmn=er/(1.-er*(1.-cos(ue))/tm)
      a1=(r*dt/ei)**ti*(dt/er)**ti*(1.-xsi/(1.-2.*ti)/dt)
      ai=a1*spec(ei,er,ue)*af(ei,er,ue)
      bi=0.
      IF(esmn.GE.(ei-r*dt).or.esmn.le.0.)go to 111
      bp=ei-r*dt
      eps = eps_r
      CALL gadaps(esmn,bp,teli,eps,yti)
      bi=yti
  111 ci=0.
      IF((er+dt).ge.ermax)go to 112
      IF(ermax.GE.ei) go to 112
      ap=er+dt
      eps = eps_r
      CALL gadaps(ap,ermax,telr,eps,ytr)
      ci=ytr
  112 tspec=ai+bi+ci
      RETURN
      END
C  **** UNDERINTEGRAL FUNCTIONS FOR TELIN ****
      FUNCTION teli(e)
      COMMON/prot/pm,pi/detr/dm,dmx/targ/aj,z,tm,rm
     */rad/tt,bt,dt,alfa,em,xsi/electr/ei,er,ue/rembo/r/tir/ti
      teli=0.
      IF(er.GE.e)RETURN
      IF(e.GE.ei)RETURN
      b1=((ei-e)/er/r)**ti*((ei-e)/ei)**ti*(ti/(ei-e)*fs((ei-e)/ei)+
     *xsi/2./(ei-e)**2)
      teli=spec(e,er,ue)*af(e,er,ue)*b1
      RETURN
      END
C  -----------------------
      FUNCTION telr(es)
      COMMON/prot/pm,pi/detr/dm,dmx/targ/aj,z,tm,rm
     */rad/tt,bt,dt,alfa,em,xsi/electr/ei,er,ue/rembo/r/tir/ti
      telr=0.
      IF((ei-es).le.0.) return
      IF(es.LE.er)RETURN
      b1=((es-er)/es)**ti*((es-er)*r/ei)**ti*(ti/(es-er)*fs((es-er)/es)+
     *xsi/2./(es-er)**2)
      telr=spec(ei,es,ue)*af(ei,es,ue)*b1
      RETURN
      END
C====== FACTOR OF INTERNAL BREMSHTROULING =====
      FUNCTION af(x,y,u)
      COMMON/rad/tt,bt,dt,alfa,em,xsi/prot/pm,pi
      g2=4.*x*y*sin(u/2.)**2
      af1=1.+0.5772*bt*tt
      af2=2.*alfa*(-14./9.+13.*alog(g2/em/em)/12.)/pi
      af3=alfa*alog(x/y)**2/(2.*pi)
      af=af1+af2-af3
      RETURN
      END
C==== SPECTOR OF SHIFF ====
      FUNCTION fs(yy)
      fs=1.-yy+3.*yy**2/4.
      RETURN
      END
C.......................................................................
C.....BBBBBB...A....A....S....S...E........NNN..........................
C.....B....B...A....A....S....S...EEEE.......N..........................
C.....BBBB.....A....A....S....S...E....E.....N....N.....................
C.....B........AAAAAAAA..SSSSSS...EEEEEE.....NNNNNN.....................
C.......................................................................
      FUNCTION fs1(p)
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair
      wo=0.012
      fs1=0.
      IF(p.GT.1.)RETURN
      f1s=4.*(12./11.*pi*pm*wo)**(-3./2.)*exp(-11./12.*p**2/pm/wo)
      fs1=f1s/12.
      RETURN
      END
C------------------------------------------------------------------
      FUNCTION fp1(p)
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair
      wo=0.012
      fp1=0.
      IF(p.GT.1.)RETURN
      fp1=16./3.*pi*p**2*(12./11.*pi*pm*wo)**(-5./2.)*exp(-11./12.*p**2
     */pm/wo)/12.
      RETURN
      END
C.....................
      FUNCTION tet(x)
      tet=1.
      IF(x.GT.0.)RETURN
      tet=0.
      RETURN
      END
C
      FUNCTION fdnorm(x)
      fdnorm = x**2 * (fd(x))
      RETURN
      END
C
c******************************************
c     C12 Wave Functiom in momentum space *
c******************************************
      FUNCTION WFEC12(P,i)   
      COMMON/PAR/PI,PM,WO
      PI = ACOS(-1.)
      PM = 0.938279
      WO = 0.012
      WFEC12= FS1(P)+FP1(P)
      RETURN                                                            
      END                                                               
      
*virtual nucleon

      SUBROUTINE vn_incl
***********************************************************************
*     Subroutine to calculate the inclusive (ee') cross section in    *
*     virtual nucleon approximation (quasielastic scattering by       *
*     De Forest off shell approximation, inelastic one by West        *
*     approximation)                                                  *
*                                                                     *
*     Written:         March -1987 - January-1990                     *
*     Author:          Misak Sargsyan, YERPHI                         *
*     Modification:    Hovanes Egiyan                                 *
*                                                                     *
***********************************************************************
      EXTERNAL fdnorm
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair/psg/psg
     */bound/dd,bd/targ/a,z,tm,rm/fermi/pferm/sint/rep,reu
     */rad/tt,bt,dt,alfa,em,xsi/pers/ps,sz/jil/jil/ggf/ga,gd
      COMMON/simp0/eps_p,eps_u,eps_r/k_process/k_process
      COMMON/new_int/r_acc,a_acc,k_int,s_int
      common/targ3/a_3,z_3,zn_3,tm_3,rm_3
      common/nsimp/nw0
C-
	include 'common_incl.cmn'
C-
C      INCLUDE 'inclusive$src:COMMON_INCL.CMN'
c----------------------------------------------------------------------
C            PARAMETERS OF TARGET
      zn = a - z
      em=0.00051
      pm=0.938279
      dm=1.875
      dmx=1.875 - dd
      emin = 0.0
      if(a.eq.3.0.and.z.eq.2.0)emin = 0.00549
      if(a.eq.3.0.and.z.eq.1.0)emin = 0.00626
      tm=a*pm-emin
      rm=(a-1.)*pm
      a_3  = a
      z_3  = z
      zn_3 = zn
      tm_3 = tm
      rm_3 = rm
      bda=0.02
      apair=5.5
      eps = 0.001
      pfermo = pferm
      if(a.eq.12)pfermo = pferm+0.03
      CALL gadap(pfermo,2.,fdnorm,eps,pfn)
*      CALL gadaps(pferm,2.,fdnorm,eps,pfn)
      sz = 4.*acos(-1.)*pfn
      apair = ps / sz
      gd = 0.71
      ga = 0.71*(1.-psg/100.)**2
C                                  OTHER PARAMETERS
      pi=3.14159
      alfa=1./137.
                    it3 = 1
      if(z_3.lt.2.0)it3 = -1
      ini3 = 1
      xx3 = sigma_in(ei,er,ue,it3,ini3)
      

C*******************************************************************
C                           ----RADIATIVE PARAMETERS---
      bt=4./3.
      z01=alog(1440./z**(2./3.))
      z02=alog(183./z**(1./3.))
      z0=z01/z02
      an=0.6023
      rel=0.2818
      x01=4.*an*alfa*(rel**2)*z*(z+z0)
      x02=x01*z02
      x0=a/x02
      xsi=0.000154*z*tt*x0/a
C*******************************************************************
c      WRITE(7,*)'                                               '
c      WRITE(7,*)' ================================================'
c      WRITE(7,18)ei
   18 FORMAT(2x,'ENERGY OD INCIDENT ELECTRONS  ( GeV ) =',f9.5)
c      WRITE(7,*)' ================================================'
c      WRITE(7,*)' TARGET THICNESS IN MM    =',sm
c      WRITE(7,*)' ATOMIC WEIGHT A          =',a
c      WRITE(7,*)' CHARG NUMBER  Z          =',z
c      WRITE(7,*)' PAIR MASS IN NUCLEAR     =',dmx
c      WRITE(7,*)' RESPONSE ENERGY IN GEV   =',bd
c      WRITE(7,*)' FERMI MOMETUM            =',pferm
c      WRITE(7,*)' VALUE OF HIGH COMPONENT  =',ps
c      WRITE(7,*)' LEVINGER PARAMETER       =',apair
c      WRITE(7,*)' NUCLEON DIPOL PARAMETER  =',ga
c      WRITE(7,*)' ================================================'
      v_m = v_measure
c      IF(v_m.EQ.1000000.)WRITE(7,*)' =CROSS SECTION IN (mlbn/GeV/Str)='
c      IF(v_m.EQ.1000.)   WRITE(7,*)' =CROSS SECTION IN (mcbn/GeV/Str)='
c      IF(v_m.EQ.1.)      WRITE(7,*)' =CROSS SECTION IN (nbn/GeV/Str)= '
c      IF(v_m.EQ.0.001)   WRITE(7,*)' =CROSS SECTION IN (pkbn/GeV/Str)='
c      WRITE(7,*)' ================================================'
*********************************************************************
*     scattered angle range determination
*********************************************************************
      IF(the_step.NE.0.)k_tet_sum = (the_up - the_low) / the_step + 1
      IF(the_low.EQ.0.) k_tet_sum = 1
      DO k_tet = 1,k_tet_sum
        IF(k_tet_sum.EQ.1) uet = the_fix
        IF(k_tet_sum.GT.1) uet = the_low + float(k_tet-1) * the_step
        ue=uet*pi/180.
c        WRITE(7,*)'                                              '
c        WRITE(7,*)' ================================================'
c        WRITE(7,19)uet
c        WRITE(7,*)' ================================================'
   19   FORMAT(2x,'ANGLE OF SCATTERED ELECTRONS ( degr.) =',f9.5)
        IF(type_rad.EQ.0.0)then
c	WRITE(7,20)
c	WRITE(6,20)
	endif
c        IF(type_rad.EQ.1.0)WRITE(7,21)
**********************************************************************
*     selection electron spectra type
**********************************************************************
        IF(sub_type_spec.EQ.11.0)THEN
          k_sum = (er_up - er_low) / er_step + 1
        ELSEIF(sub_type_spec.EQ.12.0)THEN
          k_sum = (q0_up - q0_low) / q0_step + 1
        ELSEIF(sub_type_spec.EQ.13.0)THEN
          k_sum = (w_up - w_low) / w_step + 1
        ELSEIF(sub_type_spec.EQ.14.0)THEN
          k_sum = (x_up - x_low) / x_step + 1
        ENDIF
**********************************************************
*        TYPE *,'TOTAL CALCULATION NUMBER =',k_sum
c        ! write(6,*)'TOTAL NUMBERS TO BE CALCULATED =',k_sum
**********************************************************
        kb = 0
        DO 1 ke = 1,k_sum
          kb = kb + 1
          IF(sub_type_spec.EQ.11.0)THEN
            er = er_low + float(ke-1)*er_step
          ELSEIF(sub_type_spec.EQ.12.0)THEN
            q0 = q0_low + float(ke-1)*q0_step
            er = ei - q0
          ELSEIF(sub_type_spec.EQ.13.0)THEN
            w2 = ( w_low + float(ke-1)*w_step ) ** 2
            er=(pm**2+2.*pm*ei-w2)/(2.*pm+4.*ei*sin(ue/2.)**2)
          ELSEIF(sub_type_spec.EQ.14.0)THEN
            x = x_low + float(ke-1)*x_step
            er=(2.*pm*ei*x)/(4.*ei*sin(ue/2.)**2+2.*pm*x)
          ENDIF
          gp0=ei-er
          gp2=4.*ei*er*sin(ue/2.)**2
          gpv=sqrt(gp0**2+gp2)
          w2=pm**2+2.*pm*gp0-gp2
          x=gp2/2./pm/gp0
          IF(x.GE.2.0) GOTO 1
*        IF(type_rad.EQ.0.0)THEN    !*  20-Oct
            sp_ql_a = 0.0
            sp_in_a = 0.0
            sp_ql_d = 0.0
            sp_in_d = 0.0
            IF(k_select(1).EQ.1)THEN
              rep = eps_p
              reu = eps_u
              if(a.eq.3.0)then
              sp_ql_a = dgi3_a(ei,er,ue) / v_m  ! quasielastic cross section A=3
              elseif(a.eq.2.0)then
              sp_ql_a = dgid_a(ei,er,ue) / v_m  ! quasielastic cross section A >2
              elseif(a.gt.3.0)then
              sp_ql_a = dgia_a(ei,er,ue) / v_m  ! quasielastic cross section A >2
              endif

              rep = eps_p
              reu = eps_u
              sp_ql_d = dgid_a(ei,er,ue) / v_m  ! quasielastic cross section on deuteron
            ENDIF
            IF(k_select(2).EQ.1)THEN
              rep = eps_p
              reu = eps_u
              if(a.eq.3.0)then
              sp_in_a = dgin3_a(ei,er,ue) / v_m ! inelastic cross section  A = 3
              elseif(a.eq.2.0)then
              sp_in_a = dgind_a(ei,er,ue) / v_m ! inelastic cross section  A = 3
              elseif(a.gt.3.0)then
              sp_in_a = dgina_a(ei,er,ue) / v_m ! inelastic cross section  A > 2
              endif

              rep = eps_p
              reu = eps_u
              sp_in_d = dgind_a(ei,er,ue) / v_m ! inelastic cross section on deutron
            ENDIF
            dgea    = sp_ql_a + sp_in_a
            dged    = sp_ql_d + sp_in_d
            IF(dged.EQ.0.0) GOTO 1
C-----------------------------------------------------------
            dgw2d   =dged/(2.*pm+4.*ei*sin(ue/2.)**2)
            rel=(2.*dgea)/(a*dged)
            if(type_rad.NE.1.0)then
c            WRITE(7,101)w2,er,x,sp_ql_a,sp_in_a,dgea,sp_ql_d,sp_in_d,
c     &        dged,
c     &dgw2d,rel,gp2
            endif
c            WRITE(6,101)w2,er,x,sp_ql_a,sp_in_a,dgea,sp_ql_d,sp_in_d,
c     &        dged,
c     &dgw2d,rel,gp2

	wd2 =  -gp2 + 2.0*gp0*dm + dm**2
	if(wd2.lt.0.0)wd2 = dm**2
	epni =sqrt(wd2)-dm
************************************************
* New addition 27-Aug-2005
************************************************
      smott = gmott(ei,ue) /v_m
      epsil = 1.0/(1.0+2.0*(1.0+gp0**2/gp2)*tan(ue/2.0)**2)
      rtiv  = 0.18
      afact = 1.0 + (1.0-epsil)/epsil * 1.0/(1.0+rtiv)
      f2be_a = dgea * gp0/(smott*afact) 
      f2be_d = dged * gp0/(smott*afact) 
c      ! write(6,*)ue*180.0/pi
      ! write(23,25)uet,gp2,x,er,gp0,dgea,dged,f2be_a,f2be_d
 25   format(2(1x,f7.4),3(f8.4),4(e11.3))

*            WRITE(27,*)uet,er,dgea,tdg_tot,x,epni ! 20-Oct

*         ENDIF                   !   20-Oct
          IF(type_rad.EQ.1.0)THEN
**********************************************************************
*     Take into account radiation effects
**********************************************************************
            k_process = 1
            tdg_ql    = tspec_a(ei,er,ue) / v_m    !  quasielastic scattering
            k_process = 2
            tdg_in    = tspec_a(ei,er,ue) / v_m    !  inelastic scattering
            tdg_tot   = tdg_ql + tdg_in
c            WRITE(7,102)w2,er,x,tdg_ql,tdg_in,tdg_tot,gp0,gp2

****************************************************************
C             Fort.27-Output for PAW, Kim
*************************************************************
****************************************************
* uet     - scattered electron angle
* er      - scattered electron energt
* dgea    - cross section without radiative effects
* tdg_tot - cross section with radiative effects
* x       - Bjorken x
*****************************************************
            ratiot = tdg_tot/dgea

c          WRITE(27,*)uet,er,dgea,tdg_tot,ratiot,x !,epni ! 19- Nov 2001
c          ! write(6,*)"rad_effects",uet,er,dgea,tdg_tot,ratiot,x !,epni ! 19- Nov 2001
********************************************************
   
          dgea_qx = dgea *(3.14*gp0)/(ei*er*x) 

          tdg_tot_qx = tdg_tot * (3.14*gp0)/(ei*er*x)

*         WRITE(27,*)uet,er,dgea_qx,tdg_tot_qx,x,epni ! 19- Nov 2001
********************************************************
          ENDIF
********************************************************
*          TYPE *,'CALCULATED NUMBER =',ke
*          ! write(6,*)'CALCULATED NUMBER =',ke
********************************************************
    1   CONTINUE
        IF(type_rad.EQ.0.0)then
c	WRITE(6,22)
c	WRITE(7,22)
	endif
c        IF(type_rad.EQ.1.0)WRITE(7,23)
      ENDDO
*********************************************************
*     Init line
*********************************************************
   20 FORMAT(123('=')/4x,'W2',6x,'Ee`',5x,'X ',8x,'QL_A',7x,'IN_A',6x,
     &'TOT_A',7x,'QL_D',7x,'IN_D',6x,'TOT_D',6x,'DGW2D',6x,' REL',
     &        6x,' Q2 '/123('-'))
   21 FORMAT(78('=')/5x,'W2',6x,'q0',6x,'X ',5x,'T_QL',7x,'T_IN',7x,
     &       'T_TOT',5x,' Q0 ',4x,' Q2 ',/78('-'))
*********************************************************
*     Exit line
*********************************************************
   22 FORMAT(123('-')/4x,'W2',6x,'Ee`',5x,'X ',8x,'QL_A',7x,'IN_A',6x,
     &'TOT_A',7x,'QL_D',7x,'IN_D',6x,'TOT_D',6x,'DGW2D',6x,' REL',
     &        6x,' Q2 '/123('='))
   23 FORMAT(78('-')/5x,'W2',6x,'Ee`',6x,'X ',5x,'T_QL',7x,'T_IN',7x,
     &       'T_TOT',5x,' Q0 ',4x,' Q2 ',/78('='))
**********************************************************
*     Data Formats
***********************************************************
  101 FORMAT(3f8.4,1x,8e11.3,f8.4)
  102 FORMAT(1x,3f8.4,3e11.3,2f8.4)
   30 FORMAT(8e10.3)
      RETURN
      END
C..........................
C======================================================================
C                  SCCATTERING ON NUCLEUS WITH A > 2
C======================================================================
C          ************ FUL SPECTRUM NO RAD. EFFECTS ***********
      FUNCTION spec_a(ei,er,ue)
      COMMON/simp0/eps_p,eps_u,eps_r/k_process/k_process
      COMMON/sint/rep,reu/targ/a,z,tm,rm
      rep = eps_p
      reu = eps_u
      IF(k_process.EQ.1)THEN
        IF(a.GT.3.0) spec_a = dgia_a(ei,er,ue)
        IF(a.EQ.2.0) spec_a = dgid_a(ei,er,ue)
        IF(a.EQ.3.0) spec_a = dgi3_a(ei,er,ue)
      ELSEIF(k_process.EQ.2)THEN
        IF(a.GT.3.0) spec_a = dgina_a(ei,er,ue)
        IF(a.EQ.2.0) spec_a = dgind_a(ei,er,ue)
        IF(a.EQ.3.0) spec_a = dgin3_a(ei,er,ue)
      ENDIF
      RETURN
      END
C----------------------------------------------------------------------
C****** QUASIELASTIC SCCATTERING *******
      FUNCTION dgia_a(ei,er,ue)
      gp0=ei-er
      gp2=4.*ei*er*sin(ue/2.)**2
      gpv=sqrt(gp0**2+gp2)
      tg2=(sin(ue/2.)/cos(ue/2.))**2
      dgia_a =
     = gmott(ei,ue)*(w2ai_a(gp0,gpv,gp2)+2.*tg2*w1ai_a(gp0,gpv,gp2))
      RETURN
      END
C............................
C****** INELASTIC SCCATTERING ********
      FUNCTION dgina_a(ei,er,ue)
      gp0=ei-er
      gp2=4.*ei*er*sin(ue/2.)**2
      gpv=sqrt(gp0**2+gp2)
      tg2=(sin(ue/2.)/cos(ue/2.))**2
      w2cd=w2ina_a(gp2,gp0,gpv)
      w1cd=(1.+gp0**2/gp2)/(1.+0.18)*w2cd
      dgina_a = gmott(ei,ue)*(w2cd+2.*tg2*w1cd)
      RETURN
      END
C======================================================================
C
C======================================================================
C                     SCCATTERING ON DEUTRON
C======================================================================
C          ************ FUL SPECTRUM NO RAD. EFFECTS ***********
      FUNCTION specd_a(ei,er,ue)
      specd_a = dgid_a(ei,er,ue) + dgind_a(ei,er,ue)
      RETURN
      END
C----------------------------------------------------------------------
C****** QUASIELASTIC SCCATTERING ******
      FUNCTION dgid_a(ei,er,ue)
      gp0=ei-er
      gp2=4.*ei*er*sin(ue/2.)**2
      gpv=sqrt(gp0**2+gp2)
      tg2=(sin(ue/2.)/cos(ue/2.))**2
      dgid_a =
     = gmott(ei,ue)*(w2di_a(gp0,gpv,gp2)+2.*tg2*w1di_a(gp0,gpv,gp2))
      RETURN
      END
C****** INELASTIC SCCATTERING *******
      FUNCTION dgind_a(ei,er,ue)
      gp0=ei-er
      gp2=4.*ei*er*sin(ue/2.)**2
      gpv=sqrt(gp0**2+gp2)
      tg2=(sin(ue/2.)/cos(ue/2.))**2
      w2cd=w2ind_a(gp2,gp0,gpv)
      w1cd=(1.+gp0**2/gp2)/(1.+0.18)*w2cd
      dgind_a=gmott(ei,ue)*(w2cd+2.*tg2*w1cd)
      RETURN
      END
C=======================================================================
C                     SCCATTERING ON HELIUM/TRITIUM
C======================================================================
***************************************
*       QUASIELASTIC SCCATTERING      *
***************************************
      function dgi3_a(ei,er,ue)
      gp0=ei-er
      gp2=4.*ei*er*sin(ue/2.)**2
      gpv=sqrt(gp0**2+gp2)
      tg2=(sin(ue/2.)/cos(ue/2.))**2
      dgi3_a =
     = gmott(ei,ue)*(w2i3_a(gp0,gpv,gp2)+2.*tg2*w1i3_a(gp0,gpv,gp2))
      return
      end
**************************************
*       INELASTIC SCCATTERING        *
**************************************
      FUNCTION dgin3_a(ei,er,ue)
      common/ttarget/an,zp,zn,tm,emin
                   it =  1
      if(zp.lt.1.5)it = -1
      ini = 0
      xx = sigma_in(ei,er,ue,it,ini) 
      dgin3_a = xx
      RETURN
      END

C--------------------------------
      FUNCTION w2ai_a(q0,qv,q2)
      EXTERNAL w2aii_a
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv
     */targ/a,z,tm,rm/sint/rep,reu
      COMMON/new_int/r_acc,a_acc,k_int,s_int
      common/nsimp/nw0
      gp0=q0
      gpv=qv
      gp2=q2
      pfa=0.001
      pfb=sqrt((gpv+1.6)**2)
      IF(k_int.EQ.0)THEN
        CALL simps(pfa,pfb,s_int,r_acc,a_acc,w2aii_a,rol,rol2,rol3)
      ELSEif(k_int.eq.1)then
        CALL gadap(pfa,pfb,w2aii_a,rep,rol)
      ELSEif(k_int.eq.2)then
	nw = 1000*nw0
        CALL simpson(pfa,pfb,w2aii_a,nw,rol)
      ENDIF
      w2ai_a=(a*pi/2.)*rol / 1000000.
      RETURN
      END
C.................................
      FUNCTION w2aii_a(pr)
      COMMON/prot/pm,pi/foton/qp0,qp2,qpv/detr/dm,dmx
     */bound/bda,bd/targ/a,z,tm,rm
     */type/ktype/ggf/ga,gd
      zn = a - z
      epr = sqrt(pm**2+pr**2)
      csp = ((pr**2+qpv**2+2.*pm*epr)-2.*pm*(qp0+pm-bd))/2./pr/qpv
      csm = (pm**2+pr**2+qpv**2-(qp0+dmx-epr)**2)/(2.*pr*qpv)
      pod2p = 0.0
      pod2m = 0.0
      IF(csp**2.gt.1.)goto 13
      ktype = 1
      pp = 0.0
      p2p = pr**2 + qpv**2 - 2.*pr*qpv*csp
      IF(p2p.GT.0.0) pp  = sqrt(p2p)
      ep  = sqrt(pm**2+p2p)
      qn2p  = qpv**2 - (epr-ep)**2
      sip = sqrt(1.-csp**2)
      podip =  pr / (epr*qpv)
      ap1 = qp2*(qn2p-qp2)*t1(pp,qn2p,qp2,a,z,zn,ga)/(qn2p*qpv**2)
      ap2 = (qp2*(epr+ep)/(2.*qpv**2))**2
      ap3 = qp2*(pr*sip)**2/(2.*qpv**2)
      ap4 = (ap2+ap3)*t2(pp,qn2p,qp2,a,z,zn,ga)/pm**2
      ap  = ap1 + ap4
      pod2p = podip * ap
   13 CONTINUE
      IF(csm**2.gt.1)goto 17
      ktype = 2
      ppm = 0.0
      p2m = pr**2 + qpv**2 - 2.*pr*qpv*csm
      IF(p2m.GT.0.0) ppm = sqrt(p2m)
      epm = sqrt(pm**2+p2m)
      west = (dmx - epm) / pm
      IF(west.LE.0.0)GOTO 17
      qn2m  = qpv**2 - (epr-epm)**2
      sim = sqrt(1.-csm**2)
      podim =  pr / (epr*qpv)
      am1 = qp2*(qn2m-qp2)*t1(ppm,qn2m,qp2,a,z,zn,gd)/(qn2m*qpv**2)
      am2 = (qp2*(epr+epm)/(2.*qpv**2))**2
      am3 = qp2*(pr*sim)**2/(2.*qpv**2)
      am4 = (am2+am3)*t2(ppm,qn2m,qp2,a,z,zn,gd)/pm**2
      am  = am1 + am4
      pod2m = podim * am/ west
   17 w2aii_a = (pod2p + pod2m) !* 100000.
      RETURN
      END
C-----------------------------------------
      FUNCTION w1ai_a(q0,qv,q2)
      EXTERNAL w1aii_a
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv
     */targ/a,z,tm,rm/sint/rep,reu
      COMMON/new_int/r_acc,a_acc,k_int,s_int
      common/nsimp/nw0
      gp0=q0
      gpv=qv
      gp2=q2
      pfa=0.001
      pfb=sqrt((gpv+1.6)**2)
      IF(k_int.EQ.0)THEN
        CALL simps(pfa,pfb,s_int,r_acc,a_acc,w1aii_a,rol,rol2,rol3)
      ELSEif(k_int.eq.1)then
        CALL gadap(pfa,pfb,w1aii_a,rep,rol)
      ELSEif(k_int.eq.2)then  
	nw = 1000*nw0
        CALL simpson(pfa,pfb,w1aii_a,nw,rol)
      ENDIF
      w1ai_a=(a*pi/2.)*rol/ 1000000.
      RETURN
      END
C.................................
      FUNCTION w1aii_a(pr)
      COMMON/prot/pm,pi/foton/qp0,qp2,qpv/detr/dm,dmx
     */bound/bda,bd/targ/a,z,tm,rm
     */type/ktype/ggf/ga,gd
      zn = a - z
      epr = sqrt(pm**2+pr**2)
      csp = ((pr**2+qpv**2+2.*pm*epr)-2.*pm*(qp0+pm-bd))/2./pr/qpv
      csm = (pm**2+pr**2+qpv**2-(qp0+dmx-epr)**2)/(2.*pr*qpv)
      pod1p = 0.0
      pod1m = 0.0
      IF(csp**2.gt.1.)goto 13
      ktype = 1
      pp =  0.0
      p2p = pr**2 + qpv**2 - 2.*pr*qpv*csp
      IF(p2p.GT.0.0) pp  = sqrt(p2p)
      ep  = sqrt(pm**2+p2p)
      sip = sqrt(1.-csp**2)
      podip =  pr / (epr*qpv)
      qn2p  = qpv**2 - (epr-ep)**2
      bp =             t1(pp,qn2p,qp2,a,z,zn,ga) +
     &     (pr*sip)**2*t2(pp,qn2p,qp2,a,z,zn,ga)/(2.*pm**2)
      pod1p = podip * bp
   13 CONTINUE
      IF(csm**2.gt.1)goto 17
      ktype = 2
      ppm = 0.0
      p2m = pr**2 + qpv**2 - 2.*qpv*pr*csm
      IF(p2m.GT.0.0) ppm = sqrt(p2m)
      epm = sqrt(pm**2 + p2m)
      west = (dmx - epm) / pm
      IF(west.LE.0.0)GOTO 17
      qn2m = qpv**2 - (epr-epm)**2
      sim  = sqrt(1.-csm**2)
      podim =  pr/(epr*qpv)
      bm =         t1(ppm,qn2m,qp2,a,z,zn,gd) +
     & (pr*sim)**2*t2(ppm,qn2m,qp2,a,z,zn,gd)/(2.*pm**2)
      pod1m = podim * bm / west
   17 w1aii_a = (pod1p + pod1m) !* 100000.
      RETURN
      END
C................................
      FUNCTION t1(p,x2,q2,a,z,zn,gx)
      COMMON/type/ktype
      common/form_factors/ics
      call  proton_formfactors(q2,gep0,gmp0,ics)
      call neutron_formfactors(q2,gen0,gmn0,ics)
      gmp = gmp0*1000.
      gmn = gmn0*1000.

*      gmp =  2.79 * g_a(q2,gx)
*      gmn = -1.91 * g_a(q2,gx)
      IF(ktype.EQ.1)THEN
        t1 = x2*((z/a)*sp(p)*gmp**2 + (zn/a)*sn(p)*gmn**2)
        RETURN
      ELSEIF(ktype.EQ.2)THEN
        t1 = x2*((z/a)*gmp**2 + (zn/a)*gmn**2)*hc(p)
        RETURN
      ELSEIF(ktype.EQ.3)THEN
        t1 = x2*((z/a)*gmp**2 + (zn/a)*gmn**2)*fd(p)
        RETURN
      ENDIF
      RETURN
      END
C.................................
      FUNCTION t2(p,y2,q2,a,z,zn,gx)
      COMMON/prot/pm,pi/type/ktype
      common/form_factors/ics
      call  proton_formfactors(q2,gep0,gmp0,ics)
      call neutron_formfactors(q2,gen0,gmn0,ics)
      gep = gep0*1000.
      gmp = gmp0*1000.

      gen = gen0*1000.
      gmn = gmn0*1000.

*      gep = g_a(q2,gx)
*      gen = (1.91*g_a(q2,gx)*y2/(4.*pm**2))/(1.+5.6*q2/(4.*pm**2))
*      gmp =  2.79 * g_a(q2,gx)
*      gmn = -1.91 * g_a(q2,gx)
      fn  = gen**2 + (y2/(4.*pm**2))*gmn**2
      fp  = gep**2 + (y2/(4.*pm**2))*gmp**2
      IF(ktype.EQ.1)THEN
        t2 =(4.*pm**2)*((z/a)*sp(p)*fp + (zn/a)*sn(p)*fn)/(1.+y2/4./pm**
     &    2)
        RETURN
      ELSEIF(ktype.EQ.2)THEN
        t2 = (4.*pm**2)*((z/a)*fp + (zn/a)*fn)/(1.+y2/4./pm**2)*hc(p)
        RETURN
      ELSEIF(ktype.EQ.3)THEN
        t2 = (4.*pm**2)*((z/a)*fp + (zn/a)*fn)/(1.+y2/4./pm**2)*fd(p)
        RETURN
      ENDIF
      RETURN
      END
C******* PROTON MOMENTUM DISTRIBUTION ********
      FUNCTION sp(pp)
      COMMON/prot/pm,pi/fermi/pferm/pers/ps,sz/targ/a,z,tm,rm
      sp = (1.-ps) * table(pp,pferm)
      IF(a.EQ.12.) sp = (1.-ps) * dpn12(pp)
      IF(a.EQ.27.) sp = (1.-ps) * dp27(pp)
      IF(a.EQ.56.) sp = (1.-ps) * dp56(pp)
      IF(a.EQ.208.)sp = (1.-ps) * dp208(pp)
      RETURN
      END
C******* NEUTRON MOMENTUM DISTRIBUTION *******
      FUNCTION sn(pp)
      COMMON/prot/pm,pi/fermi/pferm/pers/ps,sz/targ/a,z,tm,rm
      sn = (1.-ps) * table(pp,pferm)
      IF(a.EQ.12.) sn = (1.-ps) * dpn12(pp)
      IF(a.EQ.27.) sn = (1.-ps) * dn27(pp)
      IF(a.EQ.56.) sn = (1.-ps) * dn56(pp)
      IF(a.EQ.208.)sn = (1.-ps) * dn208(pp)
      RETURN
      END
C******** HIGH COMPONENT OF NUCLEAR WAVE FUNCTION *******
      FUNCTION hc(pp)
      COMMON/prot/pm,pi/fermi/pferm/pair/apair/pers/ps,sz
      hc = tet(pp-pferm) * apair * fd(pp)
      RETURN
      END
C................................
C*************************************
C  QUASIELASTIC DEUTERON FORMFACTORS *
C*************************************
      FUNCTION w2di_a(q0,qv,q2)
      EXTERNAL w2ii_a
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/sint/rep,reu/type/ktype
      COMMON/new_int/r_acc,a_acc,k_int,s_int
      common/nsimp/nw0
      ktype = 3
      gp0=q0
      gpv=qv
      gp2=q2
      pfa=0.001
      pfb=sqrt((gpv+1.6)**2)
      IF(k_int.EQ.0)THEN
        CALL simps(pfa,pfb,s_int,r_acc,a_acc,w2ii_a,rol,rol2,rol3)
      ELSEif(k_int.eq.1)then
        CALL gadap(pfa,pfb,w2ii_a,rep,rol)
      ELSEif(k_int.eq.2)then
	nw = 1000*nw0
        CALL simpson(pfa,pfb,w2ii_a,nw,rol)
      ENDIF
      w2di_a=pi*rol / 1000000.
      RETURN
      END
C.................................
      FUNCTION w2ii_a(pr)
      COMMON/prot/pm,pi/foton/qp0,qp2,qpv/detr/dm,dmx
     */bound/bda,bd/targ/a,z,tm,rm
     */ggf/ga,gd
      epr = sqrt(pm**2+pr**2)
      cspr = (pm**2+pr**2+qpv**2-(qp0+dm-epr)**2)/(2.*pr*qpv)
      w2ii_a = 0.0
      IF(cspr**2.gt.1.)return
      p = 0.0
      p2 = pr**2 + qpv**2 - 2.*pr*qpv*cspr
      IF(p2.GT.0.0) p  = sqrt(p2)
      ep  = sqrt(pm**2+p2)
      west = (dm - ep) / pm
      IF(west.LE.0.0)RETURN
      sipr = sqrt(1.-cspr**2)
      qn2  = qpv**2 - (epr-ep)**2
      pdi =  pr / (epr*qpv)
      ar1 = qp2*(qn2-qp2)/(qn2*qpv**2)*t1(p,qn2,qp2,2.,1.,1.,gd)
      ar2 = (qp2*(epr+ep)/(2.*qpv**2))**2
      ar3 = qp2*(pr*sipr)**2/(2.*qpv**2)
      ar4 = (ar2+ar3)*t2(p,qn2,qp2,2.,1.,1.,gd)/pm**2
      ar  = ar1 + ar4
      w2ii_a = (pdi * ar) / west !* 100000.
      RETURN
      END
C-----------------------------------------
      FUNCTION w1di_a(q0,qv,q2)
      EXTERNAL w1ii_a
      COMMON/prot/pm,pi/foton/gp0,gp2,gpv/sint/rep,reu/type/ktype
      COMMON/new_int/r_acc,a_acc,k_int,s_int
      common/nsimp/nw0
      ktype = 3
      gp0=q0
      gpv=qv
      gp2=q2
      pfa=0.001
      pfb=sqrt((gpv+1.6)**2)
      IF(k_int.EQ.0)THEN
        CALL simps(pfa,pfb,s_int,r_acc,a_acc,w1ii_a,rol,rol2,rol3)
      ELSEif(k_int.eq.1)then
        CALL gadap(pfa,pfb,w1ii_a,rep,rol)
      ELSEif(k_int.eq.2)then
	nw = 1000*nw0
        CALL simpson(pfa,pfb,w1ii_a,nw,rol)
      ENDIF
      w1di_a=pi*rol / 1000000.
      RETURN
      END
C.................................
      FUNCTION w1ii_a(pr)
      COMMON/prot/pm,pi/foton/qp0,qp2,qpv/detr/dm,dmx
     */bound/bda,bd/targ/a,z,tm,rm
     */ggf/ga,gd
      epr = sqrt(pm**2+pr**2)
      cspr = (pm**2+pr**2+qpv**2-(qp0+dm-epr)**2)/(2.*pr*qpv)
      w1ii_a = 0.0
      IF(cspr**2.gt.1.)return
      p = 0.0
      p2 = pr**2 + qpv**2 - 2.*pr*qpv*cspr
      IF(p2.GT.0.0) p  = sqrt(p2)
      ep  = sqrt(pm**2+p2)
      west = (dm - ep) / pm
      IF(west.LE.0.0)RETURN
      sipr = sqrt(1.-cspr**2)
      qn2  = qpv**2 - (epr-ep)**2
      pdi =  pr / (epr*qpv)
      bp =              t1(p,qn2,qp2,2.,1.,1.,gd) +
     &     (pr*sipr)**2*t2(p,qn2,qp2,2.,1.,1.,gd)/(2.*pm**2)
      w1ii_a = pdi * bp / west !* 100000.
      RETURN
      END



***********************************************************************
*  Quasielastic scattering from Helium/Tritium
***********************************************************************

C--------------------------------
      function w2i3_a(q0,qv,q2)
      external w2ii3_a
      common/prot/pm,pi
      common/foton/gp0,gp2,gpv
      common/targ3/a,z,zn,tm,rm

      common/sint/rep,reu
      common/new_int/r_acc,a_acc,k_int,s_int
      common/nsimp/nw0
      gp0=q0
      gpv=qv
      gp2=q2
      pfa=0.001
      pfb=sqrt((gpv+1.6)**2)
      if(k_int.eq.0)THEN
        CALL simps(pfa,pfb,s_int,r_acc,a_acc,w2ii3_a,rol,rol2,rol3)
      elseif(k_int.eq.1)then
        CALL gadap(pfa,pfb,w2ii3_a,rep,rol)
      elseif(k_int.eq.2)then
	nw = 1000*nw0
        CALL simpson(pfa,pfb,w2ii3_a,nw,rol)
      endif
      w2i3_a=(a*pi/2.)*rol/ 1000000.
      return
      end
C.................................
      function w2ii3_a(pr)
      common/prot/pm,pi
      common/foton/qp0,qp2,qpv
      common/detr/dm,dmx
      common/bound/bda,bd
      common/targ3/a,z,zn,tm,rm
      common/type/ktype
      common/ggf/ga,gd
      common/fermi/pferm      
      epr = sqrt(pm**2+pr**2)
      pod2p  = 0.0	
******************************************************************
*    TWO BODY BREAK UP CONTRIBUTION
******************************************************************
*     angle between knocked-out nucleon and q in two-body break-up
      csp=(dm**2-tm**2-pm**2+qp2-2.*qp0*tm+2.*(qp0+tm)*epr)/2./pr/qpv


      IF(csp**2.gt.1.)goto 12
      ktype = 1
      pp = 0.0
      p2p = pr**2 + qpv**2 - 2.*pr*qpv*csp
      IF(p2p.GT.0.0) pp  = sqrt(p2p)
      ep  = sqrt(pm**2+p2p)
      qn2p  = qpv**2 - (epr-ep)**2
      sip = sqrt(1.-csp**2)
      podip =  pr / (epr*qpv)
      west = tm - sqrt(dm**2 +p2p)
      if(west.le.0.0)goto 12
      if(z.ge.2)then
      ap1 = qp2*(qn2p-qp2)*t1_3(pp,qn2p,qp2,a,z,zn-1.,ga)/(qn2p*qpv**2)
      else
      ap1 = qp2*(qn2p-qp2)*t1_3(pp,qn2p,qp2,a,z-1.,zn,ga)/(qn2p*qpv**2)
      endif

      ap2 = (qp2*(epr+ep)/(2.*qpv**2))**2
      ap3 = qp2*(pr*sip)**2/(2.*qpv**2)
      if(z.ge.2)then
      ap4 = (ap2+ap3)*t2_3(pp,qn2p,qp2,a,z,zn-1.,ga)/pm**2
      else
      ap4 = (ap2+ap3)*t2_3(pp,qn2p,qp2,a,z-1.,zn,ga)/pm**2
      endif
      ap  = ap1 + ap4
      pod2p = podip * ap /west

12    continue
      pod2m = 0.0
******************************************************************
*    THREE BODY BREAK UP - MEAN FIELD CONTRIBUTION
******************************************************************
*     angle between knocked-out nucleon and q in three-body break-up mean field
      cspm = 
     &  ((2.*pm)**2-tm**2-pm**2+qp2-2.*qp0*tm+2.*(qp0+tm)*epr)/2./pr/qpv

      if(cspm**2.gt.1.)goto 13
      ktype = 2
      pp = 0.0
      p2p = pr**2 + qpv**2 - 2.*pr*qpv*cspm
      IF(p2p.GT.0.0) pp  = sqrt(p2p)
      if(pp.gt.pferm)goto 13
      ep  = sqrt(pm**2+p2p)
      qn2p  = qpv**2 - (epr-ep)**2
      sip = sqrt(1.-cspm**2)
      podip =  pr / (epr*qpv)
      west = tm - sqrt(4.*pm**2+p2p)
      if(west.le.0.0)goto 13
      ap1 = qp2*(qn2p-qp2)*t1_3(pp,qn2p,qp2,a,z,zn,ga)/(qn2p*qpv**2)
      ap2 = (qp2*(epr+ep)/(2.*qpv**2))**2
      ap3 = qp2*(pr*sip)**2/(2.*qpv**2)
      ap4 = (ap2+ap3)*t2_3(pp,qn2p,qp2,a,z,zn,ga)/pm**2
      ap  = ap1 + ap4
      pod2m = podip * ap/west
*      ! write(6,*)pferm
      if(pod2m.gt.0.0)goto 17

   13 continue
******************************************************************
*    THREE BODY BREAK UP - SRC CONTRIBUTION
******************************************************************
*     angle between knocked-out nucleon and q in the three-body break-up SRC
      csm = (qp2-2.*qp0*dmx-dmx**2+2.*epr*(qp0+dmx))/(2.*pr*qpv)
      csm = (pm**2+pr**2+qpv**2-(qp0+dmx-epr)**2)/(2.*pr*qpv)

      if(csm**2.gt.1)goto 17
      ktype = 2
      ppm = 0.0
      p2m = pr**2 + qpv**2 - 2.*pr*qpv*csm
      if(p2m.gt.0.0) ppm = sqrt(p2m)
*      if(ppm.lt.pferm)goto 17
*      if(ppm.le.0.4)! write(6,*)ppm,csm,pm,dmx
      epm = sqrt(pm**2+p2m)
      west = (dmx - epm) / pm
      if(west.le.0.0)goto 17
      qn2m  = qpv**2 - (epr-epm)**2
      sim = sqrt(1.-csm**2)
      podim =  pr / (epr*qpv)
      am1 = qp2*(qn2m-qp2)*t1_3(ppm,qn2m,qp2,a,z,zn,gd)/(qn2m*qpv**2)
      am2 = (qp2*(epr+epm)/(2.*qpv**2))**2
      am3 = qp2*(pr*sim)**2/(2.*qpv**2)
      am4 = (am2+am3)*t2_3(ppm,qn2m,qp2,a,z,zn,gd)/pm**2
      am  = am1 + am4
      pod2m = podim * am / west

   17 w2ii3_a = (pod2p + pod2m) !* 100000.
      return
      end







C-----------------------------------------
      function w1i3_a(q0,qv,q2)
      external w1ii3_a
      common/prot/pm,pi
      common/foton/gp0,gp2,gpv
      common/targ3/a,z,zn,tm,rm

      common/sint/rep,reu
      common/new_int/r_acc,a_acc,k_int,s_int
      common/nsimp/nw0
      gp0=q0
      gpv=qv
      gp2=q2
      pfa=0.001
      pfb=sqrt((gpv+1.6)**2)
      if(k_int.eq.0)then
        call simps(pfa,pfb,s_int,r_acc,a_acc,w1ii3_a,rol,rol2,rol3)
      elseif(k_int.eq.1)then
        call gadap(pfa,pfb,w1ii3_a,rep,rol)
      elseif(k_int.eq.2)then  
	nw = 1000*nw0
        call simpson(pfa,pfb,w1ii3_a,nw,rol)
      endif
      w1i3_a=(a*pi/2.)*rol / 1000000.
      return
      end
C.................................
      function w1ii3_a(pr)
      common/prot/pm,pi
      common/foton/qp0,qp2,qpv
      common/detr/dm,dmx
      common/bound/bda,bd
      common/targ3/a,z,zn,tm,rm
      common/fermi/pferm
      common/type/ktype
      common/ggf/ga,gd

      epr = sqrt(pm**2+pr**2)

      pod1p = 0.0
******************************************************************
*    TWO BODY BREAK UP CONTRIBUTION
******************************************************************
*     angle between knocked-out nucleon and q in two-body break-up
      csp=(dm**2-tm**2-pm**2+qp2-2.*qp0*tm+2.*(qp0+tm)*epr)/2./pr/qpv

*      ! write(6,*)dm,tm,pm,qp2,qp0,epr,qpv

      if(csp**2.gt.1.)goto 12
      ktype = 1
      pp =  0.0
      p2p = pr**2 + qpv**2 - 2.*pr*qpv*csp
      if(p2p.GT.0.0) pp  = sqrt(p2p)
      ep  = sqrt(pm**2+p2p)
      sip = sqrt(1.-csp**2)
      podip =  pr / (epr*qpv)
      qn2p  = qpv**2 - (epr-ep)**2
      if(z.ge.2.0)then
      bp =             t1_3(pp,qn2p,qp2,a,z,zn-1,ga) +
     &     (pr*sip)**2*t2_3(pp,qn2p,qp2,a,z,zn-1,ga)/(2.*pm**2)
      else
      bp =             t1_3(pp,qn2p,qp2,a,z-1,zn,ga) +
     &     (pr*sip)**2*t2_3(pp,qn2p,qp2,a,z-1,zn,ga)/(2.*pm**2)
      endif
      pod1p = podip * bp

12    continue
      pod1m = 0.0
******************************************************************
*    THREE BODY BREAK UP - MEAN FIELD CONTRIBUTION
******************************************************************
*     angle between knocked-out nucleon and q in three-body break-up mean field
      cspm = 
     &  ((2.*pm)**2-tm**2-pm**2+qp2-2.*qp0*tm+2.*(qp0+tm)*epr)/2./pr/qpv
 
      IF(cspm**2.gt.1.)goto 13
      ktype = 2
      pp =  0.0
      p2p = pr**2 + qpv**2 - 2.*pr*qpv*cspm
      IF(p2p.GT.0.0) pp  = sqrt(p2p)
	if(pp.gt.pferm)goto 13
      ep  = sqrt(pm**2+p2p)
      sip = sqrt(1.-cspm**2)
      podip =  pr / (epr*qpv)
      qn2p  = qpv**2 - (epr-ep)**2
      bp =             t1_3(pp,qn2p,qp2,a,z,zn,ga) +
     &     (pr*sip)**2*t2_3(pp,qn2p,qp2,a,z,zn,ga)/(2.*pm**2)
      
      pod1m = podip * bp 
      if(pod1m.gt.0.0)goto 17

13    continue
      pod1m = 0.0
******************************************************************
*    THREE BODY BREAK UP - SRC CONTRIBUTION
******************************************************************
*     angle between knocked-out nucleon and q in the three-body break-up
      csm = (qp2-2.*qp0*dmx-dmx**2+2.*epr*(qp0+dmx))/(2.*pr*qpv)

      if(csm**2.gt.1)goto 17
      ktype = 2
      ppm = 0.0
      p2m = pr**2 + qpv**2 - 2.*qpv*pr*csm
      if(p2m.GT.0.0) ppm = sqrt(p2m)
      epm = sqrt(pm**2 + p2m)
      west = (dmx - epm) / pm
      IF(west.LE.0.0)GOTO 17
      qn2m = qpv**2 - (epr-epm)**2
      sim  = sqrt(1.-csm**2)
      podim =  pr/(epr*qpv)
      bm =         t1_3(ppm,qn2m,qp2,a,z,zn,gd) +
     & (pr*sim)**2*t2_3(ppm,qn2m,qp2,a,z,zn,gd)/(2.*pm**2)
      pod1m = podim * bm / west
   17 w1ii3_a = (pod1p + pod1m) !* 100000.
      return
      end
C................................
      function t1_3(p,x2,q2,a,z,zn,gx)
      common/type/ktype
      common/form_factors/ics
      call  proton_formfactors(q2,gep0,gmp0,ics)
      call neutron_formfactors(q2,gen0,gmn0,ics)
      gmp = gmp0*1000.
      gmn = gmn0*1000.

*      gmp =  2.79 * g_a(q2,gx)
*      gmn = -1.91 * g_a(q2,gx)
      if(ktype.eq.1)then
        t1_3 = x2*((z/a)*sp3_2(p)*gmp**2 + (zn/a)*sn3_2(p)*gmn**2)
      return
      elseif(ktype.eq.2)then
        t1_3 = x2*((z/a)*gmp**2*sp3_3(p) + (zn/a)*gmn**2*sn3_3(p))
      return
      endif
      return
      end
C.................................
      function t2_3(p,y2,q2,a,z,zn,gx)
      common/prot/pm,pi
      common/type/ktype
      common/form_factors/ics
      call  proton_formfactors(q2,gep0,gmp0,ics)
      call neutron_formfactors(q2,gen0,gmn0,ics)
      gep = gep0*1000.
      gmp = gmp0*1000.

      gen = gen0*1000.
      gmn = gmn0*1000.

*      gep = g_a(q2,gx)
*      gen = (1.91*g_a(q2,gx)*y2/(4.*pm**2))/(1.+5.6*q2/(4.*pm**2))
*      gmp =  2.79 * g_a(q2,gx)
*      gmn = -1.91 * g_a(q2,gx)
      fn  = gen**2 + (y2/(4.*pm**2))*gmn**2
      fp  = gep**2 + (y2/(4.*pm**2))*gmp**2
      if(ktype.EQ.1)then
        t2_3 =(4.*pm**2)*((z/a)*sp3_2(p)*fp + 
     &                   (zn/a)*sn3_2(p)*fn)/(1.+y2/4./pm**2)
        return
      elseif(ktype.eq.2)then
        t2_3 = (4.*pm**2)*((z/a)*sp3_3(p)*fp + 
     &	                  (zn/a)*sn3_3(p)*fn)/(1.+y2/4./pm**2)
      return
      endif
      return
      end
C******* PROTON TWO-BODY BREAK-UP MOMENTUM DISTRIBUTION ********
      function sp3_2(pp)
      common/targ3/a,z,zn,tm,rm
      if(z.ge.2.0)sp3_2 = dngr(pp)
      if(z.lt.2.0)sp3_2 = 0.0 !dngr(pp)
      return
      end
C******* NEUTRON TWO-BODY BREAK-UP MOMENTUM DISTRIBUTION *******
      function sn3_2(pp)
      common/targ3/a,z,zn,tm,rm
      if(z.ge.2.0)sn3_2 = 0.0 !dngr(pp)
      if(z.lt.2.0)sn3_2 = dngr(pp)
      return
      end
C******** PROTON THREE-BODY BREAK-UP MOMENTUM DISTRIBUTION  *******
      function sp3_3(pp)
      common/targ3/a,z,zn,tm,rm
       if(z.ge.2.0)then
         in=1
         sp3_3 = dnex(in,pp)
      else
          in=0
         sp3_3 = dnex(in,pp)
      endif
      return
      end

C******** NEUTRON THREE-BODY BREAK-UP MOMENTUM DISTRIBUTION  *******
      function sn3_3(pp)
      common/targ3/a,z,zn,tm,rm
      if(z.ge.2.0)then
         in=0
         sn3_3 = dnex(in,pp)
      else
          in=1
         sn3_3 = dnex(in,pp)
      endif
      return
      end



C-----------------------------------------
      FUNCTION g_a(q2,ggf)
      g_a = 1./(1.+q2/ggf)**2 * 1000.0
      RETURN
      END
C      ===============================================
C      I           INELASTIC CONTRIBUTION            I
C      ===============================================
C
C      ===============================================
C      I          CASE OF NUCLEUS WITH A > 2         I
C      ===============================================
      FUNCTION w2ina_a(q2,q0,q3)
      EXTERNAL piv2_a,ul,uup
      COMMON/prot/pm,pi
     */fotin/gp2,gp0,gpv,aq
     */sint/rep,reu
      gp2=q2
      gp0=q0
      gpv=q3
      CALL gadap2(0.,1.5,ul,uup,piv2_a,reu,ys)
      w2ina_a= 2.*pi*ys/ 100000.
      RETURN
      END
C........................................
      FUNCTION piv2_a(pn,u)
      COMMON/prot/pm,pi/detr/dm,dmx/pair/apair
     */bound/bda,bd/targ/a,z,tm,rm/fermi/pferm/fotin/gp2,gp0,gpv,aq
      expr = 0.0
      exph = 0.0
      en = pm - bd - pn**2/2./pm
      pq= en * gp0 - pn * gpv * u
      w2of = en**2 - pn**2 + 2.*pq - gp2
      yun=(w2of + gp2 - pm**2)/2.
      expr = 0.0
      xtil = gp2/yun/2.0
*      IF(yun.lE.0.0.or.xtil.gt.1.0) GOTO 1
      IF(yun.lE.0.0) GOTO 1
      expr1 = (1.+pn*u*gp2/(pq*gpv))**2*(pq/pm/gp0)**2 +
     &         pn**2*(1.-u**2)/2.*pm**2*(gp2/gpv**2)
      expr=expr1*pm/yun*(z*sp(pn)*w2bp_a(w2of,yun)
     &              +(a-z)*sn(pn)*w2bn_a(w2of,yun))
    1 enh = dmx - sqrt(pm**2+pn**2)
      pqh = enh * gp0 - pn * gpv * u
      w2fh = enh**2 - pn**2 + 2.*pq - gp2
      yunh =(w2fh + gp2 - pm**2)/2.
      exprh = 0.0
      xtilh = gp2/2.0/yunh
      IF(yunh.lE.0.0) GOTO 2
      expr2 = (1.+pn*u*gp2/(pqh*gpv))**2*(pqh/pm/gp0)**2 +
     &         pn**2*(1.-u**2)/2.*pm**2*(gp2/gpv**2)
      exprh=expr2*hc(pn)*pm/yunh*(z*w2bp_a(w2fh,yunh)+
     &                        (a-z)*w2bn_a(w2fh,yunh))
*    2 piv2_a = pn**2*(expr+exprh)*emca_a(pn) * 100000.
 2    piv2_a = pn**2*(expr+exprh) * 100000.
      RETURN
      END
C............................................
      FUNCTION emca_a(x)
      emca_a=1.
      RETURN
      END
C............................................
C      =======================================
C      I            DEUTRON CASE             I
C      =======================================
      FUNCTION w2ind_a(q2,q0,q3)
      EXTERNAL div2_a,ul,uup
      COMMON/prot/pm,pi
     */fotin/gp2,gp0,gpv,aq
     */sint/rep,reu
      gp2=q2
      gp0=q0
      gpv=q3
      CALL gadap2(0.,1.5,ul,uup,div2_a,reu,yn)
      w2ind_a=2.*pi*yn / 100000.
      RETURN
      END
C........................................
      FUNCTION div2_a(pn,u)
      COMMON/prot/pm,pi/detr/dm,dmx
     */fotin/gp2,gp0,gpv,aq
      en     = dm - sqrt(pm**2 + pn**2)
      pq     = en*gp0 - pn*gpv*u
      w2of   = en**2-pn**2 + 2.*pq - gp2
      yun    = (w2of + gp2 - pm**2)/2.
      expr = 0.0
      IF(yun.lE.0.0) GOTO 1
      expr1  = (1.+pn*u*gp2/(pq*gpv))**2*(pq/pm/gp0)**2 +
     &         pn**2*(1.-u**2)/2.*pm**2*(gp2/gpv**2)
      expr   = expr1*fd(pn)/(2.*en/dm)*pm/yun*(w2bp_a(w2of,yun)   +
     &                                         w2bn_a(w2of,yun))
    1 div2_a = pn**2*expr*emcd_a(pn) * 100000.
      RETURN
      END
C...........................................
      FUNCTION emcd_a(x)
      emcd_a = 1.
      RETURN
      END
C..........................................
      FUNCTION ul(x)
      ul = -1.
      RETURN
      END
      FUNCTION uup(x)
      uup = 1.
      RETURN
      END
C............................................
C     ****** PROTON INELASTIC CONTRIBUTION ******
      FUNCTION w2bp_a(fm2,yn)
      COMMON/prot/pm,pi/fotin/gp2,gp0,gpv,aq
      w2bp_a = 0.
      xp     = gp2/(2.*yn)
      IF(xp.GT.1..OR.fm2.LT.pm**2)return
      fm     = sqrt(fm2)
      wwi    = (2.*yn+1.642)/(gp2+0.376)
      t      = 1.-1./wwi
      gw     = 0.256*t**3+2.178*t**4+0.898*t**5-6.716*t**6+3.756*t**7
      w2bp_a = b(fm,gp2)*gw*wwi*xp
      RETURN
      END
C..........................................
C     ****** NEUTRON INELASTIC CONTRIBUTION ******
      FUNCTION w2bn_a(fm2,yn)
      COMMON/prot/pm,pi/fotin/gp2,gp0,gpv,aq
      w2bn_a = 0.
      xp     = gp2/(2.*yn)
      IF(xp.GT.1..OR.fm2.LT.pm**2)return
      fm     = sqrt(fm2)
      wwi    = (2.*yn+1.642)/(gp2+0.376)
      t      = 1.-1./wwi
      gw     = 0.064*t**3+0.225*t**4+4.106*t**5-7.079*t**6+3.055*t**7
      w2bn_a = b(fm,gp2)*gw*wwi*xp
      RETURN
      END

***********************************************************************
*  Inelastic  scattering from Helium/Tritium
***********************************************************************

      function sigma_in(ei,er,ue,it,ini)
*************************************************
*     calculates inelastic cross section from 
*     helium and tritium cross section
*     ini = 1 - initializes the parameters,
*            0 - calculates tre cross section      
*     it  = 1 - hellum, -1 - tritium
*     ei  - initial electron energy in GeV
*     er  - scattered electron energy in GeV
*     ue  - scattered electron angle in radians
*************************************************
      common/par/pi,pm,dm
      common/ttarget/an,zp,zn,tm,emin
      common/photon/q2,q0,qv
      common/al0/al0a,al0b
      sigma_in = 0.0
      if(ini.eq.1)then
      pi = acos(-1.0)
      pm   = 0.938272
      pmn  = 0.939566
      dm   = 1.875613
      an  = 3.0
      if(it.eq.1 )zp  = 2.0
      if(it.eq.-1)zp  = 1.0
      zn = an - zp
                   emin = 0.00549
      if(zp.lt.2.0)emin = 0.00626
      tm = zp*pm + zn*pmn - emin
      al0a = 0.9
      al0b = 1.1
       else 
      q0 = ei - er
      q2 = 4.0*ei*er*sin(ue/2.0)**2
      qv = sqrt(q2 + q0**2)
      x = q2/(2.0*pm*q0)
      tn = (sin(ue/2.0)/cos(ue/2.0))
      sigma = f2_a3(x,q2) + 2.0*q0/pm*tn**2 *f1_a3(x,q2)
      sigma_in = gmott(ei,ue)/q0 * sigma
      endif
      return
      end


	function f2_a3(x,q2)
        common/par/pi,pm,dm
        common/sint/rep,reu
	external pta,ptb,undint
        ala = x
	alb = 1.99
	eps = reu !0.0001
	call gadap2(ala,alb,pta,ptb,undint,eps,sum)
	f2_a3  = sum * 2.0*acos(-1.0)
	return
	end 

	function f1_a3(x,q2)
        common/par/pi,pm,dm
        r = 0.18
        q0 = q2/(2.0*pm*x)
        f1_a3 = f2_a3(x,q2)/((1.0+r)*2.0*x)*(1.0+2.0*pm*x/q0)
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

 
      function undint(al,pt)
      common/par/pi,pm,dm
      common/ttarget/a,zp,zn,tm,emin
      common/photon/q2,q0,qv
      undint = 0.0

      alq  = a*(q0 - qv)/tm
      qplus = q0 + qv
**************************************************************
* definition of tl_nu and tl_x, which enters as 
* the argument in the structure function. 
* It is defined through  the final hadronic mass w2
***************************************************************
      ib = 2 ! for two body break-up
      tl_nu_2 = (wfin2(al,pt,q2,q0,ib)+q2-pm**2)/(2.0*pm)      

      ib = 3 ! for three body break-up
      tl_nu_3 = (wfin2(al,pt,q2,q0,ib)+q2-pm**2)/(2.0*pm)
      
      if(tl_nu_2.le.0.0.or.tl_nu_3.le.0.0)return

      tl_x_2 = q2/(2.0*tl_nu_2*pm)
      tl_x_3 = q2/(2.0*tl_nu_3*pm)
*      tl_x_2 = q2/(2.0*pm*q0)/al
*      tl_x_3 = q2/(2.0*pm*q0)/al


*      ! write(14,*)"wfin2",q2
****************************************************************
* definition of pr_nu, which is the four-product of p*q
* where p is the interacting nucleon's four momenta
* again we have to calculate for 2-body and 3-body 
* break-up cases separately
* pr_nu = 1/2m (p_{+}q_{-} + p_{-}q_{+})
****************************************************************
       ib = 2 ! for two body break-up     
       pr_nu_2 = (tm/A)/(2.0*pm)*(pplus(al,pt,ib)*alq+qplus*al)
       ib = 3 ! for three body break-up
       pr_nu_3 = (tm/A)/(2.0*pm)*(pplus(al,pt,ib)*alq+qplus*al)
      if(pr_nu_2.le.0.0.or.pr_nu_3.le.0.0)return

****************************************************************
* definitions of cos\delta and sin\delta
****************************************************************
       cos_delta = q0/qv
       sin_delta = sqrt(q2)/qv

****************************************************************
* calculation of integrand
****************************************************************
*     Two-body break-up
****************************************************************

      a10_2 = (1.0+cos_delta)**2 * (al+alq*pm*pr_nu_2/Q2)**2
      a1_2  = (tm/(a*pm))**2*a10_2 + sin_delta**2*pt**2/(2.0*pm**2)
      a_2   = q0/pr_nu_2 * a1_2
*      term_2 = rho_2(al,pt)*q0/pr_nu_2 * a1_2 

****************************************************************
*     Three-body break-up
****************************************************************
      a10_3 = (1.0+cos_delta)**2 * (al+alq*pm*pr_nu_3/Q2)**2
      a1_3  = (tm/(a*pm))**2*a10_3 + sin_delta**2*pt**2/(2.0*pm**2)
	a_3   = q0/pr_nu_3 * a1_3 

*      in    = 1 ! scattering with proton	in He3
*      term_3p_he3 = rho_3(al,pt,in)*q0/pr_nu_3 * a1_3 
*      term_3n_h3  =  term_3p_he3

*      in    = 0 ! scattering with neutron
*      term_3n_he3 = rho_3(al,pt,in)*q0/pr_nu_3 * a1_3 
*      term_3n_he3 =  
     
******************************************************************************
      if(zp.gt.1.0)then !helium target
	it = 1 ! he3
*	! write(6,*)tl_x_2,Q2,q2
      term2bb = zp* rho_2(al,pt,it)*f2p_in(tl_x_2,Q2)*a_2
      term3bb =(zp* rho_3(al,pt,it,1)*f2p_in(tl_x_3,Q2)
     &	       +zn* rho_3(al,pt,it,0)*f2n_in(tl_x_3,Q2))*a_3

      else ! tritium target
	it  = -1 ! h3 target
      term2bb = zn* rho_2(al,pt,it)*f2n_in(tl_x_2,Q2)*a_2
      term3bb =(zp* rho_3(al,pt,it,1)*f2p_in(tl_x_3,Q2)
     &	       +zn* rho_3(al,pt,it,0)*f2n_in(tl_x_3,Q2))*a_3
      endif
      
      undint = (term2bb + term3bb)*pt ! chmoranal 2*pi-n d phi - ic
      return
      end

      function rho_2(al,pt,it)
********************************************************
*    Momentum distribution for two-body break-up
********************************************************
*    it = 1 he3
*    it =-1 h3 
*
********************************************************
      common/par/pi,pm,dm
      common/ttarget/a,zp,zn,tm,emin
      pza = -(dm**2 + pt**2 - ((1.0-al/3.0)*tm)**2)
      pz_2  = pza/(2.0*(1.0-al/3.0)*tm) ! two-body break-up
      e0_2  = tm - sqrt(dm**2 + pz_2**2)
      p = sqrt(pt**2 + pz_2**2)
      if(it.eq.1)then      ! helium target
      rho_2 = tm/a *dngr(p)/(e0_2/(tm/a))
      elseif(it.eq.-1)then ! tritium target
      rho_2 = tm/a *dngr_t(p)/(e0_2/(tm/a))
      endif
      return
      end


      

      function rho_3(al,pt,it,in)
********************************************************
*    Momentum distribution for three-body break-up
********************************************************
*    it = 1 he3
*    it =-1 h3 
*
********************************************************
      common/par/pi,pm,dm
      common/ttarget/a,zp,zn,tm,emin
      common/al0/al0a,al0b
***** mean field approximation
      pza = -((2*pm)**2 + pt**2 - ((1.0-al/3.0)*tm)**2)
      pz_mn  = pza/(2.0*(1.0-al/3.0)*tm) 
      e0_mn  = tm - sqrt(dm**2 + pz_mn**2)

***** 2N SRC approximation
      pms  = pm 
      dmx  = tm - pms 
      pz_src  = -(pm**2+pt**2-(dmx-tm/a*al)**2)/(2.0*(dmx-tm/a*al))
      e0_src  = dmx-sqrt(pm**2 + pz_src**2 + pt**2)

      e0 = e0_mn
      p = sqrt(pt**2 + pz_mn**2)
      if(al.lt.al0a.or.al.gt.al0b)then
      e0=e0_src
      p = sqrt(pt**2 + pz_src**2)
      endif

      if(it.eq.1)then             ! helium target
      rho_3 = tm/a *dnex(in,p)/(e0/(tm/a))
      elseif(it.eq.-1)then        ! tritium target
      rho_3 = tm/a *dnex_t(in,p)/(e0/(tm/a))
      endif
      return
      end




      function pplus(al,pt,ib)
*****************************************************
* The + component of the interacting nucleon momentum
*****************************************************
      common/par/pi,pm,dm
      common/ttarget/a,zp,zn,tm,emin
      common/al0/al0a,al0b
      if(ib.eq.2)then  ! two body breakup
      pplus=tm - (dm**2 + pt**2)/((a-al)*tm/a)
      else  ! three body break up
	if(al.ge.al0a.and.al.le.al0b)then ! mean field approximation
      rm = 2.0*pm
	pplus=tm - (rm**2 + pt**2)/((a-al)*tm/a)     
      else !  2N SRC kinematics
      pms  = pm 
      dmx  = tm - pms 
      pplus = dmx - (pm**2 + pt**2)/((2.0-al)*tm/a)
      endif
	endif
      return
      end
      

      function wfin2(al,pt,q2,q0,ib)
*************************************************
* The final hadronic mass^2 produced on the 
* interacting nucleon
**************************************************
      common/par/pi,pm,dm
      common/ttarget/a,zp,zn,tm,emin
      common/al0/al0a,al0b

      qv = sqrt(q2 + q0**2)
      if(ib.eq.2)then  ! two body breakup
********************************************************
*   calculation of missing momentum pm from al and pt  *
********************************************************
      d  = -q2 + 2.0*q0*tm+tm**2
      pza = -(dm**2 + pt**2 - ((1.0-al/3.0)*tm)**2)
      pz  = pza/(2.0*(1.0-al/3.0)*tm)
      ed = sqrt(dm**2 + pz**2 + pt**2)
      wfin2 = d - 2.0*ed*(q0+tm) - 2.0*pz*qv + dm**2
      else  ! three body brea up
********************************************************
*   calculation of spectator momentum ps from al and pt  
*   in 2N SRC approximation
********************************************************
	if(al.ge.al0a.and.al.le.al0b)then    ! mean field approximation 
	rm = 2.0*pm
      d  = -q2 + 2.0*q0*tm+tm**2
      pza = -(rm**2 + pt**2 - ((1.0-al/3.0)*tm)**2)
      pz  = pza/(2.0*(1.0-al/3.0)*tm)
      er = sqrt(rm**2 + pz**2 + pt**2)
      wfin2 = d - 2.0*er*(q0+tm) - 2.0*pz*qv + rm**2
	else ! 2N SRC kinematics 
      pms  = pm 
      dmx  = tm - pms 
      d = -q2 + 2.0*q0*dmx + dmx**2
      psz = (pm**2+pt**2-(dmx-tm/a*al)**2)/(2.0*(dmx-tm/a*al))
      es  = sqrt(pm**2 + psz**2 + pt**2)
      wfin2 = d -2.0*es*(q0+dmx) + 2.0*psz*qv + pm**2
      endif
	endif
      return
      end
         
      







	function dngr_t(p)
***************************************************
*    Two body break up momentum distribution of
*    tritium
***************************************************
	dngr_t = dngr(p)
	return
	end

	function dnex_t(in,p)
***************************************************
*    Three body break up momentum distribution of
*    tritium
*    in = 1 - proton
*    in = 0 - neutron
*
****************************************************
	         inn = 1
      if(in.eq.1)inn = 0
	dnex_t = dnex(inn,p)
        
	return
	end

*********************************************************
* inelastic structure functions for proton and neutron 
*********************************************************
      function f2p_in(x,q2)
      f2p_in=0.0
      if(x.gt.1)return
      f2p_in = f2p_b(x,q2)
      return
      end

      function f2n_in(x,q2)
      f2n_in=0.0
      if(x.gt.1)return
      f2n_in = f2n_b(x,q2)
      return
      end



*******************************************************
* Bodek - Ritchie Parameterization
*******************************************************
C............................................
C     ****** PROTON INELASTIC CONTRIBUTION ******
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
      f2n_b = b(fm,q2)*gw*wwi*xp
      RETURN
      END
C----------------------------------------------------------------------





C----------------------------------------------------------------------
C         ************************************
C         *  INCLUSION OF RADIATIVE EFFECTS  *
C         ************************************
      FUNCTION tspec_a(e,es,ul)
      EXTERNAL teli_a,telr_a
      COMMON/prot/pm,pi/detr/dm,dmx/targ/aj,z,tm,rm
     */rad/tt,bt,dt,alfa,em,xsi/electr/ei,er,ue/rembo/r/tir/ti
     */simp0/re,ae,eps_r/k_process/k_process
      ei=e
      er=es
      ue=ul
      gp2=4.*ei*er*sin(ue/2.)**2
      gp0=ei-er
      gpv=sqrt(gp2+gp0**2)
      tr=alfa*(alog(gp2/em**2)-1.)/(pi*bt)
      ti=bt*(tt/2.+tr)
*      ermax=ei/(1.+ei*(1.-cos(ue))/pm)
      ermax=ei/(1.+ei*(1.-cos(ue))/tm)
*      r=(pm+ei*(1.-cos(ue)))/(pm-ermax*(1.-cos(ue)))
      rhayt = (tm-ermax*(1.-cos(ue)))
      bi = 0.0
      ci = 0.0
      if(rhayt.eq.0.0)goto 112 
      r=(tm+ei*(1.-cos(ue)))/(tm-ermax*(1.-cos(ue)))
*      esmn=er/(1.-er*(1.-cos(ue))/pm)
      esmn=er/(1.-er*(1.-cos(ue))/tm)
      a1=(r*dt/ei)**ti*(dt/er)**ti*(1.-xsi/(1.-2.*ti)/dt)
      ai=a1*spec_a(ei,er,ue)*af_a(ei,er,ue)
      bi=0.
      IF(esmn.GE.(ei-r*dt).or.esmn.le.0.)go to 111
      bp=ei-r*dt
      eps = eps_r
      CALL gadaps(esmn,bp,teli_a,eps,yti)
      bi=yti
  111 ci=0.
      IF((er+dt).ge.ermax)go to 112
      IF(ermax.GE.ei) go to 112
      ap=er+dt
      eps = eps_r
      CALL gadaps(ap,ermax,telr_a,eps,ytr)
      ci=ytr
  112 tspec_a=ai+bi+ci
*      print *,"*",tspec_a,ai,bi,ci
*      print *,"**",esmn,bp,eps,ti
      RETURN
      END
C  **** UNDERINTEGRAL FUNCTIONS FOR TELIN ****
      FUNCTION teli_a(e)
      COMMON/prot/pm,pi/detr/dm,dmx/targ/aj,z,tm,rm
     */rad/tt,bt,dt,alfa,em,xsi/electr/ei,er,ue/rembo/r/tir/ti
      teli_a = 0.
      IF(er.GE.e)RETURN
      IF(e.GE.ei)RETURN
      b1=((ei-e)/er/r)**ti*((ei-e)/ei)**ti*(ti/(ei-e)*fs((ei-e)/ei)+
     *xsi/2./(ei-e)**2)
      teli_a = spec_a(e,er,ue) * af_a(e,er,ue) * b1
      gp0=e-er
      gp2=4.*e*er*sin(ue/2.)**2
      x = gp2/2.0/gp0/pm
*      ! write(42,*)"aha",teli_a,spec_a(e,er,ue),af_a(e,er,ue),b1,e,er,ue,x
      RETURN
      END
C  -----------------------
      FUNCTION telr_a(es)
      COMMON/prot/pm,pi/detr/dm,dmx/targ/aj,z,tm,rm
     */rad/tt,bt,dt,alfa,em,xsi/electr/ei,er,ue/rembo/r/tir/ti
      telr_a = 0.
      IF((ei-es).le.0.) return
      IF(es.LE.er)RETURN
      b1=((es-er)/es)**ti*((es-er)*r/ei)**ti*(ti/(es-er)*fs((es-er)/es)+
     *xsi/2./(es-er)**2)
      telr_a = spec_a(ei,es,ue) * af_a(ei,es,ue) * b1
      RETURN
      END
C====== FACTOR OF INTERNAL BREMSHTROULING =====
      FUNCTION af_a(x,y,u)
      COMMON/rad/tt,bt,dt,alfa,em,xsi/prot/pm,pi
      g2=4.*x*y*sin(u/2.)**2
      af1=1.+0.5772*bt*tt
      af2=2.*alfa*(-14./9.+13.*alog(g2/em/em)/12.)/pi
      af3=alfa*alog(x/y)**2/(2.*pi)
      af_a = af1+af2-af3
      RETURN
      END




*hydro.f
      SUBROUTINE hydro
***********************************************************************
*     Subroutine to calculate the inclusive (ee') cross section for   *
*     hidrogen target                                                 *
*                                                                     *
*     Written:       February, 1989                                   *
*     Author:        Misak Sargsyan, YERPHI                           *
*     Modification:  Adapted on VAX/VM May,1990 M.Sargsyan            *
*		     Hovanes Egiyan 				      *
*                                                                     *
***********************************************************************
      COMMON/prot/pm,pi
      COMMON/targ/a,z,tm,rm
      COMMON/rad/tt,bt,dt,alfa,em,xsi
      COMMON/k_process/k_process
      COMMON/bin/width_e,width_u,i_case
      COMMON/simp0/rep,reu,eps_r
      COMMON/r_int/eps
C-
	include 'common_incl.cmn'
	real q2,sinuet,epsilon,gamma_t,gamma_w,jacob
C-
C      INCLUDE 'inclusive$src:COMMON_INCL.CMN'
c=======================================================================
C                       BLOCK OF PARAMETERS
C=======================================================================
      pm=0.938279
      pi=3.14159
      em=0.000511
      alfa=1./137.
      bt=4./3.
      r=0.18
***********************************************************************
*     Radiation parameters
***********************************************************************
      z0=alog(1440.*z**(-2./3.))/alog(183.*z**(-1./3.))
      an=0.6023
      rel=0.2818
      x01=4.*an*alfa*rel**2*z*(z+z0)*alog(183.*z**(-1./3.))
      x0=a/x01
      xsi=0.000154*z/a*tt*x0
************************************************************************
c      WRITE(6,*)'                                               '
c      WRITE(6,*)' ================================================'
c      WRITE(6,18)ei
   18 FORMAT(2x,'ENERGY OF INCIDENT ELECTRONS  ( GeV ) =',f9.5)
c      WRITE(6,*)' ================================================'
c      WRITE(6,*)' TARGET THICNESS IN MM    =',sm
c      WRITE(6,*)' ATOMIC WEIGHT A          =',a
c      WRITE(6,*)' CHARG NUMBER  Z          =',z
c      WRITE(6,*)' ================================================'
**********************************************************************
*     measure of cross section
**********************************************************************
      v_m = v_measure
c      IF(v_m.EQ.1000000.)WRITE(6,*)' =CROSS SECTION IN (mlbn/GeV/Str)='
c      IF(v_m.EQ.1000.)   WRITE(6,*)' =CROSS SECTION IN (mcbn/GeV/Str)='
c      IF(v_m.EQ.1.)      WRITE(6,*)' =CROSS SECTION IN (nbn/GeV/Str)= '
c      IF(v_m.EQ.0.001)   WRITE(6,*)' =CROSS SECTION IN (pkbn/GeV/Str)='
c      WRITE(6,*)' ================================================'
*********************************************************************
*     scattered angle range determination
*********************************************************************
      IF(the_step.NE.0.)k_tet_sum = (the_up - the_low) / the_step + 1
      IF(the_low.EQ.0.) k_tet_sum = 1
      DO k_tet = 1,k_tet_sum
        IF(k_tet_sum.EQ.1) uet = the_fix
cStep        IF(k_tet_sum.EQ.1) q2 = the_fix
        IF(k_tet_sum.GT.1) uet = the_low + float(k_tet-1) * the_step
cStep        IF(k_tet_sum.GT.1) q2 = the_low + float(k_tet-1) * the_step
        ue=uet*pi/180.
c        WRITE(6,20)
c        ! write(6,*)'Type of spectra   ',sub_type_spec,w_up,w_low,w_step
**********************************************************************
*     selection electron spectra type
**********************************************************************
        IF(sub_type_spec.EQ.11.0)THEN
          k_sum = (er_up - er_low) / er_step + 1
        ELSEIF(sub_type_spec.EQ.12.0)THEN
          k_sum = (q0_up - q0_low) / q0_step + 1
        ELSEIF(sub_type_spec.EQ.13.0)THEN
          k_sum = (w_up - w_low) / w_step + 1
        ELSEIF(sub_type_spec.EQ.14.0)THEN
          k_sum = (x_up - x_low) / x_step + 1
        ENDIF
c        k_sum = 1
**********************************************************
c        ! write(6,*)'TOTAL NUMBERS TO BE CALCULATED =',k_sum
**********************************************************
        DO 1 ke = 1,k_sum
          IF(sub_type_spec.EQ.11.0)THEN
            er = er_low + float(ke-1)*er_step
          ELSEIF(sub_type_spec.EQ.12.0)THEN
            q0 = q0_low + float(ke-1)*q0_step
            er = ei - q0
          ELSEIF(sub_type_spec.EQ.13.0)THEN
            w2 = ( w_low + float(ke-1)*w_step ) ** 2
            er=ei-(w2+q2-pm**2)/2./pm
            sinuet2=sqrt(q2/4./ei/er)
            ue=asin(sinuet2)*2.
            uet=ue*180./pi
c            ! write(6,*)uet,er,sinuet2
c            er=(pm**2+2.*pm*ei-w2)/(2.*pm+4.*ei*sin(ue/2.)**2)
          ELSEIF(sub_type_spec.EQ.14.0)THEN
            x = x_low + float(ke-1)*x_step
            er=(2.*pm*ei*x)/(4.*ei*sin(ue/2.)**2+2.*pm*x)
          ENDIF
        ero = ei / (1.+2*ei/pm*sin(ue/2.)**2)
        if(ero.lt.er)GOTO 1
c        WRITE(6,*)'                                               '
c        WRITE(6,*)' ================================================'
c        WRITE(6,19)uet
c        WRITE(6,19)q2
c        WRITE(6,*)' ================================================'
   19   FORMAT(2x,'ANGLE OF SCATTERED ELECTRONS ( degr.) =',f9.5)
c        WRITE(6,*)' Elastic scattering at Ee` = ',er,' GeV'
c        WRITE(6,*)' Elastic cross section in (nbn/GeV/Str) = ',
c     &                                       h_elast(ei,ue)
c        WRITE(6,*)' Radiative elastic cross sect. in (nbn/GeV/Str) = ',
c     &                                       h_elast_r(ei,ue)
          gp0 = ei-er
          gp2 = 4.*ei*er*sin(ue/2.)**2
          gpv = sqrt(gp0**2+gp2)
          w2  = pm**2+2.*pm*gp0-gp2
          IF(w2.LT.0.)GOTO 1
          w   = sqrt(w2)
          x   = gp2/2./pm/gp0
          IF(x.GE.2.0)GOTO 1
          epsilon=1./(1.+2.*(1.+(ei-er)**2/q2)*(tan(ue/2))**2)
          gamma_t=alfa*(w2-pm**2)*er/4./q2/pm/ei/(1-epsilon)/pi**2
          gamma_w=alfa*(w2-pm**2)*w/8./q2/pm**2/(1-epsilon)/ei**2/pi**2
          jacob=pi*w/ei/er/pm
*******************************************************
*    Without radiative effects
*******************************************************
          y_el  = h_elast(ei,ue) / width_e  / v_m *                 ! Elastic
     *        tet(ero-(er-width_e/2.))*tet((er+width_e/2.)-ero) ! scattering
*
          y_in  = h_inel(ei,er,ue) / v_m     ! Inelastic scattering
*
          y_su = y_el + y_in                 ! Elastic + Inelastic cross secttion
*******************************************************
*    Take into account radiation effects
*******************************************************
          t_el = h_elast_r(ei,ue) / width_e  / v_m *                ! Elastic
     *       tet(ero-(er-width_e/2.))*tet((er+width_e/2.)-ero)  ! scattering
*
          t_tl = h_el_tail(ei,er,ue) / v_m   !  Radiative tail from elastic peak
*
          t_in  = h_inel_r(ei,er,ue) / v_m   !  Inelastic scattering
*
          t_su  = t_el + t_tl + t_in         !  Elastic + Tail + Inelastic
********************************************************
c          WRITE(6,101)w,er,x,y_el,y_in,y_su,t_el,
c     &            t_tl,t_in,t_su,gp2
         y_su_w=y_su*jacob
         t_su_w=t_su*jacob
         y_su_t=y_su/gamma_t
         t_su_t=t_su/gamma_t
         y_su_tw=y_su_w/gamma_w
         t_su_tw=t_su_w/gamma_w
cStep          WRITE(26,*)gp2,uet,w,er,y_su_w,t_su_w
c          WRITE(26,*)uet,er,y_su,t_su,gp2,w,
c     &       h_elast(ei,ue), h_elast_r(ei,ue)
c     &    y_su_w,t_su_w
c     &    y_su_t,t_su_t,y_su_tw,t_su_tw
********************************************************
c          ! write(6,*)'CALCULATED NUMBER =',ke
********************************************************
    1   CONTINUE
c        WRITE(6,22)
c        endif
      ENDDO
***************************************************************
*     Init line formats
***************************************************************
   20 FORMAT(109('=')/5x,'W ',5x,'Ee`',5x,'X ',6x,'S_el',7x,'S_in',
     &7x,'S_sum',6x,'R_el',7x,'E_tl',7x,'R_in',7x,'R_sum',5x,' Q2',
     &        /109('-'))
***************************************************************
*     Exit line formats
***************************************************************
   22 FORMAT(109('-')/5x,'W ',5x,'Ee`',5x,'X ',6x,'S_el',7x,'S_in',
     &7x,'S_sum',6x,'R_el',7x,'E_tl',7x,'R_in',7x,'R_sum',5x,' Q2',
     &        /109('='))
***************************************************************
*     Data  formats
***************************************************************
  101 FORMAT(3f8.4,7e11.3,f8.4)
  102 FORMAT(1x,8e11.3)
      RETURN
      END
****************************************************************
*     Elastic scattering on hidrogen                           *
****************************************************************
      FUNCTION h_elast(ei,ue)
      COMMON/prot/pm,pi
      common/form_factors/ics
      call  proton_formfactors(q2,gep0,gmp0,ics)

      ero=ei/(1.+2.*ei/pm*sin(ue/2.)**2)
      gp2=4.*ei*ero*sin(ue/2.)**2
      gm=gmott(ei,ue)
      tau=gp2/4./pm**2

*      s2=(gep(gp2)**2+tau*gmp(gp2)**2)/(1.+tau)
      s2=(gep0**2+tau*gmp0**2)/(1.+tau)
*      s1=tau*gmp(gp2)**2
      s1=tau*gmp0**2
      h_elast=gm/(1.+2.*ei/pm*sin(ue/2.)**2)*(s2+2.*tan(ue/2.)**2*s1)
      RETURN
      END
C----------------------------------------------
      FUNCTION gep(q2)
      gep=1./(1.+q2/0.71)**2
      RETURN
      END
C---------------------
      FUNCTION gmp(q2)
      gmp=gep(q2)*2.79
      RETURN
      END
****************************************************************
*     Inelastic scattering on hidrogen                           *
****************************************************************
      FUNCTION h_inel(ei,er,ue)
      COMMON/prot/pm,pi
      r   = 0.18
      gp0 = ei-er
      gp2 = 4.*ei*er*sin(ue/2.)**2
      gpv = sqrt(gp2+gp0**2)
      gm  = gmott(ei,ue)
      w1h = (1.+gp0**2/gp2)/(1.+r)*w2h(gp2,gp0)
      h_inel = gm*(w2h(gp2,gp0)+2.*tan(ue/2.)**2*w1h)
      RETURN
      END
C..................................
      FUNCTION w2h(gp2,gp0)
      COMMON/prot/pm,pi
      fm2=pm**2+2.*pm*gp0-gp2
      w2h=0.
      IF(fm2.LT.pm**2) return
      wi=sqrt(fm2)
      w2h=gp_h(gp0,gp2)*b(wi,gp2)/gp0
      RETURN
      END
C     .........................
      FUNCTION gp_h(q0,q2)
      COMMON/prot/pm,pi
      xx = q2/(2.*pm*q0)
      gi = 2.*pm*q0
      ww = (gi+1.642)/(q2+0.376)
      t  = (1.-1./ww)
      wp = 0.256*t**3+2.178*t**4+0.898*t**5-6.716*t**6+3.756*t**7
      gp_h=wp*ww*q2/(2.*pm*q0)*fact(q2,xx)
      RETURN
      END
C---------------------------------
      FUNCTION fact(g2,x)
C      FACT=1.135
C      IF(X.GT.0.1.AND.X.LT.0.2.AND.G2.LT.0.5)RETURN
C      IF(X.GT.0.1.AND.G2.LT.0.5)RETURN
      fact=1.
      RETURN
      END
**********************************************************
*                         RADIATIONS                     *
**********************************************************
**********************************************************
*     Radiative correction to elastic peak on hidrogen   *
**********************************************************
      FUNCTION h_elast_r(ei,ue)
      COMMON/prot/pm,pi/ti/ti
      COMMON/rad/tt,bt,dt,alfa,em,xsi
      COMMON/bin/width_e,width_u,i_case
      dte = width_e / 2.
      ero = ei/(1.+2.*ei/pm*sin(ue/2.)**2)
      gp2 = 4.*ei*ero*sin(ue/2.)**2
      tr  = alfa/pi/bt*(alog(gp2/em/em)-1.)
      ti  = bt*(tt/2.+tr)
      r   = (pm+ei*(1.-cos(ue)))/(pm-(ero)*(1.-cos(ue)))
      h_elast_r = h_elast(ei,ue)*af(ei,ero,ue)*
     *            (dte*r/ei)**ti*(dte/ero)**ti*
     *            (1.-xsi/dte)
      RETURN
      END
**********************************************************
*     Radiative tail from elastic peak on hidrogen       *
**********************************************************
      FUNCTION h_el_tail(ei,er,ue)
      COMMON/prot/pm,pi/ti/ti
      COMMON/rad/tt,bt,dt,alfa,em,xsi
      COMMON/bin/width_e,width_u,i_case
      dte = width_e / 2.
      ero = ei / (1.+2.*ei/pm*sin(ue/2.)**2)
      gp0 = ei-er
      gp2 = 4.*ei*er*sin(ue/2.)**2
      gpv = sqrt(gp2+gp0**2)
      r   = abs((pm+ei*(1.-cos(ue)))/(pm-er*(1.-cos(ue))))
      tr  = alfa/pi/bt*(alog(gp2/em/em)-1.)
      ti  = bt*(tt/2.+tr)
      u2  = pm**2+2.*pm*gp0-gp2
      ws  = (u2-pm**2)/2./(pm-er*(1.-cos(ue)))
      wp  = (u2-pm**2)/2./(pm+ei*(1.-cos(ue)))
      vs  = ws/ei
      vp  = wp/(er+wp)
      h_el_tail = 0.0
      IF(ws.LE.r*dte.or.wp.le.dte.or.er.ge.ero-dte)return
      fac = (vs*vp)**ti
*******************************************************************
*     equivalent radiator approximation
********************************************************************
      t1  = 0.0
      t23 = ti/ws*fs(vs)+xsi/2./ws**2
      t33 = ti/wp*fs(vp)+xsi/2./wp**2
      t21 = (pm+(ei-ws)*(1.-cos(ue)))/(pm-er*(1.-cos(ue)))
      t22 = h_elast(ei-ws,ue)*af(ei-ws,er,ue)
      t2  = t21*t22*t23
      t32 = h_elast(ei,ue)*af(ei,er,ue)
      t3  = t32*t33
      h_el_tail = fac*(t1+t2+t3)
      RETURN
      END
***********************************************************************
* Radiative correction and tail for  inelastic scattering on hidrogen *
***********************************************************************
      FUNCTION h_inel_r(ei,er,ue)
      EXTERNAL teli_h,telr_h!,kermtr,abend
      COMMON/prot/pm,pi/ti/ti
      COMMON/rad/tt,bt,dt,alfa,em,xsi
      COMMON/electr/es,ep,us/relt/r
      COMMON/simp0/rep,reu,eps_r
      gp2=4.*ei*er*sin(ue/2.)**2
      tr=alfa/pi/bt*(alog(gp2/em**2)-1.)
      ti=bt*(tt/2.+tr)
      es=ei
      ep=er
      us=ue
      r=abs((pm+es*(1.-cos(ue)))/(pm-ep*(1.-cos(ue))))
      a11=(r*dt/es)**ti*(dt/ep)**ti*(1.-xsi/(1.-2.*ti)/dt)
      a1=a11*h_inel(ei,er,ue)*af(ei,er,ue)
      esmin=er/(1.-2.*er/pm*sin(ue/2.)**2)
      ermax=ei/(1.+2.*ei/pm*sin(ue/2.)**2)
      a2=0.
      IF(esmin.GE.es-r*dt.or.esmin.le.0.0)go to 11
      eps = eps_r
      CALL gadap(esmin,es-r*dt,teli_h,eps,a2)
C                                           A2=GAUSS(TELI_H,ESMIN,ES-R*DT,0.05)
   11 a3=0.
      IF(ermax.LE.ep+dt.or.ermax.ge.ei)go to 12
      eps = eps_r
      CALL gadap(ep+dt,ermax,telr_h,eps,a3)
C                                           A3=GAUSS(TELR_H,EP+DT,ERMAX,0.05)
   12 h_inel_r = a1 + a2 + a3
      RETURN
      END
*********************************************************************
*     Undeintegral expresions for the inelastic scattering tail     *
*********************************************************************
      FUNCTION teli_h(esi)
      COMMON/prot/pm,pi/ti/ti
      COMMON/rad/tt,bt,dt,alfa,em,xsi
      COMMON/electr/es,ep,us/relt/r
      term1  = h_inel(esi,ep,us)*af(esi,ep,us)
      term2  = ((es-esi)/ep/r)**ti*((es-esi)/es)**ti
      term3  = ti/(es-esi)*fs((es-esi)/es)+xsi/2./(es-esi)**2
      teli_h = term1 * term2 * term3
      RETURN
      END
C....................................
      FUNCTION telr_h(epi)
      COMMON/prot/pm,pi/ti/ti
      COMMON/rad/tt,bt,dt,alfa,em,xsi
      COMMON/electr/es,ep,us/relt/r
      term1   = h_inel(es,epi,us)*af(es,epi,us)
      term2   = ((epi-ep)/epi)**ti*(((epi-ep)*r)/es)**ti
      term3   = ti/(epi-ep)*fs((epi-ep)/epi)+xsi/2./(epi-ep)**2
      telr_h  = term1 * term2 * term3
      RETURN
      END

*zverev.f
C **********************************************************************
C *             WAVE FUNCTION FOR ALUMINIUM-27                         *
C *  DN AND DP NON REGULAR DISTRIBUTIONS NEUTRONS AND PROTONS IN AL-27 *
C *  CALCULATED BY ZVEREV.                                             *
C *  REGUL IS REGULAR PART OF ----- WAVE FUNCTION,                     *
C *  FHNCIC IS ANOTHER ----- WAVE FUNCTION,                            *
C *  SUB IS A FHNCIC-REGUL, ALL THIS WAVE FUNCTIONS TAKING             *
C *  FROM THE WORKS:E.KROTSCHECK,NP.A317(1979)149,PHYS.REV.B24(1981)   *
C *  6383 AND M.F.FLYNN ET AL,NP.A427(1984)253.                        *
C *  ALL FUNCTIONS NORMALIZED TO UNITY.                                *
C *                     ---- SARGSYAN M.M.  05.06.1989Y YEREVAN ---    *
C **********************************************************************
C                                                                       
      FUNCTION DN27(X)                                                 
      DIMENSION P(50),RN(50)                                           
      DATA RN/1.24833,1.24856,1.25047,1.25552,1.26447, 
     *1.27665,1.28973,1.29989,1.30259,1.29339,1.26884,
     *1.22710,1.16816,1.09375,1.00687,9.11319E-1,8.11148E-1,
     *7.10195E-1,6.11803E-1,5.18652E-1,4.32709E-1,3.55261E-1,
     *2.86986E-1,2.28049E-1,1.78200E-1,1.36878E-1,1.03299E-1,          
     *7.65495E-2,5.56593E-2,3.96678E-2,2.76722E-2,1.88606E-2,          
     *1.25291E-2,8.08649E-2,5.05017E-3,3.03570E-3,1.74421E-3,          
     *9.49025E-4,4.82772E-4,2.25624E-4,9.48727E-5,3.58386E-5,          
     *1.41900E-5,9.67978E-6,1.12923E-5,1.37003E-5,1.48380E-5,          
     *1.43409E-5,1.26035E-5,1.02445E-5/                                
      PY=X/0.197328                                                    
      DO 1 K=1,50                                                      
      P(K)=FLOAT(K)*0.050                                              
1     CONTINUE                                                         
      DN27=RN(1)/(0.197328**3)/6.018759                                
      IF(PY.LE.P(1)) RETURN                                            
      DO 2 N=1,49                                                      
      IF(PY.GE.P(N).AND.PY.LE.P(N+1)) GO TO 3                          
      GO TO 2                                                          
3     DN27=(RN(N)+(RN(N+1)-RN(N))/(P(N+1)-P(N))*(PY-P(N)))/0.197328**3 
     */6.018759                                                        
      RETURN                                                           
2     CONTINUE                                                         
      DN27=0.                                                          
      RETURN                                                           
      END                                                              
C--------------------------------------------------------------------   
      FUNCTION DP27(X)                                                  
      DIMENSION P(50),RP(50)                                            
      DATA RP/9.43535E-1,9.67375E-1,1.00532E-0,1.05449E-0,1.11061E-0,   
     *1.16815E-0,1.22075E-0,1.26194E-0,1.28600E-0,1.28873E-0,           
     *1.26803E-0,1.22406E-0,1.15904E-0,1.07677E-0,9.81978E-1,           
     *8.79663E-1,7.74558E-1,6.70754E-1,5.71511E-1,4.79223E-1,           
     *3.95472E-1,3.21144E-1,2.56550E-1,2.01545E-1,1.55638E-1,           
     *1.18083E-1,8.79733E-2,6.43137E-2,4.60947E-2,3.23483E-2,           
     *2.21900E-2,1.48441E-2,9.65347E-3,6.07796E-3,3.68470E-3,           
     *2.13514E-3,1.17067E-3,5.98665E-4,2.79661E-4,1.15973E-4,           
     *4.19127E-5,1.54387E-5,1.12200E-5,1.50839E-5,1.98747E-5,           
     *2.26100E-5,2.26524E-5,2.05452E-5,1.72506E-5,1.36724E-5/           
      PY=X/0.197328                                                     
      DO 1 K=1,50                                                       
      P(K)=FLOAT(K)*0.050                                               
1     CONTINUE                                                          
      DP27=RP(1)/(0.197328**3)/5.50747                                  
      IF(PY.LE.P(1)) RETURN                                             
      DO 2 N=1,49                                                       
      IF(PY.GE.P(N).AND.PY.LE.P(N+1)) GO TO 3                           
      GO TO 2                                                           
3     DP27=(RP(N)+(RP(N+1)-RP(N))/(P(N+1)-P(N))*(PY-P(N)))/0.197328**3  
     */5.50747                                                          
      RETURN                                                            
2     CONTINUE                                                          
      DP27=0.                                                           
      RETURN                                                            
      END                                                               
C--------------------------------------------------------------------   
C **********************************************************************
C *             WAVE FUNCTION FOR FERRUM-56                            *
C *  DN AND DP NON REGULAR DISTRIBUTIONS NEUTRONS AND PROTONS IN FE-56 *
C *  CALCULATED BY ZVEREV.                                             *
C *                     ---- SARGSYAN M.M.  17.12.1989  YEREVAN ---    *
C **********************************************************************
      FUNCTION DN56(X)                                                  
      DIMENSION P(50),RN(50)                                            
      DATA RN/1.60035,1.59084,1.57212,1.54160,1.49829,                  
     *1.44376,1.38214,1.31899,1.25961,1.20741,1.16306,                  
     *1.12441,1.08744,1.04741,1.00023,9.43264E-1,8.75781E-1,            
     *7.98812E-1,7.14738E-1,6.26728E-1,5.38185E-1,4.52307E-1,           
     *3.71794E-1,2.98687E-1,2.34312E-1,1.79307E-1,1.33697E-1,           
     *9.70024E-2,6.83746E-2,4.67326E-2,3.08947E-2,1.96908E-2,           
     *1.20448E-2,7.02718E-3,3.87601E-3,1.99651E-3,9.44553E-4,           
     *4.02825E-4,1.54968E-4,6.12694E-5,3.75839E-5,3.79774E-5,           
     *4.10407E-5,3.96047E-5,3.35351E-5,2.51842E-5,1.69575E-5,           
     *1.03633E-5,5.92871E-6,3.48951E-6/                                 
      PY=X/0.197328                                                     
      DO 1 K=1,50                                                       
      P(K)=FLOAT(K)*0.050                                               
1     CONTINUE                                                          
      DN56 = RN(1)/(0.197328**3)/6.505547                               
      IF(PY.LE.P(1)) RETURN                                             
      DO 2 N=1,49                                                       
      IF(PY.GE.P(N).AND.PY.LE.P(N+1)) GO TO 3                           
      GO TO 2                                                           
3     DN56 = (RN(N)+(RN(N+1)-RN(N))/(P(N+1)-P(N))*(PY-P(N)))/0.197328**3
     */6.505547                                                         
      RETURN                                                            
2     CONTINUE                                                          
      DN56 = 0.                                                         
      RETURN                                                            
      END                                                               
C--------------------------------------------------------------------   
      FUNCTION DP56(X)                                                  
      DIMENSION P(50),RP(50)                                            
      DATA RP/1.67581E+0,1.62246E+0,1.54290E-0,1.44902E-0,1.35375E-0,   
     *1.26853E-0,1.20116E-0,1.15474E-0,1.12757E-0,1.11413E-0,           
     *1.10666E-0,1.09690E-0,1.07772E-0,1.04418E-0,9.93997E-1,           
     *9.27507E-1,8.47147E-1,7.56771E-1,6.60903E-1,5.64089E-1,           
     *4.70398E-1,3.83118E-1,3.04597E-1,2.36240E-1,1.78580E-1,           
     *1.31426E-1,9.40372E-2,6.53029E-2,4.39159E-2,2.85186E-2,           
     *1.78159E-2,1.06524E-2,6.05360E-3,3.23855E-3,1.61017E-3,           
     *7.32758E-4,3.03068E-4,1.20630E-4,6.06806E-5,5.13609E-5,           
     *5.56611E-5,5.78716E-5,5.39761E-5,4.53014E-5,3.47223E-5,           
     *2.47412E-5,1.68112E-5,1.13674E-5,8.15491E-6,6.59340E-6/           
      PY=X/0.197328                                                     
      DO 1 K=1,50                                                       
      P(K)=FLOAT(K)*0.050                                               
1     CONTINUE                                                          
      DP56 = RP(1)/(0.197328**3)/5.772066                               
      IF(PY.LE.P(1)) RETURN                                             
      DO 2 N=1,49                                                       
      IF(PY.GE.P(N).AND.PY.LE.P(N+1)) GO TO 3                           
      GO TO 2                                                           
3     DP56 = (RP(N)+(RP(N+1)-RP(N))/(P(N+1)-P(N))*(PY-P(N)))/0.197328**3
     */5.772066                                                         
      RETURN                                                            
2     CONTINUE                                                          
      DP56 = 0.0                                                        
      RETURN                                                            
      END                                                               
C--------------------------------------------------------------------   
C **********************************************************************
C *             WAVE FUNCTION FOR PLUMBUM-208                          *
C * DN AND DP NON REGULAR DISTRIBUTIONS NEUTRONS AND PROTONS IN PB-208 *
C *  CALCULATED BY ZVEREV.                                             *
C *                     ---- SARGSYAN M.M.  17.12.1989  YEREVAN ---    *
C **********************************************************************
      FUNCTION DN208(X)                                                 
      DIMENSION P(50),RN(50)                                            
      DATA RN/1.29961,1.35167,1.40915,1.44407,                          
     *1.43986,1.39784,1.33403,1.26884,1.21629,1.17860,                  
     *1.14811,1.11422,1.07049,1.01802,9.63719E-1,9.15426E-1,            
     *8.77124E-1,8.46715E-1,8.17132E-1,7.79661E-1,7.27552E-1,           
     *6.58335E-1,5.74222E-1,4.80913E-1,3.85664E-1,2.95416E-1,           
     *2.15512E-1,1.49140E-1,9.73540E-2,5.94746E-2,3.36391E-2,           
     *1.73647E-2,8.03887E-3,3.29158E-3,1.22703E-3,5.11621E-4,           
     *3.37123E-4,3.01381E-4,2.59759E-4,1.94161E-4,1.25528E-4,           
     *7.18848E-5,3.81535E-5,2.03938E-5,1.22410E-5,8.61691E-6,           
     *6.63022E-6,5.09218E-6,3.73824E-6,2.62382E-6/                      
      PY=X/0.197328                                                     
      DO 1 K=1,50                                                       
      P(K)=FLOAT(K)*0.050                                               
1     CONTINUE                                                          
      DN208=RN(1)/(0.197328**3)/7.695439                                
      IF(PY.LE.P(1)) RETURN                                             
      DO 2 N=1,49                                                       
      IF(PY.GE.P(N).AND.PY.LE.P(N+1)) GO TO 3                           
      GO TO 2                                                           
3     DN208=(RN(N)+(RN(N+1)-RN(N))/(P(N+1)-P(N))*(PY-P(N)))/0.197328**3 
     */7.695439                                                         
      RETURN                                                            
2     CONTINUE                                                          
      DN208=0.                                                          
      RETURN                                                            
      END                                                               
C--------------------------------------------------------------------   
      FUNCTION DP208(X)                                                 
      DIMENSION P(50),RP(50)                                            
      DATA RP/1.35392E-0,1.31349E-0,1.26056E-0,1.20992E-0,1.17201E-0,   
     *1.14910E-0,1.13562E-0,1.12206E-0,1.10028E-0,1.06738E-0,           
     *1.02649E-0,9.84450E-1,9.47747E-1,9.18996E-1,8.95426E-1,           
     *8.69918E-1,8.33839E-1,7.80325E-1,7.06671E-1,6.15108E-1,           
     *5.11952E-1,4.05713E-1,3.04922E-1,2.16379E-1,1.44173E-1,           
     *8.95262E-2,5.12774E-2,2.67074E-2,1.24215E-2,5.08549E-3,           
     *1.90952E-3,8.63332E-4,6.72629E-4,6.75389E-4,6.21798E-4,           
     *4.84233E-4,3.16398E-4,1.72770E-4,7.87667E-5,3.22318E-5,           
     *1.70535E-5,1.60156E-5,1.75914E-5,1.69472E-5,1.38052E-5,           
     *9.73508E-6,6.27645E-6,4.16784E-6,3.35893E-6,3.35988E-6/           
      PY=X/0.197328                                                     
      DO 1 K=1,50                                                       
      P(K)=FLOAT(K)*0.050                                               
1     CONTINUE                                                          
      DP208=RP(1)/(0.197328**3)/5.3400306                               
      IF(PY.LE.P(1)) RETURN                                             
      DO 2 N=1,49                                                       
      IF(PY.GE.P(N).AND.PY.LE.P(N+1)) GO TO 3                           
      GO TO 2                                                           
3     DP208=(RP(N)+(RP(N+1)-RP(N))/(P(N+1)-P(N))*(PY-P(N)))/0.197328**3 
     */5.3400306                                                        
      RETURN                                                            
2     CONTINUE                                                          
      DP208=0.                                                          
      RETURN                                                            
      END                                                               
C---------------------------------------------------------------------- 
      FUNCTION REGUL(X)                                                 
      COMMON/KFIF/PFIF                                                  
      DIMENSION P(12),REG(12)                                           
      DATA REG/1.78E-2,1.77E-2,1.75E-2,1.72E-2,1.67E-2,1.588E-2,        
     *1.307E-2,8.489E-3,4.473E-3,1.959E-3,7.329E-4,2.471E-4/            
      P(1)=0.                                                           
      P(2)=0.2*PFIF                                                     
      P(3)=0.4*PFIF                                                     
      P(4)=0.6*PFIF                                                     
      P(5)=0.8*PFIF                                                     
      P(6)=1.*PFIF                                                      
      P(7)=1.4*PFIF                                                     
      P(8)=1.8*PFIF                                                     
      P(9)=2.2*PFIF                                                     
      P(10)=2.6*PFIF                                                    
      P(11)=3.0*PFIF                                                    
      P(12)=3.4*PFIF                                                    
      PY=X/0.197328                                                     
      DO 1 K=1,11                                                       
      IF(PY.GE.P(K).AND.PY.LE.P(K+1)) GO TO 3                           
      GO TO 1                                                           
3     REGUL=(REG(K)+(REG(K+1)-REG(K))/(P(K+1)-P(K))*(PY-P(K)))          
     */0.197328**3/1.397281                                             
      RETURN                                                            
1     CONTINUE                                                          
      REGUL=0.                                                          
      RETURN                                                            
      END                                                               
C----------------------------------------------------------------       
      FUNCTION FHNCIC(X)                                                
      COMMON/KFIF/PFIF                                                  
      DIMENSION FH(13),P(13)                                            
      DATA FH/0.8595,0.8594,0.8592,0.8589,0.8584,0.8576,1.588E-2,       
     *1.307E-2,8.489E-3,4.473E-3,1.959E-3,7.329E-4,2.471E-4/            
      P(1)=0.                                                           
      P(2)=0.2*PFIF                                                     
      P(3)=0.4*PFIF                                                     
      P(4)=0.6*PFIF                                                     
      P(5)=0.8*PFIF                                                     
      P(6)=0.99*PFIF                                                    
      P(7)=1.01*PFIF                                                    
      P(8)=1.4*PFIF                                                     
      P(9)=1.8*PFIF                                                     
      P(10)=2.2*PFIF                                                    
      P(11)=2.6*PFIF                                                    
      P(12)=3.0*PFIF                                                    
      P(13)=3.4*PFIF                                                    
      PY=X/0.197328                                                     
      DO 1 K=1,12                                                       
      IF(PY.GE.P(K).AND.PY.LE.P(K+1)) GO TO 3                           
      GO TO 1                                                           
3     FHNCIC=(FH(K)+(FH(K+1)-FH(K))/(P(K+1)-P(K))*(PY-P(K)))            
     */0.197328**3/9.6400775                                            
      RETURN                                                            
1     CONTINUE                                                          
      FHNCIC=0.                                                         
      RETURN                                                            
      END                                                               
C----------------------------------------------------------------       
      FUNCTION SUB(X)                                                   
      COMMON/KFIF/PFIF                                                  
      DIMENSION SB(13),P(13)                                            
      P(1)=0.                                                           
      P(2)=0.2*PFIF                                                     
      P(3)=0.4*PFIF                                                     
      P(4)=0.6*PFIF                                                     
      P(5)=0.8*PFIF                                                     
      P(6)=0.99*PFIF                                                    
      P(7)=1.01*PFIF                                                    
      P(8)=1.4*PFIF                                                     
      P(9)=1.8*PFIF                                                     
      P(10)=2.2*PFIF                                                    
      P(11)=2.6*PFIF                                                    
      P(12)=3.0*PFIF                                                    
      P(13)=3.4*PFIF                                                    
      SB(1)=0.8595-0.0178                                               
      SB(2)=0.8594-0.0177                                               
      SB(3)=0.8592-0.0175                                               
      SB(4)=0.8589-0.0172                                               
      SB(5)=0.8584-0.0167                                               
      SB(6)=0.8576-0.01588                                              
      SB(7)=0.                                                          
      SB(8)=0.                                                          
      SB(9)=0.                                                          
      SB(10)=0.                                                         
      SB(11)=0.                                                         
      SB(12)=0.                                                         
      SB(13)=0.                                                         
      PY=X/0.197328                                                     
      DO 1 K=1,12                                                       
      IF(PY.GE.P(K).AND.PY.LT.P(K+1))GO TO 3                            
      GO TO 1                                                           
3     SUB=(SB(K)+(SB(K+1)-SB(K))/(P(K+1)-P(K))*(PY-P(K)))/0.197328**3   
     */8.242601                                                         
      RETURN                                                            
1     CONTINUE                                                          
      SUB=0.                                                            
      RETURN                                                            
      END                                                               


*fd.f
      FUNCTION FD(X)                                                    
C ************************************************                      
C *  DEUTRON WAVE FUNCTION WITH PARIS POTENTIAL  *                      
C ************************************************                      
      COMMON/PARIS/C(13),D(13),BM(13)                                   
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
      FD=(U(X/0.197328)**2+WW(X/0.197328)**2)/0.197328**3               
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
      FUNCTION WW(X)                                                    
      COMMON/PARIS/C(13),D(13),BM(13)                                   
      A=0.                                                              
      DO 1 J=1,13                                                       
1     A=D(J)/(X*X+BM(J)**2)+A                                           
      F=0.79788456                                                      
      WW=A*F/SQRT(4.*3.14159265)                                        
      RETURN                                                            
      END                                                               



*table.f
************************************************************
*       Fermi step distribution PF in [GeV/c]              *
************************************************************
	FUNCTION TABLE(P,PF)
	TABLE = 0.0
	IF(P.GT.PF)RETURN
	TABLE = 3.0 / (4.0*ACOS(-1.)*PF**3)
	RETURN
	END

	function dpn12(p)
****************************************************        
*       Oscilliator WF momentum distribution for C12               
****************************************************       
	pm = 0.938279
	pi = acos(-1.0)            
        wo  = 0.012                                              
        wom = 12./11.*pi*pm*wo                                   
        wos = 11./12.*p**2/pm/wo                                   
        fs1a = 4.             * wom**(-3./2.) * exp(-wos)             
        fp1a = 16./3.*pi*p**2 * wom**(-5./2.) * exp(-wos)   
        dpn12  = (fs1a + fp1a)/12.0
        return                           
        end   
                                                        
	function fs1_c12(p)
****************************************************     
*       Oscilliator WF momentum distribution for C12               
****************************************************     
	pm = 0.938279
	pi = acos(-1.0)            
        wo  = 0.012                                              
        wom = 12./11.*pi*pm*wo                                   
        wos = 11./12.*p**2/pm/wo                                   
        fs1_c12 = 4.             * wom**(-3./2.) * exp(-wos)             
        return                           
        end   
                                                        
	function fp1_c12(p)
************************************     
*       Oscilliator WF for C12               
************************************     
	pm = 0.938279
	pi = acos(-1.0)            
        wo  = 0.012                                              
        wom = 12./11.*pi*pm*wo                                   
        wos = 11./12.*p**2/pm/wo                                   
        fp1_c12 = 16./3.*pi*p**2 * wom**(-5./2.) * exp(-wos)   
        return                           
        end   


******************************************************
* Silvano's He3 and H3 wave function's 
* momentum distributions, 
* pk - in fm^-1
* n  - fm^3

      FUNCTION DNGR(p)
      common/a3case/a3case
      common/fermi/pferm      
*      print *,a3case,pferm
*
*      GROUND COMPONENT OF THE PROTON MOMENTUM DISTRIBUTION IN HE-3
*
*      IMPLICIT REAL*8 (A-H,O-Z)
      if(a3case.lt.1.1)then ! Silvano's wave function

      pk = p/0.197327
      PK2=PK*PK
      DNGR0=31.74519*EXP(-1.324*PK2)/((1+5.978*PK2)**2)+
     +     0.002665001*EXP(-0.365*PK2)

      dngr = dngr0/(4*acos(-1.0))/0.197327**3
      else
      ifl = 0
c      call he3_mom_dist(p,dist,dist_p,dist_n,dist_pn,dist_pp,ifl)

      dngr = 3.0/2.0*dist_p
*      print *,ifl,p,dngr

      if(p.gt.pferm)dngr=0.0
      endif

      RETURN
      END


      FUNCTION DNEX(IN,P)
***********************************************************************
*    EXCITED COMPONENT OF THE MOMENTUM DISTRIBUTIONS IN HE-3
*    IN=0 neutron
*    IN=1 proton   
***********************************************************************
*      IMPLICIT REAL*8 (A-H,O-Z)
      common/a3case/a3case
      common/fermi/pferm      
      if(a3case.lt.1.1)then ! Silvano's wave function
      pk = p/0.197327
      PK2=PK*PK
      IF(IN.EQ.0) THEN
       DNEX0=22.83538*EXP(-0.94*PK2)/((1+3.6006*PK2)**2)+
     +      0.01761402*EXP(-0.22D0*PK2)
      ELSE
       DNEX0=7.402948*EXP(-1.229*PK2)/((1+3.2118*PK2)**2)+
     +      0.01390257*EXP(-0.23352*PK2)/((1+
     +      0.00032989*PK2)**2)
      ENDIF
      dnex = dnex0/(4*acos(-1.0))/0.197327**3
*      if(p.gt.0.23)dnex = 2.0*fd(p)

      else   ! new Bochum wave function
         ifl = 0
c      call he3_mom_dist(p,dist,dist_p,dist_n,dist_pn,dist_pp,ifl)
      if(in.eq.0)then 
      dnex = 3.0*dist_n
      else      
      dnex = 3.0/2.0*dist_p
      if(p.lt.pferm)dnex=0.0
      endif
      endif

      RETURN
      END




c      subroutine he3_mom_dist(p,dist,dist_p,dist_n,dist_pn,dist_pp,ifl)
c********************************************************************************************
c*  Calculates momentum distribution of nucleon, proton,neutron, pn and pp
c*  ifl=-1,-2, initialization, 0 calculation
c*  ifl=-1 v8_ix wave function of He3
c*  ifl=-2 v8_tm wave function of He3
c*
c* Source from ghenn/code_wkng, data points are calculated using norm_check.f
c*
c* 10-Dec-08
c* Miami, FL
c* 
c**********************************************************************************************
c
c      common/dists/a_dist(0:100),a_dist_p(0:100),a_dist_n(0:100),
c     &             a_dist_pn(0:100),a_dist_pp(0:100),a_p(0:100)
c      dist    = 0.0
c      dist_p  = 0.0
c      dist_n  = 0.0
c      dist_pn = 0.0
c      dist_pp = 0.0
c      if(ifl.lt.0)then
c      if(ifl.eq.-1)then
c      open(unit=5,file='mom_dist_v8_ix.calc')
c      elseif(ifl.eq.-2)then
c      open(unit=5,file='mom_dist_v8_tm.calc')
c      endif
c*      print *,'aha'
c      do i = 0,100
c      read(5,12)a_p(i),a_dist(i),a_dist_p(i), a_dist_n(i),
c     &                  a_dist_pn(i),a_dist_pp(i)
c      ! write(20,12)a_p(i),a_dist(i),a_dist_p(i), a_dist_n(i),
c     &                  a_dist_pn(i),a_dist_pp(i)
c      enddo
c
c      close(unit=5)
c 12   format(f7.3,5(1x,e11.3))
c      endif
c
c      if(p.gt.1.0)return
c      
c      do i=0,99
c      if(p.ge.a_p(i).and.p.le.a_p(i+1))then
c
c	dist = a_dist(i) 
c     &       + (p-a_p(i))/(a_p(i+1)-a_p(i))*(a_dist(i+1)-a_dist(i))
c   
c	dist_p = a_dist_p(i) 
c     &       + (p-a_p(i))/(a_p(i+1)-a_p(i))*(a_dist_p(i+1)-a_dist_p(i))
c   
c	dist_n = a_dist_n(i) 
c     &       + (p-a_p(i))/(a_p(i+1)-a_p(i))*(a_dist_n(i+1)-a_dist_n(i))
c
c	dist_pn = a_dist_pn(i) 
c     &       +(p-a_p(i))/(a_p(i+1)-a_p(i))*(a_dist_pn(i+1)-a_dist_pn(i))
c	dist_pp = a_dist_pp(i) 
c     &       +(p-a_p(i))/(a_p(i+1)-a_p(i))*(a_dist_pp(i+1)-a_dist_pp(i))
c        endif
c
c       enddo
c
c       return
c       end
cc



                                                        


* b.f
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



* targ_r_length.f 
	SUBROUTINE TARG_R_LENGTH(ANUN,RL)
********************************************************************* 
*                                                                   * 
*       Function to determine the radiation length of               *
*       target mather                                               *
*                                                                   *
*        Written:        October 10, 1989                           *
*        Author:         Misak Sargsyan, YERPHI                     *
*        Modifications:                                             *
*                                                                   *
*        Note: Data was taken from "Particle Properties Data        *
*               Booklet" April 1986                                 *
*                                                                   *
*********************************************************************
	CHARACTER*10 ANUN
	IF(ANUN.EQ.' H2'  ) RL = 1. / 8650.   
	IF(ANUN.EQ.' D2'  ) RL = 1. / 7570.   
	IF(ANUN.EQ.' HE'  ) RL = 1. / 7550.   
	IF(ANUN.EQ.' LI'  ) RL = 1. / 1550.    
	IF(ANUN.EQ.' BE'  ) RL = 1. / 353.   
	IF(ANUN.EQ.' C'   ) RL = 1. / 188.   
	IF(ANUN.EQ.' N2'  ) RL = 1. / 470.   
	IF(ANUN.EQ.' O2'  ) RL = 1. / 300.   
	IF(ANUN.EQ.' NE'  ) RL = 1. / 240.   
	IF(ANUN.EQ.' AL'  ) RL = 1. / 89.   
	IF(ANUN.EQ.' SI'  ) RL = 1. / 93.6   
	IF(ANUN.EQ.' AR'  ) RL = 1. / 140.   
	IF(ANUN.EQ.' FE'  ) RL = 1. / 17.6   
	IF(ANUN.EQ.' CU'  ) RL = 1. / 14.3   
	IF(ANUN.EQ.' SN'  ) RL = 1. / 12.1   
	IF(ANUN.EQ.' XE'  ) RL = 1. / 27.7   
	IF(ANUN.EQ.' W'   ) RL = 1. / 3.5   
	IF(ANUN.EQ.' PB'  ) RL = 1. / 5.6    
	IF(ANUN.EQ.' U'   ) RL = 1. / 3.2   
	IF(ANUN.EQ.' AIR  '   ) RL = 1. / 304200.   
	IF(ANUN.EQ.' H2O' ) RL = 1. / 361.    
	IF(ANUN.EQ.' SIO2') RL = 1. / 123.    
	IF(ANUN.EQ.' H2-26K'  ) RL = 1. / 10000.     
	IF(ANUN.EQ.' D2-31K'  ) RL = 1. / 9000.    
	IF(ANUN.EQ.' CH-SCIN' ) RL = 1. / 424.   
	IF(ANUN.EQ.' CH2-POLY') RL = 1. / 479.    
	IF(ANUN.EQ.' MYLAR'   ) RL = 1. / 287.    
	IF(ANUN.EQ.' CO2-GAS' ) RL = 1. / 183100.    
	IF(ANUN.EQ.' CH4-METH') RL = 1. / 648500.    
	IF(ANUN.EQ.' FREON'   ) RL = 1. / 48100.     
        RETURN
        END


*my_gadap.f
      SUBROUTINE GADAP(A0,B0,F,EPS,SUM) 
C **********************************************************************    
C   
C   THE FOLLOWING INTEGRATION ROUTINES WHERE OBTAINED FROM THE  
C   LUND UNIVERSITY COMPUTER CENTER.    
C   
C **********************************************************************    
C.......................................................................    
C   
C   PURPOSE           - INTEGRATE A FUNCTION F(X)   
C   METHOD            - ADAPTIVE GAUSSIAN   
C   USAGE             - CALL GADAP(A0,B0,F,EPS,SUM) 
C   PARAMETERS  A0    - LOWER LIMIT (INPUT,REAL)    
C               B0    - UPPER LIMIT (INPUT,REAL)    
C               F     - FUNCTION F(X) TO BE INTEGRATED. MUST BE 
C                       SUPPLIED BY THE USER. (INPUT,REAL FUNCTION) 
C               EPS   - DESIRED RELATIVE ACCURACY. IF SUM IS SMALL EPS  
C                       WILL BE ABSOLUTE ACCURACY INSTEAD. (INPUT,REAL) 
C               SUM   - CALCULATED VALUE FOR THE INTEGRAL (OUTPUT,REAL) 
C   PRECISION         - SINGLE  
C   REQ'D PROG'S      - F   
C   AUTHOR            - THOMAS JOHANSSON, LDC,1973  
C   REFERENCE(S)      - THE AUSTRALIAN COMPUTER JOURNAL,3 P.126 AUG. -71    
C   
C.......................................................................    
      COMMON/GADAP1/ NUM,IFU    
      EXTERNAL F    
      DIMENSION A(300),B(300),F1(300),F2(300),F3(300),S(300),N(300) 
    1 FORMAT(16H GADAP:I TOO BIG)   
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
C   PURPOSE           - INTEGRATE A FUNCTION F(X,Y) OF TWO VARIABLES    
C   METHOD            - ADAPTIVE GAUSSIAN IN BOTH DIRECTIONS    
C   USAGE             - CALL GADAP2(A0,B0,FL,FU,F,EPS,SUM)  
C   PARAMETERS  A0    - LOWER X-LIMIT (INPUT,REAL)  
C               B0    - UPPER X-LIMIT (INPUT,REAL)  
C               FL    - USER SUPPLIED FUNCTION FL(X) GIVING THE LOWER   
C                       Y-LIMIT FOR A GIVEN X-VALUE 
C                       (INPUT,REAL FUNCTION)   
C               FU    - USER SUPPLIED FUNCTION FU(X) GIVING THE UPPER   
C                       Y-LIMIT FOR A GIVEN X-VALUE 
C                       (INPUT,REAL FUNCTION)   
C               F     - USER SUPPLIED FUNCTION F(X,Y) TO BE INTEGRATED  
C                       (INPUT,REAL FUNCTION)   
C               EPS   - DESIRED ACCURACY (INPUT,REAL)   
C               SUM   - CALCULATED VALUE FOR THE INTEGRAL (OUTPUT,REAL) 
C   PRECISION         - SINGLE  
C   REQ'D PROG'S      - FL,FU,F,FGADAP  
C   AUTHOR            - THOMAS JOHANSSON, LDC,1973  
C   
C.......................................................................    
      COMMON/GADAP_2/ NUM,IFU    
      EXTERNAL F,FL,FU  
      DIMENSION A(300),B(300),F1(300),F2(300),F3(300),S(300),N(300) 
    1 FORMAT(16H GADAP:I TOO BIG)   
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
    1 FORMAT(16H GADAP:I TOO BIG)   
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
      SUBROUTINE GADAPS(A0,B0,F,EPS,SUM) 
C **********************************************************************    
C   This is a same as in case GADAP  
C **********************************************************************    
      COMMON/GADAPS_1/ NUM,IFU    
      EXTERNAL F    
      DIMENSION A(300),B(300),F1(300),F2(300),F3(300),S(300),N(300) 
    1 FORMAT(16H GADAP:I TOO BIG)   
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


*my_simps.f
	SUBROUTINE SIMPS(A,B,ST,REPS,AEPS,FUNCT,AI,AIH,AIABS)
**************************************************************************
*       Subroutine calculates the definite integral with the             *
*       relative or absolute precision by Simpson's method with          *
*       the automatical choice of the step of integration.               *
*                                                                        *
*                  A,B    - the limits of integration                    *
*                  ST     - an initial step of integration               *
*                  REPS   - relative precision of integration            *
*                  AEPS   - absolute precision of integration            * 
*                  FUNCT  - user supplied function, for the integration  *
*                  AI     - the result of integration                    *
*                  AIH    - the result of integration with the step      *  
*                           of integration                               *
*                  AIABS  - the result of integration of absolute        *
*                           value of integrand                           *
*                                                                        *
*                                                                        *
*       Note if the AEPS = 1.E-17, (but no just 0.0) then calculation    *
*       take a place with REPS and  vice versa                           *
*                                                                        *
*                                                                        *
*	Author:           Dubna, IJNR                                    *
*       Written:          1966, Dubna                                    *
*       Modification:     Optimised by suppresing the some unused        *
*                         variables. M.Sargsyan, June 1990, CEBAF        *  
*                                                                        *  
**************************************************************************
	EXTERNAL FUNCT
	DIMENSION F(7) , P(5)
	H  = SIGN(ST,B-A)
	S  = SIGN(1.,H)
	AI = 0.0
	AIH = 0.0
	AIABS = 0.
	P(2) = 4.0
	P(4) = 4.0
	P(3) = 2.0
	P(5) = 1.0
	IF(B-A.EQ.0.0)GOTO 2
	DO 3 K = 1 , 7
3	F(K) = 10.0E+16
	X = A
	C = 0.0
	F(1) = FUNCT(X) / 3.
4	X0 = X
	IF((X0+4.0*H-B)*S)5,5,6
6       H = (B-X0)/4.
	IF(H) 7,2,7
7	DO 8 K = 2 , 7
8	F(K) = 10.0E+16
	C = 1.0
5	DI2 = F(1)
	DI3 = ABS(F(1))
	DO 9  K = 2 , 5
	X = X + H
	IF((X-B)*S) 23,24,24
24	X = B
23	IF(F(K)-10.0E+16) 10 , 11 , 10
11	F(K) = FUNCT(X) / 3.0
10	DI2 = DI2 + P(K)*F(K)
9	DI3 = DI3 + P(K)*ABS(F(K))
	DI1 = (F(1) + 4.*F(3) + F(5)) * 2.0 * H
	DI2 = DI2 * H
	DI3 = DI3 * H
        IF(REPS.GE.1.0)GOTO 13
	IF(REPS) 12,13,12
13      IF(AEPS.GE.1.0)GOTO 14
	IF(AEPS) 12,14,12
12	EPS = ABS((AIABS+DI3)*REPS)
	IF(EPS-AEPS) 15 , 16 , 16
15	EPS = AEPS
16	DELTA = ABS(DI1)
	IF(DELTA - EPS) 20 , 21 , 21
20	IF(DELTA - EPS/8.0) 17 , 14 , 14
17	H = 2.0 * H
	F(1) = F(5)
	F(2) = F(6)
	F(3) = F(7)
	DO 19 K = 4 , 7
19 	F(K) = 10.0E+16
	GO TO 18
14	F(1) = F(5)
	F(3) = F(6)
	F(5) = F(7)
	F(2) = 10.0E+16
	F(4) = 10.0E+16 
	F(6) = 10.0E+16	
	F(7) = 10.0E+16
18	DI1 = DI2 + (DI2-DI1) / 15.
	AI = AI + DI1
	AIH = AIH + DI2
	AIABS = AIABS + DI3
	GO TO 22
21      H = H / 2.0
	F(7) = F(5)
	F(6) = F(4)
	F(5) = F(3)
	F(3) = F(2)
	F(2) = 10.0E+16
	F(4) = 10.0E+16
	X = X0
	C = 0.0
	GO TO  5
22	IF(C) 2 , 4 , 2
2	RETURN
	END	 


      SUBROUTINE simpson(A0,B0,F,n,SUM) 
C **********************************************************************    
C   
C   THE FOLLOWING INTEGRATION ROUTINES WHERE OBTAINED FROM THE  
C   LUND UNIVERSITY COMPUTER CENTER.    
C   
C **********************************************************************    
C.......................................................................    
C   
C   PURPOSE           - INTEGRATE A FUNCTION F(X)   
C   METHOD            - ADAPTIVE GAUSSIAN   
C   USAGE             - CALL GADAP(A0,B0,F,EPS,SUM) 
C   PARAMETERS  A0    - LOWER LIMIT (INPUT,REAL)    
C               B0    - UPPER LIMIT (INPUT,REAL)    
C               F     - FUNCTION F(X) TO BE INTEGRATED. MUST BE 
C                       SUPPLIED BY THE USER. (INPUT,REAL FUNCTION) 
C               EPS   - DESIRED RELATIVE ACCURACY. IF SUM IS SMALL EPS  
C                       WILL BE ABSOLUTE ACCURACY INSTEAD. (INPUT,REAL) 
C               SUM   - CALCULATED VALUE FOR THE INTEGRAL (OUTPUT,REAL) 
C   PRECISION         - SINGLE  
C   REQ'D PROG'S      - F   
C   AUTHOR            - THOMAS JOHANSSON, LDC,1973  
C   REFERENCE(S)      - THE AUSTRALIAN COMPUTER JOURNAL,3 P.126 AUG. -71    
C   
C.......................................................................    
	external f
*	n = 100
	width = (b0-a0)/n
	sumi = 0.0
	do i = 1,n
	x = a0 + float(i)*width 
	sumi = sumi + f(x)* width
	enddo
*	! write(6,*)"sumi",sumi
	sum = sumi
	return
	end





************************************************************************
* Nuclon Form-Factor Parameterizations
*************************************************************************

C     -------------------------------------                             
*      ics      defines the parameterization of nucleon form-factors
*               ! 1 - SLAC, 2 - Kelly, 3-Bodek, BB, Arrington
*               ! 4 - Kelly with different Gen ( =0)
*               ! 5 - Kelly with different Gen (2Gen_Galster)
*               ! 6 - GMn is Riordans, remaining is Kelly's
*
*******************************************************
*   Charge and Magnetic Form Factor Parameterizations
*   Standard parameterization (one I used before)
*******************************************************
      subroutine proton_formfactors(q2,GEp,GMp,ics)
      pm = 0.938272
      tau = Q2/4./pm**2                           

      if(ics.eq.1)then
************************************************************
*  SLAC Parameterization
************************************************************
      GEp = Gs(Q2)                                                         
      GMp = Gs(Q2)*2.79

      elseif(ics.eq.2.or.ics.ge.4)then
************************************************************
*    J.J. Kelly's Parameterization
*    From Phys. Rev. C70, 068202, 2004
************************************************************
      GEp = (1.-0.24*tau)/(1.+10.98*tau+12.82*tau**2+21.97*tau**3)
      GMp = 2.79*(1.+0.12*tau)/(1.+10.97*tau+18.86*tau**2+6.55*tau**3)

      elseif(ics.eq.3)then
************************************************************
*    Bradford, Bodek, Budd, Arrington
*    Hep-ex/0602017
************************************************************
      GEp = (1.-0.0578*tau)/(1.+11.1*tau+13.6*tau**2+33.0*tau**3)
      GMp = 2.79*(1.+0.15*tau)/(1.+11.1*tau+19.6*tau**2+7.54*tau**3)
***************************************************************************      
      endif
      
      return
      end

      subroutine neutron_formfactors(q2,GEn,GMn,ics)
      pm = 0.938272

      tau = Q2/4./pm**2    

      if(ics.eq.1)then
************************************************************
*  SLAC Parameterization
************************************************************
      GEn =  1.91*Gs(Q2)*tau/(1.+5.6*tau)                                   
      GMn = -1.91*Gs(Q2) 

      elseif(ics.eq.2.or.ics.ge.4)then
************************************************************
*    J.J. Kelly's Parameterization
*    From Phys. Rev. C70, 068202, 2004
************************************************************
      GEn0=  1.7*tau/(1.+3.3*tau)*Gs(Q2)                                  
      GMn = -1.91*(1.+2.33*tau)/(1.+14.72*tau+24.20*tau**2+84.1*tau**3)

      GEn = Gen0
      if(ics.eq.4)GEn = 0.0
      if(ics.eq.5)GEn = 2.0*GEn0
      if(ics.eq.6)then !Riordan's parameterization
      GMn= -1.91*(1 + 6.32*tau)/(1.+18.46*tau+64.63*tau**2+182.8*tau**3)
      endif
      elseif(ics.eq.3)then   
************************************************************
*    Bradford, Bodek, Budd, Arrington
*    Hep-ex/0602017
************************************************************
      GEn = (1.25*tau+1.3*tau**2)/(1.-9.86*tau+305.*tau**2-758.0*tau**3
     &                                                    +802.0*tau**4)

      GMn = -1.91*(1.+1.81*tau)/(1.+14.1*tau+20.7*tau**2+68.7*tau**3)
      endif

      return
      end



      function Gs(Q2)                                                    
      Gs=1./(1.+Q2/0.71)**2                                               
      return                                                            
      end
