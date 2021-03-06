#include <cstring>
#include <TGraphAsymmErrors.h>
#include <cstdio>
#include <cstdlib>
#include <TMultiGraph.h>
#include <TFormula.h>
#include <TCanvas.h>
#include <iostream>
#include <TStyle.h>
#include <TLine.h>
#include <TFrame.h>
#include <TLegend.h>
#include <TMarker.h>
#include <TF1.h>
#include <TSystem.h>
#include "HallA_style.cxx"
#include "halla_plotting.h"

const char* psfile = "plot_B_fit";

using namespace std;

datafile_t datafiles[] = {
//{ "data file.dat", "Data Name", "Q^2", "B", "Error Up", "Error Down", ?, ?, Shape, Color}
	{ "data_B/all_data.dat", 	"", 			"[0]", "[1]", "[2]", "[2]", 0,0,1,10 },
//	{ "data_B/all_sorted_data.txt", 	"", 			"[0]", "[1]", "[2]", "[2]", 0,0,1,0 },
	{ "data_B/Bosted.dat", 		"Bosted", 		"[0]", "[1]", "[2]", "[2]", 0,0,20,1 },
	{ "data_B/Cramer.dat", 		"Cramer", 		"[0]", "[1]", "[2]", "[2]", 0,0,21,1 },
	{ "data_B/Auffret.dat", 	"Auffret", 		"[0]", "[1]", "[2]", "[2]", 0,0,22,1 },
	{ "data_B/Simon.dat", 		"Simon", 		"[0]", "[1]", "[2]", "[2]", 0,0,23,1 },
	{ "data_B/Buchanan.dat", 	"Buchanan",		"[0]", "[1]", "[2]", "[2]", 0,0,24,1 },
	{ NULL }
};	

datafile_t theoryfiles1[] = {
//{ "theory file.txt", "Data Name", "Q2 (Include range in theory file)", "Ay", "Error Up", "Error Down", ?, ?, 2, 3 },
//	{ "asym_theory/mami_ay_theory_full.txt", "FSI and MEC (Faddeev)", "[0]", "[1]", "0", "0", 0, 0, 2, 3 },
	{ NULL }
};

