C---- b1d_calc.F ---------
C
C Patricia Solvignon (October 19, 2010)
C
C Generate xb1 following the formalism of Kumano PRD82, 017501 (2010). 
C In the paper, fig.1 was generated for Q2 = 2.5 GeV2 and with MSTW2008LO
C
C Generate xb1 from G. Miller:
C Proceedings for Electronuclear Physics with Internal Targets, ed. R. G. Arnold
C (World Scientific, Singapore 1989) p. 30
C
C Also generated here with CTEQ5 and MRST2001LO.
C---------------------------------------------------------------
C
C---------------------------------------------------------------
      PROGRAM b1d_calc
      IMPLICIT NONE

      INTEGER NPTS,ix,nx,j,ipdf,iset,npdf,k
      REAL*8 hbarc2
      REAL*8 PI,ALPHA,MP,e_ch,picobarn,nanobarn
      PARAMETER( npdf   = 3          ) ! CTEQ, MRST and MSTW
      PARAMETER( hbarc2 = 0.389379E-3) ! barn/GeV^2
      PARAMETER( PI     = 3.14159265 )
      PARAMETER( NPTS   = 10000      )
      PARAMETER( MP     = 0.98272    )
      PARAMETER( e_ch = 1.602E-19    )
      PARAMETER( picobarn = 1E12     )
      PARAMETER( nanobarn = 1E9      )
 
      DOUBLE PRECISION xmin,xstep
      DOUBLE PRECISION QQ,x,w2,q
      DOUBLE PRECISION Ctq5Pdf
      DOUBLE PRECISION GetOnePDF,xpdf(-6:6)
      DOUBLE PRECISION upv,dnv,usea,dsea,str,chm,bot,glu,phot
      DOUBLE PRECISION u(npdf,NPTS),ubar(npdf,NPTS),d(npdf,NPTS),dbar(npdf,NPTS)
      DOUBLE PRECISION s(npdf,NPTS),sbar(npdf,NPTS),c(npdf,NPTS),cbar(npdf,NPTS)
      DOUBLE PRECISION b(npdf,NPTS),bbar(npdf,NPTS),g(npdf,NPTS)
      DOUBLE PRECISION dsig(npdf,NPTS)
      CHARACTER PREFIX*18

      DOUBLE PRECISION ei,asm_vn,asm_lc

      DOUBLE PRECISION b1d(2,NPTS),xb1d(2,NPTS)
      DOUBLE PRECISION deltaT_qv(2,NPTS),xdeltaT_qv(2,NPTS)
      DOUBLE PRECISION deltaT_qbar(2,NPTS),xdeltaT_qbar(2,NPTS)
      DOUBLE PRECISION Azz(2,NPTS)
      DOUBLE PRECISION F1p(2,NPTS),F1n(2,NPTS),F1d(2,NPTS)

      ! parameters from Kumano paper: PRD82,017501 (2010)
      DOUBLE PRECISION delta_Tw(2,NPTS)
      DOUBLE PRECISION alpha_qbar(2),a_parm(2),b_parm(2),c_parm(2),x0(2)
      DATA alpha_qbar/0.0,3.20/
      DATA a_parm/0.378,0.221/
      DATA b_parm/0.706,0.648/
      DATA c_parm/1.0,1.0/
      DATA x0/0.229,0.221/
c 
c--------------------------------------------------------------------
c
c------------------------------ OUTPUT FILE -------------------------
c
c      OPEN(UNIT=90,FILE='output/b1model_kumano.dat',  STATUS='UNKNOWN')
c      OPEN(UNIT=91,FILE='output/b1model_miller.dat',  STATUS='UNKNOWN')
      OPEN(UNIT=92,FILE='output/b1model_sargsian.dat',STATUS='UNKNOWN')
c      OPEN(UNIT=93,FILE='output/b1model_bacchetta.dat',STATUS='UNKNOWN')
c
c------------------------------ CONSTANTS ---------------------------
c
      ALPHA  = 1.0/137.0
c
c------------------------------ INPUTS ------------------------------      
c-- set option
 
      QQ    = 5.0      ! in GeV^2
      ei    = 11.0     ! in GeV: incident energy needed for Sargsian's calc.
c
c---------------------------- MAIN CODE -----------------------------
c
      xstep  = 0.05
      xmin   = 0.25
      nx     = int((1.0-xmin)/xstep)
      ix     = 0
      DO ix=1,nx
         x  = xmin+(ix-1)*xstep
         w2 = MP**2 + (QQ/x) - QQ
         q      = sqrt(QQ)

c         IF (W2.lt.4.0) GOTO 999

c--      CTEQ5
         ipdf=1    ! 1=cteq
         Iset=3    ! LO
         Call SetCtq5(Iset)
         u(ipdf,ix)    = Ctq5Pdf(1,x,q)
         d(ipdf,ix)    = Ctq5Pdf(2,x,q)
         s(ipdf,ix)    = Ctq5Pdf(3,x,q)
         c(ipdf,ix)    = Ctq5Pdf(4,x,q)
         b(ipdf,ix)    = Ctq5Pdf(5,x,q)
         g(ipdf,ix)    = Ctq5Pdf(0,x,q)
         ubar(ipdf,ix) = Ctq5Pdf(-1,x,q)
         dbar(ipdf,ix) = Ctq5Pdf(-2,x,q)
         sbar(ipdf,ix) = Ctq5Pdf(-3,x,q)   
         cbar(ipdf,ix) = Ctq5Pdf(-4,x,q)
         bbar(ipdf,ix) = Ctq5Pdf(-5,x,q)
         WRITE(6,*)'CTEQ: ',u(ipdf,ix)


c--      MRST2001LO
         ipdf=2   ! 2=mrst
         iset=1   ! LO
         call mrstlo(x,QQ,iset,upv,dnv,usea,dsea,str,chm,bot,glu)
         WRITE(6,*)'upv= ',upv/x
         u(ipdf,ix)    = upv/x
         WRITE(6,*)'u(ipdf,ix)= ',u(ipdf,ix)
         d(ipdf,ix)    = dnv/x
         s(ipdf,ix)    = str/x
         c(ipdf,ix)    = chm/x
         b(ipdf,ix)    = bot/x
         g(ipdf,ix)    = glu/x
         ubar(ipdf,ix) = usea/x
         dbar(ipdf,ix) = dsea/x
         sbar(ipdf,ix) = str/x  ! assuming symmetry of the sea
         cbar(ipdf,ix) = chm/x  ! assuming symmetry of the sea
         bbar(ipdf,ix) = bot/x  ! assuming symmetry of the sea

c--      MSTW2008LO
         ipdf=3   ! 3=mstw
         iset=0   ! LO
         prefix = "Grids/mstw2008lo" ! prefix for the grid files
         CALL GetAllPDFs(prefix,iset,x,q,upv,dnv,usea,dsea,str,sbar,
     &        chm,cbar,bot,bbar,glu,phot)
         WRITE(6,*)'upv= ',upv/x
         u(ipdf,ix)    = upv/x
         WRITE(6,*)'u(ipdf,ix)= ',u(ipdf,ix)
         d(ipdf,ix)    = dnv/x
         s(ipdf,ix)    = str/x
         c(ipdf,ix)    = chm/x
         b(ipdf,ix)    = bot/x
         g(ipdf,ix)    = glu/x
         ubar(ipdf,ix) = usea/x
         dbar(ipdf,ix) = dsea/x
         sbar(ipdf,ix) = str/x  ! assuming symmetry of the sea
         cbar(ipdf,ix) = chm/x  ! assuming symmetry of the sea
         bbar(ipdf,ix) = bot/x  ! assuming symmetry of the sea

c--
c------- KUMANO ------------------------------------------------------------
         DO k=1,2  ! 1=b1d no sea, 2=b1d sea
            delta_Tw(k,ix)  = a_parm(k) * (x**(b_parm(k))) 
     &                       * ((1.0-x)**(c_parm(k))) * (x0(k)-x)   ! eq.7
         ENDDO

         DO j =1,npdf
            DO k=1,2
               deltaT_qv(k,ix)   = delta_Tw(k,ix)                   ! eq.5 top
     &                             * (u(j,ix) + d(j,ix)) /2.
               deltaT_qbar(k,ix) = alpha_qbar(k) * delta_Tw(k,ix)   ! eq.5 bottom
     &                      * (2.*ubar(j,ix) + 2.*dbar(j,ix) 
     &                         + s(j,ix) + sbar(j,ix)) / 6.

               xdeltaT_qv(k,ix)   = x*deltaT_qv(k,ix)    ! multiply by x to reproduce fig.2
               xdeltaT_qbar(k,ix) = x*deltaT_qbar(k,ix)  ! multiply by x to reproduce fig.2

               b1d(k,ix)  =  2.*ubar(j,ix) + 2.*dbar(j,ix) 
     &                      + s(j,ix) + sbar(j,ix)
               b1d(k,ix)  = b1d(k,ix) * 4. * alpha_qbar(k)
               b1d(k,ix)  = b1d(k,ix) + 5.*(u(j,ix) + d(j,ix))
               b1d(k,ix)  = b1d(k,ix) * delta_Tw(k,ix) / 36.0      ! eq.6

               xb1d(k,ix) = x*b1d(k,ix)  ! multiply by x to reproduce fig.1
               
               ! forming Azz
               F1p(k,ix)  =   0.5*((4./9.) * (u(j,ix) + ubar(j,ix))
     &                      + (1./9.) * (d(j,ix) + dbar(j,ix))
     &                      + (1./9.) * (s(j,ix) + sbar(j,ix)))
               F1n(k,ix)  =  0.5*((4./9.) * (d(j,ix) + dbar(j,ix)) ! using isospin symmetry
     &                      + (1./9.) * (u(j,ix) + ubar(j,ix))
     &                      + (1./9.) * (s(j,ix) + sbar(j,ix)))
               F1d(k,ix)  = (F1p(k,ix) + F1n(k,ix))/2.

               Azz(k,ix)  = (-2./3.)*b1d(k,ix)/F1d(k,ix)

            ENDDO
            write(90,1000) j, x, QQ,                                       ! 1-3
     &                     delta_Tw(1,ix),xdeltaT_qv(1,ix),xb1d(1,ix),     ! 4-6  --> no sea contribution
     &                     delta_Tw(2,ix),xdeltaT_qv(2,ix),                ! 7-8  --> sea contibutes
     &                     xdeltaT_qbar(2,ix),xb1d(2,ix),                  ! 9-10 --> sea contibutes
     &                     Azz(1,ix),Azz(2,ix)                             !11-12 --> asymmetries without and with sea

         ENDDO

