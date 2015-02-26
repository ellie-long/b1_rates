#include "styling.cxx"
// #include "readRepFile.C"


void deuteron_t20() {
styling();
c = new TCanvas("c","Deuteron T_20",000,10,700,540);
plot_figure("deuteron_t20",gPad);
}

void plot_figure(TString fn,TPad *thePad,bool saxis=true,float ymin=-2.0,float ymax=1.0,bool with_d=false) {
//cout<<"wit"<<with_d<<endl;

gStyle->SetOptFit();
gStyle->SetPadTickY(1);

gStyle->SetLineStyleString(11,"40 20");
float xmin=0,xmax=9;

thePad->cd();
//thePad->SetGrid();

/*****************************************************
 Colors
*****************************************************/
int HRMcol=kRed+2;
int RNAcol=kMagenta;
int QGScol=kGreen+1;

float kb2b=1000;
Double_t x,y;
/*****************************************************
 Format the pad
*****************************************************/

thePad->SetTopMargin(0.15);
TH1F *hr = thePad->DrawFrame(xmin,ymin,xmax,ymax);
hr->SetXTitle("Q (fm^{-1})");
hr->SetYTitle("T_{20}");
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
TLegend *legend=new TLegend(0.66,0.22,0.95,0.56);
legend->SetMargin(0.2);
legend->SetTextFont(72);
legend->SetTextSize(0.035);
legend->SetFillStyle(0);
legend->SetBorderSize(0);

legend->Draw();

thePad->SetLeftMargin(0.19);
/*****************************************************
  Draw top axis
*****************************************************/
float titlex1=0.47, titley1=0.85,titlex2=0.56,titley2=0.95;

if (saxis) {
  titley1=0.72;titley2=0.82;
  TGaxis *axispp = new TGaxis(thePad->GetUxmin(),thePad->GetUymax()*1,
		 thePad->GetUxmax(),
		 thePad->GetUymax()*1,
		 xmin*0.1973,
		 xmax*0.1973,510,"-R");
  axispp->SetTitle("Q (GeV)");
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
    Generate theory curves
---------------------------------------------------------------------------------------*/
 const Int_t narr = 140.;
  Int_t n = narr;
  float xqsq[narr], a[narr], b[narr], t20[narr], boa[narr];
  float a0[narr], b0[narr], t200[narr], boa0[narr];
  float xinfm[narr];
  Double_t xmd = 1.875613;
  Double_t xmdsq = xmd*xmd;
  Double_t q0sq = 1.15;
  Double_t degr = 0.01745329252;
  Double_t qsqmin = 0.5;
  Double_t qsqstep = 0.02;
  Double_t qsq = qsqmin - qsqstep;
  for (Int_t i=0;i<n;i++) {
    qsq = qsq+qsqstep;
    xqsq[i] = qsq;
    xinfm[i] = xqsq[i]**(0.5)/0.1973;
    Double_t eta = qsq / (4.*xmd**2);
    Double_t gc  = (6.*xmdsq+5.*q0sq)/(6.*xmdsq-3.*q0sq) - (2./3.)*eta;
    Double_t gm  = (2.*eta-1.)*q0sq/(eta*(2.*xmdsq-q0sq)) + 1.;
    Double_t gq  = q0sq/(eta*(2.*xmdsq-q0sq)) - 1.;
    a[i]   = gc**2 + (2./3.)*eta*gm**2 + (8./9.)*(eta*gq)**2;
    b[i]   = (4./3.)*eta*(1.+eta)*gm*gm;
    boa[i] = log(b[i]/a[i]);
    Double_t tth = (tan(35.*degr))**2;
    t20[i] = (8./9.)*(eta*gq)**2 + (8./3.)*eta*gc*gq + (2./3.)*eta*gm**2*(0.1+(1+eta)*tth);
    t20[i] = t20[i] / (1.414*(a[i]+b[i]*tth));
    gc      = 1.-(2./3.)*eta;
    gm      = 2.;
    gq      = -1.;
    a0[i]   = gc**2 + (2./3.)*eta*gm**2 + (8./9.)*(eta*gq)**2;
    b0[i]   = (4./3.)*eta*(1.+eta)*gm*gm;
    boa0[i] = log(b[i]/a[i]);
    t200[i] = (8./9.)*(eta*gq)**2 + (8./3.)*eta*gc*gq + (2./3.)*eta*gm**2*(0.1+(1+eta)*tth);
    t200[i] = t200[i] / (1.414*(a0[i]+b0[i]*tth));
  }
/*--------------------------------------------------------------------------------------
    Plot QGS model -> KS curve for t20
 ---------------------------------------------------------------------------------------*/
//TGraph* gQGS=new TGraph("log170_89.dat","%lg %lg");
  gQGS = new TGraph(n,xinfm,t20);
  gQGS->SetLineColor(QGScol);
  gQGS->SetMarkerStyle(20);
  gQGS->SetMarkerSize(1.3);
  gQGS->SetLineStyle(11);
  gQGS->SetLineWidth(2);

TPaveLabel * Label = new TPaveLabel(0.38,0.67,0.55,0.74,"KS","NDC");
Label->SetTextSize(0.6);
Label->SetLineColor(kWhite);
Label->SetFillColor(kWhite);
Label->SetTextColor(QGScol);
Label->SetBorderSize(0);
Label->Draw();

gQGS->Draw("l");
/*--------------------------------------------------------------------------------------
    Plot RNA model -> cg estimate
---------------------------------------------------------------------------------------*/
 TGraph* gRNA=new TGraph(n,xinfm,t200);
gRNA->SetLineColor(RNAcol);
gRNA->SetMarkerStyle(1);
gRNA->SetMarkerSize(1.3);
gRNA->SetLineStyle(9);
gRNA->SetLineWidth(2);

TPaveLabel * Label = new TPaveLabel(0.37,0.55,0.55,0.61,"CG","NDC");
Label->SetTextSize(0.6);
Label->SetLineColor(kWhite);
Label->SetFillColor(kWhite);
Label->SetTextColor(kMagenta);
Label->SetBorderSize(0);
Label->Draw();
gRNA->Draw("l");
/*--------------------------------------------------------------------------------------
    put line at -root(2)
---------------------------------------------------------------------------------------*/
n = 2;
float xfm[2] = {0., 9.};
float yt20[2] = {0., 0.}; 
TGraph* g0=new TGraph(n,xfm,yt20);
g0->SetLineColor(1);
g0->SetMarkerStyle(1);
g0->SetMarkerSize(1.3);
g0->SetLineStyle(1);
g0->SetLineWidth(1);
g0->Draw("l");
yt20[0] = -1.*2**(0.5);
yt20[1] = yt20[0];
TGraph* g1=new TGraph(n,xfm,yt20);
g1->SetLineColor(1);
g1->SetMarkerStyle(1);
g1->SetMarkerSize(1.3);
g1->SetLineStyle(3);
g1->SetLineWidth(1);
g1->Draw("l");

/*  sanity checks
plots11dsdtSet(100,0.040,0.020,0.05,0.000,0.140,kBlack,legend,"E03-101 140 MeV Bins Pn< 100 Mev/c 80 mr X 40 mr");
*/

/*  PRL */
//plotSet(kBlue,legend,"T_{20}");
//plotSet(kBlue,legend,"");
plotSet(kBlue,legend,"");
//plots11dsdtSet(kBlue,legend,"");


/*****************************************************
 Add the rest of the legend enteries
*****************************************************/

//if(!with_d){
//legend->AddEntry(gQGS,"QGS","l");
//legend->AddEntry(gRNA,"RNA","l");
//legend->AddEntry(gHRM,"HRM","F");
//};
gStyle->SetPaperSize(20,26);  //default
//TPaveLabel *label = new TPaveLabel(0.5,0.4,0.85,0.5,"Preliminary","NDC");
//label->SetTextColor(kBlue);
//label->Draw();
//cout<<with_d<<endl;
c->SaveAs(fn+".pdf");
c->SaveAs(fn+".eps");
c->SaveAs(fn+".png");
}

void plotSet(int col,TLegend* legend,char* title="") {
/*******************************************************************
 Set the t20 values
*******************************************************************/
  const Int_t npt24 = 1;
  Double_t qpt24[1] = {0.86};
  Double_t t20pt24[1] = {-0.30};
  Double_t t20err24[1] = {0.16};
  TGraphErrors* gscaled=new TGraphErrors(npt24,qpt24,t20pt24,0,t20err24);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(24);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Dmitriev","p");

  const Int_t npt29 = 1;
  Double_t qpt29[1] = {1.15};
  Double_t t20pt29[1] = {-0.181};
  Double_t t20err29[1] = {0.070};
  TGraphErrors* gscaled=new TGraphErrors(npt29,qpt29,t20pt29,0,t20err29);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(29);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  //  legend->AddEntry(gscaled,"Wojtsekhowski","p");
  legend->AddEntry(gscaled,"Voitsekhovskii","p");

  const Int_t npt25 = 1;
  Double_t qpt25[1] = {1.58};
  Double_t t20pt25[1] = {-0.400};
  Double_t t20err25[1] = {0.037};
  TGraphErrors* gscaled=new TGraphErrors(npt25,qpt25,t20pt25,0,t20err25);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(25);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Ferro-Luzzi","p");

  const Int_t npt28 = 2;
  Double_t qpt28[2] = {1.74, 2.03};
  Double_t t20pt28[2] = {-0.420, -0.590};
  Double_t t20err28[2] = {0.060, 0.130};
  TGraphErrors* gscaled=new TGraphErrors(npt28,qpt28,t20pt28,0,t20err28);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(28);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Schulze","p");

  const Int_t npt23 = 3;
  Double_t qpt23[3] = {2.026, 2.352, 2.788};
  Double_t t20pt23[3] = {-0.713, -0.896, -1.334};
  Double_t t20err23[3] = {0.090, 0.093, 0.233};
  TGraphErrors* gscaled=new TGraphErrors(npt23,qpt23,t20pt23,0,t20err23);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(23);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Bowhuis","p");

  const Int_t npt27 = 2;
  Double_t qpt27[2] = {2.49, 2.93};
  Double_t t20pt27[2] = {-0.751, -1.255};
  Double_t t20err27[2] = {0.153, 0.299};
  TGraphErrors* gscaled=new TGraphErrors(npt27,qpt27,t20pt27,0,t20err27);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(27);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Gilman","p");

  const Int_t npt22 = 1;
  Double_t qpt22[1] = {3.566};
  Double_t t20pt22[1] = {-1.87};
  Double_t t20err22[1] = {1.04};
  TGraphErrors* gscaled=new TGraphErrors(npt22,qpt22,t20pt22,0,t20err22);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(22);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Boden","p");

  const Int_t npt26 = 3;
  Double_t qpt26[3] = {3.78, 4.22, 4.62};
  Double_t t20pt26[3] = {-1.278, -0.833, -0.411};
  Double_t t20err26[3] = {0.186, 0.153, 0.187};
  TGraphErrors* gscaled=new TGraphErrors(npt26,qpt26,t20pt26,0,t20err26);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(26);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Garcon","p");

  const Int_t npt21 = 6;
  Double_t qpt21[6] = {4.09, 4.46, 5.09, 5.47, 6.15, 6.64};
  Double_t t20pt21[6] = {-0.534, -0.324, 0.178, 0.292, 0.621, 0.476};
  Double_t t20err21[6] = {0.163, 0.089, 0.053, 0.073, 0.168, 0.189};
  TGraphErrors* gscaled=new TGraphErrors(npt21,qpt21,t20pt21,0,t20err21);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(21);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Abbott","p");

  const Int_t npt30 = 6;
  Double_t qpt30[6] = {2.90, 3.143, 3.432, 3.808, 4.204, 4.64};
  Double_t t20pt30[6] = {-1.294, -1.398, -1.384, -0.982, -0.818, 0.557};
  Double_t t20err30[6] = {0.122, 0.137, 0.137, 0.181, 0.275, 0.345};
  TGraphErrors* gscaled=new TGraphErrors(npt30,qpt30,t20pt30,0,t20err30);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(30);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Nikolenko","p");

  //  const Int_t npt = 26;
  //  Double_t qpt[npt] = {0.86, 1.15, 1.58, 1.74, 2.026, 2.03, 2.352, 2.49, 2.788, 2.90 2.93, 3.143, 3.432
  //		       3.566, 3.78, 3.808, 4.09, 4.204, 4.22, 4.46, 4.62, 4.64, 5.09, 5.47, 6.15, 6.64};
  //  Double_t t20pt[npt] = {-0.30, -0.181, -0.400, -0.420, -0.713, -0.590, -0.896, -0.751, -1.334, -1.294, -1.255, -1.398, -1.384
  //			 -1.87, -1.278, -0.982, -0.534, -0.818, -0.833, -0.324, -0.411, 0.557, 0.178, 0.292, 0.621, 0.476};
  //  Double_t t20err[npt] = {0.16, 0.070, 0.037, 0.060, 0.090, 0.130, 0.093, 0.153, 0.233, 0.122, 0.299, 0.137, 0.137
  //			  1.04,	0.186, 0.181, 0.163, 0.275 0.153, 0.089, 0.187, 0.345, 0.053, 0.073, 0.168, 0.189};
  //  for (Int_t i=0;i<npt;i++) {
  //    qpt[i] = (qpt[i]*0.1973)**2;
  //  }

  //  TGraphErrors* gscaled=new TGraphErrors(npt,qpt,t20pt,0,t20err);
  //  gscaled->SetMarkerColor(col);
  //  gscaled->SetMarkerStyle(4);
  //  gscaled->SetMarkerSize(1.1);
  //  gscaled->Draw("P");
  //  if(title!="") legend->AddEntry(gscaled,title,"p");
}

