#include "styling.cxx"
// #include "readRepFile.C"


void deuteron_A_calc() {
styling();
c = new TCanvas("c","Deuteron A Calcs",000,10,500,540);
plot_figure("deuteron_A_calc",gPad);
}

void plot_figure(TString fn,TPad *thePad,bool saxis=false,float ymin=1.0e-10,float ymax=1.0,bool with_d=false) {
//cout<<"wit"<<with_d<<endl;

gStyle->SetOptFit();
gStyle->SetPadTickY(1);
//gStyle->SetLogY();

gStyle->SetLineStyleString(11,"40 20");
float xmin=0,xmax=6;

thePad->cd();
thePad->SetLogy();
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
hr->SetYTitle("A");
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

TLegend *thlegend=new TLegend(0.30,0.64,0.63,0.84);
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
    Plot IMII modelfor t20
 ---------------------------------------------------------------------------------------*/
  const Int_t npt = 95;
  //Double_t x, y;
  Double_t qfm[npt];
  Double_t qsqpt[npt] = {  0.0000,  0.0004,  0.0039,  0.0389,  0.0584,  0.0779,  0.0973,  0.1168,  0.1363,  0.1558, 
			   0.1752,  0.1947,  0.2531,  0.3115,  0.3894,  0.4673,  0.5451,  0.6230,  0.7009,  0.7788, 
			   0.8566,  0.9345,  1.0124,  1.0903,  1.1681,  1.2460,  1.3239,  1.4018,  1.4796,  1.5575, 
			   1.5965,  1.6354,  1.6743,  1.7133,  1.7522,  1.8106,  1.8301,  1.8690,  1.9080,  1.9469, 
			   1.9858,  2.0248,  2.0637,  2.1026,  2.1416,  2.1805,  2.2195,  2.2584,  2.2973,  2.3363, 
			   2.3752,  2.4142,  2.4531,  2.4920,  2.5310,  2.5699,  2.6088,  2.6478,  2.6867,  2.7257, 
			   2.8035,  2.8814,  2.9593,  3.0372,  3.1150,  3.3097,  3.5044,  3.6991,  3.8938,  4.0885, 
			   4.2832,  4.4779,  4.6726,  4.8672,  5.0619,  5.2566,  5.4513,  5.6460,  5.8407,  6.0354, 
			   6.2301,  6.4248,  6.6195,  6.7168,  6.8141,  6.9115,  7.0088,  7.1062,  7.2035,  7.3009, 
			   7.3982,  7.4956,  7.5929,  7.6902,  7.7876};
  Double_t atheory[npt]   = {9.9836E-01,  9.8496E-01,  8.6423E-01,  3.0766E-01,  1.9607E-01, 
			     1.3135E-01,  9.1199E-02,  6.5059E-02,  4.7402E-02,  3.5132E-02, 
			     2.6413E-02,  2.0103E-02,  9.4313E-03,  4.7877E-03,  2.1553E-03, 
			     1.0806E-03,  5.9578E-04,  3.5638E-04,  2.2795E-04,  1.5374E-04, 
			     1.0799E-04,  7.8226E-05,  5.7990E-05,  4.3745E-05,  3.3437E-05, 
			     2.5814E-05,  2.0079E-05,  1.5704E-05,  1.2330E-05,  9.7051E-06, 
			     8.6156E-06,  7.6499E-06,  6.7938E-06,  6.0336E-06,  5.3583E-06, 
			     4.4837E-06,  4.2249E-06,  3.7506E-06,  3.3289E-06,  2.9541E-06, 
			     2.6209E-06,  2.3248E-06,  2.0618E-06,  1.8282E-06,  1.6209E-06, 
			     1.4369E-06,  1.2737E-06,  1.1290E-06,  1.0007E-06,  8.8704E-07, 
			     7.8637E-07,  6.9721E-07,  6.1827E-07,  5.4838E-07,  4.8651E-07, 
			     4.3175E-07,  3.8329E-07,  3.4037E-07,  3.0239E-07,  2.6875E-07, 
			     2.1259E-07,  1.6850E-07,  1.3384E-07,  1.0655E-07,  8.5028E-08, 
			     4.8905E-08,  2.8587E-08,  1.6983E-08,  1.0254E-08,  6.2868E-09, 
			     3.9118E-09,  2.4683E-09,  1.5767E-09,  1.0196E-09,  6.6627E-10, 
			     4.3916E-10,  2.9206E-10,  1.9572E-10,  1.3181E-10,  8.9200E-11, 
			     6.0668E-11,  4.1439E-11,  2.8340E-11,  2.3444E-11,  1.9405E-11, 
			     1.6073E-11,  1.3323E-11,  1.1053E-11,  9.1798E-12,  7.6331E-12, 
			     6.3542E-12,  5.2936E-12,  4.4145E-12,  3.6872E-12,  3.0870E-12};
//TGraph* gQGS=new TGraph("log170_89.dat","%lg %lg");
  gQGS = new TGraph(npt,qsqpt,atheory);
  gQGS->SetLineColor(kMagenta);
  gQGS->SetMarkerStyle(20);
  gQGS->SetMarkerSize(1.3);
  gQGS->SetLineStyle(11);
  gQGS->SetLineWidth(2);
gQGS->Draw("l");
thlegend->AddEntry(gQGS,"IMII","L");
/*--------------------------------------------------------------------------------------
    Plot IMII+ME modelfor t20
 ---------------------------------------------------------------------------------------*/
  Double_t atheoryme[npt] =   {1.0099E+00,  9.9641E-01,  8.7436E-01,  3.1077E-01,  1.9757E-01, 
			       1.3192E-01,  9.1246E-02,  6.4806E-02,  4.6992E-02,  3.4650E-02, 
			       2.5912E-02,  1.9616E-02,  9.0585E-03,  4.5423E-03,  2.0350E-03, 
			       1.0350E-03,  5.9079E-04,  3.7171E-04,  2.5224E-04,  1.8087E-04, 
			       1.3479E-04,  1.0318E-04,  8.0470E-05,  6.3597E-05,  5.0748E-05, 
			       4.0785E-05,  3.2953E-05,  2.6729E-05,  2.1743E-05,  1.7722E-05, 
			       1.6008E-05,  1.4463E-05,  1.3070E-05,  1.1813E-05,  1.0678E-05, 
			       9.1776E-06,  8.7261E-06,  7.8886E-06,  7.1315E-06,  6.4472E-06, 
			       5.8285E-06,  5.2693E-06,  4.7640E-06,  4.3074E-06,  3.8948E-06, 
			       3.5219E-06,  3.1851E-06,  2.8809E-06,  2.6062E-06,  2.3581E-06, 
			       2.1342E-06,  1.9319E-06,  1.7492E-06,  1.5842E-06,  1.4351E-06, 
			       1.3004E-06,  1.1788E-06,  1.0690E-06,  9.6984E-07,  8.8023E-07, 
			       7.2595E-07,  5.9965E-07,  4.9614E-07,  4.1129E-07,  3.4165E-07, 
			       2.1657E-07,  1.3873E-07,  9.0124E-08,  5.9319E-08,  3.9551E-08, 
			       2.6833E-08,  1.8510E-08,  1.2925E-08,  9.1734E-09,  6.6615E-09, 
			       4.9584E-09,  3.7751E-09,  2.9345E-09,  2.3392E-09,  1.9179E-09, 
			       1.6148E-09,  1.3885E-09,  1.2110E-09,  1.1349E-09,  1.0659E-09, 
			       1.0042E-09,  9.4920E-10,  9.0014E-10,  8.5654E-10,  8.1785E-10, 
			       7.8371E-10,  7.5343E-10,  7.2639E-10,  7.0182E-10,  6.7914E-10};
TGraph* gRNA=new TGraph(npt,qsqpt,atheoryme);
gRNA->SetLineColor(kRed);
gRNA->SetMarkerStyle(1);
gRNA->SetMarkerSize(1.3);
gRNA->SetLineStyle(11);
gRNA->SetLineWidth(3);
gRNA->Draw("l");
thlegend->AddEntry(gRNA,"IM+E II","L");
/*--------------------------------------------------------------------------------------
    Dan Phillips no rpg(f/g=0)
 ---------------------------------------------------------------------------------------*/
 const Int_t nph = 66;
 Double_t qph[nph] = {      0.0,    0.2,    0.5,    0.8,    1.0,    1.5,    2.0,    2.5,    3.0,    4.0, 
			    5.0,    6.0,    7.0,    8.0,    9.0,   10.0,   11.0,   12.0,   13.0,   14.0, 
			   15.0,   16.0,   17.0,   18.0,   19.0,   20.0,   21.0,   22.0,   23.0,   24.0, 
			   25.0,   26.0,   27.0,   28.0,   29.0,   30.0,   31.0,   32.0,   33.0,   34.0, 
			   35.0,   36.0,   37.0,   38.0,   39.0,   40.0,   41.0,   42.0,   43.0,   44.0, 
			   45.0,   47.5,   50.0,   52.5,   55.0,   57.5,   60.0,   62.5,   65.0,   70.0, 
			   75.0,   80.0,   85.0,   90.0,   95.0,  100.0};
 for (Int_t i=0;i<nph;i++) {qph[i] = qph[i]*xhbarc**2;}
 Double_t tphrpg0[nph] = {9.8463E-01,  6.9640E-01,  5.0232E-01,  3.7366E-01,  2.8636E-01, 
			  1.7957E-01,  1.1883E-01,  8.1215E-02,  5.6651E-02,  2.9055E-02, 
			  1.5951E-02,  9.2849E-03,  5.6657E-03,  3.6026E-03,  2.3675E-03, 
			  1.6212E-03,  1.1567E-03,  8.5774E-04,  6.5807E-04,  5.1941E-04, 
			  4.1924E-04,  3.3859E-04,  2.8151E-04,  2.3701E-04,  2.0160E-04, 
			  1.7290E-04,  1.4924E-04,  1.2947E-04,  1.1276E-04,  9.8470E-05, 
			  8.6134E-05,  7.3307E-05,  6.4275E-05,  5.6429E-05,  4.9628E-05, 
			  4.3717E-05,  3.8571E-05,  3.4123E-05,  3.0188E-05,  2.6736E-05, 
			  2.3700E-05,  2.0552E-05,  1.8259E-05,  1.6239E-05,  1.4457E-05, 
			  1.2885E-05,  1.1496E-05,  1.0159E-05,  9.0831E-06,  8.1286E-06, 
			  7.2839E-06,  5.5050E-06,  4.2315E-06,  3.2718E-06,  2.4719E-06, 
			  1.9298E-06,  1.5154E-06,  1.1980E-06,  9.5397E-07,  6.2173E-07, 
			  3.9782E-07,  2.7077E-07,  1.8978E-07,  1.3683E-07,  1.0132E-07, 
			  7.5019E-08};

TGraph* gph=new TGraph(nph,qph,tphrpg0);
gph->SetLineColor(9);
gph->SetMarkerStyle(1);
gph->SetMarkerSize(1.3);
gph->SetLineStyle(1);
gph->SetLineWidth(3);
gph->Draw("l");
thlegend->AddEntry(gph,"#rho#pi#gamma f/g=0","L");

 Double_t tphrpg3[nph] = {9.8463E-01,  6.9639E-01,  5.0230E-01,  3.7362E-01,  2.8631E-01, 
			  1.7952E-01,  1.1878E-01,  8.1164E-02,  5.6604E-02,  2.9025E-02, 
			  1.5930E-02,  9.2730E-03,  5.6610E-03,  3.6032E-03,  2.3726E-03, 
			  1.6295E-03,  1.1674E-03,  8.7000E-04,  6.7129E-04,  5.3311E-04, 
			  4.3307E-04,  3.5197E-04,  2.9459E-04,  2.4965E-04,  2.1372E-04, 
			  1.8443E-04,  1.6017E-04,  1.3978E-04,  1.2245E-04,  1.0754E-04, 
			  9.4612E-05,  8.1084E-05,  7.1515E-05,  6.3160E-05,  5.5882E-05, 
			  4.9525E-05,  4.3962E-05,  3.9105E-05,  3.4811E-05,  3.1024E-05, 
			  2.7678E-05,  2.4201E-05,  2.1645E-05,  1.9381E-05,  1.7375E-05, 
			  1.5594E-05,  1.4012E-05,  1.2485E-05,  1.1246E-05,  1.0140E-05, 
			  9.1556E-06,  7.1429E-06,  5.6050E-06,  4.4273E-06,  3.4344E-06, 
			  2.7440E-06,  2.2062E-06,  1.7864E-06,  1.4570E-06,  1.0231E-06, 
			  6.9348E-07,  4.9496E-07,  3.6235E-07,  2.7155E-07,  2.0786E-07, 
			  1.5944E-07};

 //TGraph* gph3=new TGraph(nph,qph,tphrpg3);
//gph3->SetLineColor(39);
//gph3->SetMarkerStyle(1);
//gph3->SetMarkerSize(1.3);
//gph3->SetLineStyle(2);
//gph3->SetLineWidth(2);

//TPaveLabel * Label = new TPaveLabel(0.26,0.27,0.48,0.33,"Propagator f/g=3","NDC");
//Label->SetTextSize(0.6);
//Label->SetLineColor(kWhite);
//Label->SetFillColor(kWhite);
//Label->SetTextColor(39);
//Label->SetBorderSize(0);
//Label->Draw();
//gph3->Draw("l");

 Double_t tphrpg6[nph] = {9.8463E-01,  6.9639E-01,  5.0227E-01,  3.7358E-01,  2.8626E-01, 
			  1.7947E-01,  1.1873E-01,  8.1112E-02,  5.6556E-02,  2.8995E-02, 
			  1.5910E-02,  9.2611E-03,  5.6566E-03,  3.6045E-03,  2.3785E-03, 
			  1.6388E-03,  1.1791E-03,  8.8334E-04,  6.8563E-04,  5.4796E-04, 
			  4.4805E-04,  3.6649E-04,  3.0878E-04,  2.6338E-04,  2.2690E-04, 
			  1.9700E-04,  1.7209E-04,  1.5104E-04,  1.3305E-04,  1.1750E-04, 
			  1.0393E-04,  8.9661E-05,  7.9520E-05,  7.0623E-05,  6.2834E-05, 
			  5.5997E-05,  4.9987E-05,  4.4689E-05,  4.0007E-05,  3.5860E-05, 
			  3.2177E-05,  2.8345E-05,  2.5503E-05,  2.2973E-05,  2.0721E-05, 
			  1.8712E-05,  1.6918E-05,  1.5183E-05,  1.3763E-05,  1.2489E-05, 
			  1.1349E-05,  9.0941E-06,  7.2572E-06,  5.8310E-06,  4.6180E-06, 
			  3.7557E-06,  3.0737E-06,  2.5330E-06,  2.1020E-06,  1.5556E-06, 
			  1.0950E-06,  8.0523E-07,  6.0521E-07,  4.6392E-07,  3.6188E-07, 
			  2.8310E-07};

 TGraph* gph6=new TGraph(nph,qph,tphrpg6);
gph6->SetLineColor(49);
gph6->SetMarkerStyle(1);
gph6->SetMarkerSize(1.3);
gph6->SetLineStyle(1);
gph6->SetLineWidth(2);
gph6->Draw("l");
thlegend->AddEntry(gph6,"#rho#pi#gamma f/g=6.1","L");

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
 Set the A values
*******************************************************************/
  const Int_t npt24 = 5;
  Double_t qpt24[npt24] = {.2337,   .2725,   .3113,   .4671,   .7785};
  Double_t t20pt24[npt24] = {9.1800E-03,  5.7100E-03,  3.6300E-03,  8.9500E-04,  1.7100E-04};
  Double_t t20err24[npt24] = {5.3200E-04,  3.2000E-04,  1.8200E-04,  1.0700E-04,  4.3900E-05};  
  TGraphErrors* gscaled=new TGraphErrors(npt24,qpt24,t20pt24,0,t20err24);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(24);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Buchanan","p");

  const Int_t npt29 = 18;
  Double_t qpt29[npt29] = {.5731,   .6003,   .6256,   .6486,   .6730,   .7035,   .7312,   .7598,   .7914,   .8194, 
			   .8493,   .8790,   .9100,   .9438,   .9880,  1.0676,  1.2029,  1.3276};
  Double_t t20pt29[npt29] = {4.2880E-04,  4.5600E-04,  3.5750E-04,  2.8080E-04,  2.7600E-04, 
			     2.1660E-04,  1.5750E-04,  1.9260E-04,  1.5880E-04,  1.3020E-04, 
			     1.1290E-04,  9.3300E-05,  1.0810E-04,  7.0100E-05,  6.7500E-05, 
			     4.3800E-05,  5.4000E-05,  2.5700E-05};
  Double_t t20err29[npt29] = {3.6900E-05,  4.1500E-05,  3.4000E-05,  2.5300E-05,  2.5800E-05, 
			      2.1100E-05,  1.7900E-05,  2.0600E-05,  1.8700E-05,  1.4800E-05, 
			      1.4700E-05,  1.5000E-05,  1.8700E-05,  1.7600E-05,  1.6200E-05, 
			      1.6700E-05,  1.4900E-05,  1.3400E-05};
  TGraphErrors* gscaled=new TGraphErrors(npt29,qpt29,t20pt29,0,t20err29);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(29);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Elias","p");
 
  const Int_t npt25 = 4;
  Double_t qpt25[npt25] = {.1168,   .1557,   .1946,   .2335};
  Double_t t20pt25[npt25] = {6.7600E-02,  3.2400E-02,  1.8000E-02,  1.0500E-02};
  Double_t t20err25[npt25] = {1.8000E-03,  1.0000E-03,  6.0000E-04,  2.0000E-03};
  TGraphErrors* gscaled=new TGraphErrors(npt25,qpt25,t20pt25,0,t20err25);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(25);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Benaksas","p");

  const Int_t npt28 = 8;
  Double_t qpt28[npt28] = {.7999,   .9998,  1.4997,  1.7495,  1.9995,  2.4994,  2.9995,  3.9993};
  Double_t t20pt28[npt28] = {2.3100E-04,  8.9500E-05,  2.0400E-05,  9.0500E-06,  4.7400E-06, 
			 1.4300E-06,  5.0200E-07,  5.1200E-08};
  Double_t t20err28[npt28] = {2.2000E-05,  7.7000E-06,  1.6000E-06,  7.8000E-07,  3.7000E-07, 
			  1.4000E-07,  5.5000E-08,  1.1600E-08};
  TGraphErrors* gscaled=new TGraphErrors(npt28,qpt28,t20pt28,0,t20err28);
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
  Double_t t20pt23[npt23] = {5.4550E-01,  4.1479E-01,  3.1069E-01,  2.3870E-01,  1.7780E-01, 
			     1.3999E-01,  1.1270E-01,  9.1450E-02,  7.8520E-02,  6.6330E-02, 
			     4.6976E-01,  3.7430E-01,  2.9537E-01,  1.8582E-01,  1.1395E-01, 
			     7.2490E-02,  4.8440E-02,  3.2329E-02,  2.2820E-02,  1.1088E-01, 
			     7.0144E-02,  4.4780E-02,  2.8738E-02,  1.8564E-02,  1.2465E-02, 
			     8.4210E-03,  5.7433E-03,  4.1691E-03,  3.1510E-03,  2.3429E-03, 
			     3.9279E-02,  2.0715E-02,  1.1644E-02,  8.9040E-03,  6.7303E-03, 
			     5.0284E-03,  3.9579E-03,  2.4130E-03,  1.5620E-03,  1.0380E-03, 
			     5.4030E-04,  3.4989E-04,  2.3346E-04};
  Double_t t20err23[npt23] = {9.2730E-03,  7.4660E-03,  5.5920E-03,  4.5350E-03,  3.3780E-03, 
			      2.3800E-03,  2.2530E-03,  2.0110E-03,  2.0410E-03,  1.9230E-03, 
			      7.0460E-03,  6.3630E-03,  4.4300E-03,  2.7870E-03,  1.7090E-03, 
			      1.2320E-03,  8.7190E-04,  6.1420E-04,  5.0200E-04,  1.6630E-03, 
			      1.0520E-03,  8.5080E-04,  4.3100E-04,  2.7840E-04,  1.8690E-04, 
			      1.5990E-04,  9.3140E-05,  6.7040E-05,  8.1920E-05,  7.0290E-05, 
			      6.6770E-04,  3.1070E-04,  1.7460E-04,  1.6910E-04,  1.0090E-04, 
			      7.5420E-05,  5.9360E-05,  5.0670E-05,  3.5920E-05,  2.9060E-05, 
			      1.8370E-05,  1.5740E-05,  1.1860E-05};
  TGraphErrors* gscaled=new TGraphErrors(npt23,qpt23,t20pt23,0,t20err23);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(23);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Platchkov","p");

  const Int_t npt27 = 10;
  Double_t qpt27[npt27] = {.2398,   .2569,   .2740,   .2920,   .3797,   .4244,   .4293,   .4556,   .4834,   .5062};
  Double_t t20pt27[npt27] = {9.8600E-03,  7.5700E-03,  6.4000E-03,  5.3900E-03,  2.0500E-03, 
			     1.4900E-03,  1.2870E-03,  1.0770E-03,  9.2600E-04,  7.7900E-04};
  Double_t t20err27[npt27] = {5.0000E-04,  4.5000E-04,  4.1000E-04,  3.8000E-04,  1.5000E-04, 
			      1.2000E-04,  8.0000E-05,  6.0000E-05,  6.8000E-05,  6.3000E-05};
  TGraphErrors* gscaled=new TGraphErrors(npt27,qpt27,t20pt27,0,t20err27);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(27);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Galster","p");

  const Int_t npt22 = 5;
  Double_t qpt22[npt22] = {.4997,   .5997,   .7799,   .9998,  1.2996};
  Double_t t20pt22[npt22] = {7.7900E-04,  4.6300E-04,  1.7700E-04,  7.1000E-05,  1.7700E-05};
  Double_t t20err22[npt22] = {3.4000E-05,  4.5000E-05,  7.0000E-06,  2.1000E-06,  2.6000E-06};
  TGraphErrors* gscaled=new TGraphErrors(npt22,qpt22,t20pt22,0,t20err22);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(22);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Cramer","p");

  const Int_t npt26 = 16;
  Double_t qpt26[npt26] = {.0017,   .0082,   .0097,   .0117,   .0136,   .0155,   .0175,   .0195,   .0214,   .0234, 
		       .0273,   .0389,   .0603,   .0817,   .1285,   .1557};
  Double_t t20pt26[npt26] = {9.3580E-01,  7.4500E-01,  7.1010E-01,  6.6590E-01,  6.2200E-01, 
			     5.9110E-01,  5.5480E-01,  5.2470E-01,  4.9720E-01,  4.6620E-01, 
			     4.1980E-01,  3.1030E-01,  1.9110E-01,  1.2410E-01,  5.3900E-02, 
			     3.5500E-02};
  Double_t t20err26[npt26] = {1.5000E-03,  2.8000E-03,  1.5000E-03,  1.6000E-03,  1.6000E-03, 
			      1.5000E-03,  1.4000E-03,  2.0000E-03,  2.2000E-03,  2.8000E-03, 
			      1.8000E-03,  1.3000E-03,  1.1000E-03,  7.0000E-04,  4.0000E-04, 
			      4.0000E-04};
  TGraphErrors* gscaled=new TGraphErrors(npt26,qpt26,t20pt26,0,t20err26);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(26);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Simon","p");

  const Int_t npt21 = 6;
  Double_t qpt21[npt21] = {.6569,   .7858,  1.0165,  1.1776,  1.5094,  1.7894};
  Double_t t20pt21[npt21] = {3.2300E-04,  1.9400E-04,  8.8300E-05,  5.1900E-05,  2.0900E-05, 9.7700E-06};
  Double_t t20err21[npt21] = {1.2900E-05,  7.9000E-06,  3.9600E-06,  2.2400E-06,  1.0200E-06, 5.5600E-07};
  TGraphErrors* gscaled=new TGraphErrors(npt21,qpt21,t20pt21,0,t20err21);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(21);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Abbott","p");

  const Int_t npt32 = 16;
  Double_t qpt32[npt32] = {.6929,   .8208,   .9477,  1.0758,  1.2025,  1.3308,  1.5494,  1.7794,  2.3762,  3.0392, 
			   3.4447,  3.9553,  4.4435,  4.9495,  5.3525,  5.9536};
  Double_t t20pt32[npt32] = {2.5600E-04,  1.5200E-04,  9.6900E-05,  6.5200E-05,  4.5600E-05, 
			     2.9600E-05,  1.5600E-05,  8.6200E-06,  1.7800E-06,  3.3200E-07, 
			     1.3500E-07,  5.2300E-08,  2.0400E-08,  7.9000E-09,  3.4600E-09, 
			     2.8500E-09};
  Double_t t20err32[npt32] = {1.5000E-05,  9.0000E-06,  5.8000E-06,  3.9000E-06,  2.7000E-06, 
			      1.8000E-06,  1.0000E-06,  5.2000E-07,  1.1000E-07,  2.6000E-08, 
			      1.2000E-08,  5.9000E-09,  3.1000E-09,  1.4100E-09,  7.5000E-10, 
			      8.1000E-10};
  TGraphErrors* gscaled=new TGraphErrors(npt32,qpt32,t20pt32,0,t20err32);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(32);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Alexa","p");

  const Int_t npt31 = 9;
  Double_t qpt31[npt31] = {.0019,   .0039,   .0078,   .0097,   .0117,   .0136,   .0156,   .0186,   .0195};
  Double_t t20pt31[npt31] = {9.2780E-01,  8.6850E-01,  7.5400E-01,  7.1120E-01,  6.6720E-01, 
			     6.2800E-01,  5.8890E-01,  5.3780E-01,  5.2430E-01};
  Double_t t20err31[npt31] = {2.9000E-03,  1.8000E-03,  2.0000E-03,  4.9000E-03,  2.5000E-03, 
			      3.5000E-03,  2.3000E-03,  2.8000E-03,  2.5000E-03};
  TGraphErrors* gscaled=new TGraphErrors(npt31,qpt31,t20pt31,0,t20err31);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(31);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Berard","p");

  const Int_t npt30 = 25;
  Double_t qpt30[npt30] = {.0140,   .0148,   .0151,   .0160,   .0165,   .0179,   .0189,   .0192,   .0197,   .0217, 
			   .0221,   .0222,   .0242,   .0243,   .0248,   .0265,   .0266,   .0272,   .0285,   .0304, 
			   .0308,   .0319,   .0330,   .0339,   .0347};
  Double_t t20pt30[npt30] = {6.2020E-01,  6.0490E-01,  6.0880E-01,  5.8170E-01,  5.6980E-01, 
			     5.4830E-01,  5.2650E-01,  5.3460E-01,  5.2410E-01,  4.9410E-01, 
			     4.8950E-01,  4.8770E-01,  4.5830E-01,  4.5050E-01,  4.4710E-01, 
			     4.2230E-01,  4.3020E-01,  4.2110E-01,  4.0080E-01,  3.7700E-01, 
			     3.7950E-01,  3.6210E-01,  3.4190E-01,  3.5480E-01,  3.3920E-01};
  Double_t t20err30[npt30] = {2.8000E-03,  2.8000E-03,  3.1000E-03,  3.5000E-03,  3.6000E-03, 
			      4.9000E-03,  4.4000E-03,  3.8000E-03,  3.6000E-03,  3.8000E-03, 
			      5.3000E-03,  4.1000E-03,  6.0000E-03,  7.3000E-03,  6.3000E-03, 
			      7.2000E-03,  5.8000E-03,  5.4000E-03,  5.1000E-03,  5.8000E-03, 
			      6.0000E-03,  7.4000E-03,  9.1000E-03,  6.0000E-03,  8.7000E-03};
  TGraphErrors* gscaled=new TGraphErrors(npt30,qpt30,t20pt30,0,t20err30);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(30);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Akimov","p");
}