c------- MILLER ------------------------------------------------------------

         DO j =1,npdf
            k = 1

            ! forming Azz
            Azz(k,ix)  = (-2./3.)*0.02*(x - 0.3)

            F1p(k,ix)  =  0.5*((4./9.) * (u(j,ix) + ubar(j,ix))
     &                  + (1./9.) * (d(j,ix) + dbar(j,ix))
     &                  + (1./9.) * (s(j,ix) + sbar(j,ix)))
            F1n(k,ix)  =  0.5*((4./9.) * (d(j,ix) + dbar(j,ix)) ! using isospin symmetry
     &                  + (1./9.) * (u(j,ix) + ubar(j,ix))
     &                  + (1./9.) * (s(j,ix) + sbar(j,ix)))
            F1d(k,ix)  = (F1p(k,ix) + F1n(k,ix))/2.

            b1d(k,ix)  = (-3./2.) * Azz(k,ix)* F1d(k,ix)   ! eq.23

            xb1d(k,ix) = x*b1d(k,ix)      ! multiply by x

            ! forming Azz
            Azz(k,ix)  = (-2./3.)*b1d(k,ix)/F1d(k,ix)

            write(91,1001) j, x, QQ,                ! 1-3
     &                     xb1d(1,ix),Azz(1,ix)     ! 4-5
         ENDDO


c------- Sargsian model ------------------------------------------------------------

         DO j =1,npdf

            call nestfun(x,QQ,ei,asm_vn,asm_lc)

            DO k = 1,2
               if (k.eq.1) Azz(k,ix)  = asm_vn
               if (k.eq.2) Azz(k,ix)  = asm_lc

               F1p(k,ix)  =  0.5*((4./9.) * (u(j,ix) + ubar(j,ix))
     &                      + (1./9.) * (d(j,ix) + dbar(j,ix))
     &                      + (1./9.) * (s(j,ix) + sbar(j,ix)))
               F1n(k,ix)  =  0.5*((4./9.) * (d(j,ix) + dbar(j,ix)) ! using isospin symmetry
     &                      + (1./9.) * (u(j,ix) + ubar(j,ix))
     &                      + (1./9.) * (s(j,ix) + sbar(j,ix)))
               F1d(k,ix)  = (F1p(k,ix) + F1n(k,ix))/2.

               b1d(k,ix)  = (-3./2.) * Azz(k,ix)* F1d(k,ix)   ! eq.23

               xb1d(k,ix) = x*b1d(k,ix)      ! multiply by x
            ENDDO

            write(92,1002) j, x, QQ,                ! 1-3
     &                     xb1d(1,ix),Azz(1,ix),    ! 4-5
     &                     xb1d(2,ix),Azz(2,ix)     ! 6-7
         ENDDO

c------- Bacchetta limits ------------------------------------------------------------

         DO j =1,npdf

            k = 1

            F1p(k,ix)  =  0.5*((4./9.) * (u(j,ix) + ubar(j,ix))
     &                   + (1./9.) * (d(j,ix) + dbar(j,ix))
     &                   + (1./9.) * (s(j,ix) + sbar(j,ix)))
            F1n(k,ix)  =  0.5*((4./9.) * (d(j,ix) + dbar(j,ix)) ! using isospin symmetry
     &                   + (1./9.) * (u(j,ix) + ubar(j,ix))
     &                   + (1./9.) * (s(j,ix) + sbar(j,ix)))
            F1d(k,ix)  = (F1p(k,ix) + F1n(k,ix))/2.

            write(93,1001) j, x, QQ,                ! 1-3
     &                     -3./2.*F1d(1,ix),        ! lower limit
     &                     3.*F1d(1,ix)             ! upper limit
         ENDDO


 999     CONTINUE
      ENDDO
 1000 FORMAT(I1,(1x,F7.3),(1x,F7.1),9(1x,E10.3))
 1001 FORMAT(I1,(1x,F7.3),(1x,F7.1),2(1x,E10.3))
 1002 FORMAT(I1,(1x,F7.3),(1x,F7.1),4(1x,E10.3))

      END

C-------------------------- END MAIN CODE ---------------------------
C----------------------------------------------------------------------------
C
C**********************************************************************************C
C**********************************************************************************C
C**********************************************************************************C
C CTEQ5
C
C ---------------------------------------------------------------------------
C  Iset   PDF        Description       Alpha_s(Mz)  Lam4  Lam5   Table_File
C ---------------------------------------------------------------------------
C   1    CTEQ5M   Standard MSbar scheme   0.118     326   226    cteq5m.tbl
C   2    CTEQ5D   Standard DIS scheme     0.118     326   226    cteq5d.tbl
C   3    CTEQ5L   Leading Order           0.127     192   146    cteq5l.tbl
C   4    CTEQ5HJ  Large-x gluon enhanced  0.118     326   226    cteq5hj.tbl
C   5    CTEQ5HQ  Heavy Quark             0.118     326   226    cteq5hq.tbl
C   6    CTEQ5F3  Nf=3 FixedFlavorNumber  0.106     (Lam3=395)   cteq5f3.tbl
C   7    CTEQ5F4  Nf=4 FixedFlavorNumber  0.112     309   XXX    cteq5f4.tbl
C         --------------------------------------------------------
C   8    CTEQ5M1  Improved CTEQ5M         0.118     326   226    cteq5m1.tbl
C   9    CTEQ5HQ1 Improved CTEQ5HQ        0.118     326   226    ctq5hq1.tbl
C ---------------------------------------------------------------------------
C   
C  The available applied range is 10^-5 << x << 1 and 1.0 << Q << 10,000 (GeV).
C   Lam5 (Lam4, Lam3) represents Lambda value (in MeV) for 5 (4,3) flavors. 
C   The matching alpha_s between 4 and 5 flavors takes place at Q=4.5 GeV,  
C   which is defined as the bottom quark mass, whenever it can be applied.
C
C   The Table_Files are assumed to be in the working directory.
C   
C   Before using the PDF, it is necessary to do the initialization by
C       Call SetCtq5(Iset) 
C   where Iset is the desired PDF specified in the above table.
C   
C   The function Ctq5Pdf (Iparton, X, Q)
C   returns the parton distribution inside the proton for parton [Iparton] 
C   at [X] Bjorken_X and scale [Q] (GeV) in PDF set [Iset].
C   Iparton  is the parton label (5, 4, 3, 2, 1, 0, -1, ......, -5)
C                            for (b, c, s, d, u, g, u_bar, ..., b_bar),
C      whereas CTEQ5F3 has, by definition, only 3 flavors and gluon;
C              CTEQ5F4 has only 4 flavors and gluon.
C   
C   For detailed information on the parameters used, e.q. quark masses, 
C   QCD Lambda, ... etc.,  see info lines at the beginning of the 
C   Table_Files.
C
C   These programs, as provided, are in double precision.  By removing the
C   "Implicit Double Precision" lines, they can also be run in single 
C   precision.
C   
C   If you have detailed questions concerning these CTEQ5 distributions, 
C   or if you find problems/bugs using this package, direct inquires to 
C   Hung-Liang Lai(lai@phys.nthu.edu.tw) or Wu-Ki Tung(Tung@pa.msu.edu).
C   
C===========================================================================

      Function Ctq5Pdf (Iparton, X, Q)
      Implicit Double Precision (A-H,O-Z)
      Logical Warn
      Common
     > / CtqPar2 / Nx, Nt, NfMx
     > / QCDtable /  Alambda, Nfl, Iorder

      Data Warn /.true./
      save Warn

      If (X .lt. 0D0 .or. X .gt. 1D0) Then
	Print *, 'X out of range in Ctq5Pdf: ', X
	Stop
      Endif
      If (Q .lt. Alambda) Then
	Print *, 'Q out of range in Ctq5Pdf: ', Q
	Stop
      Endif
      If ((Iparton .lt. -NfMx .or. Iparton .gt. NfMx)) Then
         If (Warn) Then
C        put a warning for calling extra flavor.
	     Warn = .false.
	     Print *, 'Warning: Iparton out of range in Ctq5Pdf: '
     >              , Iparton
         Endif
         Ctq5Pdf = 0D0
         Return
      Endif

      Ctq5Pdf = PartonX (Iparton, X, Q)
      if(Ctq5Pdf.lt.0.D0)  Ctq5Pdf = 0.D0

      Return

C                             ********************
      End

      FUNCTION PartonX (IPRTN, X, Q)
C
C   Given the parton distribution function in the array Upd in
C   COMMON / CtqPar1 / , this routine fetches u(fl, x, q) at any value of
C   x and q using Mth-order polynomial interpolation for x and Ln(Q/Lambda).
C
      IMPLICIT DOUBLE PRECISION (A-H, O-Z)
C
      PARAMETER (MXX = 105, MXQ = 25, MXF = 6)
      PARAMETER (MXPQX = (MXF *2 +2) * MXQ * MXX)
      PARAMETER (M= 2, M1 = M + 1)
C
      Logical First
      Common 
     > / CtqPar1 / Al, XV(0:MXX), QL(0:MXQ), UPD(MXPQX)
     > / CtqPar2 / Nx, Nt, NfMx
     > / XQrange / Qini, Qmax, Xmin
