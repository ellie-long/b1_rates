/////////////////////////////////////////////////////////////////////
// C++ example program to demonstrate usage of the MSTW 2008 PDFs. //
// Comments to Graeme Watt <Graeme.Watt(at)cern.ch>.               //
/////////////////////////////////////////////////////////////////////
#include "mstwpdf.h"
//#include <vector>

// Wrapper around Fortran code for alpha_S.
extern "C" {
  void initalphas_(int *IORD, double *FR2, double *MUR, double *ASMUR,
		   double *MC, double *MB, double *MT);
  double alphas_(double *MUR);
}
inline void InitAlphaS(int IORD, double FR2, double MUR, double ASMUR,
		       double MC, double MB, double MT) {
  initalphas_(&IORD, &FR2, &MUR, &ASMUR,
	      &MC, &MB, &MT);
}
inline double AlphaS(double MUR) {
  return alphas_(&MUR);
}

int main (void)
{

  char filename[100];
  char prefix[] = "Grids/mstw2008nnlo"; // prefix for the grid files

  // Consider only the central PDF set to start with.
  sprintf(filename,"%s.%2.2d.dat",prefix,0);
  c_mstwpdf *pdf = new c_mstwpdf(filename); // default: warn=false, fatal=true
  //   bool warn = true;   // option to turn on warnings if extrapolating.
  //   bool fatal = false; // option to return zero instead of terminating if invalid x or q
  //   c_mstwpdf *pdf = new c_mstwpdf(filename,warn,fatal);
  
  // Specify the momentum fraction "x" and scale "q".
  double x = 1e-3, q = 1e1;
  cout << "x = " << x << ", q = " << q << endl;
   
  // Update all PDF flavours.
  pdf->update(x,q);
  // Then the individual flavours are accessed from the cont structure.
  double upv,dnv,usea,dsea,str,sbar,chm,cbar,bot,bbar,glu,phot;
  upv = pdf->cont.upv;
  dnv = pdf->cont.dnv;
  usea = pdf->cont.usea;
  dsea = pdf->cont.dsea;
  str = pdf->cont.str;
  sbar = pdf->cont.sbar;
  chm = pdf->cont.chm;
  cbar = pdf->cont.cbar;
  bot = pdf->cont.bot;
  bbar = pdf->cont.bbar;
  glu = pdf->cont.glu;
  phot = pdf->cont.phot;
  
  // If only a single parton flavour needs to be evaluated,
  // then update(x,q) does not need to be called.
  double upv1,dnv1,usea1,dsea1,str1,sbar1,chm1,cbar1,bot1,bbar1,glu1,phot1;
  upv1 = pdf->parton(8,x,q);
  dnv1 = pdf->parton(7,x,q);
  usea1 = pdf->parton(-2,x,q);
  dsea1 = pdf->parton(-1,x,q);
  str1 = pdf->parton(3,x,q);
  sbar1 = pdf->parton(-3,x,q);
  chm1 = pdf->parton(4,x,q);
  cbar1 = pdf->parton(-4,x,q);
  bot1 = pdf->parton(5,x,q);
  bbar1 = pdf->parton(-5,x,q);
  glu1 = pdf->parton(0,x,q);
  phot1 = pdf->parton(13,x,q);
  // Here the PDG notation is used for the parton flavour
  // (apart from the gluon has f=0, not 21):
  //  f =   -6,  -5,  -4,  -3,  -2,  -1,0,1,2,3,4,5,6
  //    = tbar,bbar,cbar,sbar,ubar,dbar,g,d,u,s,c,b,t.
  // Can also get valence quarks directly:
  //  f =  7, 8, 9,10,11,12.
  //    = dv,uv,sv,cv,bv,tv.
  // Photon: f = 13.
  // Warning: this numbering scheme is different from that used
  // in the MRST2006 NNLO code!
  // (The photon distribution is zero unless considering QED
  // contributions: implemented here for future compatibility.)

  // Demonstrate the equivalence of the above two methods.
  cout << "upv = " << upv << " = " << upv1 << endl;
  cout << "dnv = " << dnv << " = " << dnv1 << endl;
  cout << "usea = " << usea << " = " << usea1 << endl;
  cout << "dsea = " << dsea << " = " << dsea1 << endl;
  cout << "str = " << str << " = " << str1 << endl;
  cout << "sbar = " << sbar << " = " << sbar1 << endl;
  cout << "chm = " << chm << " = " << chm1 << endl;
  cout << "cbar = " << cbar << " = " << cbar1 << endl;
  cout << "bot = " << bot << " = " << bot1 << endl;
  cout << "bbar = " << bbar << " = " << bbar1 << endl;
  cout << "glu = " << glu << " = " << glu1 << endl;
  cout << "phot = " << phot << " = " << phot1 << endl;


  ///////////////////////////////////////////////////////////////////
  // Print out grid ranges, heavy quark masses, and alphaS values. //
  ///////////////////////////////////////////////////////////////////

  cout << "xmin = " << pdf->xmin << ", "
       << "xmax = " << pdf->xmax << ", "
       << "qsqmin = " << pdf->qsqmin << ", "
       << "qsqmax = " << pdf->qsqmax << endl;

  cout << "mCharm = " << pdf->mCharm << ", "
       << "mBottom = " << pdf->mBottom << endl;

  cout << "alphaS(Q0) = " << pdf->alphaSQ0 << ", "
       << "alphaS(MZ) = " << pdf->alphaSMZ << ", "
       << "alphaSorder = " << pdf->alphaSorder << ", "
       << "alphaSnfmax = " << pdf->alphaSnfmax << endl;

  // Call the Fortran initialisation routine with alpha_S(Q_0).
  double FR2 = 1e0, Q0 = 1e0, mTop = 1.e10;
  InitAlphaS(pdf->alphaSorder,FR2,Q0,pdf->alphaSQ0,pdf->mCharm,pdf->mBottom,mTop);

  // Check calculated value of alpha_S(M_Z) matches value stored in grid file.
  double MZ = 91.1876;
  printf("alphaS(MZ) = %7.5f = %7.5f\n",AlphaS(MZ),pdf->alphaSMZ);

  // Alternatively, call the Fortran initialisation routine with alpha_S(M_Z).
  InitAlphaS(pdf->alphaSorder,FR2,MZ,pdf->alphaSMZ,pdf->mCharm,pdf->mBottom,mTop);
  // Check calculated value of alpha_S(Q_0) matches stored value.
  printf("alphaS(Q0) = %7.5f = %7.5f\n",AlphaS(Q0),pdf->alphaSQ0);


  //////////////////////////////////////////////////////////////////////
  // Now demonstrate use of the eigenvector PDF sets.                 //
  //////////////////////////////////////////////////////////////////////

  // Get the central value of the gluon distribution.
  //  sprintf(filename,"%s.%2.2d.dat",prefix,0);
  //  c_mstwpdf *pdf = new c_mstwpdf(filename);
  cout << "central fit: distance = " << pdf->distance << ", tolerance = " << pdf->tolerance << ", glu = " << pdf->parton(0,x,q) << endl;
  // Now get the value of the gluon distribution at a distance t from
  // the global minimum along the first eigenvector direction in the
  // '+' direction.  The distance t is chosen to give a tolerance 
  // T = sqrt(Delta(chi^2_{global})) ensuring all data sets are
  // described within their 90% confidence level (C.L.) limits.
  // Under ideal quadratic behaviour, t = T.
  sprintf(filename,"%s.90cl.%2.2d.dat",prefix,1); // first eigenvector
  c_mstwpdf *pdf90 = new c_mstwpdf(filename);
  cout << "eigenvector +1, 90% C.L.: distance = " << pdf90->distance << ", tolerance = " << pdf90->tolerance << ", glu = " << pdf90->parton(0,x,q) << endl;
  // Now the same thing, but with the tolerance chosen to ensure
  // that all data sets are described only within their
  // one-sigma (68%) C.L. limits.
  sprintf(filename,"%s.68cl.%2.2d.dat",prefix,1); // first eigenvector
  c_mstwpdf *pdf68 = new c_mstwpdf(filename);
  cout << "eigenvector +1, 68% C.L.: distance = " << pdf68->distance << ", tolerance = " << pdf68->tolerance << ", glu = " << pdf68->parton(0,x,q) << endl;

  // Free dynamic memory allocated for "pdf", "pdf90" and "pdf68".
  delete pdf; delete pdf90; delete pdf68;


  ////////////////////////////////////////////////////////////////////////
  // Calculate the uncertainty on the parton distributions using both   //
  // the formula for asymmetric errors [eqs.(51,52) of arXiv:0901.0002] //
  // and the formula for symmetric errors [eq.(50) of same paper].      //
  ////////////////////////////////////////////////////////////////////////

  const int neigen=20; // number of eigenvectors

  // Choose either the 90% C.L. error sets or the 68% C.L. error sets
  char prefix1[100];
  sprintf(prefix1,"%s.90cl",prefix); // 90% C.L. errors
  //  sprintf(prefix1,"%s.68cl",prefix); // 68% C.L. errors

  // Create an array of instances of classes "pdfs"
  // to hold the eigenvector sets.
  c_mstwpdf *pdfs[2*neigen+1];
  for (int i=0;i<=2*neigen;i++) {
    if (i==0) sprintf(filename,"%s.%2.2d.dat",prefix,i);
    else sprintf(filename,"%s.%2.2d.dat",prefix1,i);
    pdfs[i] = new c_mstwpdf(filename);
  }

//   // As an alternative to the above create a
//   // vector "pdfs" to hold the eigenvector sets.
//   std::vector<c_mstwpdf*> pdfs;
//   for (int i=0;i<=2*neigen;i++) {
//     if (i==0) sprintf(filename,"%s.%2.2d.dat",prefix,i);
//     else sprintf(filename,"%s.%2.2d.dat",prefix1,i);
//     pdfs.push_back(new c_mstwpdf(filename));
//   }
  
  // First get xf as a function of x at a fixed value of q.
  // Extrapolation will be used for x < 10^-6.
  q = 1e1;
  int nx = 100;
  double xmin = 1e-7, xmax = 0.99, xf, xfp, xfm, summax, summin, sum;
  ofstream outfile;
  char buffer[100];
  string flavours[] = {"bbar","cbar","sbar","ubar","dbar","glu",
		       "dn","up","str","chm","bot"};
  for (int flav=-5;flav<=5;flav++) {
    string xflav = "x"+flavours[flav+5];
    string xfilename = xflav+"_vs_x_cpp.dat";
    outfile.open(xfilename.c_str());
    sprintf(buffer," # q = %12.4E",q);
    outfile << buffer << endl;
    sprintf(buffer," #%10s%12s%12s%12s%12s","x",xflav.c_str(),"error+","error-","error");
    outfile << buffer << endl;
    for (int ix=1;ix<=nx;ix++) {
      x = pow(10.,log10(xmin) + (ix-1.)/(nx-1.)*(log10(xmax)-log10(xmin)));
      xf = pdfs[0]->parton(flav,x,q); // central set
      summax = 0.; summin = 0.; sum = 0.;
      for (int ieigen=1;ieigen<=neigen;ieigen++) { // loop over eigenvector sets
	xfp = pdfs[2*ieigen-1]->parton(flav,x,q); // "+" direction
	xfm = pdfs[2*ieigen]->parton(flav,x,q);   // "-" direction
	double maxtemp;
	maxtemp = max(xfp-xf,xfm-xf); summax += pow(max(maxtemp,0.),2);
	maxtemp = max(xf-xfp,xf-xfm); summin += pow(max(maxtemp,0.),2);
	sum += pow(xfp-xfm,2);
      }
      sprintf(buffer,"%12.4E%12.4E%12.4E%12.4E%12.4E",
	      x,xf,sqrt(summax),sqrt(summin),0.5*sqrt(sum));
      outfile << buffer << endl;
    }
    outfile.close();
    cout << xflav << " vs. x for q2 = " << q*q << " written to " << xfilename << endl;
  }

  // Now get xf as a function of q^2 at a fixed value of x.
  // Extrapolation will be used for q^2 < 1 GeV^2 and for q^2 > 10^9 GeV^2.
  x = 1e-3;
  int nq = 100;
  double q2min = 5e-1, q2max = 1e10;
  for (int flav=-5;flav<=5;flav++) {
    string xflav = "x"+flavours[flav+5];
    string qfilename = xflav+"_vs_q2_cpp.dat";
    outfile.open(qfilename.c_str());
    sprintf(buffer," # x = %12.4E",x);
    outfile << buffer << endl;
    sprintf(buffer," #%10s%12s%12s%12s%12s","q2",xflav.c_str(),"error+","error-","error");
    outfile << buffer << endl;
    for (int iq=1;iq<=nq;iq++) {
      q = sqrt(pow(10.,log10(q2min) + (iq-1.)/(nq-1.)*(log10(q2max)-log10(q2min))));
      xf = pdfs[0]->parton(flav,x,q); // central set
      summax = 0.; summin = 0.; sum = 0.;
      for (int ieigen=1;ieigen<=neigen;ieigen++) { // loop over eigenvector sets
	xfp = pdfs[2*ieigen-1]->parton(flav,x,q);
	xfm = pdfs[2*ieigen]->parton(flav,x,q);
	summax += pow(max(max(xfp-xf,xfm-xf),0.),2);
	summin += pow(max(max(xf-xfp,xf-xfm),0.),2);
	sum += pow(xfp-xfm,2);
      }
      sprintf(buffer,"%12.4E%12.4E%12.4E%12.4E%12.4E",
	      q*q,xf,sqrt(summax),sqrt(summin),0.5*sqrt(sum));
      outfile << buffer << endl;
    }
    outfile.close();
    cout << xflav << " vs. q2 for x = " << x << " written to " << qfilename << endl;
  }

  // Free dynamic memory allocated for "pdfs".
  for (int i=0;i<=2*neigen;i++) {
    delete pdfs[i]; 
  }

  return (0);

}
