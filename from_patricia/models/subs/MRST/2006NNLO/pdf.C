// Class implementation file.
// Original C++ version by J.Andersen.
// Minor changes made by G.Watt.
//
// Update (14/08/2007): The first version of this file didn't account
// for the discontinuities in the charm and bottom distributions at
// threshold when calculating the Q^2 derivatives used for interpolation.
// This led to incorrect results for charm in the ranges from 2.045-2.5 GeV^2
// and 12-26 GeV^2 and bottom in the range 18.49-26 GeV^2.  This problem
// has now been fixed.
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
// This method is fastest, if only one parton needs evaluated.

#include "pdf.h"

int locate(double xx[],int n,double x)
  // returns an integer j such that x lies inbetween xx[j] and xx[j+1].
  // unit offset of increasing ordered array xx assumed.
  // n is the length of the array (xx[n] highest element).
{
  int ju,jm,jl(0),j;
  ju=n+1;
  
  while (ju-jl>1) {
    jm=(ju+jl)/2; // compute a mid point.
    if ( x>= xx[jm])
      jl=jm;
    else ju=jm;
  }
  if (x==xx[1]) j=1;
  else if (x==xx[n]) j=n-1;
  else j=jl;
  
  return j;
}


double polderivative(double x1,double x2,double x3,double y1,double y2,double y3)
  // returns the estimate of the derivative at x2 obtained by a polynomial 
  // interpolation using the three points (x_i,y_i).
{
  return (x3*x3*(y1-y2)-2.0*x2*(x3*(y1-y2)+x1*(y2-y3))+x2*x2*(y1-y3)+x1*x1*(y2-y3))/((x1-x2)*(x1-x3)*(x2-x3));
}

double c_pdf::xx[nx+1];

double c_pdf::qq[nq+1];

