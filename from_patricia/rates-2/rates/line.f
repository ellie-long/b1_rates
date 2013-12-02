      PROGRAM LINE
c----------
c     generate x and Q2 values for W values at
c         - the DIS lower limit: W = 2GeV
c         - the delta peak: W = M_delta = 1.232 GeV
c         - the pion threshold: W = Mp + Mpi
c     pion threshold, 
c     and at y=0.85 and y=0.1 in order to display 
c     these  lines on the kinematics coverage plot
c
c--   Patricia Solvignon, Nov. 28, 2010
c  
      REAL*8 mp,mdelta,mpi
      PARAMETER( mp       = 0.98272    )
      PARAMETER( mdelta   = 1.232      )
      PARAMETER( mpi      = 0.1396     )

      REAL*8 e_in
      REAL*8 xx,w2,y
      REAL*8 qq1,qq2,qq3,qq4,qq5,qq6

      INTEGER nx
      PARAMETER (nx  = 989)

c---- OUTPUT FILE ------------------------------------------

      OPEN(UNIT=8, FILE='output/lines.out',  STATUS='UNKNOWN')

c---- INPUT ------------------------------------------------

      e_in    = 11.0          ! incident energy in GeV

c----- MAIN ------------------------------------------------

      ix=0
      do ix = 1,nx ! number of x
         xx    = 0.01 + ix*0.001

         ! y = nu/E = 0.85 line
         y     = 0.85 
         qq1   = 2.*mp*xx*e_in*y

         ! y = nu/E = 0.1 line
         y     = 0.1 
         qq2   = 2.*mp*xx*e_in*y

         ! W = 2 GeV line
         w2    = 4.0
         qq3   = (w2 - mp**2)/((1./xx) - 1)

         ! W = delta line
         w2    = mdelta**2
         qq4   = (w2 - mp**2)/((1./xx) - 1)

         ! W = pion threshold
         w2    = (mp + mpi)**2
         qq5   = (w2 - mp**2)/((1./xx) - 1)

         ! W = 1.8 GeV
         w2    = 1.8**2
         qq6   = (w2 - mp**2)/((1./xx) - 1)



         write(8,1002)xx, qq1, qq2, qq3, qq4, qq5, qq6
      enddo

C =========================== Format Statements ================================

 1002 format(3(F7.3,1x),4(F10.3,1x))
      end
