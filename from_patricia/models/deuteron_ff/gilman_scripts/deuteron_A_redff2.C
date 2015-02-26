#include "styling.cxx"
// #include "readRepFile.C"


void deuteron_A_redff2() {
styling();
c = new TCanvas("c","Deuteron A Calcs",000,10,500,540);
plot_figure("deuteron_A_redff2",gPad);
}

void plot_figure(TString fn,TPad *thePad,bool saxis=false,float ymin=0.0,float ymax=0.05,bool with_d=false) {
//cout<<"wit"<<with_d<<endl;

gStyle->SetOptFit();
gStyle->SetPadTickY(1);
//gStyle->SetLogY();

gStyle->SetLineStyleString(11,"40 20");
float xmin=0,xmax=7;

thePad->cd();
//thePad->SetLogy();
//thePad->SetGrid();

/*****************************************************
 Colors
*****************************************************/
int HRMcol=kRed+2;
int RNAcol=kMagenta;
int QGScol=kGreen+1;

Double_t x,y;
/*****************************************************
 Format the pad
*****************************************************/

thePad->SetTopMargin(0.15);
TH1F *hr = thePad->DrawFrame(xmin,ymin,xmax,ymax);
hr->SetXTitle("Q^{2} (GeV^{2})");
hr->SetYTitle("f_{D}(Q^{2}) = #sqrt{A(Q^{2})} / G_{D}^{2}(Q^{2}/4)");
hr->GetYaxis()->SetTitleOffset(1.5);
hr->GetYaxis()->SetTitleSize(.06);
hr->GetYaxis()->SetTitleFont(42);
hr->GetYaxis()->CenterTitle();
hr->GetXaxis()->SetTitleSize(.06);
hr->GetXaxis()->SetTitleFont(42);
/*****************************************************
  Draw legend
*****************************************************/

TLegend *dummylegend=new TLegend();
TLegend *legend=new TLegend(0.66,0.50,0.93,0.84);
legend->SetMargin(0.2);
legend->SetTextFont(72);
legend->SetTextSize(0.035);
legend->SetFillStyle(0);
legend->SetBorderSize(0);
legend->Draw();

TLegend *thlegend=new TLegend(0.35,0.74,0.65,0.84);
thlegend->SetMargin(0.2);
thlegend->SetTextFont(72);
thlegend->SetTextSize(0.035);
thlegend->SetFillStyle(0);
thlegend->SetBorderSize(0);
thlegend->Draw();

thePad->SetLeftMargin(0.19);
/*****************************************************
  Draw top axis
*****************************************************/
float titlex1=0.47, titley1=0.85,titlex2=0.56,titley2=0.95;

if (saxis) {
  titley1=0.72;titley2=0.82;
  TGaxis *axispp = new TGaxis(thePad->GetUxmin(),thePad->GetUymax(),
		 thePad->GetUxmax(),
		 thePad->GetUymax(),
		 xmin/0.1973**2,
		 xmax/0.1973**2,510,"-R");
  axispp->SetTitle("Q^{2} (fm^{-2})");
  axispp->SetLabelFont(42);
  axispp->SetLabelSize(0.04);
  axispp->SetTitleFont(42);
  axispp->SetTitleSize(.055);
  axispp->Draw();
}
/*****************************************************
    Make Title
*****************************************************/
//TPaveLabel *label = new TPaveLabel(titlex1,titley1,titlex2,titley2,"^{3}He(#gamma,pp)n","NDC");
//label->SetTextSize(0.7);
//label->SetFillStyle(0);
//label->SetTextFont(42);
//label->SetBorderSize(0);
//label->Draw();
//TPaveLabel *label = new TPaveLabel(titlex1,titley1-0.06,titlex2,titley2-0.06,"90#circc.m.","NDC");
//label->SetTextSize(0.5);
//label->SetFillStyle(0);
//label->SetTextFont(42);
//label->SetBorderSize(0);
//label->Draw();
/*--------------------------------------------------------------------------------------
    Constants?
---------------------------------------------------------------------------------------*/
  Double_t xmd = 1.875613;
  Double_t xmdsq = xmd*xmd;
  Double_t q0sq = 1.15;
  Double_t degr = 0.01745329252;
  Double_t xhbarc = 0.1973;

 /*--------------------------------------------------------------------------------------
    RNA - Brodsky & Hiller
 ---------------------------------------------------------------------------------------*/
 const Int_t nrna = 180;
 Double_t qrna[180], arna[200];
 Double_t xm0sq = 0.01;
 Double_t fnorm = 0.0075*(1.+4./xm0sq);
 for (Int_t i=0;i<nrna;i++) {
   qrna[i] = 1. + 0.05*i;
   arna[i] = fnorm/(1.+qrna[i]/xm0sq);
 }

TGraph* gRNA=new TGraph(nrna,qrna,arna);
gRNA->SetLineColor(12);
gRNA->SetMarkerStyle(1);
gRNA->SetMarkerSize(1.3);
gRNA->SetLineStyle(2);
gRNA->SetLineWidth(2);
gRNA->Draw("l");
thlegend->AddEntry(gRNA,"BH","L");

 /*--------------------------------------------------------------------------------------
    QCD - Brodsky, Ji, LePage
 ---------------------------------------------------------------------------------------*/
 Double_t aqcd[200];
 Double_t nc = 3.;
 Double_t nf = 2.;
 Double_t cf = (nc**2.-1.)/(2.*nc);
 Double_t beta = 11.-(2./3.)*nf;
 Double_t gamma = -1.*(2.*cf/(5.*beta));
 Double_t lambdasq = 0.1**2.;
 Double_t alphas = 1.;
 Double_t fnorm = 0.0075/((alphas/4.)*(log(4./lambdasq))**(-1.+gamma));
 for (Int_t i=0;i<nrna;i++) {
   aqcd[i] = fnorm*(alphas/qrna[i])*(log(qrna[i]/lambdasq))**(-1.+gamma);
 }

TGraph* gph=new TGraph(nrna,qrna,aqcd);
gph->SetLineColor(2);
gph->SetMarkerStyle(1);
gph->SetMarkerSize(1.3);
gph->SetLineStyle(9);
gph->SetLineWidth(3);
gph->Draw("l");
thlegend->AddEntry(gph,"BJL","L");

plotSet(kBlue,legend,"");

/*****************************************************
 Add the rest of the legend enteries
*****************************************************/

gStyle->SetPaperSize(20,26);  //default
c->SaveAs(fn+".pdf");
c->SaveAs(fn+".eps");
c->SaveAs(fn+".png");
}