C
      Dimension Fq(M1), Df(M1)

      Data First /.true./
      save First
C                                                 Work with Log (Q)
      QG  = LOG (Q/AL)

C                           Find lower end of interval containing X
      JL = -1
      JU = Nx+1
 11   If (JU-JL .GT. 1) Then
         JM = (JU+JL) / 2
         If (X .GT. XV(JM)) Then
            JL = JM
         Else
            JU = JM
         Endif
         Goto 11
      Endif

      Jx = JL - (M-1)/2
      If (X .lt. Xmin .and. First ) Then
         First = .false.
         Print '(A, 2(1pE12.4))', 
     >     ' WARNING: X << Xmin, extrapolation used; X, Xmin =', X, Xmin
         If (Jx .LT. 0) Jx = 0
      Elseif (Jx .GT. Nx-M) Then
         Jx = Nx - M
      Endif
C                                    Find the interval where Q lies
      JL = -1
      JU = NT+1
 12   If (JU-JL .GT. 1) Then
         JM = (JU+JL) / 2
         If (QG .GT. QL(JM)) Then
            JL = JM
         Else
            JU = JM
         Endif
         Goto 12
      Endif

      Jq = JL - (M-1)/2
      If (Jq .LT. 0) Then
         Jq = 0
         If (Q .lt. Qini)  Print '(A, 2(1pE12.4))', 
     >     ' WARNING: Q << Qini, extrapolation used; Q, Qini =', Q, Qini
      Elseif (Jq .GT. Nt-M) Then
         Jq = Nt - M
         If (Q .gt. Qmax)  Print '(A, 2(1pE12.4))', 
     >     ' WARNING: Q > Qmax, extrapolation used; Q, Qmax =', Q, Qmax
      Endif

      If (Iprtn .GE. 3) Then
         Ip = - Iprtn
      Else
         Ip = Iprtn
      EndIf
C                             Find the off-set in the linear array Upd
      JFL = Ip + NfMx
      J0  = (JFL * (NT+1) + Jq) * (NX+1) + Jx
C
C                                           Now interpolate in x for M1 Q's
      Do 21 Iq = 1, M1
         J1 = J0 + (Nx+1)*(Iq-1) + 1
         Call Polint (XV(Jx), Upd(J1), M1, X, Fq(Iq), Df(Iq))
 21   Continue
C                                          Finish off by interpolating in Q
      Call Polint (QL(Jq), Fq(1), M1, QG, Ftmp, Ddf)

      PartonX = Ftmp
C
      RETURN
C                        ****************************
      END

      Subroutine SetCtq5 (Iset)
      Implicit Double Precision (A-H,O-Z)
      Parameter (Isetmax=9)
      Character Flnm(Isetmax)*22, Tablefile*40
      Data (Flnm(I), I=1,Isetmax)
     > / 'subs/CTEQ5/cteq5m.tbl', 'subs/CTEQ5/cteq5d.tbl' 
     > , 'subs/CTEQ5/cteq5l.tbl', 'subs/CTEQ5/cteq5hj.tbl'
     > , 'subs/CTEQ5/cteq5hq.tbl', 'subs/CTEQ5/cteq5f3.tbl' 
     > , 'subs/CTEQ5/cteq5f4.tbl', 'subs/CTEQ5/cteq5m1.tbl'
     > , 'subs/CTEQ5/ctq5hq1.tbl'  /
      Data Tablefile / 'test.tbl' /
      Data Isetold, Isetmin, Isettest / -987, 1, 911 /
      save

C             If data file not initialized, do so.
      If(Iset.ne.Isetold) then
	 IU= NextUn()
         If (Iset .eq. Isettest) then
            Print* ,'Opening ', Tablefile
 21         Open(IU, File=Tablefile, Status='OLD', Err=101)
            GoTo 22
 101        Print*, Tablefile, ' cannot be opened '
            Print*, 'Please input the .tbl file:'
            Read (*,'(A)') Tablefile
            Goto 21
 22         Continue
         ElseIf (Iset.lt.Isetmin .or. Iset.gt.Isetmax) Then
	    Print *, 'Invalid Iset number in SetCtq5 :', Iset
	    Stop
         Else
            Tablefile=Flnm(Iset)
            Open(IU, File=Tablefile, Status='OLD', Err=100)
	 Endif
         Call ReadTbl (IU)
         Close (IU)
	 Isetold=Iset
      Endif
      Return

 100  Print *, ' Data file ', Tablefile, ' cannot be opened '
     >//'in SetCtq5!!'
      Stop
C                             ********************
      End

      Subroutine ReadTbl (Nu)
      Implicit Double Precision (A-H,O-Z)
      Character Line*80
      PARAMETER (MXX = 105, MXQ = 25, MXF = 6)
      PARAMETER (MXPQX = (MXF *2 +2) * MXQ * MXX)
      Common 
     > / CtqPar1 / Al, XV(0:MXX), QL(0:MXQ), UPD(MXPQX)
     > / CtqPar2 / Nx, Nt, NfMx
     > / XQrange / Qini, Qmax, Xmin
     > / QCDtable /  Alambda, Nfl, Iorder
     > / Masstbl / Amass(6)
      
      Read  (Nu, '(A)') Line     
      Read  (Nu, '(A)') Line
      Read  (Nu, *) Dr, Fl, Al, (Amass(I),I=1,6)
      Iorder = Nint(Dr)
      Nfl = Nint(Fl)
      Alambda = Al

      Read  (Nu, '(A)') Line 
      Read  (Nu, *) NX,  NT, NfMx

      Read  (Nu, '(A)') Line
      Read  (Nu, *) QINI, QMAX, (QL(I), I =0, NT)

      Read  (Nu, '(A)') Line
      Read  (Nu, *) XMIN, (XV(I), I =0, NX)

      Do 11 Iq = 0, NT
         QL(Iq) = Log (QL(Iq) /Al)
   11 Continue
C
C                  Since quark = anti-quark for nfl>2 at this stage, 
C                  we Read  out only the non-redundent data points
C     No of flavors = NfMx (sea) + 1 (gluon) + 2 (valence) 

      Nblk = (NX+1) * (NT+1)
      Npts =  Nblk  * (NfMx+3)
      Read  (Nu, '(A)') Line
      Read  (Nu, *, IOSTAT=IRET) (UPD(I), I=1,Npts)

      Return
C                        ****************************
      End

      Function NextUn()
C                                 Returns an unallocated FORTRAN i/o unit.
      Logical EX
C
      Do 10 N = 10, 300
         INQUIRE (UNIT=N, OPENED=EX)
         If (.NOT. EX) then
            NextUn = N
            Return
         Endif
 10   Continue
      Stop ' There is no available I/O unit. '
C               *************************
      End
C

      SUBROUTINE POLINT (XA,YA,N,X,Y,DY)
 
      IMPLICIT DOUBLE PRECISION (A-H, O-Z)
C                                        Adapted from "Numerical Recipes" 
      PARAMETER (NMAX=10)
      DIMENSION XA(N),YA(N),C(NMAX),D(NMAX)
      NS=1
      DIF=ABS(X-XA(1))
      DO 11 I=1,N
        DIFT=ABS(X-XA(I))
        IF (DIFT.LT.DIF) THEN
          NS=I
          DIF=DIFT
        ENDIF
        C(I)=YA(I)
        D(I)=YA(I)
11    CONTINUE
      Y=YA(NS)
      NS=NS-1
      DO 13 M=1,N-1
        DO 12 I=1,N-M
          HO=XA(I)-X
          HP=XA(I+M)-X
          W=C(I+1)-D(I)
          DEN=HO-HP
          IF(DEN.EQ.0.)PAUSE
          DEN=W/DEN
          D(I)=HP*DEN
          C(I)=HO*DEN
12      CONTINUE
        IF (2*NS.LT.N-M)THEN
          DY=C(NS+1)
        ELSE
          DY=D(NS)
          NS=NS-1
        ENDIF
        Y=Y+DY
13    CONTINUE
      RETURN
      END
C**********************************************************************************C
C**********************************************************************************C
C**********************************************************************************C
C MRST2001
C
      subroutine mrstlo(x,q,mode,upv,dnv,usea,dsea,str,chm,bot,glu)
