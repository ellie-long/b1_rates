C----------------------------------------------------------------------
C--   Example program to demonstrate usage of the MSTW 2008 PDFs.    --
C--   Comments to Graeme Watt <Graeme.Watt(at)cern.ch>.              --
C----------------------------------------------------------------------
      PROGRAM example

      IMPLICIT NONE
      INTEGER iset,ieigen,neigen,ix,nx,iq,nq,flav,
     &     alphaSorder,alphaSnfmax,lentrim
      PARAMETER(neigen=20)      ! number of eigenvectors
      DOUBLE PRECISION x,q,upv,dnv,usea,dsea,str,sbar,
     &     chm,cbar,bot,bbar,glu,phot,upv1,dnv1,usea1,dsea1,str1,sbar1,
     &     chm1,cbar1,bot1,bbar1,glu1,phot1,xphoton,
     &     GetOnePDF,xpdf(-6:6),xf,xfp,xfm,xmin,xmax,q2min,q2max,
     &     summin,summax,sum,distance,tolerance,
     &     mCharm,mBottom,alphaSQ0,alphaSMZ,ALPHAS
      CHARACTER prefix*50,prefix1*55,flavours(-5:5)*10,
     &     xfilename*50,qfilename*50
      COMMON/mstwCommon/distance,tolerance,
     &     mCharm,mBottom,alphaSQ0,alphaSMZ,alphaSorder,alphaSnfmax
      DATA flavours /"bbar","cbar","sbar","ubar","dbar","glu",
     &     "dn","up","str","chm","bot"/

      prefix = "Grids/mstw2008nnlo" ! prefix for the grid files

C--   There are three different interfaces to access the PDFs.
C--   Consider only the central PDF set to start with.
      iset = 0

C--   Specify the momentum fraction "x" and scale "q".
      x = 1.d-3
      q = 1.d1
      WRITE(6,*) "x = ",x,", q = ",q

C--   First the traditional MRST-like interface
C--   (but note the "sbar", "cbar", "bbar" and "phot").
      CALL GetAllPDFs(prefix,iset,x,q,upv,dnv,usea,dsea,str,sbar,
     &        chm,cbar,bot,bbar,glu,phot)

C--   Alternatively, an LHAPDF-like interface where the PDFs
C--   are returned in an array xpdf(-6:6).  Indices given by PDG
C--   convention (apart from the gluon is 0, not 21):
C--                -6,  -5,  -4,  -3,  -2,  -1,0,1,2,3,4,5,6
C--            = tbar,bbar,cbar,sbar,ubar,dbar,g,d,u,s,c,b,t.
      CALL GetAllPDFsAlt(prefix,iset,x,q,xpdf,xphoton)

C--   Alternatively, get each parton flavour separately.
C--   Flavour number again given by PDG convention (apart from gluon).
C--    f =   -6,  -5,  -4,  -3,  -2,  -1,0,1,2,3,4,5,6
C--      = tbar,bbar,cbar,sbar,ubar,dbar,g,d,u,s,c,b,t.
C--   Can also get valence quarks directly:
C--    f =  7, 8, 9,10,11,12.
C--      = dv,uv,sv,cv,bv,tv.
C--   Photon: f = 13.
C--   Warning: this numbering scheme is different from that used
C--   in the MRST2006 NNLO code!
C--   (The photon distribution is zero unless considering QED
C--   contributions: implemented here for future compatibility.)
      upv1 = GetOnePDF(prefix,iset,x,q,8)
      dnv1 = GetOnePDF(prefix,iset,x,q,7)
      usea1 = GetOnePDF(prefix,iset,x,q,-2)
      dsea1 = GetOnePDF(prefix,iset,x,q,-1)
      str1 = GetOnePDF(prefix,iset,x,q,3)
      sbar1 = GetOnePDF(prefix,iset,x,q,-3)
      chm1 = GetOnePDF(prefix,iset,x,q,4)
      cbar1 = GetOnePDF(prefix,iset,x,q,-4)
      bot1 = GetOnePDF(prefix,iset,x,q,5)
      bbar1 = GetOnePDF(prefix,iset,x,q,-5)
      glu1 = GetOnePDF(prefix,iset,x,q,0)
      phot1 = GetOnePDF(prefix,iset,x,q,13)

