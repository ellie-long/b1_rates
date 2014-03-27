      PROGRAM main
         REAL*8 e_in,pit,thit,x
         REAL*8 a,z
         REAL*8 cross_section
         e_in = 6.6
         pit = 6.07
         thit = 9.51
         a = 14.0
         z = 7.0
         x = 1.0
         call init_incl(e_in,pit,thit,x,a,z,cross_section)
         write(6,*) "Cross Section:",cross_section
      END

