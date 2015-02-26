#include "styling.cxx"
// #include "readRepFile.C"


void deuteron_B_calc() {
styling();
c = new TCanvas("c","Deuteron B Calcs",000,10,500,540);
plot_figure("deuteron_B_calc",gPad);
}

void plot_figure(TString fn,TPad *thePad,bool saxis=false,float ymin=1.0e-10,float ymax=1.0e-02,bool with_d=false) {
//cout<<"wit"<<with_d<<endl;

gStyle->SetOptFit();
gStyle->SetPadTickY(1);
//gStyle->SetLogY();

gStyle->SetLineStyleString(11,"40 20");
float xmin=0,xmax=4;

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
hr->SetYTitle("B");
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
TLegend *legend=new TLegend(0.66,0.64,0.93,0.84);
legend->SetMargin(0.2);
legend->SetTextFont(72);
legend->SetTextSize(0.035);
legend->SetFillStyle(0);
legend->SetBorderSize(0);
legend->Draw();

TLegend *thlegend=new TLegend(0.33,0.64,0.66,0.84);
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
    Plot IMII modelfor B
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
  Double_t atheory[npt]   = { 1.0710E-05,  1.0574E-04,  9.3420E-04,  3.5050E-03,  3.4115E-03, 
			      3.0845E-03,  2.6987E-03,  2.3221E-03,  1.9803E-03,  1.6807E-03, 
			      1.4229E-03,  1.2034E-03,  7.2925E-04,  4.4651E-04,  2.3739E-04, 
			      1.2959E-04,  7.2494E-05,  4.1431E-05,  2.4107E-05,  1.4229E-05, 
			      8.4877E-06,  5.0970E-06,  3.0687E-06,  1.8439E-06,  1.0999E-06, 
			      6.4724E-07,  3.7264E-07,  2.0753E-07,  1.0994E-07,  5.3905E-08, 
			      3.6143E-08,  2.3248E-08,  1.4106E-08,  7.8561E-09,  3.8096E-09, 
			      7.1157E-10,  2.6517E-10,  7.6047E-12,  3.8643E-10,  1.1987E-09, 
			      2.2880E-09,  3.5354E-09,  4.8498E-09,  6.1665E-09,  7.4371E-09, 
			      8.6270E-09,  9.7149E-09,  1.0688E-08,  1.1537E-08,  1.2263E-08, 
			      1.2867E-08,  1.3352E-08,  1.3726E-08,  1.3996E-08,  1.4171E-08, 
			      1.4259E-08,  1.4270E-08,  1.4209E-08,  1.4089E-08,  1.3914E-08, 
			      1.3434E-08,  1.2822E-08,  1.2120E-08,  1.1364E-08,  1.0584E-08, 
			      8.6526E-09,  6.8980E-09,  5.4000E-09,  4.1725E-09,  3.1908E-09, 
			      2.4208E-09,  1.8250E-09,  1.3673E-09,  1.0200E-09,  7.5739E-10, 
			      5.5948E-10,  4.1182E-10,  3.0194E-10,  2.2009E-10,  1.5958E-10, 
			      1.1516E-10,  8.2658E-11,  5.8806E-11,  4.9418E-11,  4.1436E-11, 
			      3.4661E-11,  2.8921E-11,  2.4066E-11,  1.9968E-11,  1.6516E-11, 
			      1.3608E-11,  1.1156E-11,  9.0935E-12,  7.3668E-12,  5.9294E-12};
//TGraph* gQGS=new TGraph("log170_89.dat","%lg %lg");
  gQGS = new TGraph(npt,qsqpt,atheory);
  gQGS->SetLineColor(kMagenta);
  gQGS->SetMarkerStyle(20);
  gQGS->SetMarkerSize(1.3);
  gQGS->SetLineStyle(11);
  gQGS->SetLineWidth(2);
  //TPaveLabel * Label = new TPaveLabel(0.74,0.24,0.84,0.30,"IMII","NDC");
  //Label->SetTextSize(0.6);
  //Label->SetLineColor(kWhite);
  //Label->SetFillColor(kWhite);
  //Label->SetTextColor(kMagenta);
  //Label->SetBorderSize(0);
  //Label->Draw();
gQGS->Draw("l");
thlegend->AddEntry(gQGS,"IMII","L");
/*--------------------------------------------------------------------------------------
    Plot IMII+ME modelfor B
 ---------------------------------------------------------------------------------------*/
  Double_t atheoryme[npt] =   { 1.0806E-05,  1.0669E-04,  9.4299E-04,  3.5533E-03,  3.4668E-03, 
				3.1422E-03,  2.7561E-03,  2.3777E-03,  2.0331E-03,  1.7302E-03, 
				1.4689E-03,  1.2459E-03,  7.6183E-04,  4.7094E-04,  2.5382E-04, 
				1.4061E-04,  7.9917E-05,  4.6454E-05,  2.7523E-05,  1.6562E-05, 
				1.0086E-05,  6.1936E-06,  3.8206E-06,  2.3582E-06,  1.4498E-06, 
				8.8327E-07,  5.2973E-07,  3.1019E-07,  1.7528E-07,  9.3887E-08, 
				6.6801E-08,  4.6325E-08,  3.1059E-08,  1.9921E-08,  1.1991E-08, 
				4.6073E-09,  3.0706E-09,  1.0502E-09,  1.3882E-10,  4.4654E-11, 
				5.3635E-10,  1.4329E-09,  2.5922E-09,  3.9043E-09,  5.2841E-09, 
				6.6632E-09,  8.0019E-09,  9.2634E-09,  1.0425E-08,  1.1476E-08, 
				1.2409E-08,  1.3215E-08,  1.3893E-08,  1.4448E-08,  1.4882E-08, 
				1.5208E-08,  1.5432E-08,  1.5567E-08,  1.5619E-08,  1.5596E-08, 
				1.5350E-08,  1.4883E-08,  1.4254E-08,  1.3528E-08,  1.2744E-08, 
				1.0662E-08,  8.6328E-09,  6.8749E-09,  5.3894E-09,  4.1719E-09, 
				3.2238E-09,  2.4857E-09,  1.9002E-09,  1.4523E-09,  1.1197E-09, 
				8.7045E-10,  6.7932E-10,  5.3066E-10,  4.1792E-10,  3.3449E-10, 
				2.7250E-10,  2.2493E-10,  1.8672E-10,  1.7020E-10,  1.5532E-10, 
				1.4219E-10,  1.3070E-10,  1.2068E-10,  1.1198E-10,  1.0447E-10, 
				9.8023E-11,  9.2442E-11,  8.7575E-11,  8.3244E-11,  7.9331E-11};
TGraph* gRNA=new TGraph(npt,qsqpt,atheoryme);
gRNA->SetLineColor(kRed);
gRNA->SetMarkerStyle(1);
gRNA->SetMarkerSize(1.3);
gRNA->SetLineStyle(11);
gRNA->SetLineWidth(3);

//TPaveLabel * Label = new TPaveLabel(0.72,0.34,0.89,0.40,"IM+E II","NDC");
//Label->SetTextSize(0.6);
//Label->SetLineColor(kWhite);
//Label->SetFillColor(kWhite);
//Label->SetTextColor(kRed);
//Label->SetBorderSize(0);
//Label->Draw();
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
 Double_t tphrpg0[nph] = { 1.0947E-04,  1.9851E-03,  2.9335E-03,  3.3468E-03,  3.4916E-03, 
			   3.4072E-03,  3.1031E-03,  2.7207E-03,  2.3330E-03,  1.6663E-03, 
			   1.1822E-03,  8.4372E-04,  6.0546E-04,  4.3536E-04,  3.1518E-04, 
			   2.3030E-04,  1.6981E-04,  1.2638E-04,  9.4826E-05,  7.1682E-05, 
			   5.4533E-05,  4.1635E-05,  3.1895E-05,  2.4516E-05,  1.8919E-05, 
			   1.4661E-05,  1.1401E-05,  8.8907E-06,  6.9517E-06,  5.4487E-06, 
			   4.2756E-06,  3.3572E-06,  2.6366E-06,  2.0698E-06,  1.6242E-06, 
			   1.2738E-06,  9.9798E-07,  7.9339E-07,  6.2007E-07,  4.8291E-07, 
			   3.7446E-07,  2.8884E-07,  2.2138E-07,  1.6846E-07,  1.2710E-07, 
			   9.4863E-08,  6.9878E-08,  5.0644E-08,  3.5914E-08,  2.4760E-08, 
			   1.6446E-08,  7.0652E-09,  1.2173E-09,  7.6159E-12,  9.6591E-10, 
			   2.6954E-09,  4.5038E-09,  6.0939E-09,  7.3450E-09,  6.3859E-09, 
			   6.7640E-09,  6.3279E-09,  5.5286E-09,  4.5850E-09,  3.6182E-09, 
			   2.7204E-09};

TGraph* gph=new TGraph(nph,qph,tphrpg0);
gph->SetLineColor(9);
gph->SetMarkerStyle(1);
gph->SetMarkerSize(1.3);
gph->SetLineStyle(1);
gph->SetLineWidth(3);

//TPaveLabel * Label = new TPaveLabel(0.545,0.16,0.755,0.22,"#rho#pi#gamma f/g=0","NDC");
//Label->SetTextSize(0.6);
//Label->SetLineColor(kWhite);
//Label->SetFillColor(kWhite);
//Label->SetTextColor(9);
//Label->SetBorderSize(0);
//Label->Draw();
gph->Draw("l");
thlegend->AddEntry(gph,"#rho#pi#gamma f/g=0","L");

 Double_t tphrpg3[nph] = {1.0907E-04,  1.9766E-03,  2.9192E-03,  3.3286E-03,  3.4707E-03, 
			  3.3824E-03,  3.0769E-03,  2.6944E-03,  2.3073E-03,  1.6423E-03, 
			  1.1612E-03,  8.2554E-04,  5.8989E-04,  4.2211E-04,  3.0392E-04, 
			  2.2073E-04,  1.6165E-04,  1.1941E-04,  8.8865E-05,  6.6570E-05, 
			  5.0141E-05,  3.7859E-05,  2.8647E-05,  2.1720E-05,  1.6508E-05, 
			  1.2580E-05,  9.6042E-06,  7.3376E-06,  5.6085E-06,  4.2865E-06, 
			  3.2703E-06,  2.4882E-06,  1.8860E-06,  1.4224E-06,  1.0665E-06, 
			  7.9418E-07,  5.8638E-07,  4.3319E-07,  3.1260E-07,  2.2158E-07, 
			  1.5352E-07,  1.0325E-07,  6.6740E-08,  4.0856E-08,  2.3101E-08, 
			  1.1490E-08,  4.5140E-09,  9.8979E-10,  3.1737E-13,  8.5748E-10, 
			  3.0274E-09,  9.8315E-09,  1.9608E-08,  2.8845E-08,  3.6378E-08, 
			  4.1832E-08,  4.5388E-08,  4.7378E-08,  4.8091E-08,  4.4323E-08, 
			  4.0773E-08,  3.5870E-08,  3.0742E-08,  2.5819E-08,  2.1278E-08, 
			  1.7241E-08};

 //TGraph* gph3=new TGraph(nph,qph,tphrpg3);
//gph3->SetLineColor(39);
//gph3->SetMarkerStyle(1);
//gph3->SetMarkerSize(1.3);
//gph3->SetLineStyle(2);
//gph3->SetLineWidth(2);

//TPaveLabel * Label = new TPaveLabel(0.60,0.49,0.82,0.55,"Propagator f/g=3","NDC");
//Label->SetTextSize(0.6);
//Label->SetLineColor(kWhite);
//Label->SetFillColor(kWhite);
//Label->SetTextColor(39);
//Label->SetBorderSize(0);
//Label->Draw();
//gph3->Draw("l");

 Double_t tphrpg6[nph] = {1.0866E-04,  1.9679E-03,  2.9046E-03,  3.3099E-03,  3.4491E-03, 
			  3.3569E-03,  3.0500E-03,  2.6674E-03,  2.2810E-03,  1.6177E-03, 
			  1.1396E-03,  8.0697E-04,  5.7402E-04,  4.0863E-04,  2.9249E-04, 
			  2.1104E-04,  1.5343E-04,  1.1242E-04,  8.2908E-05,  6.1486E-05, 
			  4.5796E-05,  3.4145E-05,  2.5473E-05,  1.9008E-05,  1.4190E-05, 
			  1.0598E-05,  7.9092E-06,  5.8892E-06,  4.3719E-06,  3.2319E-06, 
			  2.3729E-06,  1.7267E-06,  1.2421E-06,  8.8052E-07,  6.1299E-07, 
			  4.1706E-07,  2.7536E-07,  1.7461E-07,  1.0443E-07,  5.7152E-08, 
			  2.7017E-08,  9.6080E-09,  1.5284E-09,  1.7233E-10,  3.5226E-09, 
			  1.0061E-08,  1.8644E-08,  2.8417E-08,  3.8799E-08,  4.9346E-08, 
			  5.9730E-08,  8.3215E-08,  1.0290E-07,  1.1730E-07,  1.2653E-07, 
			  1.3121E-07,  1.3238E-07,  1.3099E-07,  1.2769E-07,  1.1937E-07, 
			  1.0601E-07,  9.1747E-08,  7.8220E-08,  6.5922E-08,  5.4966E-08, 
			  4.5409E-08};

TGraph* gph6=new TGraph(nph,qph,tphrpg6);
gph6->SetLineColor(49);
gph6->SetMarkerStyle(1);
gph6->SetMarkerSize(1.3);
gph6->SetLineStyle(1);
gph6->SetLineWidth(2);

//TPaveLabel * Label = new TPaveLabel(0.23,0.16,0.45,0.22,"#rho#pi#gamma f/g=6.1","NDC");
//Label->SetTextSize(0.6);
//Label->SetLineColor(kWhite);
//Label->SetFillColor(kWhite);
//Label->SetTextColor(49);
//Label->SetBorderSize(0);
//Label->Draw();
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
  const Int_t npt24 = 9;
  Double_t qpt24[npt24] = {1.2000,  1.4900,  1.6100,  1.7400,  1.9800,  2.2300,  2.4800,  2.5300,  2.7700};
  Double_t t20pt24[npt24] = {1.1200E-06,  3.4700E-07,  1.4000E-07,  2.0700E-08,  7.5000E-09, 
			     1.2500E-08,  1.6700E-08,  2.0000E-08,  3.6000E-09};
  Double_t t20err24[npt24] = {2.2000E-07,  7.0000E-08,  3.8000E-08,  1.1500E-08,  7.1000E-09, 
			      6.3000E-09,  6.6000E-09,  1.0500E-08,  5.4000E-09};  
  TGraphErrors* gscaled=new TGraphErrors(npt24,qpt24,t20pt24,0,t20err24);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(24);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Bosted","p");

  //const Int_t npt29 = 2;
  //Double_t qpt29[npt29] = {1.0000,  1.0000};
  //Double_t t20pt29[npt29] = {5.9000E-06,  1.0000E-05};
  //Double_t t20err29[npt29] = {1.2000E-05,  1.1200E-05};
  //TGraphErrors* gscaled=new TGraphErrors(npt29,qpt29,t20pt29,0,t20err29);
  //gscaled->SetMarkerColor(col);
  //gscaled->SetMarkerStyle(29);
  //gscaled->SetMarkerSize(1.1);
  //gscaled->Draw("P");
  //legend->AddEntry(gscaled,"Martin","p");
 
  const Int_t npt25 = 5;
  Double_t qpt25[npt25] = {.5000,   .6000,   .7800,  1.0000,  1.3000};
  Double_t t20pt25[npt25] = {1.2500E-04,  8.0900E-05,  2.8100E-05,  9.4800E-06,  1.8700E-06};
  Double_t t20err25[npt25] = {2.9000E-05,  1.4700E-05,  1.6700E-05,  3.0000E-06,  9.3000E-07};
  TGraphErrors* gscaled=new TGraphErrors(npt25,qpt25,t20pt25,0,t20err25);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(25);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Cramer","p");

  const Int_t npt28 = 13;
  Double_t qpt28[npt28] = {.2610,   .3090,   .3600,   .4230,   .4890,   .5680,   .6300,   .7050,   .7820,   .8500, 
			   .9320,  1.0160,  1.0890};
  Double_t t20pt28[npt28] = {8.5100E-04,  5.6600E-04,  4.1700E-04,  2.5200E-04,  1.7200E-04, 
			     9.3800E-05,  6.4600E-05,  3.3400E-05,  2.3500E-05,  1.5100E-05, 
			     7.9400E-06,  6.3300E-06,  3.3300E-06};
  Double_t t20err28[npt28] = {7.9000E-05,  6.5000E-05,  4.6700E-05,  3.4000E-05,  2.5600E-05, 
			      1.4160E-05,  8.7900E-06,  5.6800E-06,  3.8700E-06,  3.1600E-06, 
			      2.0200E-06,  2.3300E-06,  1.2300E-06};
  TGraphErrors* gscaled=new TGraphErrors(npt28,qpt28,t20pt28,0,t20err28);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(28);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Auffret","p");

  const Int_t npt23 = 4;
  Double_t qpt23[npt23] = {.0600,   .0818,   .1280,   .1560};
  Double_t t20pt23[npt23] = {3.9000E-03,  3.1000E-03,  2.0000E-03,  1.8000E-03};
  Double_t t20err23[npt23] = {4.0000E-04,  2.0000E-04,  1.0000E-04,  1.0000E-04};
  TGraphErrors* gscaled=new TGraphErrors(npt23,qpt23,t20pt23,0,t20err23);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(23);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Simon","p");

  const Int_t npt27 = 4;
  Double_t qpt27[npt27] = {.2340,   .2730,   .3120,   .4670};
  Double_t t20pt27[npt27] = {8.9200E-04,  7.3900E-04,  5.2300E-04,  1.6400E-04};
  Double_t t20err27[npt27] = {1.1500E-04,  9.0900E-05,  6.1200E-05,  3.2000E-05};
  TGraphErrors* gscaled=new TGraphErrors(npt27,qpt27,t20pt27,0,t20err27);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(27);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Buchanan","p");
}