void plotSet(int col,TLegend* legend,char* title="") {
/*******************************************************************
 Set the A values
*******************************************************************/
  const Int_t npt24 = 5;

  Double_t qpt24[npt24] = {.2337,   .2725,   .3113,   .4671,   .7785};
  Double_t apt24[npt24] = {9.1800E-03,  5.7100E-03,  3.6300E-03,  8.9500E-04,  1.7100E-04};
  Double_t aerr24[npt24] = {5.3200E-04,  3.2000E-04,  1.8200E-04,  1.0700E-04,  4.3900E-05};
  for (Int_t i=0;i<npt24;i++) {
    apt24[i] = apt24[i]**(0.5)*(1.+0.25*qpt24[i]/0.71)**4;
    aerr24[i] = aerr24[i]*(1.+0.25*qpt24[i]/0.71)**4;}
  TGraphErrors* gscaled=new TGraphErrors(npt24,qpt24,apt24,0,aerr24);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(24);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Buchanan","p");

  const Int_t npt29 = 18;
  Double_t qpt29[npt29] = {.5731,   .6003,   .6256,   .6486,   .6730,   .7035,   .7312,   .7598,   .7914,   .8194, 
			   .8493,   .8790,   .9100,   .9438,   .9880,  1.0676,  1.2029,  1.3276};
  Double_t apt29[npt29] = {4.2880E-04,  4.5600E-04,  3.5750E-04,  2.8080E-04,  2.7600E-04, 
			     2.1660E-04,  1.5750E-04,  1.9260E-04,  1.5880E-04,  1.3020E-04, 
			     1.1290E-04,  9.3300E-05,  1.0810E-04,  7.0100E-05,  6.7500E-05, 
			     4.3800E-05,  5.4000E-05,  2.5700E-05};
  Double_t aerr29[npt29] = {3.6900E-05,  4.1500E-05,  3.4000E-05,  2.5300E-05,  2.5800E-05, 
			      2.1100E-05,  1.7900E-05,  2.0600E-05,  1.8700E-05,  1.4800E-05, 
			      1.4700E-05,  1.5000E-05,  1.8700E-05,  1.7600E-05,  1.6200E-05, 
			      1.6700E-05,  1.4900E-05,  1.3400E-05};
  for (Int_t i=0;i<npt29;i++) {
    Double_t erel = 0.5*aerr29[i]/apt29[i];
    apt29[i] = apt29[i]**(0.5)*(1.+0.25*qpt29[i]/0.71)**4;
    aerr29[i] = erel*apt29[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt29,qpt29,apt29,0,aerr29);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(29);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Elias","p");
 
  const Int_t npt25 = 4;
  Double_t qpt25[npt25] = {.1168,   .1557,   .1946,   .2335};
  Double_t apt25[npt25] = {6.7600E-02,  3.2400E-02,  1.8000E-02,  1.0500E-02};
  Double_t aerr25[npt25] = {1.8000E-03,  1.0000E-03,  6.0000E-04,  2.0000E-03};
  for (Int_t i=0;i<npt25;i++) {
    erel = 0.5*aerr25[i]/apt25[i];
    apt25[i] = apt25[i]**(0.5)*(1.+0.25*qpt25[i]/0.71)**4;
    aerr25[i] = erel*apt25[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt25,qpt25,apt25,0,aerr25);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(25);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Benaksas","p");

  const Int_t npt28 = 8;
  Double_t qpt28[npt28] = {.7999,   .9998,  1.4997,  1.7495,  1.9995,  2.4994,  2.9995,  3.9993};
  Double_t apt28[npt28] = {2.3100E-04,  8.9500E-05,  2.0400E-05,  9.0500E-06,  4.7400E-06, 
			 1.4300E-06,  5.0200E-07,  5.1200E-08};
  Double_t aerr28[npt28] = {2.2000E-05,  7.7000E-06,  1.6000E-06,  7.8000E-07,  3.7000E-07, 
			  1.4000E-07,  5.5000E-08,  1.1600E-08};
  for (Int_t i=0;i<npt28;i++) {
    erel = 0.5*aerr28[i]/apt28[i];
    apt28[i] = apt28[i]**(0.5)*(1.+0.25*qpt28[i]/0.71)**4;
    aerr28[i] = erel*apt28[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt28,qpt28,apt28,0,aerr28);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(28);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Arnold","p");

  const Int_t npt23 = 43;
  Double_t qpt23[npt23] = {.0179,   .0273,   .0378,   .0487,   .0603,   .0717,   .0829,   .0930,   .1024,   .1109, 
			   .0234,   .0315,   .0405,   .0603,   .0830,   .1066,   .1308,   .1542,   .1768,   .0861, 
			   .1097,   .1355,   .1623,   .1908,   .2199,   .2492,   .2788,   .3082,   .3376,   .3659, 
			   .1432,   .1821,   .2242,   .2456,   .2678,   .2903,   .3131,   .3588,   .4051,   .4516, 
			   .5416,   .6260,   .7031};
  Double_t apt23[npt23] = {5.4550E-01,  4.1479E-01,  3.1069E-01,  2.3870E-01,  1.7780E-01, 
			     1.3999E-01,  1.1270E-01,  9.1450E-02,  7.8520E-02,  6.6330E-02, 
			     4.6976E-01,  3.7430E-01,  2.9537E-01,  1.8582E-01,  1.1395E-01, 
			     7.2490E-02,  4.8440E-02,  3.2329E-02,  2.2820E-02,  1.1088E-01, 
			     7.0144E-02,  4.4780E-02,  2.8738E-02,  1.8564E-02,  1.2465E-02, 
			     8.4210E-03,  5.7433E-03,  4.1691E-03,  3.1510E-03,  2.3429E-03, 
			     3.9279E-02,  2.0715E-02,  1.1644E-02,  8.9040E-03,  6.7303E-03, 
			     5.0284E-03,  3.9579E-03,  2.4130E-03,  1.5620E-03,  1.0380E-03, 
			     5.4030E-04,  3.4989E-04,  2.3346E-04};
  Double_t aerr23[npt23] = {9.2730E-03,  7.4660E-03,  5.5920E-03,  4.5350E-03,  3.3780E-03, 
			      2.3800E-03,  2.2530E-03,  2.0110E-03,  2.0410E-03,  1.9230E-03, 
			      7.0460E-03,  6.3630E-03,  4.4300E-03,  2.7870E-03,  1.7090E-03, 
			      1.2320E-03,  8.7190E-04,  6.1420E-04,  5.0200E-04,  1.6630E-03, 
			      1.0520E-03,  8.5080E-04,  4.3100E-04,  2.7840E-04,  1.8690E-04, 
			      1.5990E-04,  9.3140E-05,  6.7040E-05,  8.1920E-05,  7.0290E-05, 
			      6.6770E-04,  3.1070E-04,  1.7460E-04,  1.6910E-04,  1.0090E-04, 
			      7.5420E-05,  5.9360E-05,  5.0670E-05,  3.5920E-05,  2.9060E-05, 
			      1.8370E-05,  1.5740E-05,  1.1860E-05};
  for (Int_t i=0;i<npt23;i++) {
    erel = 0.5*aerr23[i]/apt23[i];
    apt23[i] = apt23[i]**(0.5)*(1.+0.25*qpt23[i]/0.71)**4;
    aerr23[i] = erel*apt23[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt23,qpt23,apt23,0,aerr23);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(23);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Platchkov","p");

  const Int_t npt27 = 10;
  Double_t qpt27[npt27] = {.2398,   .2569,   .2740,   .2920,   .3797,   .4244,   .4293,   .4556,   .4834,   .5062};
  Double_t apt27[npt27] = {9.8600E-03,  7.5700E-03,  6.4000E-03,  5.3900E-03,  2.0500E-03, 
			     1.4900E-03,  1.2870E-03,  1.0770E-03,  9.2600E-04,  7.7900E-04};
  Double_t aerr27[npt27] = {5.0000E-04,  4.5000E-04,  4.1000E-04,  3.8000E-04,  1.5000E-04, 
			      1.2000E-04,  8.0000E-05,  6.0000E-05,  6.8000E-05,  6.3000E-05};
  for (Int_t i=0;i<npt27;i++) {
    erel = 0.5*aerr27[i]/apt27[i];
    apt27[i] = apt27[i]**(0.5)*(1.+0.25*qpt27[i]/0.71)**4;
    aerr27[i] = aerr27[i] = erel*apt27[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt27,qpt27,apt27,0,aerr27);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(27);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Galster","p");

  const Int_t npt22 = 5;
  Double_t qpt22[npt22] = {.4997,   .5997,   .7799,   .9998,  1.2996};
  Double_t apt22[npt22] = {7.7900E-04,  4.6300E-04,  1.7700E-04,  7.1000E-05,  1.7700E-05};
  Double_t aerr22[npt22] = {3.4000E-05,  4.5000E-05,  7.0000E-06,  2.1000E-06,  2.6000E-06};
  for (Int_t i=0;i<npt22;i++) {
    erel = 0.5*aerr22[i]/apt22[i];
    apt22[i] = apt22[i]**(0.5)*(1.+0.25*qpt22[i]/0.71)**4;
    aerr22[i] = aerr22[i] = erel*apt22[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt22,qpt22,apt22,0,aerr22);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(22);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Cramer","p");

  const Int_t npt26 = 16;
  Double_t qpt26[npt26] = {.0017,   .0082,   .0097,   .0117,   .0136,   .0155,   .0175,   .0195,   .0214,   .0234, 
		       .0273,   .0389,   .0603,   .0817,   .1285,   .1557};
  Double_t apt26[npt26] = {9.3580E-01,  7.4500E-01,  7.1010E-01,  6.6590E-01,  6.2200E-01, 
			     5.9110E-01,  5.5480E-01,  5.2470E-01,  4.9720E-01,  4.6620E-01, 
			     4.1980E-01,  3.1030E-01,  1.9110E-01,  1.2410E-01,  5.3900E-02, 
			     3.5500E-02};
  Double_t aerr26[npt26] = {1.5000E-03,  2.8000E-03,  1.5000E-03,  1.6000E-03,  1.6000E-03, 
			      1.5000E-03,  1.4000E-03,  2.0000E-03,  2.2000E-03,  2.8000E-03, 
			      1.8000E-03,  1.3000E-03,  1.1000E-03,  7.0000E-04,  4.0000E-04, 
			      4.0000E-04};
  for (Int_t i=0;i<npt26;i++) {
    erel = 0.5*aerr26[i]/apt26[i];
    apt26[i] = apt26[i]**(0.5)*(1.+0.25*qpt26[i]/0.71)**4;
    aerr26[i] = erel*apt26[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt26,qpt26,apt26,0,aerr26);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(26);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Simon","p");

  const Int_t npt21 = 6;
  Double_t qpt21[npt21] = {.6569,   .7858,  1.0165,  1.1776,  1.5094,  1.7894};
  Double_t apt21[npt21] = {3.2300E-04,  1.9400E-04,  8.8300E-05,  5.1900E-05,  2.0900E-05, 9.7700E-06};
  Double_t aerr21[npt21] = {1.2900E-05,  7.9000E-06,  3.9600E-06,  2.2400E-06,  1.0200E-06, 5.5600E-07};
  for (Int_t i=0;i<npt21;i++) {
    erel = 0.5*aerr21[i]/apt21[i];
    apt21[i] = apt21[i]**(0.5)*(1.+0.25*qpt21[i]/0.71)**4;
    aerr21[i] = erel*apt21[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt21,qpt21,apt21,0,aerr21);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(21);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Abbott","p");

  const Int_t npt32 = 16;
  Double_t qpt32[npt32] = {.6929,   .8208,   .9477,  1.0758,  1.2025,  1.3308,  1.5494,  1.7794,  2.3762,  3.0392, 
			   3.4447,  3.9553,  4.4435,  4.9495,  5.3525,  5.9536};
  Double_t apt32[npt32] = {2.5600E-04,  1.5200E-04,  9.6900E-05,  6.5200E-05,  4.5600E-05, 
			     2.9600E-05,  1.5600E-05,  8.6200E-06,  1.7800E-06,  3.3200E-07, 
			     1.3500E-07,  5.2300E-08,  2.0400E-08,  7.9000E-09,  3.4600E-09, 
			     2.8500E-09};
  Double_t aerr32[npt32] = {1.5000E-05,  9.0000E-06,  5.8000E-06,  3.9000E-06,  2.7000E-06, 
			      1.8000E-06,  1.0000E-06,  5.2000E-07,  1.1000E-07,  2.6000E-08, 
			      1.2000E-08,  5.9000E-09,  3.1000E-09,  1.4100E-09,  7.5000E-10, 
			      8.1000E-10};
  for (Int_t i=0;i<npt32;i++) {
    erel = 0.5*aerr32[i]/apt32[i];
    apt32[i] = apt32[i]**(0.5)*(1.+0.25*qpt32[i]/0.71)**4;
    aerr32[i] = erel*apt32[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt32,qpt32,apt32,0,aerr32);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(32);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Alexa","p");

  const Int_t npt31 = 9;
  Double_t qpt31[npt31] = {.0019,   .0039,   .0078,   .0097,   .0117,   .0136,   .0156,   .0186,   .0195};
  Double_t apt31[npt31] = {9.2780E-01,  8.6850E-01,  7.5400E-01,  7.1120E-01,  6.6720E-01, 
			     6.2800E-01,  5.8890E-01,  5.3780E-01,  5.2430E-01};
  Double_t aerr31[npt31] = {2.9000E-03,  1.8000E-03,  2.0000E-03,  4.9000E-03,  2.5000E-03, 
			      3.5000E-03,  2.3000E-03,  2.8000E-03,  2.5000E-03};
  for (Int_t i=0;i<npt31;i++) {
    erel = 0.5*aerr31[i]/apt31[i];
    apt31[i] = apt31[i]**(0.5)*(1.+0.25*qpt31[i]/0.71)**4;
    aerr31[i] = erel*apt31[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt31,qpt31,apt31,0,aerr31);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(31);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Berard","p");

  const Int_t npt30 = 25;
  Double_t qpt30[npt30] = {.0140,   .0148,   .0151,   .0160,   .0165,   .0179,   .0189,   .0192,   .0197,   .0217, 
			   .0221,   .0222,   .0242,   .0243,   .0248,   .0265,   .0266,   .0272,   .0285,   .0304, 
			   .0308,   .0319,   .0330,   .0339,   .0347};
  Double_t apt30[npt30] = {6.2020E-01,  6.0490E-01,  6.0880E-01,  5.8170E-01,  5.6980E-01, 
			     5.4830E-01,  5.2650E-01,  5.3460E-01,  5.2410E-01,  4.9410E-01, 
			     4.8950E-01,  4.8770E-01,  4.5830E-01,  4.5050E-01,  4.4710E-01, 
			     4.2230E-01,  4.3020E-01,  4.2110E-01,  4.0080E-01,  3.7700E-01, 
			     3.7950E-01,  3.6210E-01,  3.4190E-01,  3.5480E-01,  3.3920E-01};
  Double_t aerr30[npt30] = {2.8000E-03,  2.8000E-03,  3.1000E-03,  3.5000E-03,  3.6000E-03, 
			      4.9000E-03,  4.4000E-03,  3.8000E-03,  3.6000E-03,  3.8000E-03, 
			      5.3000E-03,  4.1000E-03,  6.0000E-03,  7.3000E-03,  6.3000E-03, 
			      7.2000E-03,  5.8000E-03,  5.4000E-03,  5.1000E-03,  5.8000E-03, 
			      6.0000E-03,  7.4000E-03,  9.1000E-03,  6.0000E-03,  8.7000E-03};
  for (Int_t i=0;i<npt30;i++) {
    erel = 0.5*aerr30[i]/apt30[i];
    apt30[i] = apt30[i]**(0.5)*(1.+0.25*qpt30[i]/0.71)**4;
    aerr30[i] = erel*apt30[i];
  }
  TGraphErrors* gscaled=new TGraphErrors(npt30,qpt30,apt30,0,aerr30);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(30);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Akimov","p");
}

