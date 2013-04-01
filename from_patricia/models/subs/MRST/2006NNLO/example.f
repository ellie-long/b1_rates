C----------------------------------------------------------------------
C--   G.Watt 21/05/2007.                                             --
C--   Program to demonstrate usage of the MRST 2006 NNLO PDFs.       --
C----------------------------------------------------------------------
      PROGRAM example

      IMPLICIT NONE
      INTEGER iset,ieigen,neigen,ix,nx,iq,nq
      PARAMETER(neigen=15)      ! number of eigenvectors
      DOUBLE PRECISION x,q,upv,dnv,usea,dsea,str,sbar,chm,bot,glu,
     &     upv1,dnv1,usea1,dsea1,str1,sbar1,chm1,bot1,glu1,
     &     GetOnePDF,xpdf(-6:6),glup,glum,xmin,xmax,q2min,q2max,
     &     summin,summax,sum
      CHARACTER prefix*50

      prefix = "Grids/mrst2006nnlo" ! prefix for the grid files
C--   N.B. This fit has m_c = 1.43 GeV, m_b = 4.30 GeV,
C--   and Lambda_{QCD} = 0.2808 GeV => alpha_S(M_Z) = 0.1191.

C--   There are three different interfaces to access the PDFs.
C--   Consider only the central PDF set to start with.
      iset = 0

C--   Specify the momentum fraction "x" and scale "q".
      x = 1.d-3
      q = 1.d1
      WRITE(6,*) "x = ",x,", q = ",q

C--   First the traditional MRST-like interface (but note the "sbar").
      CALL GetAllPDFs(prefix,iset,x,q,upv,dnv,usea,dsea,str,sbar,
     &        chm,bot,glu)

C--   Alternatively, an LHAPDF-like interface where the PDFs
C--   are returned in an array xpdf(-6:6).  Indices given by PDG
C--   convention:  -6,  -5,  -4,  -3,  -2,  -1,0,1,2,3,4,5,6
C--            = tbar,bbar,cbar,sbar,ubar,dbar,g,d,u,s,c,b,t.
      CALL GetAllPDFsAlt(prefix,iset,x,q,xpdf)

C--   Finally, if only a single parton flavour is required.
C--   Notation:1=upv 2=dnv 3=glu 4=usea 5=chm 6=str 7=bot 8=dsea 9=sbar
      upv1 = GetOnePDF(prefix,iset,x,q,1)
      dnv1 = GetOnePDF(prefix,iset,x,q,2)
      usea1 = GetOnePDF(prefix,iset,x,q,4)
      dsea1 = GetOnePDF(prefix,iset,x,q,8)
      str1 = GetOnePDF(prefix,iset,x,q,6)
      sbar1 = GetOnePDF(prefix,iset,x,q,9)
      chm1 = GetOnePDF(prefix,iset,x,q,5)
      bot1 = GetOnePDF(prefix,iset,x,q,7)      
      glu1 = GetOnePDF(prefix,iset,x,q,3)

C--   Demonstrate the equivalence of the above three methods.
      WRITE(6,*) "upv = ",upv," = ",upv1," = ",xpdf(2)-xpdf(-2)
      WRITE(6,*) "dnv = ",dnv," = ",dnv1," = ",xpdf(1)-xpdf(-1)
      WRITE(6,*) "usea = ",usea," = ",usea1," = ",xpdf(-2)
      WRITE(6,*) "dsea = ",dsea," = ",dsea1," = ",xpdf(-1)
      WRITE(6,*) "str = ",str," = ",str1," = ",xpdf(3)
      WRITE(6,*) "sbar = ",sbar," = ",sbar1," = ",xpdf(-3)
      WRITE(6,*) "chm = ",chm," = ",chm1," = ",xpdf(4)
      WRITE(6,*) "bot = ",bot," = ",bot1," = ",xpdf(5)
      WRITE(6,*) "glu = ",glu," = ",glu1," = ",xpdf(0)

C----------------------------------------------------------------------

C--   Now demonstrate use of the eigenvector PDF sets.
C--   Calculate the uncertainty on the gluon distribution using both
C--   the formula for asymmetric errors [eq.(13) of EPJC28 (2003) 455]
C--   and the formula for symmetric errors [eq.(9) of same paper].

C--   First get xg as a function of x at a fixed value of q.
      q = 1.d1
      nx = 100
      xmin = 1.d-4
      xmax = 1.d0
      OPEN(UNIT=66,FILE="xg_vs_x.dat")
      WRITE(66,'(" # q = ",1P5E12.4)') q
      WRITE(66,'(A2,A10,4A12)') " #","x","xg","error+","error-","error"
      DO ix = 1, nx
         x = 10.d0**(log10(xmin) + (ix-1.D0)/(nx-1.D0)*
     &        (log10(xmax)-log10(xmin)))
         glu = GetOnePDF(prefix,iset,x,q,3) ! central set
         summax = 0.d0
         summin = 0.d0
         sum = 0.d0
         DO ieigen = 1, neigen  ! loop over eigenvector sets
            glup = GetOnePDF(prefix,2*ieigen-1,x,q,3)
            glum = GetOnePDF(prefix,2*ieigen,x,q,3)
            summax = summax + (max(glup-glu,glum-glu,0.d0))**2
            summin = summin + (max(glu-glup,glu-glum,0.d0))**2
            sum = sum+(glup-glum)**2
         END DO
         WRITE(66,'(1P5E12.4)') x,glu,
     &        sqrt(summax),sqrt(summin),0.5d0*sqrt(sum)
      END DO
      CLOSE(UNIT=66)
      WRITE(6,*) "xg vs. x for q2 = ",q**2," written to xg_vs_x.dat"

C--   Now get xg as a function of q^2 at a fixed value of x.
      x = 1.d-3
      nq = 100
      q2min = 1.d0
      q2max = 1.d9
      OPEN(UNIT=66,FILE="xg_vs_q2.dat")
      WRITE(66,'(" # x = ",1P5E12.4)') x
      WRITE(66,'(A2,A10,4A12)') " #","q2","xg","error+","error-","error"
      DO iq = 1, nq
         q = sqrt(10.d0**(log10(q2min) + (iq-1.D0)/(nq-1.D0)*
     &        (log10(q2max)-log10(q2min))))
         glu = GetOnePDF(prefix,iset,x,q,3) ! central set
         summax = 0.d0
         summin = 0.d0
         sum = 0.d0
         DO ieigen = 1, neigen  ! loop over eigenvector sets
            glup = GetOnePDF(prefix,2*ieigen-1,x,q,3) ! "+" direction
            glum = GetOnePDF(prefix,2*ieigen,x,q,3)   ! "-" direction
            summax = summax + (max(glup-glu,glum-glu,0.d0))**2
            summin = summin + (max(glu-glup,glu-glum,0.d0))**2
            sum = sum+(glup-glum)**2
         END DO
         WRITE(66,'(1P5E12.4)') q**2,glu,
     &        sqrt(summax),sqrt(summin),0.5d0*sqrt(sum)
      END DO
      CLOSE(UNIT=66)
      WRITE(6,*) "xg vs. q2 for x = ",x," written to xg_vs_q2.dat"

      STOP
      END
C----------------------------------------------------------------------