C***************************************************************C
C								C
C  This is a package for the new MRST 2001 LO parton            C
C  distributions.                                               C     
C  Reference: A.D. Martin, R.G. Roberts, W.J. Stirling and      C
C  R.S. Thorne, hep-ph/0201xxx                                  C
C                                                               C
C  There is 1 pdf set corresponding to mode = 1                 C
C                                                               C
C  Mode=1 gives the default set with Lambda(MSbar,nf=4) = 0.220 C
C  corresponding to alpha_s(M_Z) of 0.130                       C
C  This set reads a grid whose first number is 0.02868          C
C                                                               C
C   This subroutine uses an improved interpolation procedure    C 
C   for extracting values of the pdf's from the grid            C
C                                                               C
C         Comments to : W.J.Stirling@durham.ac.uk               C
C                                                               C
C***************************************************************C
      implicit real*8(a-h,o-z)
      data xmin,xmax,qsqmin,qsqmax/1d-5,1d0,1.25d0,1d7/
      q2=q*q
      if(q2.lt.qsqmin.or.q2.gt.qsqmax) print 99,q2
      if(x.lt.xmin.or.x.gt.xmax)       print 98,x
          if(mode.eq.1) then
        call mrst1(x,q2,upv,dnv,usea,dsea,str,chm,bot,glu) 
      endif 
  99  format('  WARNING:  Q^2 VALUE IS OUT OF RANGE   ','q2= ',e10.5)
  98  format('  WARNING:   X  VALUE IS OUT OF RANGE   ','x= ',e10.5)
      return
      end

      subroutine mrst1(x,qsq,upv,dnv,usea,dsea,str,chm,bot,glu)
      implicit real*8(a-h,o-z)
      parameter(nx=49,nq=37,np=8,nqc0=2,nqb0=11,nqc=35,nqb=26)
      real*8 f1(nx,nq),f2(nx,nq),f3(nx,nq),f4(nx,nq),f5(nx,nq),
     .f6(nx,nq),f7(nx,nq),f8(nx,nq),fc(nx,nqc),fb(nx,nqb)
      real*8 qq(nq),xx(nx),cc1(nx,nq,4,4),cc2(nx,nq,4,4),
     .cc3(nx,nq,4,4),cc4(nx,nq,4,4),cc6(nx,nq,4,4),cc8(nx,nq,4,4),
     .ccc(nx,nqc,4,4),ccb(nx,nqb,4,4)
      real*8 xxl(nx),qql(nq),qqlc(nqc),qqlb(nqb)
      data xx/1d-5,2d-5,4d-5,6d-5,8d-5,
     .	      1d-4,2d-4,4d-4,6d-4,8d-4,
     .	      1d-3,2d-3,4d-3,6d-3,8d-3,
     .	      1d-2,1.4d-2,2d-2,3d-2,4d-2,6d-2,8d-2,
     .	   .1d0,.125d0,.15d0,.175d0,.2d0,.225d0,.25d0,.275d0,
     .	   .3d0,.325d0,.35d0,.375d0,.4d0,.425d0,.45d0,.475d0,
     .	   .5d0,.525d0,.55d0,.575d0,.6d0,.65d0,.7d0,.75d0,
     .	   .8d0,.9d0,1d0/
      data qq/1.25d0,1.5d0,2d0,2.5d0,3.2d0,4d0,5d0,6.4d0,8d0,1d1,
     .        1.2d1,1.8d1,2.6d1,4d1,6.4d1,1d2,
     .        1.6d2,2.4d2,4d2,6.4d2,1d3,1.8d3,3.2d3,5.6d3,1d4,
     .        1.8d4,3.2d4,5.6d4,1d5,1.8d5,3.2d5,5.6d5,1d6,
     .        1.8d6,3.2d6,5.6d6,1d7/
      data xmin,xmax,qsqmin,qsqmax/1d-5,1d0,1.25d0,1d7/
      data init/0/
      save
      xsave=x
      q2save=qsq
      if(init.ne.0) goto 10
        open(unit=33,file='subs/MRST/2001LO/lo2002.dat',status='old')
        do 20 n=1,nx-1
        do 20 m=1,nq
        read(33,50)f1(n,m),f2(n,m),f3(n,m),f4(n,m),
     .		  f5(n,m),f7(n,m),f6(n,m),f8(n,m)
c notation: 1=uval 2=val 3=glue 4=usea 5=chm 6=str 7=btm 8=dsea
  20  continue
      do 40 m=1,nq
      f1(nx,m)=0.d0
      f2(nx,m)=0.d0
      f3(nx,m)=0.d0
      f4(nx,m)=0.d0
      f5(nx,m)=0.d0
      f6(nx,m)=0.d0
      f7(nx,m)=0.d0
      f8(nx,m)=0.d0
  40  continue
      do n=1,nx
      xxl(n)=dlog(xx(n))
      enddo
      do m=1,nq
      qql(m)=dlog(qq(m))
      enddo

      call jeppe1(nx,nq,xxl,qql,f1,cc1)
      call jeppe1(nx,nq,xxl,qql,f2,cc2)
      call jeppe1(nx,nq,xxl,qql,f3,cc3)
      call jeppe1(nx,nq,xxl,qql,f4,cc4)
      call jeppe1(nx,nq,xxl,qql,f6,cc6)
      call jeppe1(nx,nq,xxl,qql,f8,cc8)

      emc2=2.045
      emb2=18.5

      do 44 m=1,nqc
      qqlc(m)=qql(m+nqc0)
      do 44 n=1,nx
      fc(n,m)=f5(n,m+nqc0)
   44 continue
      qqlc(1)=dlog(emc2)
      call jeppe1(nx,nqc,xxl,qqlc,fc,ccc)

      do 45 m=1,nqb
      qqlb(m)=qql(m+nqb0)
      do 45 n=1,nx
      fb(n,m)=f7(n,m+nqb0)
   45 continue
      qqlb(1)=dlog(emb2)
      call jeppe1(nx,nqb,xxl,qqlb,fb,ccb)


      init=1
   10 continue
      
      xlog=dlog(x)
      qsqlog=dlog(qsq)

      call jeppe2(xlog,qsqlog,nx,nq,xxl,qql,cc1,upv)
      call jeppe2(xlog,qsqlog,nx,nq,xxl,qql,cc2,dnv)
      call jeppe2(xlog,qsqlog,nx,nq,xxl,qql,cc3,glu)
      call jeppe2(xlog,qsqlog,nx,nq,xxl,qql,cc4,usea)
      call jeppe2(xlog,qsqlog,nx,nq,xxl,qql,cc6,str)
      call jeppe2(xlog,qsqlog,nx,nq,xxl,qql,cc8,dsea)

      chm=0.d0
      if(qsq.gt.emc2) then 
      call jeppe2(xlog,qsqlog,nx,nqc,xxl,qqlc,ccc,chm)
      endif

      bot=0.d0
      if(qsq.gt.emb2) then 
      call jeppe2(xlog,qsqlog,nx,nqb,xxl,qqlb,ccb,bot)
      endif

      x=xsave
      qsq=q2save
      return
   50 format(8f10.5)
      end
 
c      subroutine jeppe1(nx,my,xx,yy,ff,cc)
c      implicit real*8(a-h,o-z)
c      dimension xx(nx),yy(my),ff(nx,my),ff1(nx,my),ff2(nx,my),
c     xff12(nx,my),yy0(4),yy1(4),yy2(4),yy12(4),z(16),wt(16,16),
c     xcl(16),cc(nx,my,4,4),iwt(16,16)

      subroutine jeppe1(nx,my,xx,yy,ff,cc)
      implicit real*8(a-h,o-z)
      PARAMETER(NNX=49,MMY=37)
      dimension xx(nx),yy(my),ff(nx,my),ff1(NNX,MMY),ff2(NNX,MMY),
     xff12(NNX,MMY),yy0(4),yy1(4),yy2(4),yy12(4),z(16),wt(16,16),
     xcl(16),cc(nx,my,4,4),iwt(16,16)

      data iwt/1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
     x		  0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,
     x		  -3,0,0,3,0,0,0,0,-2,0,0,-1,0,0,0,0,
     x		  2,0,0,-2,0,0,0,0,1,0,0,1,0,0,0,0,
     x		  0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
     x		  0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,
     x		  0,0,0,0,-3,0,0,3,0,0,0,0,-2,0,0,-1,
     x		  0,0,0,0,2,0,0,-2,0,0,0,0,1,0,0,1,
     x		  -3,3,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0,
     x		  0,0,0,0,0,0,0,0,-3,3,0,0,-2,-1,0,0,
     x		  9,-9,9,-9,6,3,-3,-6,6,-6,-3,3,4,2,1,2,
     x		  -6,6,-6,6,-4,-2,2,4,-3,3,3,-3,-2,-1,-1,-2,
     x		  2,-2,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
     x		  0,0,0,0,0,0,0,0,2,-2,0,0,1,1,0,0,
     x		  -6,6,-6,6,-3,-3,3,3,-4,4,2,-2,-2,-2,-1,-1,
     x		  4,-4,4,-4,2,2,-2,-2,2,-2,-2,2,1,1,1,1/


      do 42 m=1,my
      dx=xx(2)-xx(1)
      ff1(1,m)=(ff(2,m)-ff(1,m))/dx
      dx=xx(nx)-xx(nx-1)
      ff1(nx,m)=(ff(nx,m)-ff(nx-1,m))/dx
      do 41 n=2,nx-1
      ff1(n,m)=polderiv(xx(n-1),xx(n),xx(n+1),ff(n-1,m),ff(n,m),
     xff(n+1,m))
   41 continue
   42 continue

      do 44 n=1,nx
      dy=yy(2)-yy(1)
      ff2(n,1)=(ff(n,2)-ff(n,1))/dy
      dy=yy(my)-yy(my-1)
      ff2(n,my)=(ff(n,my)-ff(n,my-1))/dy
      do 43 m=2,my-1
      ff2(n,m)=polderiv(yy(m-1),yy(m),yy(m+1),ff(n,m-1),ff(n,m),
     xff(n,m+1))
   43 continue
   44 continue

      do 46 m=1,my
      dx=xx(2)-xx(1)
      ff12(1,m)=(ff2(2,m)-ff2(1,m))/dx
      dx=xx(nx)-xx(nx-1)
      ff12(nx,m)=(ff2(nx,m)-ff2(nx-1,m))/dx
      do 45 n=2,nx-1
      ff12(n,m)=polderiv(xx(n-1),xx(n),xx(n+1),ff2(n-1,m),ff2(n,m),
     xff2(n+1,m))
   45 continue
   46 continue

      do 53 n=1,nx-1
      do 52 m=1,my-1
      d1=xx(n+1)-xx(n)
      d2=yy(m+1)-yy(m)
      d1d2=d1*d2

      yy0(1)=ff(n,m)
      yy0(2)=ff(n+1,m)
      yy0(3)=ff(n+1,m+1)
      yy0(4)=ff(n,m+1)

      yy1(1)=ff1(n,m)
      yy1(2)=ff1(n+1,m)
      yy1(3)=ff1(n+1,m+1)
      yy1(4)=ff1(n,m+1)

      yy2(1)=ff2(n,m)
      yy2(2)=ff2(n+1,m)
      yy2(3)=ff2(n+1,m+1)
      yy2(4)=ff2(n,m+1)

      yy12(1)=ff12(n,m)
      yy12(2)=ff12(n+1,m)
      yy12(3)=ff12(n+1,m+1)
      yy12(4)=ff12(n,m+1)

      do 47 k=1,4
      z(k)=yy0(k)
      z(k+4)=yy1(k)*d1
      z(k+8)=yy2(k)*d2
      z(k+12)=yy12(k)*d1d2
   47 continue

      do 49 l=1,16
      xxd=0.
      do 48 k=1,16
      xxd=xxd+iwt(k,l)*z(k)
   48 continue
      cl(l)=xxd
   49 continue
      l=0
      do 51 k=1,4
      do 50 j=1,4
      l=l+1
      cc(n,m,k,j)=cl(l)
   50 continue
   51 continue
   52 continue
   53 continue
      return
      end

      subroutine jeppe2(x,y,nx,my,xx,yy,cc,z)