C--   Demonstrate the equivalence of the above three methods.
      WRITE(6,*) "upv = ",upv," = ",upv1," = ",xpdf(2)-xpdf(-2)
      WRITE(6,*) "dnv = ",dnv," = ",dnv1," = ",xpdf(1)-xpdf(-1)
      WRITE(6,*) "usea = ",usea," = ",usea1," = ",xpdf(-2)
      WRITE(6,*) "dsea = ",dsea," = ",dsea1," = ",xpdf(-1)
      WRITE(6,*) "str = ",str," = ",str1," = ",xpdf(3)
      WRITE(6,*) "sbar = ",sbar," = ",sbar1," = ",xpdf(-3)
      WRITE(6,*) "chm = ",chm," = ",chm1," = ",xpdf(4)
      WRITE(6,*) "cbar = ",cbar," = ",cbar1," = ",xpdf(-4)
      WRITE(6,*) "bot = ",bot," = ",bot1," = ",xpdf(5)
      WRITE(6,*) "bbar = ",bbar," = ",bbar1," = ",xpdf(-5)
      WRITE(6,*) "glu = ",glu," = ",glu1," = ",xpdf(0)
      WRITE(6,*) "phot = ",phot," = ",phot1," = ",xphoton

C----------------------------------------------------------------------

C--   Heavy quark masses and alphaS values
C--   are stored in a COMMON block.
      WRITE(6,*) "mCharm = ",mCharm,", mBottom = ",mBottom
      WRITE(6,*) "alphaS(Q0) = ",alphaSQ0,", alphaS(MZ) = ",
     &     alphaSMZ,", alphaSorder = ",alphaSorder,
     &     ", alphaSnfmax = ",alphaSnfmax

C--   Call the initialisation routine with alpha_S(Q_0).
      CALL INITALPHAS(alphaSorder,1.D0,1.D0,alphaSQ0,
     &     mCharm,mBottom,1.D10)
C--   Check calculated value of alpha_S(M_Z) matches stored value.
      WRITE(6,'(" alphaS(MZ) = ",F7.5," = ",F7.5)')
     &     ALPHAS(91.1876D0),alphaSMZ

C--   Alternatively, call the initialisation routine with alpha_S(M_Z).
      CALL INITALPHAS(alphaSorder,1.D0,91.1876D0,alphaSMZ,
     &     mCharm,mBottom,1.D10)
C--   Check calculated value of alpha_S(Q_0) matches stored value.
      WRITE(6,'(" alphaS(Q0) = ",F7.5," = ",F7.5)')
     &     ALPHAS(1.D0),alphaSQ0

C----------------------------------------------------------------------

C--   Now demonstrate use of the eigenvector PDF sets.

C--   Get the central value of the gluon distribution.
      WRITE(6,*) "central fit:"
      glu = GetOnePDF(prefix,0,x,q,0) ! central value
      WRITE(6,*) "  distance,tolerance,glu = ",distance,tolerance,glu
C--   Now get the value of the gluon distribution at a distance t from
C--   the global minimum along the first eigenvector direction in the
C--   '+' direction.  The distance t is chosen to give a tolerance 
C--   T = sqrt(Delta(chi^2_{global})) ensuring all data sets are
C--   described within their 90% confidence level (C.L.) limits.
C--   Under ideal quadratic behaviour, t = T.  The distance
C--   and tolerance are stored in a COMMON block and are updated
C--   whenever a new grid file is read in.
      WRITE(6,*) "eigenvector +1, 90% C.L.:"
      prefix1 = prefix(1:lentrim(prefix))//'.90cl'
      glu = GetOnePDF(prefix1,1,x,q,0) ! first eigenvector
      WRITE(6,*) "  distance,tolerance,glu = ",distance,tolerance,glu
C--   Now the same thing, but with the tolerance chosen to ensure
C--   that all data sets are described only within their
C--   one-sigma (68%) C.L. limits.
      WRITE(6,*) "eigenvector +1, 68% C.L.:"
      prefix1 = prefix(1:lentrim(prefix))//'.68cl'
      glu = GetOnePDF(prefix1,1,x,q,0) ! first eigenvector
      WRITE(6,*) "  distance,tolerance,glu = ",distance,tolerance,glu

C----------------------------------------------------------------------

C--   Calculate the uncertainty on the parton distributions using both
C--   the formula for asymmetric errors [eqs.(51,52) of arXiv:0901.0002]
C--   and the formula for symmetric errors [eq.(50) of same paper].

