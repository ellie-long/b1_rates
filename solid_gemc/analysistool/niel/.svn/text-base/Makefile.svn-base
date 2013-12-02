FC=gfortran
CC=g++
CXX=g++
FFLAGS=
CCFLAGS=-fPIC -g -Wall `root-config --cflags`
SHARED=niel_fun_lib.so
LDFLAGS=`root-config --glibs`


all: $(SHARED)



niel_fun_Dict.cxx: niel_fun.h niel_fun_Linkdef.h
	rootcint -f $@ -c $(CCFLAGS) -p $^
 
niel_fun_lib.so: niel_fun_Dict.cxx niel_fun.cc
	g++ -shared $(LDFLAGS) -o $@  $(CCFLAGS) -I`root-config --incdir` $^

#####################################

clean :
	-rm -f niel_fun_Dict.*  $(SHARED)