C--   G.W. 02/07/2007 Allow extrapolation to small x and large q.
      implicit real*8(a-h,o-z)
      dimension xx(nx),yy(my),cc(nx,my,4,4)      
      
      n=locx(xx,nx,x)
      m=locx(yy,my,y)
      
      if (n.gt.0.and.n.lt.nx.and.m.gt.0.and.m.lt.my) then
C--   Do usual interpolation.
         t=(x-xx(n))/(xx(n+1)-xx(n))
         u=(y-yy(m))/(yy(m+1)-yy(m))
         z=0.d0
         do l=4,1,-1
            z=t*z+((cc(n,m,l,4)*u+cc(n,m,l,3))*u
     &           +cc(n,m,l,2))*u+cc(n,m,l,1)
         enddo
         
      else if (n.eq.0.and.m.gt.0.and.m.lt.my) then
C--   Extrapolate to small x.
         call jeppe3(xx(1),y,nx,my,xx,yy,cc,f0)
         call jeppe3(xx(2),y,nx,my,xx,yy,cc,f1)
         if (f0.gt.0.d0.and.f1.gt.0.d0) then
            z = exp(log(f0)+(log(f1)-log(f0))/(xx(2)-xx(1))*(x-xx(1)))
         else
            z = f0+(f1-f0)/(xx(2)-xx(1))*(x-xx(1))
         end if
         
      else if (n.gt.0.and.m.eq.my) then
C--   Extrapolate to large q.
         call jeppe3(x,yy(my),nx,my,xx,yy,cc,f0)
         call jeppe3(x,yy(my-1),nx,my,xx,yy,cc,f1)
         if (f0.gt.0.d0.and.f1.gt.0.d0) then
            z = exp(log(f0)+(log(f0)-log(f1))/(yy(my)-yy(my-1))*
     &           (y-yy(my)))
         else
            z = f0+(f0-f1)/(yy(my)-yy(my-1))*(y-yy(my))
         end if
         
      else if (n.eq.0.and.m.eq.my) then
C--   Extrapolate to small x AND large q.
         call jeppe3(xx(1),yy(my),nx,my,xx,yy,cc,f0)
         call jeppe3(xx(1),yy(my-1),nx,my,xx,yy,cc,f1)
         if (f0.gt.0.d0.and.f1.gt.0.d0) then
            z0 = exp(log(f0)+(log(f0)-log(f1))/(yy(my)-yy(my-1))*
     &           (y-yy(my)))
         else
            z0 = f0+(f0-f1)/(yy(my)-yy(my-1))*(y-yy(my))
         end if
         call jeppe3(xx(2),yy(my),nx,my,xx,yy,cc,f0)
         call jeppe3(xx(2),yy(my-1),nx,my,xx,yy,cc,f1)
         if (f0.gt.0.d0.and.f1.gt.0.d0) then
            z1 = exp(log(f0)+(log(f0)-log(f1))/(yy(my)-yy(my-1))*
     &           (y-yy(my)))
         else
            z1 = f0+(f0-f1)/(yy(my)-yy(my-1))*(y-yy(my))
         end if
         if (z0.gt.0.d0.and.z1.gt.0.d0) then
            z = exp(log(z0)+(log(z1)-log(z0))/(xx(2)-xx(1))*(x-xx(1)))
         else
            z = z0+(z1-z0)/(xx(2)-xx(1))*(x-xx(1))
         end if

      else
C--   Set parton distribution to zero otherwise.
         z = 0.d0

      end if
      
      return
      end

C--   G.W. 02/07/2007 Copy of the original jeppe2,
C--   only used for extrapolation.
      subroutine jeppe3(x,y,nx,my,xx,yy,cc,z)
      implicit real*8(a-h,o-z)
      dimension xx(nx),yy(my),cc(nx,my,4,4)      
      n=locx(xx,nx,x)
      m=locx(yy,my,y)
      t=(x-xx(n))/(xx(n+1)-xx(n))
      u=(y-yy(m))/(yy(m+1)-yy(m))
      z=0.d0
      do l=4,1,-1
         z=t*z+((cc(n,m,l,4)*u+cc(n,m,l,3))*u
     &        +cc(n,m,l,2))*u+cc(n,m,l,1)
      enddo
      return
      end
      
      real*8 function  polderiv(x1,x2,x3,y1,y2,y3)
      implicit real*8(a-h,o-z)
      polderiv=(x3*x3*(y1-y2)-2.0*x2*(x3*(y1-y2)+x1*
     .(y2-y3))+x2*x2*(y1-y3)+x1*x1*(y2-y3))/((x1-x2)*(x1-x3)*(x2-x3))
      return
      end
C**********************************************************************************C
C**********************************************************************************C
C**********************************************************************************C
C MSTW2008
C
C A. D. Martin, W. J. Stirling, R. S. Thorne and G. Watt,
C  "Parton distributions for the LHC",
C  Eur. Phys. J. C 63 (2009) 189-285,
C  [arXiv:0901.0002 [hep-ph]].
C----------------------------------------------------------------------
C--   Fortran interpolation code for MSTW PDFs, building on existing
C--   MRST Fortran code and Jeppe Andersen's C++ code.
C--   Three user interfaces:
C--    call GetAllPDFs(prefix,ih,x,q,upv,dnv,usea,dsea,
C--                    str,sbar,chm,cbar,bot,bbar,glu,phot)
C--    call GetAllPDFsAlt(prefix,ih,x,q,xpdf,xphoton)
C--    xf = GetOnePDF(prefix,ih,x,q,f)
C--   See enclosed example.f for usage.
C--   Comments to Graeme Watt <Graeme.Watt(at)cern.ch>.
C--   Updated 25/06/2010: Enlarge allowed range for m_c and m_b.
C----------------------------------------------------------------------

C----------------------------------------------------------------------

C--   Traditional MRST-like interface: return all flavours.
C--   (Note the additional "sbar", "cbar", "bbar" and "phot"
C--   compared to previous MRST releases.)
      subroutine GetAllPDFs(prefix,ih,x,q,
     &     upv,dnv,usea,dsea,str,sbar,chm,cbar,bot,bbar,glu,phot)
      implicit none
      integer ih
      double precision x,q,upv,dnv,usea,dsea,str,sbar,chm,cbar,
     &     bot,bbar,glu,phot,GetOnePDF,up,dn,sv,cv,bv
      character*(*) prefix

C--   Quarks.
      dn  = GetOnePDF(prefix,ih,x,q,1)
      up  = GetOnePDF(prefix,ih,x,q,2)
      str = GetOnePDF(prefix,ih,x,q,3)
      chm = GetOnePDF(prefix,ih,x,q,4)
      bot = GetOnePDF(prefix,ih,x,q,5)

C--   Valence quarks.
      dnv = GetOnePDF(prefix,ih,x,q,7)
      upv = GetOnePDF(prefix,ih,x,q,8)
      sv  = GetOnePDF(prefix,ih,x,q,9)
      cv  = GetOnePDF(prefix,ih,x,q,10)
      bv  = GetOnePDF(prefix,ih,x,q,11)
      
C--   Antiquarks = quarks - valence quarks.
      dsea = dn - dnv
      usea = up - upv
      sbar = str - sv
      cbar = chm - cv
      bbar = bot - bv

C--   Gluon.
      glu = GetOnePDF(prefix,ih,x,q,0)

C--   Photon (= zero unless considering QED contributions).
      phot = GetOnePDF(prefix,ih,x,q,13)

      return
      end

C----------------------------------------------------------------------

C--   Alternative LHAPDF-like interface: return PDFs in an array.
      subroutine GetAllPDFsAlt(prefix,ih,x,q,xpdf,xphoton)
      implicit none
      integer ih,f
      double precision x,q,xpdf(-6:6),xphoton,xvalence,GetOnePDF
      character*(*) prefix

      do f = 1, 6
         xpdf(f) = GetOnePDF(prefix,ih,x,q,f) ! quarks
         xvalence = GetOnePDF(prefix,ih,x,q,f+6) ! valence quarks
         xpdf(-f) = xpdf(f) - xvalence ! antiquarks
      end do
      xpdf(0) = GetOnePDF(prefix,ih,x,q,0) ! gluon
      xphoton = GetOnePDF(prefix,ih,x,q,13) ! photon
      
      return
      end

C----------------------------------------------------------------------

C--   Get only one parton flavour 'f', using PDG notation
C--   (apart from gluon has f=0, not 21):
C--    f =   -6,  -5,  -4,  -3,  -2,  -1,0,1,2,3,4,5,6
C--      = tbar,bbar,cbar,sbar,ubar,dbar,g,d,u,s,c,b,t.
C--   Can also get valence quarks directly:
C--    f =  7, 8, 9,10,11,12.
C--      = dv,uv,sv,cv,bv,tv.
C--   Photon: f = 13.
      double precision function GetOnePDF(prefix,ih,x,q,f)
      implicit none
      logical warn,fatal
      parameter(warn=.false.,fatal=.true.)
