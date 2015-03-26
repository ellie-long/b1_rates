#include "styling.cxx"
// #include "readRepFile.C"


void deuteron_t20_calc() {
styling();
c = new TCanvas("c","Deuteron T_20 Calcs",000,10,500,540);
plot_figure("deuteron_t20_calc",gPad);
}

void plot_figure(TString fn,TPad *thePad,bool saxis=false,float ymin=-2.0,float ymax=1.0,bool with_d=false) {
//cout<<"wit"<<with_d<<endl;

gStyle->SetOptFit();
gStyle->SetPadTickY(1);

gStyle->SetLineStyleString(11,"40 20");
float xmin=0,xmax=2;

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
hr->SetXTitle("Q (GeV)");
hr->SetYTitle("t_{20}");
/*hr->GetYaxis()->SetTitleOffset(1.5);
hr->GetYaxis()->SetTitleSize(.06);
hr->GetYaxis()->SetTitleFont(42);
hr->GetYaxis()->CenterTitle();
hr->GetXaxis()->SetTitleSize(.06);
hr->GetXaxis()->SetTitleFont(42);
*//*****************************************************
  Draw legend
*****************************************************/

TLegend *dummylegend=new TLegend();
TLegend *legend=new TLegend(0.59,0.17,0.94,0.55);
legend->SetMargin(0.2);
legend->SetTextFont(72);
legend->SetTextSize(0.035);
legend->SetFillStyle(0);
legend->SetBorderSize(0);
legend->Draw();

TLegend *thlegend=new TLegend(0.23,0.64,0.57,0.84);
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
  const Int_t npt = 94;
  //Double_t x, y;
  Double_t qfm[npt];
  Double_t qsqpt[npt] = {0.0003893797, 0.003893797, 0.03893797, 0.05840695, 0.07787593, 0.09734491, 0.1168139, 0.1362829, 
		       0.1557519, 0.1752208, 0.1946898, 0.2530968, 0.3115037, 0.3893797, 0.4672556, 0.5451315, 
		       0.6230075, 0.7008834, 0.7787593, 0.8566352, 0.9345112, 1.012387, 1.090263, 1.168139, 1.246015, 
		       1.323891, 1.401767, 1.479643, 1.557519, 1.596457, 1.635395, 1.674333, 1.71327, 1.752208, 
		       1.810615, 1.830084, 1.869022, 1.90796, 1.946898, 1.985836, 2.024774, 2.063712, 2.10265, 
		       2.141588, 2.180526, 2.219464, 2.258402, 2.29734, 2.336278, 2.375216, 2.414154, 2.453092, 
		       2.49203, 2.530968, 2.569906, 2.608844, 2.647782, 2.68672, 2.725658, 2.803534, 2.881409, 
		       2.959285, 3.037161, 3.115037, 3.309727, 3.504417, 3.699107, 3.893797, 4.088486, 4.283176, 
		       4.477866, 4.672556, 4.867246, 5.061936, 5.256625, 5.451315, 5.646005, 5.840695, 6.035385, 
		       6.230075, 6.424764, 6.619454, 6.716799, 6.814144, 6.911489, 7.008834, 7.106179, 7.203524, 
		       7.300869, 7.398214, 7.495558, 7.592903, 7.690248, 7.787593};
  Double_t t20theory[npt] = {-0.001309568, -0.0131055, -0.1318868, -0.1984704, -0.2654408, -0.3327329, -0.4002368, -0.4677915,
			 -0.5351828, -0.6021447, -0.668362, -0.8587877, -1.027779, -1.198694, -1.286326, -1.282388,
			 -1.197382, -1.054978, -0.8820486, -0.7009335, -0.5265257, -0.3668914, -0.2252485, -0.1019077,
			 0.004321276, 0.09524616, 0.1728195, 0.238883, 0.2950801, 0.3199333, 0.3428342, 0.3639258,
			 0.3833423, 0.4012027, 0.4253075, 0.432676, 0.4464807, 0.4591073, 0.4706305, 0.4811208, 
			 0.4906344, 0.4992296, 0.506956, 0.5138575, 0.5199757, 0.5253475, 0.5300049, 0.5339787, 
			 0.5372949, 0.539977, 0.5420477, 0.5435232, 0.5444235, 0.5447623, 0.5445543, 0.5438103, 
			 0.5425456, 0.540766, 0.5384844, 0.5324458, 0.5245013, 0.514713, 0.5031468, 0.4898722, 
			 0.4497016, 0.4006593, 0.3444063, 0.2827923, 0.2178549, 0.1514989, 0.08547981, 0.02124835, 
			 -0.04018853, -0.09806195, -0.1520174, -0.2019219, -0.2477681, -0.2898, -0.3282607, -0.3633281,
			 -0.3951718, -0.4241511, -0.4375907, -0.4502916, -0.4622216, -0.473322, -0.4835232, -0.4927239, 
			 -0.500801, -0.5076282, -0.513053, -0.516797, -0.5184837, -0.5176145};
  //FILE *fp = fopen("im2.dat","r");
  for (Int_t i=0;i<npt;i++) {
  //  Int_t ncols = fscanf(fp,"%f, %f",&x, &y);
  //  qsqpt[i] = x;
  //  t20theory[i] = y;
    qfm[i] = qsqpt[i]**(0.5)/xhbarc;
    //  printf(" line %d read: %f %f \n",i,qsqpt[i],t20theory[i]);
  }
  //fclose(fp);
//TGraph* gQGS=new TGraph("log170_89.dat","%lg %lg");
  gQGS = new TGraph(npt,qsqpt,t20theory);
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
  Double_t t20theoryme[npt] = {-0.001325945, -0.01328168, -0.1349228, -0.2041014, -0.2743705, -0.3456319, -0.4177289, -0.4904376,
			       -0.5634585, -0.6364107, -0.7088243, -0.9168859, -1.095754, -1.251422, -1.277469, -1.170903,
			       -0.9677308, -0.7200701, -0.4713423, -0.2466468, -0.05555869, 0.101535, 0.2283672, 0.3298602,
			       0.4107891, 0.4752683, 0.5266488, 0.567598, 0.6002075, 0.6139116, 0.6261154, 0.6369641,
			       0.6465931, 0.6551208, 0.6660647, 0.6692667, 0.6750632, 0.6801088, 0.6844693, 0.6882072,
			       0.6913724, 0.694014, 0.6961743, 0.6978924, 0.6992062, 0.7001432, 0.7007343, 0.701005,
			       0.7009771, 0.7006715, 0.7001097, 0.6993112, 0.6982906, 0.6970643, 0.6956426, 0.6940377,
			       0.6922587, 0.6903158, 0.6882191, 0.6836015, 0.6784688, 0.6728624, 0.6668122, 0.6603509,
			       0.6425963, 0.622676, 0.6008623, 0.5773537, 0.5521636, 0.5259722, 0.4991099, 0.4706432,
			       0.4410795, 0.4127616, 0.3872456, 0.3640124, 0.3422358, 0.3246932, 0.3143134, 0.3116054,
			       0.3142227, 0.3184956, 0.3200235, 0.3212056, 0.3227668, 0.3250734, 0.3281051, 0.3321319,
			       0.3372873, 0.3437867, 0.351448, 0.3600231, 0.3689893, 0.3779735};
TGraph* gRNA=new TGraph(npt,qsqpt,t20theoryme);
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
 Double_t qph[nph] = { 0.01, 0.25,  0.5,  0.75,   1.0,    1.5,    2.0,    2.5,    3.0,    4.0,
		        5.0,  6.0,  7.0,   8.0,   9.0,   10.0,   11.0,   12.0,   13.0,   14.0,
		       15.0, 16.0, 17.0,  18.0,  19.0,   20.0,   21.0,   22.0,   23.0,   24.0,
		       25.0, 26.0, 27.0,  28.0,  29.0,   30.0,   31.0,   32.0,   33.0,   34.0,
		       35.0, 36.0, 37.0,  38.0,  39.0,   40.0,   41.0,   42.0,   43.0,   44.0,
		       45.0, 47.5, 50.0,  52.5,  55.0,   57.5,   60.0,   62.5,   65.0,   70.0,
		       75.0, 80.0, 85.0,  90.0,  95.0,  100.0};
 for (Int_t i=0;i<nph;i++) {qph[i] = qph[i]*xhbarc**2;}
 Double_t tphrpg0[nph] = {-0.00139028, -0.0347797, -0.0705278, -0.106823, -0.143214, -0.215941, -0.28903, -0.36176, -0.437352, -0.594782,
			  -0.753442, -0.905365, -1.04209, -1.14824, -1.2301, -1.27076, -1.26585, -1.21681, -1.13043, -1.01648,
			  -0.885684, -0.7701, -0.630809, -0.495011, -0.366781, -0.248492, -0.141153, -0.0449377, 0.0407569, 0.116675,
			  0.183835, 0.230211, 0.284553, 0.332797, 0.375647, 0.41358, 0.447136, 0.476061, 0.502346, 0.525668,
			  0.546396, 0.561598, 0.57851, 0.593626, 0.607141, 0.619222, 0.630017, 0.638943, 0.647659, 0.655433,
			  0.662379, 0.675447, 0.686163, 0.693653, 0.698255, 0.70103, 0.701985, 0.701414, 0.699577, 0.696913,
			  0.68897, 0.68092, 0.673572, 0.668027, 0.665207, 0.664439};

TGraph* gph=new TGraph(nph,qph,tphrpg0);
gph->SetLineColor(9);
gph->SetMarkerStyle(1);
gph->SetMarkerSize(1.3);
gph->SetLineStyle(1);
gph->SetLineWidth(3);
gph->Draw("l");
thlegend->AddEntry(gph,"#rho#pi#gamma f/g=0","L");

 Double_t tphrpg3[nph] = {-0.00139212, -0.0348353, -0.0706589, -0.10705, -0.143559, -0.216597, -0.290087, -0.363321, -0.439532, -0.598654,
			  -0.759312, -0.913351, -1.0519, -1.15918, -1.24066, -1.27901, -1.2698, -1.21493, -1.12197, -1.00156,
			  -0.865071, -0.744981, -0.60214, -0.464095, -0.334789, -0.216384, -0.109662, -0.0145868, 0.069612, 0.143819,
			  0.20915, 0.254731, 0.307099, 0.353368, 0.394259, 0.43028, 0.461982, 0.489554, 0.51413, 0.535803,
			  0.554941, 0.568991, 0.584356, 0.59797, 0.610026, 0.620686, 0.630093, 0.63772, 0.645084, 0.651525,
			  0.657156, 0.666024, 0.673624, 0.678127, 0.679481, 0.67949, 0.677837, 0.674823, 0.670722, 0.662356,
			  0.650039, 0.638996, 0.628928, 0.620671, 0.614933, 0.610454};

 //TGraph* gph3=new TGraph(nph,qph,tphrpg3);
 //gph3->SetLineColor(39);
 //gph3->SetMarkerStyle(1);
 //gph3->SetMarkerSize(1.3);
 //gph3->SetLineStyle(2);
 //gph3->SetLineWidth(2);

 //TPaveLabel * Label = new TPaveLabel(0.20,0.66,0.48,0.71,"Propagator f/g=3","NDC");
 //Label->SetTextSize(0.6);
 //Label->SetLineColor(kWhite);
 //Label->SetFillColor(kWhite);
//Label->SetTextColor(39);
//Label->SetBorderSize(0);
//Label->Draw();
//gph3->Draw("l");

 Double_t tphrpg6[nph] = {-0.00139403, -0.0348929, -0.0707944, -0.107286, -0.143917, -0.217276, -0.29118, -0.364936, -0.441787, -0.602659,
			  -0.765378, -0.921581, -1.06195, -1.17027, -1.25116, -1.28686, -1.27292, -1.21183, -1.11202, -0.985056,
			  -0.84299, -0.718589, -0.572616, -0.432822, -0.302967, -0.184961, -0.0793357, 0.0141671, 0.0964853, 0.168642,
			  0.231842, 0.276257, 0.326398, 0.370465, 0.409197, 0.443123, 0.472809, 0.498773, 0.52149, 0.541377,
			  0.558796, 0.571442, 0.58515, 0.597161, 0.607665, 0.616818, 0.624764, 0.630973, 0.636932, 0.642002,
			  0.646291, 0.650319, 0.654857, 0.656509, 0.654827, 0.652371, 0.648479, 0.643459, 0.637587, 0.622962,
			  0.607813, 0.595048, 0.583592, 0.574033, 0.566854, 0.560502};

 TGraph* gph6=new TGraph(nph,qph,tphrpg6);
 gph6->SetLineColor(49);
 gph6->SetMarkerStyle(1);
 gph6->SetMarkerSize(1.3);
 gph6->SetLineStyle(1);
 gph6->SetLineWidth(2);
gph6->Draw("l");
thlegend->AddEntry(gph6,"#rho#pi#gamma f/g=6.1","L");

/*--------------------------------------------------------------------------------------
    put line at -root(2)
---------------------------------------------------------------------------------------*/
Int_t n = 2;
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
xfm[1] = 1.;
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
  Int_t i;
  Double_t xhbarc = 0.1973;
  Double_t qpt24[1] = {0.86};
  Double_t t20pt24[1] = {-0.30};
  Double_t t20err24[1] = {0.16};
  qpt24[0] = (qpt24[0]*xhbarc)**2;
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
  qpt29[0] = (qpt29[0]*xhbarc)**2;
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
  qpt25[0] = (qpt25[0]*xhbarc)**2;
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
  for (i=0;i<npt28;i++) {qpt28[i] = (qpt28[i]*xhbarc)**2;}
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
  for (i=0;i<npt23;i++) {qpt23[i] = (qpt23[i]*xhbarc)**2;}
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
  for (i=0;i<npt27;i++) {qpt27[i] = (qpt27[i]*xhbarc)**2;}
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
  qpt22[0] = (qpt22[0]*xhbarc)**2;
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
  for (i=0;i<npt26;i++) {qpt26[i] = (qpt26[i]*xhbarc)**2;}
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
  for (i=0;i<npt21;i++) {qpt21[i] = (qpt21[i]*xhbarc)**2;}
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
  for (i=0;i<npt30;i++) {qpt30[i] = (qpt30[i]*xhbarc)**2;}
  TGraphErrors* gscaled=new TGraphErrors(npt30,qpt30,t20pt30,0,t20err30);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(30);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Nikolenko","p");

  const Int_t npt31 = 9;
  Double_t qpt31[9] = {2.228, 2.404, 2.603, 2.827, 3.063, 3.319, 3.560, 3.823, 4.410};
  Double_t t20pt31[9] = {-0.780, -0.877, -1.016, -1.172, -1.244, -1.251, -1.15, -1.13, -0.70};
  Double_t t20err31[9] = {0.057, 0.066, 0.082, 0.094, 0.100, 0.113, 0.130, 0.140, 0.180};
  for (i=0;i<npt31;i++) {qpt31[i] = (qpt31[i]*xhbarc)**2;}
  TGraphErrors* gscaled=new TGraphErrors(npt31,qpt31,t20pt31,0,t20err31);
  gscaled->SetMarkerColor(col);
  gscaled->SetMarkerStyle(31);
  gscaled->SetMarkerSize(1.1);
  gscaled->Draw("P");
  legend->AddEntry(gscaled,"Zhang","p");

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

