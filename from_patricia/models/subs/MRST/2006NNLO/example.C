/////////////////////////////////////////////////////////////////
// G.Watt 21/05/2007.                                          //
// Program to demonstrate usage of the MRST 2006 NNLO PDFs.    //
// 29/06/2007 Rewrite to avoid using vector container objects. //
/////////////////////////////////////////////////////////////////
#include "pdf.h"

int main (void)
{

  char filename[100];
  char prefix[] = "Grids/mrst2006nnlo"; // prefix for the grid files

  // Consider only the central PDF set to start with.
  sprintf(filename,"%s.%2.2d.dat",prefix,0);
  cout << "Reading grid from " << filename << endl;
  class c_pdf pdf(filename);
  
  // Specify the momentum fraction "x" and scale "q".
  double x = 1e-3, q = 1e1;
  cout << "x = " << x << ", q = " << q << endl;
   
  // Update all PDF flavours.
  pdf.update(x,q);
  // Then the individual flavours are accessed from the cont structure.
  double upv,dnv,usea,dsea,str,sbar,chm,bot,glu;
  upv = pdf.cont.upv;
  dnv = pdf.cont.dnv;
  usea = pdf.cont.usea;
  dsea = pdf.cont.dsea;
  str = pdf.cont.str;
  sbar = pdf.cont.sbar;
  chm = pdf.cont.chm;
  bot = pdf.cont.bot;
  glu = pdf.cont.glu;
  
  // If only a single parton flavour needs to be evaluated,
  // then update(x,q) does not need to be called.
  double upv1,dnv1,usea1,dsea1,str1,sbar1,chm1,bot1,glu1;
  upv1 = pdf.parton(UPV,x,q);
  dnv1 = pdf.parton(DNV,x,q);
  usea1 = pdf.parton(USEA,x,q);
  dsea1 = pdf.parton(DSEA,x,q);
  str1 = pdf.parton(STR,x,q);
  sbar1 = pdf.parton(SBAR,x,q);
  chm1 = pdf.parton(CHM,x,q);
  bot1 = pdf.parton(BOT,x,q);
  glu1 = pdf.parton(GLU,x,q);
  // Here, the enumerated constants are defined as:
  // UPV=1,DNV=2,GLU=3,USEA=4,CHM=5,STR=6,BOT=7,DSEA=8,SBAR=9.
  // If preferred, these integer values can be used explicitly.

  // Demonstrate the equivalence of the above two methods.
  cout << "upv = " << upv << " = " << upv1 << endl;
  cout << "dnv = " << dnv << " = " << dnv1 << endl;
  cout << "usea = " << usea << " = " << usea1 << endl;
  cout << "dsea = " << dsea << " = " << dsea1 << endl;
  cout << "str = " << str << " = " << str1 << endl;
  cout << "sbar = " << sbar << " = " << sbar1 << endl;
  cout << "chm = " << chm << " = " << chm1 << endl;
  cout << "bot = " << bot << " = " << bot1 << endl;
  cout << "glu = " << glu << " = " << glu1 << endl;

  //////////////////////////////////////////////////////////////////////
  // Now demonstrate use of the eigenvector PDF sets.                 //
  // Calculate the uncertainty on the gluon distribution using both   //
  // the formula for asymmetric errors [eq.(13) of EPJC28 (2003) 455] //
  // and the formula for symmetric errors [eq.(9) of same paper].     //
  //////////////////////////////////////////////////////////////////////

  // Create an array of classes "pdfs" to hold the eigenvector sets.
  const int neigen=15; // number of eigenvectors
  class c_pdf *pdfs[2*neigen+1];
  for (int i=0;i<=2*neigen;i++) {
    sprintf(filename,"%s.%2.2d.dat",prefix,i);
    cout << "Reading grid from " << filename << endl;
    pdfs[i] = new class c_pdf(filename);
  }

  // First get xg as a function of x at a fixed value of q.
  q = 1e1;
  int nx = 100;
  double xmin = 1e-4, xmax = 1e0, glup, glum, summax, summin, sum;
  ofstream outfile;
  char buffer[100];
  outfile.open("xg_vs_x_cpp.dat");
  sprintf(buffer," # q = %12.4E",q);
  outfile << buffer << endl;
  sprintf(buffer," #%10s%12s%12s%12s%12s","x","xg","error+","error-","error");
  outfile << buffer << endl;
  for (int ix=1;ix<=nx;ix++) {
    x = pow(10.,log10(xmin) + (ix-1.)/(nx-1.)*(log10(xmax)-log10(xmin)));
    glu = pdfs[0]->parton(GLU,x,q); // central set
    summax = 0.; summin = 0.; sum = 0.;
    for (int ieigen=1;ieigen<=neigen;ieigen++) { // loop over eigenvector sets
      glup = pdfs[2*ieigen-1]->parton(GLU,x,q); // "+" direction
      glum = pdfs[2*ieigen]->parton(GLU,x,q);   // "-" direction
      summax += pow(max(max(glup-glu,glum-glu),0.),2);
      summin += pow(max(max(glu-glup,glu-glum),0.),2);
      sum += pow(glup-glum,2);
    }
    sprintf(buffer,"%12.4E%12.4E%12.4E%12.4E%12.4E",
	    x,glu,sqrt(summax),sqrt(summin),0.5*sqrt(sum));
    outfile << buffer << endl;
  }
  outfile.close();
  cout << "xg vs. x for q2 = " << q*q << " written to xg_vs_x_cpp.dat" << endl;

  // Now get xg as a function of q^2 at a fixed value of x.
  x = 1e-3;
  int nq = 100;
  double q2min = 1e0, q2max = 1e9;
  outfile.open("xg_vs_q2_cpp.dat");
  sprintf(buffer," # x = %12.4E",x);
  outfile << buffer << endl;
  sprintf(buffer," #%10s%12s%12s%12s%12s","q2","xg","error+","error-","error");
  outfile << buffer << endl;
  for (int iq=1;iq<=nq;iq++) {
    q = sqrt(pow(10.,log10(q2min) + (iq-1.)/(nq-1.)*(log10(q2max)-log10(q2min))));
    glu = pdfs[0]->parton(GLU,x,q); // central set
    summax = 0.; summin = 0.; sum = 0.;
    for (int ieigen=1;ieigen<=neigen;ieigen++) { // loop over eigenvector sets
      glup = pdfs[2*ieigen-1]->parton(GLU,x,q);
      glum = pdfs[2*ieigen]->parton(GLU,x,q);
      summax += pow(max(max(glup-glu,glum-glu),0.),2);
      summin += pow(max(max(glu-glup,glu-glum),0.),2);
      sum += pow(glup-glum,2);
    }
    sprintf(buffer,"%12.4E%12.4E%12.4E%12.4E%12.4E",
	    q*q,glu,sqrt(summax),sqrt(summin),0.5*sqrt(sum));
    outfile << buffer << endl;
  }
  outfile.close();
  cout << "xg vs. q2 for x = " << x << " written to xg_vs_q2_cpp.dat" << endl;

  // Free dynamic memory allocated for "pdfs".
  for (int i=0;i<=2*neigen;i++) {
    delete pdfs[i]; 
  }
   
  return (0);

}