C--   Set warn=.true. to turn on warnings when extrapolating.
C--   Set fatal=.false. to return zero instead of terminating when
C--    invalid input values of x and q are used.
      integer ih,f,nhess,nx,nq,np,nqc0,nqb0,n,m,ip,io,
     &     alphaSorder,alphaSnfmax,nExtraFlavours,lentrim
      double precision x,q,xmin,xmax,qsqmin,qsqmax,mc2,mb2,eps,
     &     dummy,qsq,xlog,qsqlog,res,res1,anom,ExtrapolatePDF,
     &     InterpolatePDF,distance,tolerance,
     &     mCharm,mBottom,alphaSQ0,alphaSMZ
      parameter(nx=64,nq=48,np=12)
      parameter(xmin=1d-6,xmax=1d0,qsqmin=1d0,qsqmax=1d9,eps=1d-6)
      parameter(nhess=2*20)
      character set*2,prefix*(*),filename*60,oldprefix(0:nhess)*50
      character dummyChar,dummyWord*50
      double precision ff(np,nx,nq)
      double precision qqorig(nq),qq(nq),xx(nx),cc(np,0:nhess,nx,nq,4,4)
      double precision xxl(nx),qql(nq)
C--   Store distance along each eigenvector, tolerance,
C--   heavy quark masses and alphaS parameters in COMMON block.
      common/mstwCommon/distance,tolerance,
     &     mCharm,mBottom,alphaSQ0,alphaSMZ,alphaSorder,alphaSnfmax
      save
      data xx/1d-6,2d-6,4d-6,6d-6,8d-6,
     &     1d-5,2d-5,4d-5,6d-5,8d-5,
     &     1d-4,2d-4,4d-4,6d-4,8d-4,
     &     1d-3,2d-3,4d-3,6d-3,8d-3,
     &     1d-2,1.4d-2,2d-2,3d-2,4d-2,6d-2,8d-2,
     &     .1d0,.125d0,.15d0,.175d0,.2d0,.225d0,.25d0,.275d0,
     &     .3d0,.325d0,.35d0,.375d0,.4d0,.425d0,.45d0,.475d0,
     &     .5d0,.525d0,.55d0,.575d0,.6d0,.625d0,.65d0,.675d0,
     &     .7d0,.725d0,.75d0,.775d0,.8d0,.825d0,.85d0,.875d0,
     &     .9d0,.925d0,.95d0,.975d0,1d0/
      data qqorig/1.d0,
     &     1.25d0,1.5d0,0.d0,0.d0,2.5d0,3.2d0,4d0,5d0,6.4d0,8d0,
     &     1d1,1.2d1,0.d0,0.d0,2.6d1,4d1,6.4d1,1d2,
     &     1.6d2,2.4d2,4d2,6.4d2,1d3,1.8d3,3.2d3,5.6d3,1d4,
     &     1.8d4,3.2d4,5.6d4,1d5,1.8d5,3.2d5,5.6d5,1d6,
     &     1.8d6,3.2d6,5.6d6,1d7,1.8d7,3.2d7,5.6d7,1d8,
     &     1.8d8,3.2d8,5.6d8,1d9/

      if (f.lt.-6.or.f.gt.13) then
         print *,"Error: invalid parton flavour = ",f
         stop
      end if

      if (ih.lt.0.or.ih.gt.nhess) then
         print *,"Error: invalid eigenvector number = ",ih
         stop
      end if

C--   Check if the requested parton set is already in memory.
      if (oldprefix(ih).ne.prefix) then

C--   Start of initialisation for eigenvector set "i" ...
C--   Do this only the first time the set "i" is called,
C--   OR if the prefix has changed from the last time.

C--   Check that the character arrays "oldprefix" and "filename"
C--   are large enough.
         if (lentrim(prefix).gt.len(oldprefix(ih))) then
            print *,"Error in GetOnePDF: increase size of oldprefix"
            stop
         else if (lentrim(prefix)+7.gt.len(filename)) then
            print *,"Error in GetOnePDF: increase size of filename"
            stop
         end if

         write(set,'(I2.2)') ih  ! convert integer to string
C--   Remove trailing blanks from prefix before assigning filename.
         filename = prefix(1:lentrim(prefix))//'.'//set//'.dat'
C--   Line below can be commented out if you don't want this message.
         print *,"Reading PDF grid from ",filename(1:lentrim(filename))
         open(unit=33,file=filename,iostat=io,status='old')
         if (io.ne.0) then
            print *,"Error in GetOnePDF: can't open ",
     &           filename(1:lentrim(filename))
            stop
         end if

C--   Read header containing heavy quark masses and alphaS values.
         read(33,*) 
         read(33,*)
         read(33,*) dummyChar,dummyWord,dummyWord,dummyChar,
     &        distance,tolerance
         read(33,*) dummyChar,dummyWord,dummyChar,mCharm
         read(33,*) dummyChar,dummyWord,dummyChar,mBottom
         read(33,*) dummyChar,dummyWord,dummyChar,alphaSQ0
         read(33,*) dummyChar,dummyWord,dummyChar,alphaSMZ
         read(33,*) dummyChar,dummyWord,dummyWord,dummyChar,
     &        alphaSorder,alphaSnfmax
         read(33,*) dummyChar,dummyWord,dummyChar,nExtraFlavours
         read(33,*)
         read(33,*)
         mc2=mCharm**2
         mb2=mBottom**2

C--   Check that the heavy quark masses are sensible.
C--   Redistribute grid points if not in usual range.
         do m=1,nq
            qq(m) = qqorig(m)
         end do
         if (mc2.le.qq(1).or.mc2+eps.ge.qq(8)) then
            print *,"Error in GetOnePDF: invalid mCharm = ",mCharm
            stop
         else if (mc2.lt.qq(2)) then
            nqc0=2
            qq(4)=qq(2)
            qq(5)=qq(3)
         else if (mc2.lt.qq(3)) then
            nqc0=3
            qq(5)=qq(3)
         else if (mc2.lt.qq(6)) then
            nqc0=4
         else if (mc2.lt.qq(7)) then
            nqc0=5
            qq(4)=qq(6)
         else
            nqc0=6
            qq(4)=qq(6)
            qq(5)=qq(7)
         end if
         if (mb2.le.qq(12).or.mb2+eps.ge.qq(17)) then
            print *,"Error in GetOnePDF: invalid mBottom = ",mBottom
            stop
         else if (mb2.lt.qq(13)) then
            nqb0=13
            qq(15)=qq(13)
         else if (mb2.lt.qq(16)) then
            nqb0=14
         else
            nqb0=15
            qq(14)=qq(16)
         end if
         qq(nqc0)=mc2
         qq(nqc0+1)=mc2+eps
         qq(nqb0)=mb2
         qq(nqb0+1)=mb2+eps

C--   The nExtraFlavours variable is provided to aid compatibility
C--   with future grids where, for example, a photon distribution
C--   might be provided (cf. the MRST2004QED PDFs).
         if (nExtraFlavours.lt.0.or.nExtraFlavours.gt.1) then
            print *,"Error in GetOnePDF: invalid nExtraFlavours = ",
     &           nExtraFlavours
            stop
         end if

C--   Now read in the grids from the grid file.
         do n=1,nx-1
            do m=1,nq
               if (nExtraFlavours.gt.0) then
                  if (alphaSorder.eq.2) then ! NNLO
                     read(33,'(12(1pe12.4))',iostat=io)
     &                    (ff(ip,n,m),ip=1,12)
                  else          ! LO or NLO
                     ff(10,n,m) = 0.d0 ! = chm-cbar
                     ff(11,n,m) = 0.d0 ! = bot-bbar
                     read(33,'(10(1pe12.4))',iostat=io)
     &                    (ff(ip,n,m),ip=1,9),ff(12,n,m)
                  end if
               else             ! nExtraFlavours = 0
                  if (alphaSorder.eq.2) then ! NNLO
                     ff(12,n,m) = 0.d0 ! = photon
                     read(33,'(11(1pe12.4))',iostat=io)
     &                 (ff(ip,n,m),ip=1,11)
                  else          ! LO or NLO
                     ff(10,n,m) = 0.d0 ! = chm-cbar
                     ff(11,n,m) = 0.d0 ! = bot-bbar
                     ff(12,n,m) = 0.d0 ! = photon
                     read(33,'(9(1pe12.4))',iostat=io)
     &                    (ff(ip,n,m),ip=1,9)
                  end if
               end if
               if (io.ne.0) then
                  print *,"Error in GetOnePDF reading ",filename
                  stop
               end if
            enddo
         enddo

C--   Check that ALL the file contents have been read in.
         read(33,*,iostat=io) dummy
         if (io.eq.0) then
            print *,"Error in GetOnePDF: not at end of ",filename
            stop
         end if
         close(unit=33)

C--   PDFs are identically zero at x = 1.
         do m=1,nq
            do ip=1,np
               ff(ip,nx,m)=0d0
            enddo
         enddo

         do n=1,nx
            xxl(n)=log10(xx(n))
         enddo
         do m=1,nq
            qql(m)=log10(qq(m))
         enddo

C--   Initialise all parton flavours.
         do ip=1,np
            call InitialisePDF(ip,np,ih,nhess,nx,nq,nqc0,nqb0,
     &           xxl,qql,ff,cc)
         enddo

         oldprefix(ih) = prefix

C--   ... End of initialisation for eigenvector set "ih".

      end if                    ! oldprefix(ih).ne.prefix

C----------------------------------------------------------------------

      qsq=q*q
C--   If mc2 < qsq < mc2+eps, then qsq = mc2+eps.
      if (qsq.gt.qq(nqc0).and.qsq.lt.qq(nqc0+1)) qsq = qq(nqc0+1)