c_pdf::c_pdf(string filename,bool warn_in,bool fatal_in)
  // The constructor: this will initialise the functions automatically.
{
  ifstream data_file;
  
  int i,n,m,k,l,j; // counters
  double dx,dq,dtemp;
  
  // Variables used for initialising c_ij array:
  double f[np+1][nx+1][nq+1];
  double f1[np+1][nx+1][nq+1]; // derivative wrt.x
  double f2[np+1][nx+1][nq+1]; // derivative wrt.qq
  double f12[np+1][nx+1][nq+1];// cross derivative

  int wt[16][16]={{1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
		  {0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0},
		  {-3,0,0,3,0,0,0,0,-2,0,0,-1,0,0,0,0},
		  {2,0,0,-2,0,0,0,0,1,0,0,1,0,0,0,0},
		  {0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
		  {0,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0},
		  {0,0,0,0,-3,0,0,3,0,0,0,0,-2,0,0,-1},
		  {0,0,0,0,2,0,0,-2,0,0,0,0,1,0,0,1},
		  {-3,3,0,0,-2,-1,0,0,0,0,0,0,0,0,0,0},
		  {0,0,0,0,0,0,0,0,-3,3,0,0,-2,-1,0,0},
		  {9,-9,9,-9,6,3,-3,-6,6,-6,-3,3,4,2,1,2},
		  {-6,6,-6,6,-4,-2,2,4,-3,3,3,-3,-2,-1,-1,-2},
		  {2,-2,0,0,1,1,0,0,0,0,0,0,0,0,0,0},
		  {0,0,0,0,0,0,0,0,2,-2,0,0,1,1,0,0},
		  {-6,6,-6,6,-3,-3,3,3,-4,4,2,-2,-2,-2,-1,-1},
		  {4,-4,4,-4,2,2,-2,-2,2,-2,-2,2,1,1,1,1}};
  double xxd,d1d2,cl[16],x[16],d1,d2,y[5],y1[5],y2[5],y12[5];
  //////////

  warn = warn_in;   // option to turn off warning if extrapolating
  fatal = fatal_in; // option to return 0 instead of terminating if invalid x or q

  // Initialising the x array common to all members of the class.
  // Unfortunately, ANSI-C++ does not allow a initialisation of a 
  // member array.  So here we go...

  xx[0]=0;
  xx[1]=1E-6;
  xx[2]=2E-6;
  xx[3]=4E-6;
  xx[4]=6E-6;
  xx[5]=8E-6;
  xx[6]=1E-5;
  xx[7]=2E-5;
  xx[8]=4E-5;
  xx[9]=6E-5;
  xx[10]=8E-5;
  xx[11]=1E-4;
  xx[12]=2E-4;
  xx[13]=4E-4;
  xx[14]=6E-4;
  xx[15]=8E-4;
  xx[16]=1E-3;
  xx[17]=2E-3;
  xx[18]=4E-3;
  xx[19]=6E-3;
  xx[20]=8E-3;
  xx[21]=1E-2;
  xx[22]=1.4E-2;
  xx[23]=2E-2;
  xx[24]=3E-2;
  xx[25]=4E-2;
  xx[26]=6E-2;
  xx[27]=8E-2;
  xx[28]=.1E0;
  xx[29]=.125E0;
  xx[30]=.15E0;
  xx[31]=.175E0;
  xx[32]=.2E0;
  xx[33]=.225E0;
  xx[34]=.25E0;
  xx[35]=.275E0;
  xx[36]=.3E0;
  xx[37]=.325E0;
  xx[38]=.35E0;
  xx[39]=.375E0;
  xx[40]=.4E0;
  xx[41]=.425E0;
  xx[42]=.45E0;
  xx[43]=.475E0;
  xx[44]=.5E0;
  xx[45]=.525E0;
  xx[46]=.55E0;
  xx[47]=.575E0;
  xx[48]=.6E0;
  xx[49]=.625E0;
  xx[50]=.65E0;
  xx[51]=.675E0;
  xx[52]=.7E0;
  xx[53]=.725E0;
  xx[54]=.75E0;
  xx[55]=.775E0;
  xx[56]=.8E0;
  xx[57]=.825E0;
  xx[58]=.85E0;
  xx[59]=.875E0;
  xx[60]=.9E0;
  xx[61]=.925E0;
  xx[62]=.95E0;
  xx[63]=.975E0;
  xx[64]=1E0;
  
  // ditto for qq array
  
  qq[0]=0;
  qq[1]=1.E0;
  qq[2]=1.25E0;
  qq[3]=1.5E0;
  qq[4]=mc2-eps;
  qq[5]=mc2;
  qq[6]=2.5E0;
  qq[7]=3.2E0;
  qq[8]=4E0;
  qq[9]=5E0;
  qq[10]=6.4E0;
  qq[11]=8E0;
  qq[12]=1E1;
  qq[13]=1.2E1;
  qq[14]=mb2-eps;
  qq[15]=mb2;
  qq[16]=2.6E1;
  qq[17]=4E1;
  qq[18]=6.4E1;
  qq[19]=1E2;
  qq[20]=1.6E2;
  qq[21]=2.4E2;
  qq[22]=4E2;
  qq[23]=6.4E2;
  qq[24]=1E3;
  qq[25]=1.8E3;
  qq[26]=3.2E3;
  qq[27]=5.6E3;
  qq[28]=1E4;
  qq[29]=1.8E4;
  qq[30]=3.2E4;
  qq[31]=5.6E4;
  qq[32]=1E5;
  qq[33]=1.8E5;
  qq[34]=3.2E5;
  qq[35]=5.6E5;
  qq[36]=1E6;
  qq[37]=1.8E6;
  qq[38]=3.2E6;
  qq[39]=5.6E6;
  qq[40]=1E7;
  qq[41]=1.8E7;
  qq[42]=3.2E7;
  qq[43]=5.6E7;
  qq[44]=1E8;
  qq[45]=1.8E8;
  qq[46]=3.2E8;
  qq[47]=5.6E8;
  qq[48]=1E9;
  
  // The name of the file to open is stored in 'filename'.

  data_file.open(filename.c_str());
  
  if (data_file.bad()) {
    cerr << "Error opening " << filename << "\n";
    exit (-1);
  }

  for (n=1;n<=nx-1;n++) 
    for (m=1;m<=nq;m++) {
      // notation: 1=upv 2=dnv 3=glu 4=usea 5=chm 6=str 7=bot 8=dsea 9=sbar
      data_file >> f[1][n][m];
      data_file >> f[2][n][m];
      data_file >> f[3][n][m];
      data_file >> f[4][n][m];
      data_file >> f[5][n][m];
      data_file >> f[7][n][m]; // N.B. 7 before 6!
      data_file >> f[6][n][m];
      data_file >> f[8][n][m];
      data_file >> f[9][n][m];
      
      if (data_file.eof()) {
	cerr << "Error reading " << filename << "\n";
	exit (-1);
      }
    }
  
  // Check that ALL the file contents have been read in.
  data_file >> dtemp;
  if (!data_file.eof()) {
    cerr << "Error reading " << filename << "\n";
    exit (-1);
  }
  
  // Close the datafile.
  data_file.close();
  
  // Zero remaining elements.
  for (i=1;i<=np;i++)
    for (m=1;m<=nq;m++)
      f[i][nx][m]=0.0;
  
  // Set up the new array in log10(x) and log10(qsq).
  for (i=1;i<=nx;i++)
    xx[i]=log10(xx[i]);
  for (m=1;m<=nq;m++)
    qq[m]=log10(qq[m]);
  
  // Now calculate the derivatives used for bicubic interpolation.
  for (i=1;i<=np;i++) {
    // Start by calculating the first x derivatives
    // along the first x value:
    dx=xx[2]-xx[1];
    for (m=1;m<=nq;m++)
      f1[i][1][m]=(f[i][2][m]-f[i][1][m])/dx;
    // Then along the rest (up to the last):
    for (k=2;k<nx;k++) {
      for (m=1;m<=nq;m++) {
	f1[i][k][m]=polderivative(xx[k-1],xx[k],xx[k+1],f[i][k-1][m],f[i][k][m],f[i][k+1][m]);
      }
    }
    // Then for the last column:
    dx=xx[nx]-xx[nx-1];
    for (m=1;m<=nq;m++)
      f1[i][nx][m]=(f[i][nx][m]-f[i][nx-1][m])/dx;
    

    // Then calculate the qq derivatives.  At NNLO there are
    // discontinuities in the PDFs at mc2 and mb2, so calculate
    // the derivatives at q^2 = mc2-eps, mc2, mb2-eps, mb2 in
    // the same way as at the endpoints qsqmin and qsqmax.
    for (m=1;m<=nq;m++) {
      if (m==1 || m==nqc0+1 || m==nqb0+1) {
	dq=qq[m+1]-qq[m];
	for (k=1;k<=nx;k++)
	  f2[i][k][m]=(f[i][k][m+1]-f[i][k][m])/dq;
      }
      else if (m==nq || m==nqc0 || m==nqb0) {
	dq=qq[m]-qq[m-1];
	for (k=1;k<=nx;k++)
	  f2[i][k][m]=(f[i][k][m]-f[i][k][m-1])/dq;
      }
      else {
	// The rest:
	for (k=1;k<=nx;k++)
	  f2[i][k][m]=polderivative(qq[m-1],qq[m],qq[m+1],
				    f[i][k][m-1],f[i][k][m],f[i][k][m+1]);
      }
    }
      
    // Now, calculate the cross derivatives.
    // Calculate these as x-derivatives of the y-derivatives
    // ?? Could be improved by taking the average between dxdy and dydx ??
    
    // Start by calculating the first x derivatives
    // along the first x value:
    dx=xx[2]-xx[1];
    for (m=1;m<=nq;m++)
      f12[i][1][m]=(f2[i][2][m]-f2[i][1][m])/dx;
    // Then along the rest (up to the last):
    for (k=2;k<nx;k++) {
      for (m=1;m<=nq;m++)
	f12[i][k][m]=polderivative(xx[k-1],xx[k],xx[k+1],f2[i][k-1][m],f2[i][k][m],f2[i][k+1][m]);
    }
    // Then for the last column:
    dx=xx[nx]-xx[nx-1];
    for (m=1;m<=nq;m++)
      f12[i][nx][m]=(f2[i][nx][m]-f2[i][nx-1][m])/dx;

	
    // Now calculate the coefficients c_ij.
    for (n=1;n<=nx-1;n++) {
      for (m=1;m<=nq-1;m++) {
	d1=xx[n+1]-xx[n];
	d2=qq[m+1]-qq[m];
	d1d2=d1*d2;
	
	y[1]=f[i][n][m];
	y[2]=f[i][n+1][m];
	y[3]=f[i][n+1][m+1];
	y[4]=f[i][n][m+1];
	
	y1[1]=f1[i][n][m];
	y1[2]=f1[i][n+1][m];
	y1[3]=f1[i][n+1][m+1];
	y1[4]=f1[i][n][m+1];
	
	y2[1]=f2[i][n][m];
	y2[2]=f2[i][n+1][m];
	y2[3]=f2[i][n+1][m+1];
	y2[4]=f2[i][n][m+1];
	
	y12[1]=f12[i][n][m];
	y12[2]=f12[i][n+1][m];
	y12[3]=f12[i][n+1][m+1];
	y12[4]=f12[i][n][m+1];
	
	for (k=1;k<=4;k++) {
	  x[k-1]=y[k];
	  x[k+3]=y1[k]*d1;
	  x[k+7]=y2[k]*d2;
	  x[k+11]=y12[k]*d1d2;
	}
	
	
	for (l=0;l<=15;l++) {
	  xxd=0.0;
	  for (k=0;k<=15;k++) xxd+= wt[l][k]*x[k];
	  cl[l]=xxd;
	}
	
	l=0;
	for (k=1;k<=4;k++) 
	  for (j=1;j<=4;j++) c[i][n][m][k][j]=cl[l++];
      } //m
    } //n
  } // i

}

void c_pdf::update_interpolate(double x, double q)
{
  double qsq;
  double xxx,g[np+1];
  int i,n,m,l;
  double t,u;

  // Interpolation in log10(x), log10(qsq).
  xxx=log10(x);
  qsq=log10(q*q);

  n=locate(xx,nx,xxx); // 0: below xmin, nx: above xmax
  m=locate(qq,nq,qsq); // 0: below qsqmin, nq: above qsqmax

  for (i=1;i<=np;i++) {
    
    t=(xxx-xx[n])/(xx[n+1]-xx[n]);
    u=(qsq-qq[m])/(qq[m+1]-qq[m]);
    
    g[i]=0.0;
    for (l=4;l>=1;l--) {
      g[i]=t*g[i]+((c[i][n][m][l][4]*u+c[i][n][m][l][3])*u
		   +c[i][n][m][l][2])*u+c[i][n][m][l][1];
    }
    
  }

  cont.upv=g[1];
  cont.dnv=g[2];
  cont.usea=g[4];
  cont.dsea=g[8];
  cont.str=g[6];
  cont.sbar=g[9];
  cont.chm=g[5];
  cont.glu=g[3];
  cont.bot=g[7];
}

void c_pdf::update(double x,double q)
  // Updates the parton content.
{
  double qsq;
  int interpolate(1);
  qsq=q*q;
  
  if (x<xmin) {
    interpolate=0;
    if (x<=0.) {
      cerr << "Error in c_pdf::update, x = " << x << endl;
      if (fatal) exit (-1);
    }
  }
  else if (x>xmax) {
    interpolate=0;
    cerr << "Error in c_pdf::update, x = " << x << endl;
    if (fatal) exit (-1);
  }

  if (qsq<qsqmin) {
    interpolate=0;
    cerr << "Error in c_pdf::update, qsq = " << qsq << endl;
    if (fatal) exit (-1);
  }
  else if (qsq>qsqmax) {
    interpolate=0;
  }
  
  if (interpolate) {
    update_interpolate(x,q);
  }
  else { // extrapolate outside PDF grid
    cont.upv=parton(1,x,q);
    cont.dnv=parton(2,x,q);
    cont.usea=parton(4,x,q);
    cont.dsea=parton(8,x,q);
    cont.str=parton(6,x,q);
    cont.sbar=parton(9,x,q);
    cont.chm=parton(5,x,q);
    cont.glu=parton(3,x,q);
    cont.bot=parton(7,x,q);
  }

}

double c_pdf::parton_interpolate(int flavour, double x, double q)
{
  double qsq;
  double xxx,g;
  int n,m,l;
  double t,u;

  // Interpolation in log10(x), log10(qsq):
  xxx=log10(x);
  qsq=log10(q*q);

  n=locate(xx,nx,xxx); // 0: below xmin, nx: above xmax
  m=locate(qq,nq,qsq); // 0: below qsqmin, nq: above qsqmax
  
  t=(xxx-xx[n])/(xx[n+1]-xx[n]);
  u=(qsq-qq[m])/(qq[m+1]-qq[m]);
  
  g=0.0;
  for (l=4;l>=1;l--) {
    g=t*g+((c[flavour][n][m][l][4]*u+c[flavour][n][m][l][3])*u
	   +c[flavour][n][m][l][2])*u+c[flavour][n][m][l][1];
  }
  
  return g;
}

double c_pdf::parton(int f,double x,double q)
  // Returns the PDF value for parton of flavour 'f' at x,q.
{
  double qsq;
  double xxx;
  int n,m;
  int interpolate(1);
  double parton_pdf=0;
  qsq=q*q;

  if (x<xmin) {
    interpolate=0;
    if (x<=0.) {
      cerr << "Error in c_pdf::parton, x = " << x << endl;
      if (fatal) exit (-1);
      else return 0.;
    }
  }
  else if (x>xmax) {
    interpolate=0;
    cerr << "Error in c_pdf::parton, x = " << x << endl;
    if (fatal) exit (-1);
    else return 0.;
  }

  if (qsq<qsqmin) {
    interpolate=0;
    cerr << "Error in c_pdf::parton, qsq = " << qsq << endl;
    if (fatal) exit (-1);
    else return 0.;
  }
  else if (qsq>qsqmax) {
    interpolate=0;
  }
  
  if (interpolate==1) {
    parton_pdf=parton_interpolate(f,x,q);
  }
  else { // extrapolate outside PDF grid

    if (warn) {
      cerr << "Warning in c_pdf::parton, extrapolating: f = " 
	   << f << ", x = " << x << ", q = " << q << endl;
    }
  
    xxx=log10(x);
    qsq=log10(qsq);

    n=locate(xx,nx,xxx); // 0: below xmin, nx: above xmax
    m=locate(qq,nq,qsq); // 0: below qsqmin, nq: above qsqmax

    if (n==0&&(m>0&&m<nq)) { // if extrapolation in small x only

      double f0,f1;
      f0=parton_interpolate(f,xmin,q);
      f1=parton_interpolate(f,pow(10,(xx[2])),q);
      if (f0>0.&&f1>0.) { // if values are positive, keep them so
	f0=log(f0);
	f1=log(f1);
	parton_pdf=exp(f0+(f1-f0)/(xx[2]-xx[1])*(xxx-xx[1]));
      } else // otherwise just extrapolate in the value
	parton_pdf=f0+(f1-f0)/(xx[2]-xx[1])*(xxx-xx[1]); 

    } if (n>0&&m==nq) { // if extrapolation into large q only

      double f0,f1;
      f0=parton_interpolate(f,x,sqrt(pow(10,qq[nq])));
      f1=parton_interpolate(f,x,sqrt(pow(10,qq[nq-1])));
      if (f0>0.&&f1>0.) { // if values are positive, keep them so
	f0=log(f0);
	f1=log(f1);
	parton_pdf=exp(f0+(f0-f1)/(qq[nq]-qq[nq-1])*(qsq-qq[nq]));
      } else // otherwise just extrapolate in the value
	parton_pdf=f0+(f1-f0)/(qq[nq]-qq[nq-1])*(qsq-qq[nq]); 

    } if (n==0&&m==nq) { // if extrapolation into large q AND small x

      double f0,f1;
      f0=c_pdf::parton(f,xmin,q);
      f1=c_pdf::parton(f,pow(10,xx[2]),q);
      if (f0>0.&&f1>0.) { // if values are positive, keep them so
	f0=log(f0);
	f1=log(f1);
	parton_pdf=exp(f0+(f1-f0)/(xx[2]-xx[1])*(xxx-xx[1]));
      } else // otherwise just extrapolate in the value

	parton_pdf=f0+(f1-f0)/(xx[2]-xx[1])*(xxx-xx[1]);       

    }
  }
  return parton_pdf;
}
