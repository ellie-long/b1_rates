FC=g77
CC=g++
CXX=g++
FFLAGS=
CCFLAGS=
EXEC=example example_cpp

all: $(EXEC)

#####################################
# Fortran version:

example : example.o pdf.o
	$(FC) $^ -o $@

example.o : example.f
	$(FC) -c $(FFLAGS) $< -o $@

pdf.o : pdf.f
	$(FC) -c $(FFLAGS) $< -o $@

#####################################
# C++ version:

example_cpp : example_cpp.o pdf_cpp.o
	$(CC) $^ -o $@

example_cpp.o : example.C pdf.h
	$(CC) -c $(CCFLAGS) $< -o $@

pdf_cpp.o : pdf.C pdf.h
	$(CC) -c $(CCFLAGS) $< -o $@

#####################################

clean :
	-rm -f *.o $(EXEC)