C--   If mb2 < qsq < mb2+eps, then qsq = mb2+eps.
      if (qsq.gt.qq(nqb0).and.qsq.lt.qq(nqb0+1)) qsq = qq(nqb0+1)
      
      xlog=log10(x)
      qsqlog=log10(qsq)

      res = 0.d0

      if (f.eq.0) then          ! gluon
         ip = 1
      else if (f.ge.1.and.f.le.5) then ! quarks
         ip = f+1
      else if (f.le.-1.and.f.ge.-5) then ! antiquarks
         ip = -f+1
      else if (f.ge.7.and.f.le.11) then ! valence quarks
         ip = f
      else if (f.eq.13) then    ! photon
         ip = 12
      else if (abs(f).ne.6.and.f.ne.12) then
         if (warn.or.fatal) print *,"Error in GetOnePDF: f = ",f
         if (fatal) stop
      end if
      
      if (x.le.0.d0.or.x.gt.xmax.or.q.le.0.d0) then

         if (warn.or.fatal) print *,"Error in GetOnePDF: x,qsq = ",
     &        x,qsq
         if (fatal) stop

      else if (abs(f).eq.6.or.f.eq.12) then ! set top quarks to zero
         
         res = 0.d0

      else if (qsq.lt.qsqmin) then ! extrapolate to low Q^2

         if (warn) then
            print *, "Warning in GetOnePDF, extrapolating: f = ",f,
     &           ", x = ",x,", q = ",q
         end if

         if (x.lt.xmin) then    ! extrapolate to low x

            res = ExtrapolatePDF(ip,np,ih,nhess,xlog,
     &           log10(qsqmin),nx,nq,xxl,qql,cc)
            res1 = ExtrapolatePDF(ip,np,ih,nhess,xlog,
     &           log10(1.01D0*qsqmin),nx,nq,xxl,qql,cc)
            if (f.le.-1.and.f.ge.-5) then ! antiquark = quark - valence
               res = res - ExtrapolatePDF(ip+5,np,ih,nhess,xlog,
     &              log10(qsqmin),nx,nq,xxl,qql,cc)
               res1 = res1 - ExtrapolatePDF(ip+5,np,ih,nhess,xlog,
     &              log10(1.01D0*qsqmin),nx,nq,xxl,qql,cc)
            end if
            
         else                   ! do usual interpolation
            
            res = InterpolatePDF(ip,np,ih,nhess,xlog,
     &           log10(qsqmin),nx,nq,xxl,qql,cc)
            res1 = InterpolatePDF(ip,np,ih,nhess,xlog,
     &           log10(1.01D0*qsqmin),nx,nq,xxl,qql,cc)
            if (f.le.-1.and.f.ge.-5) then ! antiquark = quark - valence
               res = res - InterpolatePDF(ip+5,np,ih,nhess,xlog,
     &              log10(qsqmin),nx,nq,xxl,qql,cc)
               res1 = res1 - InterpolatePDF(ip+5,np,ih,nhess,xlog,
     &              log10(1.01D0*qsqmin),nx,nq,xxl,qql,cc)
            end if
            
         end if

C--   Calculate the anomalous dimension, dlog(xf)/dlog(qsq),
C--   evaluated at qsqmin.  Then extrapolate the PDFs to low
C--   qsq < qsqmin by interpolating the anomalous dimenion between
C--   the value at qsqmin and a value of 1 for qsq << qsqmin.
C--   If value of PDF at qsqmin is very small, just set
C--   anomalous dimension to 1 to prevent rounding errors.
C--   Impose minimum anomalous dimension of -2.5.
         if (abs(res).ge.1.D-5) then
            anom = max( -2.5D0, (res1-res)/res/0.01D0 )
         else
            anom = 1.D0
         end if
         res = res*(qsq/qsqmin)**(anom*qsq/qsqmin+1.D0-qsq/qsqmin)

      else if (x.lt.xmin.or.qsq.gt.qsqmax) then ! extrapolate

         if (warn) then
            print *, "Warning in GetOnePDF, extrapolating: f = ",f,
     &           ", x = ",x,", q = ",q
         end if

         res = ExtrapolatePDF(ip,np,ih,nhess,xlog,
     &        qsqlog,nx,nq,xxl,qql,cc)
         
         if (f.le.-1.and.f.ge.-5) then ! antiquark = quark - valence
            res = res - ExtrapolatePDF(ip+5,np,ih,nhess,xlog,
     &           qsqlog,nx,nq,xxl,qql,cc)
         end if

      else                      ! do usual interpolation
         
         res = InterpolatePDF(ip,np,ih,nhess,xlog,
     &        qsqlog,nx,nq,xxl,qql,cc)

         if (f.le.-1.and.f.ge.-5) then ! antiquark = quark - valence
            res = res - InterpolatePDF(ip+5,np,ih,nhess,xlog,
     &           qsqlog,nx,nq,xxl,qql,cc)
         end if
            
      end if
      
      GetOnePDF = res

      return
      end

C----------------------------------------------------------------------

      subroutine InitialisePDF(ip,np,ih,nhess,nx,my,myc0,myb0,
     &     xx,yy,ff,cc)
      implicit none
      integer nhess,ih,nx,my,myc0,myb0,j,k,l,m,n,ip,np
      double precision xx(nx),yy(my),ff(np,nx,my),
     &     ff1(nx,my),ff2(nx,my),ff12(nx,my),ff21(nx,my),
     &     yy0(4),yy1(4),yy2(4),yy12(4),z(16),
     &     cl(16),cc(np,0:nhess,nx,my,4,4),iwt(16,16),
     &     polderiv1,polderiv2,polderiv3,d1,d2,d1d2,xxd

      data iwt/1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
     &     0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,
     &     -3,0,0,3,0,0,0,0,-2,0,0,-1,0,0,0,0,
     &     2,0,0,-2,0,0,0,0,1,0,0,1,0,0,0,0,
     &     0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,
     &     0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,
     &     0,0,0,0,-3,0,0,3,0,0,0,0,-2,0,0,-1,
     &     0,0,0,0,2,0,0,-2,0,0,0,0,1,0,0,1,
     &     -3,3,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0,
     &     0,0,0,0,0,0,0,0,-3,3,0,0,-2,-1,0,0,
     &     9,-9,9,-9,6,3,-3,-6,6,-6,-3,3,4,2,1,2,
     &     -6,6,-6,6,-4,-2,2,4,-3,3,3,-3,-2,-1,-1,-2,
     &     2,-2,0,0,1,1,0,0,0,0,0,0,0,0,0,0,
     &     0,0,0,0,0,0,0,0,2,-2,0,0,1,1,0,0,
     &     -6,6,-6,6,-3,-3,3,3,-4,4,2,-2,-2,-2,-1,-1,
     &     4,-4,4,-4,2,2,-2,-2,2,-2,-2,2,1,1,1,1/

      do m=1,my
         ff1(1,m)=polderiv1(xx(1),xx(2),xx(3),
     &        ff(ip,1,m),ff(ip,2,m),ff(ip,3,m))
         ff1(nx,m)=polderiv3(xx(nx-2),xx(nx-1),xx(nx),
     &        ff(ip,nx-2,m),ff(ip,nx-1,m),ff(ip,nx,m))
         do n=2,nx-1
            ff1(n,m)=polderiv2(xx(n-1),xx(n),xx(n+1),
     &           ff(ip,n-1,m),ff(ip,n,m),ff(ip,n+1,m))
         enddo
      enddo

C--   Calculate the derivatives at qsq=mc2,mc2+eps,mb2,mb2+eps
C--   in a similar way as at the endpoints qsqmin and qsqmax.
      do n=1,nx
         do m=1,my
            if (m.eq.1.or.m.eq.myc0+1.or.m.eq.myb0+1) then
               ff2(n,m)=polderiv1(yy(m),yy(m+1),yy(m+2),
     &              ff(ip,n,m),ff(ip,n,m+1),ff(ip,n,m+2))
            else if (m.eq.my.or.m.eq.myc0.or.m.eq.myb0) then
               ff2(n,m)=polderiv3(yy(m-2),yy(m-1),yy(m),
     &              ff(ip,n,m-2),ff(ip,n,m-1),ff(ip,n,m))
            else
               ff2(n,m)=polderiv2(yy(m-1),yy(m),yy(m+1),
     &              ff(ip,n,m-1),ff(ip,n,m),ff(ip,n,m+1))
            end if
         end do
      end do

C--   Calculate the cross derivatives (d/dx)(d/dy).
      do m=1,my
         ff12(1,m)=polderiv1(xx(1),xx(2),xx(3),
     &        ff2(1,m),ff2(2,m),ff2(3,m))
         ff12(nx,m)=polderiv3(xx(nx-2),xx(nx-1),xx(nx),
     &        ff2(nx-2,m),ff2(nx-1,m),ff2(nx,m))
         do n=2,nx-1
            ff12(n,m)=polderiv2(xx(n-1),xx(n),xx(n+1),
     &           ff2(n-1,m),ff2(n,m),ff2(n+1,m))
         enddo
      enddo

C--   Calculate the cross derivatives (d/dy)(d/dx).
      do n=1,nx
         do m = 1, my
            if (m.eq.1.or.m.eq.myc0+1.or.m.eq.myb0+1) then
               ff21(n,m)=polderiv1(yy(m),yy(m+1),yy(m+2),
     &              ff1(n,m),ff1(n,m+1),ff1(n,m+2))
            else if (m.eq.my.or.m.eq.myc0.or.m.eq.myb0) then
               ff21(n,m)=polderiv3(yy(m-2),yy(m-1),yy(m),
     &              ff1(n,m-2),ff1(n,m-1),ff1(n,m))
            else
               ff21(n,m)=polderiv2(yy(m-1),yy(m),yy(m+1),
     &              ff1(n,m-1),ff1(n,m),ff1(n,m+1))
            end if
         end do
      end do