C--   Choose either the 90% C.L. error sets or the 68% C.L. error sets
      prefix1 = prefix(1:lentrim(prefix))//'.90cl' ! 90% C.L. errors
C      prefix1 = prefix(1:lentrim(prefix))//'.68cl' ! 68% C.L. errors

C--   First get xf as a function of x at a fixed value of q.
C--   Extrapolation will be used for x < 10^-6.
      q = 1.d1
      nx = 100
      xmin = 1.d-7
      xmax = 0.99d0
      DO flav = -5, 5
         xfilename = "x"//flavours(flav)(1:lentrim(flavours(flav)))
     &        //"_vs_x.dat"
         OPEN(UNIT=10,FILE=xfilename)
         WRITE(10,'(" # q = ",1PE12.4)') q
         WRITE(10,'(A2,A10,4A12)')
     &        " #","x","x"//
     &        flavours(flav)(1:lentrim(flavours(flav))),
     &        "error+","error-","error"
         DO ix = 1, nx
            x = 10.d0**(log10(xmin) + (ix-1.D0)/(nx-1.D0)*
     &           (log10(xmax)-log10(xmin)))
            xf = GetOnePDF(prefix,iset,x,q,flav) ! central set
            summax = 0.d0
            summin = 0.d0
            sum = 0.d0
            DO ieigen = 1, neigen ! loop over eigenvector sets
               xfp = GetOnePDF(prefix1,2*ieigen-1,x,q,flav) ! "+"
               xfm = GetOnePDF(prefix1,2*ieigen,x,q,flav) ! "-"
               summax = summax + (max(xfp-xf,xfm-xf,0.d0))**2
               summin = summin + (max(xf-xfp,xf-xfm,0.d0))**2
               sum = sum+(xfp-xfm)**2
            END DO
            WRITE(10,'(1P5E12.4)') x,xf,
     &           sqrt(summax),sqrt(summin),0.5d0*sqrt(sum)
         END DO
         CLOSE(UNIT=10)
         WRITE(6,*) "x"//
     &        flavours(flav)(1:lentrim(flavours(flav))),
     &        " vs. x for q2 = ",q**2," written to ",
     &        xfilename(1:lentrim(xfilename))
      END DO

C--   Now get xf as a function of q^2 at a fixed value of x.
C--   Extrapolation will be used for q^2 < 1 GeV^2 and for q^2 > 10^9 GeV^2.
      x = 1.d-3
      nq = 100
      q2min = 5.d-1
      q2max = 1.d10
      DO flav = -5, 5
         qfilename = "x"//flavours(flav)(1:lentrim(flavours(flav)))
     &        //"_vs_q2.dat"
         OPEN(UNIT=10,FILE=qfilename)
         WRITE(10,'(" # x = ",1PE12.4)') x
         WRITE(10,'(A2,A10,4A12)')
     &        " #","q2","x"//
     &        flavours(flav)(1:lentrim(flavours(flav))),
     &        "error+","error-","error"
         DO iq = 1, nq
            q = sqrt(10.d0**(log10(q2min) + (iq-1.D0)/(nq-1.D0)*
     &           (log10(q2max)-log10(q2min))))
            xf = GetOnePDF(prefix,iset,x,q,flav) ! central set
            summax = 0.d0
            summin = 0.d0
            sum = 0.d0
            DO ieigen = 1, neigen ! loop over eigenvector sets
               xfp = GetOnePDF(prefix1,2*ieigen-1,x,q,flav) ! "+"
               xfm = GetOnePDF(prefix1,2*ieigen,x,q,flav) ! "-"
               summax = summax + (max(xfp-xf,xfm-xf,0.d0))**2
               summin = summin + (max(xf-xfp,xf-xfm,0.d0))**2
               sum = sum+(xfp-xfm)**2
            END DO
            WRITE(10,'(1P5E12.4)') q**2,xf,
     &           sqrt(summax),sqrt(summin),0.5d0*sqrt(sum)
         END DO
         CLOSE(UNIT=10)
         WRITE(6,*) "x"//
     &        flavours(flav)(1:lentrim(flavours(flav))),
     &        " vs. q2 for x = ",x," written to ",
     &        qfilename(1:lentrim(qfilename))
      END DO

      STOP
      END
C----------------------------------------------------------------------
