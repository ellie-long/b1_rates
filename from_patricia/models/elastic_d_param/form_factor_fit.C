#include <iostream>
#include <fstream>
#include <string>
#include <string.h>
#include <math.h>
#include <iomanip>


void form_factor_fit()
{

	cout << "Starting Form Factors Fit" << endl;

	Double_t Q[20];
	Double_t QErr[20];
	cout << "Setting Q (1/fm) Values" << endl;
	Q[0]  = 0.86;
	Q[1]  = 1.15;
	Q[2]  = 1.58;
	Q[3]  = 1.74;
	Q[4]  = 2.026;
	Q[5]  = 2.03;
	Q[6]  = 2.352;
	Q[7]  = 2.49;
	Q[8]  = 2.788;
	Q[9]  = 2.93;
	Q[10] = 3.566;
	Q[11] = 3.78;
	Q[12] = 4.09;
	Q[13] = 4.22;
	Q[14] = 4.46;
	Q[15] = 4.62;
	Q[16] = 5.09;
	Q[17] = 5.47;
	Q[18] = 6.15;
	Q[19] = 6.64;

	Double_t t20[20];
	Double_t t20Err[20];
	cout << "Setting t20" << endl;
 	t20[0]  = -0.300; t20Err[0]  = 0.160;
	t20[1]  = -0.181; t20Err[1]  = 0.070;
	t20[2]  = -0.400; t20Err[2]  = 0.037;
	t20[3]  = -0.420; t20Err[3]  = 0.060;
	t20[4]  = -0.713; t20Err[4]  = 0.090;
	t20[5]  = -0.590; t20Err[5]  = 0.130;
	t20[6]  = -0.896; t20Err[6]  = 0.093;
	t20[7]  = -0.751; t20Err[7]  = 0.153;
	t20[8]  = -1.334; t20Err[8]  = 0.233;
	t20[9]  = -1.255; t20Err[9]  = 0.299;
	t20[10] = -1.870; t20Err[10] = 1.040;
	t20[11] = -1.278; t20Err[11] = 0.186;
	t20[12] = -0.534; t20Err[12] = 0.163;
	t20[13] = -0.833; t20Err[13] = 0.153;
	t20[14] = -0.324; t20Err[14] = 0.089;
	t20[15] = -0.411; t20Err[15] = 0.187;
	t20[16] =  0.178; t20Err[16] = 0.053;
	t20[17] =  0.292; t20Err[17] = 0.073;
	t20[18] =  0.621; t20Err[18] = 0.168;
	t20[19] =  0.476; t20Err[19] = 0.189;

	Double_t tTil20[20];
	Double_t tTil20Err[20];
	cout << "Setting t~20" << endl;
	tTil20[0]  = -0.300; tTil20Err[0]  = 0.16;
	tTil20[1]  = -0.178; tTil20Err[1]  = 0.071;
	tTil20[2]  = -0.402; tTil20Err[2]  = 0.038;
	tTil20[3]  = -0.423; tTil20Err[3]  = 0.063;
	tTil20[4]  = -0.734; tTil20Err[4]  = 0.095;
	tTil20[5]  = -0.604; tTil20Err[5]  = 0.138;
	tTil20[6]  = -0.945; tTil20Err[6]  = 0.101;
	tTil20[7]  = -0.792; tTil20Err[7]  = 0.169;
	tTil20[8]  = -1.473; tTil20Err[8]  = 0.267;
	tTil20[9]  = -1.401; tTil20Err[9]  = 0.347;
	tTil20[10] = -2.200; tTil20Err[10] = 1.260;
	tTil20[11] = -1.476; tTil20Err[11] = 0.228;
	tTil20[12] = -0.567; tTil20Err[12] = 0.193;
	tTil20[13] = -0.913; tTil20Err[13] = 0.179;
	tTil20[14] = -0.320; tTil20Err[14] = 0.100;
	tTil20[15] = -0.417; tTil20Err[15] = 0.207;
	tTil20[16] =  0.208; tTil20Err[16] = 0.056;
	tTil20[17] =  0.312; tTil20Err[17] = 0.075;
	tTil20[18] =  0.630; tTil20Err[18] = 0.170;
	tTil20[19] =  0.478; tTil20Err[19] = 0.189;

	Double_t GC[20];
	Double_t GCErr[20];
	cout << "Setting GC" << endl;
	GC[0]  =    0.627; GCErr[0]  =   0.011;
	GC[1]  =    0.474; GCErr[1]  =   0.008;
	GC[2]  =    0.289; GCErr[2]  =   0.006;
	GC[3]  =    0.238; GCErr[3]  =   0.005;
	GC[4]  =    0.160; GCErr[4]  =   0.005;
	GC[5]  =    0.163; GCErr[5]  =   0.005;
	GC[6]  =    0.100; GCErr[6]  =   0.004;
	GC[7]  =    0.087; GCErr[7]  =   0.004;
	GC[8]  =  3.71E-2; GCErr[8]  = 1.47E-2; // +1.47E-2, -0.11E-2
	GC[9]  =  3.45E-2; GCErr[9]  = 1.22E-2; // +1.22E-2, -0.39E-2
	GC[10] =  1.53E-2; GCErr[10] = 1.38E-2; // +0.00E-2, -1.38E-2
	GC[11] =  1.25E-2; GCErr[11] = 0.55E-2; // +0.05E-2, -0.55E-2
	GC[12] = -1.14E-3; GCErr[12] = 1.60E-3;
	GC[13] =  1.63E-3; GCErr[13] = 1.61E-3; // +1.61E-3, -1.44E-3
	GC[14] = -2.39E-3; GCErr[14] = 0.61E-3;
	GC[15] = -1.63E-3; GCErr[15] = 1.14E-3;
	GC[16] = -3.87E-3; GCErr[16] = 0.30E-3;
	GC[17] = -3.48E-3; GCErr[17] = 0.32E-3;
	GC[18] = -3.19E-3; GCErr[18] = 0.55E-3;
//	GC[18] = -4.20E-3; GCErr[18] = 0.42E-3; // +0.42E-3, -0.32E-3
	GC[19] = -1.89E-3; GCErr[19] = 0.38E-3;
//	GC[19] = -3.13E-3; GCErr[19] = 0.24E-3; // +0.24E-3, -0.19E-3

	Double_t GQ[20];
	Double_t GQErr[20];
	cout << "Setting GQ" << endl;
	GQ[0]  =  47.0; GQErr[0]  = 25.00;
	GQ[1]  =  12.0; GQErr[1]  = 4.700;
	GQ[2]  =  8.66; GQErr[2]  = 0.810;
	GQ[3]  =  6.19; GQErr[3]  = 0.900;
	GQ[4]  =  5.51; GQErr[4]  = 0.730;
	GQ[5]  =  4.50; GQErr[5]  = 1.020;
	GQ[6]  =  3.49; GQErr[6]  = 0.410;
	GQ[7]  =  2.17; GQErr[7]  = 0.480;
	GQ[8]  =  2.59; GQErr[8]  = 0.073;
	GQ[9]  =  1.85; GQErr[9]  = 0.640; // +0.120, -0.640
	GQ[10] = 0.651; GQErr[10] = 0.147; // +0.147, -0.023
	GQ[11] = 0.474; GQErr[11] = 0.078; // +0.780, -0.018
	GQ[12] = 0.383; GQErr[12] = 0.015;
	GQ[13] = 0.325; GQErr[13] = 0.013;
	GQ[14] = 0.245; GQErr[14] = 0.010;
	GQ[15] = 0.208; GQErr[15] = 0.009;
	GQ[16] = 0.199; GQErr[16] = 0.006;
	GQ[17] = 0.080; GQErr[17] = 0.004;
	GQ[18] = 0.034; GQErr[18] = 0.006; // +0.005, -0.006
//	GQ[18] = 0.019; GQErr[18] = 0.007;
	GQ[19] = 0.023; GQErr[19] = 0.003; // +0.002, -0.003
//	GQ[19] = 0.008; GQErr[19] = 0.004;


	cout << "Plotting data" << endl;
	TCanvas *t20Canvas = new TCanvas("t20Canvas","t20(70)",1400,730); //x,y
	t20Canvas->cd();
	t20Canvas->SetGrid();

	t20Hist = new TH2F("t20Hist","t20(70)",300,0,7,1000,-1.75,1.0);
        t20Hist->SetStats(kFALSE);
        t20Hist->Draw();
		t20Hist->GetXaxis()->SetTitle("Q (1/fm)");
		t20Hist->GetYaxis()->SetTitle("t20(70)");

	cout << "Making fit" << endl;
	t20Graph = new TGraphErrors(20, Q, t20, 0, t20Err);
        t20Graph->SetMarkerStyle(21);
//      t20Graph->SetMarkerColor(4);
        t20Graph->SetMarkerColor(kBlue);
//      t20Graph->SetLineColor(4);
        t20Graph->SetLineColor(kBlue);

	t20Graph->Draw("P");
	TF1 *fitt20Graph = new TF1("fitt20Graph", "[0] + [1]*x + [2]*x^2 + [3]*x^3 + [4]*x^4 + [5]*x^5 + [6]*x^6", 0.001, 7);
	t20Graph->Fit("fitt20Graph");
	double p00t20 = fitt20Graph->GetParameter(0);
	double p01t20 = fitt20Graph->GetParameter(1);
	double p02t20 = fitt20Graph->GetParameter(2);
	double p03t20 = fitt20Graph->GetParameter(3);
	double p04t20 = fitt20Graph->GetParameter(4);
	double p05t20 = fitt20Graph->GetParameter(5);
	double p06t20 = fitt20Graph->GetParameter(6);

	TString t20FitEq = "";
	t20FitEq += p00t20;
	t20FitEq += " + ";
	t20FitEq += p01t20;
	t20FitEq += "*x + ";
	t20FitEq += p02t20;
	t20FitEq += "*x^2 + ";
	t20FitEq += p03t20;
	t20FitEq += "*x^3 + ";
	t20FitEq += p04t20;
	t20FitEq += "*x^4 + ";
	t20FitEq += p05t20;
	t20FitEq += "*x^5 + ";
	t20FitEq += p06t20;
	t20FitEq += "*x^6";
	cout << "Parameterization: t20 = " << t20FitEq << endl;
	TF1 *t20fitLineAttempt = new TF1("t20fitLineAttempt", t20FitEq,0,7);
	t20fitLineAttempt->SetLineColor(kBlue);
	t20fitLineAttempt->Draw("same");
	t20Canvas->Update();
	cout << "All done!" << endl;
}