C--   Take the average of (d/dx)(d/dy) and (d/dy)(d/dx).
      do n=1,nx
         do m = 1, my
            ff12(n,m)=0.5*(ff12(n,m)+ff21(n,m))
         end do
      end do

      do n=1,nx-1
         do m=1,my-1
            d1=xx(n+1)-xx(n)
            d2=yy(m+1)-yy(m)
            d1d2=d1*d2
            
            yy0(1)=ff(ip,n,m)
            yy0(2)=ff(ip,n+1,m)
            yy0(3)=ff(ip,n+1,m+1)
            yy0(4)=ff(ip,n,m+1)
            
            yy1(1)=ff1(n,m)
            yy1(2)=ff1(n+1,m)
            yy1(3)=ff1(n+1,m+1)
            yy1(4)=ff1(n,m+1)
            
            yy2(1)=ff2(n,m)
            yy2(2)=ff2(n+1,m)
            yy2(3)=ff2(n+1,m+1)
            yy2(4)=ff2(n,m+1)
            
            yy12(1)=ff12(n,m)
            yy12(2)=ff12(n+1,m)
            yy12(3)=ff12(n+1,m+1)
            yy12(4)=ff12(n,m+1)
            
            do k=1,4
               z(k)=yy0(k)
               z(k+4)=yy1(k)*d1
               z(k+8)=yy2(k)*d2
               z(k+12)=yy12(k)*d1d2
            enddo
            
            do l=1,16
               xxd=0.d0
               do k=1,16
                  xxd=xxd+iwt(k,l)*z(k)
               enddo
               cl(l)=xxd
            enddo
            l=0
            do k=1,4
               do j=1,4
                  l=l+1
                  cc(ip,ih,n,m,k,j)=cl(l)
               enddo
            enddo
         enddo
      enddo
      return
      end

C----------------------------------------------------------------------

      double precision function InterpolatePDF(ip,np,ih,nhess,x,y,
     &     nx,my,xx,yy,cc)
      implicit none
      integer ih,nx,my,nhess,locx,l,m,n,ip,np
      double precision xx(nx),yy(my),cc(np,0:nhess,nx,my,4,4),
     &     x,y,z,t,u

      n=locx(xx,nx,x)
      m=locx(yy,my,y)
      
      t=(x-xx(n))/(xx(n+1)-xx(n))
      u=(y-yy(m))/(yy(m+1)-yy(m))
      
      z=0.d0
      do l=4,1,-1
         z=t*z+((cc(ip,ih,n,m,l,4)*u+cc(ip,ih,n,m,l,3))*u
     &        +cc(ip,ih,n,m,l,2))*u+cc(ip,ih,n,m,l,1)
      enddo

      InterpolatePDF = z

      return
      end

C----------------------------------------------------------------------

      double precision function ExtrapolatePDF(ip,np,ih,nhess,x,y,
     &     nx,my,xx,yy,cc)
      implicit none
      integer ih,nx,my,nhess,locx,n,m,ip,np
      double precision xx(nx),yy(my),cc(np,0:nhess,nx,my,4,4),
     &     x,y,z,f0,f1,z0,z1,InterpolatePDF
      
      n=locx(xx,nx,x)           ! 0: below xmin, nx: above xmax
      m=locx(yy,my,y)           ! 0: below qsqmin, my: above qsqmax
      
C--   If extrapolation in small x only:
      if (n.eq.0.and.m.gt.0.and.m.lt.my) then
         f0 = InterpolatePDF(ip,np,ih,nhess,xx(1),y,nx,my,xx,yy,cc)
         f1 = InterpolatePDF(ip,np,ih,nhess,xx(2),y,nx,my,xx,yy,cc)
         if (f0.gt.1.d-3.and.f1.gt.1.d-3) then
            z = exp(log(f0)+(log(f1)-log(f0))/(xx(2)-xx(1))*(x-xx(1)))
         else
            z = f0+(f1-f0)/(xx(2)-xx(1))*(x-xx(1))
         end if
C--   If extrapolation into large q only:
      else if (n.gt.0.and.m.eq.my) then
         f0 = InterpolatePDF(ip,np,ih,nhess,x,yy(my),nx,my,xx,yy,cc)
         f1 = InterpolatePDF(ip,np,ih,nhess,x,yy(my-1),nx,my,xx,yy,cc)
         if (f0.gt.1.d-3.and.f1.gt.1.d-3) then
            z = exp(log(f0)+(log(f0)-log(f1))/(yy(my)-yy(my-1))*
     &           (y-yy(my)))
         else
            z = f0+(f0-f1)/(yy(my)-yy(my-1))*(y-yy(my))
         end if
C--   If extrapolation into large q AND small x:
      else if (n.eq.0.and.m.eq.my) then
         f0 = InterpolatePDF(ip,np,ih,nhess,xx(1),yy(my),nx,my,xx,yy,cc)
         f1 = InterpolatePDF(ip,np,ih,nhess,xx(1),yy(my-1),nx,my,xx,yy,
     &        cc)
         if (f0.gt.1.d-3.and.f1.gt.1.d-3) then
            z0 = exp(log(f0)+(log(f0)-log(f1))/(yy(my)-yy(my-1))*
     &           (y-yy(my)))
         else
            z0 = f0+(f0-f1)/(yy(my)-yy(my-1))*(y-yy(my))
         end if
         f0 = InterpolatePDF(ip,np,ih,nhess,xx(2),yy(my),nx,my,xx,yy,cc)
         f1 = InterpolatePDF(ip,np,ih,nhess,xx(2),yy(my-1),nx,my,xx,yy,
     &        cc)
         if (f0.gt.1.d-3.and.f1.gt.1.d-3) then
            z1 = exp(log(f0)+(log(f0)-log(f1))/(yy(my)-yy(my-1))*
     &           (y-yy(my)))
         else
            z1 = f0+(f0-f1)/(yy(my)-yy(my-1))*(y-yy(my))
         end if
         if (z0.gt.1.d-3.and.z1.gt.1.d-3) then
            z = exp(log(z0)+(log(z1)-log(z0))/(xx(2)-xx(1))*(x-xx(1)))
         else
            z = z0+(z1-z0)/(xx(2)-xx(1))*(x-xx(1))
         end if
      else
         print *,"Error in ExtrapolatePDF"
         stop
      end if

      ExtrapolatePDF = z      

      return
      end

C----------------------------------------------------------------------

      integer function locx(xx,nx,x)
C--   returns an integer j such that x lies inbetween xx(j) and xx(j+1).
C--   nx is the length of the array with xx(nx) the highest element.
      implicit none
      integer nx,jl,ju,jm
      double precision x,xx(nx)
      if(x.eq.xx(1)) then
         locx=1
         return
      endif
      if(x.eq.xx(nx)) then
         locx=nx-1  
         return
      endif
      ju=nx+1
      jl=0
    1 if((ju-jl).le.1) go to 2
      jm=(ju+jl)/2
      if(x.ge.xx(jm)) then
         jl=jm
      else
         ju=jm
      endif
      go to 1
    2 locx=jl
      return
      end

C----------------------------------------------------------------------

      double precision function polderiv1(x1,x2,x3,y1,y2,y3)
C--   returns the estimate of the derivative at x1 obtained by a
C--   polynomial interpolation using the three points (x_i,y_i).
      implicit none
      double precision x1,x2,x3,y1,y2,y3
      polderiv1=(x3*x3*(y1-y2)+2.d0*x1*(x3*(-y1+y2)+x2*(y1-y3))
     &     +x2*x2*(-y1+y3)+x1*x1*(-y2+y3))/((x1-x2)*(x1-x3)*(x2-x3))
      return
      end

      double precision function polderiv2(x1,x2,x3,y1,y2,y3)
C--   returns the estimate of the derivative at x2 obtained by a
C--   polynomial interpolation using the three points (x_i,y_i).
      implicit none
      double precision x1,x2,x3,y1,y2,y3
      polderiv2=(x3*x3*(y1-y2)-2.d0*x2*(x3*(y1-y2)+x1*(y2-y3))
     &     +x2*x2*(y1-y3)+x1*x1*(y2-y3))/((x1-x2)*(x1-x3)*(x2-x3))
      return
      end

      double precision function polderiv3(x1,x2,x3,y1,y2,y3)
C--   returns the estimate of the derivative at x3 obtained by a
C--   polynomial interpolation using the three points (x_i,y_i).
      implicit none
      double precision x1,x2,x3,y1,y2,y3
      polderiv3=(x3*x3*(-y1+y2)+2.d0*x2*x3*(y1-y3)+x1*x1*(y2-y3)
     &     +x2*x2*(-y1+y3)+2.d0*x1*x3*(-y2+y3))/
     &     ((x1-x2)*(x1-x3)*(x2-x3))
      return
      end

C----------------------------------------------------------------------

C--   G.W. 05/07/2010 Avoid using Fortran 90 intrinsic function
C--   "len_trim" since not supported by all Fortran 77 compilers.
      integer function lentrim(s)
      implicit none
      character*(*) s
      do lentrim = len(s), 1, -1
         if (s(lentrim:lentrim) .ne. ' ') return
      end do
      return
      end
C
C----------------------------------------------------------------------
C----------------------------------------------------------------------
C----------------------------------------------------------------------
C
C Misak Sargsian's code

c      program nestfun
      subroutine nestfun(x,q2,ein,asm_vn,asm_lc)
      common/par/pi,pm,dm
      double precision x,q2,ein,asm_vn,asm_lc
      real ei

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
        ini = 1  ! (1)- initialization,
        xx  = sigma_in(ei,er,uet,ilc,it,ib,imc,ipol,ini)
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
cpat        ei  = 11.0   ! initial electron energy
         ei = ein
*        uet = 10.0 
*        ue = uet*pi/180.0
cpat        q2 = 5.0

        
*        x  = .001
        write(11,*)"x,w,asm_vn,asm_lc"
cpat        do ix = 0,32
cpat        x = 0.1+float(ix)*0.05
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
cpat        enddo
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







