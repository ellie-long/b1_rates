// Class header file.
// Original C++ version by J.Andersen.
// Minor changes made by G.Watt.
//
// Usage:
// Initialising the class:
//   c_pdf pdf("filename.dat")
// with "filename.dat" being the data file to interpolate.
//
// A call to the method 
//   c_pdf::update(x,q)
// updates the parton content to the values at (x,q^2).
// The parton contents can then be accessed in
//   c_pdf::cont.upv etc.
// This method is faster, if all the partons need to be evaluated.
//
// A call to the method 
//   c_pdf::parton(f,x,q)
// will return the value of the PDF with flavour 'f' at (x,q^2).
// Notation: 1=upv 2=dnv 3=glu 4=usea 5=chm 6=str 7=bot 8=dsea 9=sbar.
// This method is fastest, if only one parton needs to be evaluated.

#ifndef _PDF_H_INCLUDED_
#define _PDF_H_INCLUDED_
#include <stdio.h>
#include <iostream>
#include <fstream>
#include <stdlib.h>
#include <string>
#include <math.h>

static const int np=9;    // number of parton flavours
static const int nx=64;   // number of x grid points
static const int nq=48;   // number of q^2 grid points
static const int nqc0=4;  // number of q^2 bins below charm threshold
static const int nqb0=14; // number of q^2 bins below bottom threshold
static const double xmin=1e-6;  // minimum x grid point
static const double xmax=1.0;   // maximum x grid point
static const double qsqmin=1.0; // minimum q^2 grid point
static const double qsqmax=1e9; // maximum q^2 grid point
static const double mc2=pow(1.43,2); // charm mass squared
static const double mb2=pow(4.30,2); // bottom mass squared
static const double eps=1e-6; // q^2 grid points at mc2-eps, mb2-eps
using namespace std;

enum { UPV=1,DNV=2,GLU=3,USEA=4,CHM=5,STR=6,BOT=7,DSEA=8,SBAR=9 };

struct s_partoncontent {
  double upv,dnv,usea,dsea,str,sbar,chm,bot,glu;
};

class c_pdf {
 private:
  static double xx[nx+1]; // grid points in x
  static double qq[nq+1]; // grid points in q^2
  double c[np+1][nx][nq][5][5]; // coefficients used for interpolation
  void update_interpolate(double x,double q); // update cont
  double parton_interpolate(int flavour,double x,double q);
  bool warn;
  bool fatal;
 public:
  struct s_partoncontent cont;
  void update(double x,double q);
  double parton(int flavour,double x,double q);
  // The constructor (initialises the functions):
  c_pdf(string filename,bool warn=true,bool fatal=true);
};
#endif