void plot_B_fit() {
	gROOT->SetStyle("HALLA");
	TCanvas *cn = new TCanvas("cn","cn",800,600);
	cn->Draw();
	cn->UseCurrentStyle();
	TH1F *frm = new TH1F("frm","",100,0.0,4.);
	gPad->SetLogy();
	frm->GetXaxis()->SetTitle("Q^2   (GeV/c)^2");
	frm->GetYaxis()->SetTitle("B");
	frm->SetMinimum(1E-10);
	frm->SetMaximum(1.0);
//	frm->SetMaximum(0.005);
	frm->UseCurrentStyle();
	frm->SetStats(false);
	frm->Draw();
	frm->SetAxisRange(0.,3.0,"X");

	
	TMultiGraph* mgrDta = new TMultiGraph("Data","B Data");
	TLegend *legDta = new TLegend(.75,.6,.9,.90,"","brNDC");

	TMultiGraph* wgr = mgrDta;
	TLegend *wlg = legDta;

	 // the data
	legDta->SetBorderSize(0); // turn off border
	legDta->SetFillStyle(0);


	datafile_t *f = datafiles;
	TGraph* gr=0;
	TF1 *fitLong = new TF1("fitLong","10^([0]+[1]*x+[2]*x^2)",0,6);
//	TF1 *fitLong = new TF1("fitLong","4*2E-8*((2/x)^3-(2/x)^1)",0.0001,7);
	fitLong->SetParameters(-2.1870,-3.4066,0.44380);
	fitLong->SetParLimits(0,-3,-1);
	fitLong->SetParLimits(1,-4,-2);
	fitLong->SetParLimits(2,0,1);
	TLegend *legFits = new TLegend(0.5,0.5,0.9,0.6,"","brNDC");
	legFits->SetBorderSize(0);
	legFits->SetFillStyle(0);
	TString label = "";
	double chi2 = 0;
	double ndf = 0;
	while ( f && f->filename ) {
		cout << "f: " << f->filename << endl;
		gr=OneGraph(f);
		if (gr) {
			if (f->lnpt) {
				mgrDta->Add(gr,f->lnpt);
				legDta->AddEntry(gr,f->label,f->lnpt);
			}
			else if (f->filename=="data_B/all_data.dat") {
				gr->SetMarkerSize(0);
				gr->SetLineWidth(1);
				mgrDta->Add(gr,"p");
				legDta->AddEntry(gr,f->label,"p");
				gr->Fit(fitLong,"R");
				chi2 = fitLong->GetChisquare();
				ndf = fitLong->GetNDF();
				chi2 = chi2/ndf;
				label = "Long Fit, chi2/ndf=";
				label += chi2;
				legFits->AddEntry(fitLong,label,"l");
			 }	
			else if (gr->GetMarkerStyle()>=20) {
				mgrDta->Add(gr,"p");
				legDta->AddEntry(gr,f->label,"p");
			}	
			else {
				mgrDta->Add(gr,"l");
				legDta->AddEntry(gr,f->label,"l");
			}
		}
		f++;
	}
		

	TF1 *fitPetratos = new TF1("fitPetratos","10^(-2.1870-3.4066*x+0.44380*x^2)",0,7);
 	chi2 = 10.52;
	label = "Petratos Fit, chi2/ndf=";
	label += chi2;
	mgrDta->Draw("p");
	legDta->Draw();
	legFits->Draw();
	fitLong->Draw("same");
	fitPetratos->SetLineColor(kBlue);
	fitPetratos->Draw("same");
	legFits->AddEntry(fitPetratos,label,"l");
//	legDta->AddEntry();

	TMultiGraph* mgrThry = new TMultiGraph("Theory","B Theory");
	TLegend *legThry = new TLegend(.54,.3,.875,.6,"","brNDC");

	wgr = mgrThry;
	wlg = legThry;

	// the theory
	wlg->SetBorderSize(0); // turn off border
	wlg->SetFillStyle(0);
	
/*	f = theoryfiles1;
	gr=0;
	while ( f && f->filename ) {
		gr=OneGraph(f);
		if (gr) {
			TGraphAsymmErrors *egr = dynamic_cast<TGraphAsymmErrors*>(gr);
			if (egr && egr->GetN()>1 && egr->GetEYhigh() && egr->GetEYhigh()[1]>0) {
	gr = toerror_band(egr);
	gr->SetFillStyle(3000+f->style);
			}
			if (f->lnpt) {
	wgr->Add(gr,f->lnpt);
	wlg->AddEntry(gr,f->label,f->lnpt);
			}
			else if (gr->GetMarkerStyle()>=20) {
	wgr->Add(gr,"p");
	wlg->AddEntry(gr,f->label,"p");
			}	
			else {
	wgr->Add(gr,"l");
	wlg->AddEntry(gr,f->label,"l");
			}
		}
		f++;
	}
*/
	cout << "Am I here?" << endl;	
	mgrThry->Draw("c");
	legThry->Draw();
	legDta->Draw();
	// draw a line at 1
	cn->Modified();

	cn->Update();
	cn->SaveAs(Form("eps/%s.eps",psfile));
	cn->SaveAs(Form("png/%s.png",psfile));
	cn->SaveAs(Form("root/%s.root",psfile));
	gSystem->Exec(Form("./replace_symbols.pl eps/%s.eps",psfile));

	return;	// LEAVING HERE

	// now an overlay, hopefully matching dimensions

	// remove everything but the graph
	cn->Update();
	TList *clist = cn->GetListOfPrimitives();
	TFrame* frame = cn->GetFrame();
	for (int i=0; i<clist->GetSize(); ) {
		if (clist->At(i) != frame) {
			clist->RemoveAt(i);
		} else i++;
	}
	// draw markers in the corners
	TMarker *mkr = new TMarker(frame->GetX1(),frame->GetY1(),2);
	mkr->Draw();
	mkr = new TMarker(frame->GetX2(),frame->GetY1(),2);
	mkr->Draw();
	mkr = new TMarker(frame->GetX1(),frame->GetY2(),2);
	mkr->Draw();
	mkr = new TMarker(frame->GetX2(),frame->GetY2(),2);
	mkr->Draw();
	frame->SetLineColor(10);
	cn->Update();

}
