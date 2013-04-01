
default: libqcdnum16.a

FFLAGS= -32 -O2 -mips2 -static -Olimit 3500 -align32 

libqcdnum16.a: ../car/qcdnum16.car 
	runpatchy ;
	fsplit qcdnum16.f ;
	rm qcdnum16.f ;
	f77 -c $(FFLAGS) *.f ;
	ar crv libqcdnum16.a *.o ;
	\rm *.f ;
	\rm *.o ;
